---
title: "大附院档案卷脊封面打印管理系统"
date: 2026-06-15T10:00:00+08:00
draft: false
tags: ["档案管理", "Web开发", "打印系统", "小程序", "办公自动化"]
categories: ["技术实践"]
author: "李海峰"
description: "Vue.js + Flask 全栈项目，效率提升1800倍"
---

## 项目背景

在大理大学第一附属医院档案室，每天都要处理大量的档案卷脊和封面打印工作。传统的手工制作方式效率低下，平均每制作一个标签需要30分钟，且容易出现错误。

为了解决这个问题，我开发了一套基于 Web 的档案卷脊封面打印管理系统。

---

## 技术栈

- **前端**：Vue.js 3.x + Element Plus
- **后端**：Python Flask
- **数据库**：SQLite
- **打印**：jsPDF + 浏览器打印API

---

## 核心功能

### 1. 批量导入

支持 Excel 文件批量导入档案数据，自动解析档号、题名、保管期限等信息。

### 2. 模板编辑

提供可视化的标签模板编辑器，可以自定义字体、大小、位置等。

### 3. 批量打印

一键批量生成并打印所有标签，大幅提升工作效率。

---

## 效率对比

| 方式 | 单个标签时间 | 100个标签时间 |
|------|------------|--------------|
| 手工制作 | 30分钟 | 50小时 |
| 系统打印 | 1秒 | 2分钟 |

**效率提升：1800倍！**

---

## 核心代码示例

### Python 后端 - Excel 导入

```python
import pandas as pd
from openpyxl import load_workbook

def import_excel_data(file_path):
    """导入Excel档案数据"""
    try:
        df = pd.read_excel(file_path, sheet_name='Sheet1')
        df = df.dropna(subset=['档号', '题名'])
        df['档号'] = df['档号'].astype(str).str.strip()
        df['题名'] = df['题名'].astype(str).str.strip()
        return {
            'success': True,
            'data': df.to_dict('records'),
            'count': len(df)
        }
    except Exception as e:
        return {'success': False, 'error': str(e)}
```

### Vue.js 前端 - 批量打印

```javascript
async function batchPrint(archives) {
  for (const archive of archives) {
    const pdf = generateLabelPDF(archive)
    const blob = pdf.output('blob')
    const url = URL.createObjectURL(blob)
    
    // 打开打印窗口
    const printWindow = window.open(url)
    await new Promise(resolve => {
      printWindow.onload = resolve
    })
    printWindow.print()
    
    // 延迟，避免浏览器阻塞
    await sleep(500)
  }
}
```

---

## 使用效果

系统上线后，档案室的标签制作效率提升了1800倍，工作人员从繁琐的手工制作中解放出来，可以将更多精力投入到档案管理的质量控制工作中。

---

## 总结

这个项目展示了如何利用现代 Web 技术解决传统工作中的痛点问题。通过自动化和批量处理，不仅提高了效率，还减少了人为错误，提升了工作质量。
