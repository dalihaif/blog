---
layout: post
title: "用 Python 批量去除 AI 壁纸的「豆包AI生成」水印"
subtitle: "零成本、纯代码方案，54张图片99秒搞定"
date: 2026-06-18
author: "老墨"
header-img: "img/posts/watermark-removal/watermark-demo-full.png"
tags:
  - Python
  - 图像处理
  - AI工具
  - 实用技巧
  - WorkBuddy
categories:
  - 技术实践
---

## 背景

最近用 AI 生成了一批手机壁纸和桌面壁纸，效果不错，但每张图的右下角都带着「豆包AI生成」的水印字样。

![水印对比图](/blog/img/posts/watermark-removal/watermark-before-after.png)

一张两张手动裁掉也行，但这次一共 **54 张**（手机壁纸 35 张 + 桌面壁纸 19 张），手动处理太耗费时间。于是我用 Python 写了个自动去水印脚本，效果出乎意料地好。

---

## 效果一览

> 左边是带水印的原图，右边是去除后的效果

![全文对比](/blog/img/posts/watermark-removal/watermark-demo-full.png)

处理速度也相当快：**平均 1.8 秒/张，54 张总计 99 秒**，喝口水的功夫就全部搞定了。

---

## 原理：四步搞定

![处理步骤](/blog/img/posts/watermark-removal/watermark-steps.png)

### 第一步：定位水印区域

AI 生成的水印通常固定在某个角落。我们只需告诉程序「看右下角」，它就会在那个区域里扫描，不用把整张图都分析一遍，省时省力。

### 第二步：识别水印像素

水印文字通常是**高亮颜色**（白色或浅色），和周围的壁纸颜色有明显区别。用「亮度阈值」把特别亮的像素筛出来，再配合「连通域分析」（把相邻的亮像素归成一组），就能精确定位每个水印点。

### 第三步：BFS 修复（核心）

这是整个方案最关键的一步。

传统做法是对每个水印点，一层层往外扩环找最近的干净像素——速度快但质量一般。我这里用了**多源广度优先搜索（Multi-source BFS）**：

```
把水印边界上所有干净像素同时加入队列
然后像"墨水扩散"一样，一层层往水印内部填充颜色
```

这样做有两个好处：
- **速度快**：复杂度从 O(N×R²) 降到 O(N)，N 是水印像素数
- **效果好**：填充的颜色来自真正的相邻像素，不会有明显的修补痕迹

### 第四步：输出成品

修复完的区域写回原图，另存为 `<原文件名>_clean.png`，原图丝毫不改。

---

## 代码实现

核心代码其实不到 100 行，依赖只有两个库：

```python
# 需要安装的库
# pip install Pillow numpy
```

**水印检测（亮度阈值 + 连通域）：**

```python
import numpy as np
from PIL import Image

def detect_watermark(arr, corner="bottom-right", 
                     region_ratio=0.25, brightness_thresh=0.4):
    h, w = arr.shape[:2]
    # 取右下角区域
    rx2, ry2 = w, h
    rx1, ry1 = int(w * (1 - region_ratio)), int(h * (1 - region_ratio))
    
    region = arr[ry1:ry2, rx1:rx2]
    brightness = region.reshape(-1, 3).mean(axis=1)
    
    # 亮度阈值：比最大值低不超过 (max-mean)*thresh 的视为水印
    thresh_val = brightness.max() - (brightness.max() - brightness.mean()) * brightness_thresh
    mask_flat = brightness > thresh_val
    
    # 连通域过滤：去掉太小的噪声点（< 50 像素的不要）
    # ...（完整代码见文末）
    return mask
```

**多源 BFS 修复：**

```python
from collections import deque

def inpaint_roi(roi, mask):
    """多源BFS：从边界干净像素同时向内扩散填充"""
    result = roi.copy()
    h, w = mask.shape
    filled = np.zeros_like(mask, dtype=bool)
    q = deque()

    # 把所有"紧邻水印的干净像素"加入队列作为种子
    for r in range(h):
        for c in range(w):
            if not mask[r, c]:
                # 检查是否与水印像素相邻
                for dr in range(-1, 2):
                    for dc in range(-1, 2):
                        nr, nc = r + dr, c + dc
                        if 0 <= nr < h and 0 <= nc < w and mask[nr, nc] and not filled[nr, nc]:
                            q.append((nr, nc, roi[r, c].copy()))
                            filled[nr, nc] = True

    # BFS 扩散
    while q:
        r, c, color = q.popleft()
        result[r, c] = color
        for dr in range(-1, 2):
            for dc in range(-1, 2):
                nr, nc = r + dr, c + dc
                if 0 <= nr < h and 0 <= nc < w and mask[nr, nc] and not filled[nr, nc]:
                    q.append((nr, nc, color))
                    filled[nr, nc] = True

    return result
```

---

## 批量处理：一行命令搞定 54 张

有了脚本之后，批量处理就是写个循环的事：

```bash
python remove_watermark.py "手机壁纸 (1).png"
# 自动输出：手机壁纸 (1)_clean.png

# 批量处理整个文件夹
for f in 手机壁纸*.png; do
    python remove_watermark.py "$f"
done
```

实际运行时输出大概这样：

```
[1/54] 手机壁纸 (1).png
  水印像素：9258  detected
  修复完成 → 手机壁纸 (1)_clean.png  (1.82s)

[2/54] 手机壁纸 (2).png
  水印像素：9823  detected
  修复完成 → 手机壁纸 (2)_clean.png  (1.91s)
...
✅ 完成！共处理 53 张，0 失败，总计 99.2 秒
```

---

## 做成 Skill，以后随时用

我把这套流程封装成了一个 **WorkBuddy Skill**（技能），以后遇到类似需求直接调用就行，不用再写代码。

Skill 已保存在两个位置：
- `~/.workbuddy/skills/image-watermark-remover/`（用户级，跨项目可用）
- `G:\skills\image-watermark-remover/`（备份）

**使用方式：**

```
# 去除单张图片水印（默认右下角）
python scripts/remove_watermark.py 图片.png

# 指定水印位置
python scripts/remove_watermark.py 图片.png --corner bottom-right

# 指定输出路径
python scripts/remove_watermark.py 图片.png -o 输出.png
```

Skill 不需要安装 OpenCV 或其他重量级依赖，只需要 **Python + Pillow**，零系统依赖，拷到哪台电脑都能跑。

---

## 局限性 & 注意事项

这个方案针对性很强，主要适用于：

- ✅ 水印在固定角落、颜色高亮（白/浅色）
- ✅ 背景相对简单，相邻像素颜色连续
- ✅ 批量处理同类型图片

不太适合的场景：
- ❌ 水印在图片正中央、跨越多区域
- ❌ 背景极其复杂（如风景照里的水印）
- ❌ 水印颜色和背景非常接近

---

## 总结

| 项目 | 数据 |
|------|------|
| 处理图片数 | 54 张 |
| 总耗时 | 99 秒 |
| 平均速度 | 1.8 秒/张 |
| 依赖项 | Python + Pillow（仅两个库） |
| 代码量 | ~250 行（含注释） |
| 可复用性 | 封装为 Skill，随时调用 |

整个方案的核心思路是**「就近填充」**——水印旁边的像素颜色，大概率是水印下面应该显示的颜色。用 BFS 保证填充过程高效且自然，比传统的「内容感知填充」轻量得多。

如果你也有类似的需求（批量去水印、批量图片处理），欢迎留言交流～

---

**相关资源：**
- 完整代码已封装为 [image-watermark-remover Skill](https://github.com/yourusername/workbuddy-skills)（待上传）
- 博客源码托管在 [dalihaif.github.io/blog](https://github.com/dalihaif/dalihaif.github.io)

*（本文由 WorkBuddy AI 助手辅助撰写，老墨审核发布）*
