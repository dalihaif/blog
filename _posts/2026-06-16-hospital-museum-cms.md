---
layout: post
title: "纯静态CMS架构实战：为三甲医院打造零运维成本的数字院史馆"
subtitle: "从 localStorage 到 data.js —— 一个无后台、无数据库、可离线编辑的内容管理方案"
date: 2026-06-16
author: "老墨"
header-img: "img/post-bg-desk.jpg"
tags:
  - 前端开发
  - CMS
  - GitHub Pages
  - 静态网站
  - JavaScript
categories:
  - 技术实践
---

## 📖 前言

2002年我回连队看到连史馆时，我就在想医院如果也做一个院史馆，让传承有地方看到，终于在今年通过AI为医院做一个数字院史馆。以下是我在做院史馆时的一些想法和做法。

云端院史馆，需求听起来很简单——不就是做个展示网页嘛。但仔细梳理下来，这事儿比想象中复杂得多：

- **13 个内容板块**：历史沿革、人物风采、学科建设、院区风貌、医学教育、文化建设、医疗技术、社会责任、医院荣誉、发展愿景、组织架构、历任院领导、职工名录
- **近 2500 条职工数据**，需要支持批量导入和分页浏览
- **内容需要持续更新**，不能每次改几个字就找我改代码
- **零运维预算**，不能租服务器、不能搭数据库

换句话说：这个网站要有 CMS 的能力，但不能有任何服务端依赖。

这就是本文要讲的故事——如何用纯前端技术栈，搭建一个"编辑即发布"的静态内容管理系统。

---

## 🏗️ 整体架构

整个系统的核心矛盾只有一个：**数据从哪来，到哪去**。

传统的 CMS 有数据库、有后台接口、有服务端渲染。但我们只有一堆 HTML 文件和一个 GitHub Pages。所以必须想清楚数据的流转路径。

最终的设计是一个"**双通道**"模型：

```
        编辑态（localStorage）          发布态（data.js）
        ┌──────────────┐              ┌──────────────┐
        │  管理后台     │   导出覆盖    │  前台渲染     │
        │  admin/      │ ─────────→   │  main.js     │
        │  localStorage│              │  data-core.js│
        │  即时预览     │              │  data-staff  │
        └──────────────┘              │  .js         │
                                       └──────────────┘
                                              │
                                              ▼
                                       GitHub Pages
```

**编辑态**：管理员在 `admin/` 后台修改内容，数据实时存入浏览器的 `localStorage`。改完就能在本地预览效果，所见即所得。

**发布态**：确认无误后，点"导出数据"，后台自动生成两个 JS 文件——`data-core.js`（核心数据，约 50KB）和 `data-staff.js`（职工名录，约 580KB）。把这两个文件覆盖到 `js/` 目录，`git push` 一下，GitHub Actions 自动部署。

这个过程有两个关键设计：

1. **localStorage 的优先级高于 data.js**——本地编辑时，前台自动读取 `localStorage` 中的最新内容；访客访问线上版时，由于没有 `localStorage`，自动回退到 `data.js`。同一套渲染代码，自适应两种数据源。

2. **核心数据与职工数据分离**——首页、板块页只需要加载 50KB 的 `data-core.js`；只有打开"职工名录"页面时，才按需加载 580KB 的 `data-staff.js`。首页加载快，职工页按需取。

---

## 🖥️ 管理后台：让非技术人员也能更新内容

后台选型上，我用了 **AdminLTE 3**——一个基于 Bootstrap 4 的后台 UI 框架。选它的原因很简单：

- 成熟稳定，社区活跃
- 自带侧边栏、导航、表单、表格等后台常用组件
- 响应式，手机上也能凑合编辑
- 不依赖任何 JS 框架，直接操作 DOM

后台核心逻辑约 3000 行原生 JavaScript，对所有现代浏览器友好。功能模块包括：

| 模块 | 功能 |
|------|------|
| 首页编辑 | Hero 轮播图、板块导航卡片、Footer |
| 13 个板块 | 各自独立的标题、正文、配图编辑器 |
| 人物风采 | 专家群像、医学人才、榜样员工卡片管理 |
| 历任院领导 | 照片+姓名+职务+任期+简介 |
| 职工名录 | CSV/文本批量导入、分页、增删改查 |
| 数据导出 | 一键生成 `data-core.js` + `data-staff.js` |
| 数据导入 | 从 `data-core.js` 恢复编辑态 |

每个板块的编辑表单统一用原生 `<textarea>` + HTML，不做富文本抽象。为什么不用 Markdown 或主流富文本编辑器？两个考虑：

1. **零依赖**——原生 `<textarea>` 不需要引入任何第三方库，体积为零
2. **可预测**——富文本编辑器生成的 HTML 往往夹带大量冗余标签和内联样式，不利于页面统一控样。直接写 HTML 片段，干净可控

当然，代价是对编辑者有一点 HTML 基础要求。但考虑到实际运营人员是院办同事，写个 `<p>` 和 `<img>` 完全不是问题——况且后台提供了大量模板片段，大部分情况只需改文字和图片路径。

---

## 👷 职工名录：2487 条数据的导入与编码挑战

13 个板块里，技术难度最高的不是首页渲染，而是**职工名录**。

数据来源是医院人事科的 Excel 表格，导出为 CSV。问题来了：这些表格的编码五花八门——有的是 UTF-8，有的是 GBK，有的是 GB2312，甚至有混用的情况。

不能让院办同事每次导入前手动转码——那不叫解决方案，那叫甩锅。

所以后台的 CSV 导入器做了**自动编码检测**：

```javascript
// 核心思路：读取文件二进制数据，检测 BOM 标记
// 并根据字节特征判断 GBK/UTF-8
function detectEncoding(buffer) {
  const arr = new Uint8Array(buffer);

  // UTF-8 BOM: EF BB BF
  if (arr[0] === 0xEF && arr[1] === 0xBB && arr[2] === 0xBF)
    return 'utf-8';

  // UTF-16 LE BOM: FF FE
  if (arr[0] === 0xFF && arr[1] === 0xFE)
    return 'utf-16le';

  // GBK/GB2312 无 BOM，通过采样判断
  // 如果高字节比例超过阈值，判定为 GBK
  return detectGBKBySampling(arr) ? 'gbk' : 'utf-8';
}
```

GBK 检测的采样策略：取文件前 1024 个字节，统计高位字节（`> 0x7F`）的比例。中文字符在 GBK 编码下高位字节比例通常在 30%~60% 之间，英文 UTF-8 文本则远低于此。设定一个经验阈值（如 15%）即可完成判断。

准确率？实际测试中，对于中文占比较高的 CSV，准确率接近 100%。对于纯英文 CSV（比如只有工号+姓名拼音），即使误判为 UTF-8 也不影响结果——因为纯 ASCII 在两种编码下完全兼容。

---

## 📊 数据文件的按需拆分

前面提到，`data-core.js`（约 50KB）和 `data-staff.js`（约 580KB）是分开的。

这个决策的合理性需要放在**真实网络环境**中看：

- 如果合并为一个大文件（约 630KB），**所有页面**都要承受这 630KB 的首屏加载
- 如果分开，首页和其他板块只需 50KB，只有打开职工名录页才加载额外的 580KB

630KB 在宽带下不算什么，但在医院内网、移动端 4G 网络、或者 GitHub Pages 的免费带宽下，差异是显著的。

实现上，在 `main.js` 初始化时先加载 `data-core.js`，渲染首页和导航。当用户点击"职工名录"时，动态注入 `<script>` 标签加载 `data-staff.js`，加载完毕后追加职工数据到内存中，触发重新渲染。

核心代码大致如下：

```javascript
// main.js 数据加载逻辑
const HM_DATA = {
  // 优先从 localStorage 读取（编辑预览模式）
  // 其次从 data-core.js 的全局变量读取
  // staff 数据按需追加
};

function loadStaffData() {
  if (window.STAFF_DATA) return Promise.resolve();
  return new Promise((resolve) => {
    const script = document.createElement('script');
    script.src = 'js/data-staff.js';
    script.onload = () => resolve();
    document.head.appendChild(script);
  });
}
```

命名空间也花了些心思。`data-core.js` 暴露 `window.CORE_DATA`，`data-staff.js` 暴露 `window.STAFF_DATA`，全局变量命名清晰，避免冲突。

---

## 🚀 部署：Push 即上线

部署链路极其简单：

```bash
git add js/data-core.js js/data-staff.js
git commit -m "update: 内容更新"
git push
# 约 1 分钟后，https://dalihaif.github.io/DFY/ 自动更新
```

背后是 `.github/workflows/pages.yml` 中一个标准的三步 Action：

1. `actions/checkout` — 拉取代码
2. `actions/configure-pages` — 配置 Pages 环境
3. `actions/upload-pages-artifact` + `actions/deploy-pages` — 打包上传部署

因为整个网站是纯静态 HTML/CSS/JS，不需要构建步骤。GitHub Actions 做的唯一事情就是把文件从仓库搬到 Pages 服务器。

**零运维**不是口号，是真的：没有服务器要维护，没有数据库要备份，没有证书要续期。GitHub 全包了。

---

## 🎨 样式与性能优化

几个值得一提的细节：

### CSS 合并

原始的样式文件分散在多个 `.css` 文件中——基础样式、板块样式、视觉特效样式。每次页面加载要发 3 个 HTTP 请求。

合并为单个 `bundle.css`（约 69KB），一次请求搞定。同时做了简单的去重和压缩，移除了未使用的选择器。

### 字体策略

中文网站的字体加载是个头疼的问题。思源字体完整包动辄几十 MB，不可能全量加载。

采用 `font-display: swap` + 按需子集化策略：
- 标题使用 Noto Serif TC（衬线，显庄重）
- 正文使用 Noto Sans TC（无衬线，读屏友好）
- CSS 中声明 `font-display: swap`，确保字体加载期间不阻塞文字渲染

### 模块化 HTML

`modules/` 目录下存放可复用的 HTML 片段（文化建设子模块、科室介绍、历史子模块等）。这些片段通过 `fetch()` 动态加载并插入 DOM，避免在多个页面中重复写相同的 HTML。

```javascript
async function loadModule(name, targetId) {
  const resp = await fetch(`modules/${name}.html`);
  const html = await resp.text();
  document.getElementById(targetId).innerHTML = html;
}
```

---

## 🧠 几个关键设计决策的复盘

### 为什么不用 React/Vue？

不是不会，是不需要。

这个项目的交互复杂度很低——本质上是"读数据 → 渲染 HTML"。用 React 或 Vue 会引入构建工具链（webpack/vite）、额外依赖（数 MB 的 JS bundle）、以及一个"构建 → 部署"的额外步骤。

原生 JS + 模板字符串，几十行代码就能搞定的事，引入框架反而增加维护负担。做技术选型，**够用**比**先进**更重要。

### 为什么不用 IndexedDB？

`localStorage` 有 5MB 上限，对于职工数据（2487 条约 580KB）来说绰绰有余。`IndexedDB` 的 API 更复杂，异步操作更多，在没有大数据存储需求的情况下是过度设计。

### 为什么导出 JS 而不是 JSON？

`data-core.js` 的内容本质就是一个巨大的 JSON 对象，赋给 `window.CORE_DATA`。导出为 `.js` 文件的好处是浏览器可以直接用 `<script>` 标签加载，不需要额外发一次 `fetch` + `JSON.parse`。对于首页的关键渲染路径，能省一个异步操作就省一个。

---

## 📈 项目现状与数据

| 指标 | 数值 |
|------|------|
| 内容板块 | 13 个 |
| 职工数据 | 2487 条 |
| 核心代码量 | 约 3000 行（admin.js）+ 约 800 行（main.js） |
| 核心数据体积 | ~50KB（data-core.js） |
| 职工数据体积 | ~580KB（data-staff.js） |
| 首屏 CSS 体积 | ~69KB（bundle.css，合并后） |
| 外部依赖 | AdminLTE 3 + Bootstrap 4 + Font Awesome 5 |
| 部署方式 | GitHub Pages，push 即上线 |
| 运维成本 | 零（无服务器、无数据库、无域名证书） |

---

## 💡 可复用的设计模式

这套架构不仅适用于医院院史馆。任何"内容需要偶尔更新，但不需要实时交互"的场景都能直接套用：

- 学校校史馆 / 校友录
- 企业官网 / 品牌展示站
- 政府机构的政务公开页
- 协会/社团的组织介绍与成员名录
- 个人作品集 / 知识库

核心思路总结成一句话：**用 localStorage 做编辑缓冲，用静态 JS 文件做发布载体，用 GitHub Pages 做免费服务器**。

不需要后端，不需要数据库，不需要 DevOps。一个人，一台电脑，一个 GitHub 仓库，就能运营一个五脏俱全的内容网站。

---

## 🔚 结语

做这个项目的过程中，我时常想起自己在档案室的日子。三十五年，我经手了无数档案——纸质卷宗、电子台账、扫描件、目录索引。医院的记忆，就封存在这些文件里。

现在，这些记忆有了一个新的载体：一个不需要服务器、不需要数据库、却能永久存续的数字展馆。只要 GitHub 还在，只要浏览器还能解析 HTML，它就能一直"开展"下去。

这大概就是技术的浪漫——以最轻量的方式，承载最厚重的历史。

---

*本文首发于老墨的博客，转载请注明出处。*

*项目地址：[github.com/dalihaif/DFY](https://github.com/dalihaif/DFY)*
