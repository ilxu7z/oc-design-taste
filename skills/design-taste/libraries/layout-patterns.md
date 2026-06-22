---
library: layout-patterns
description: 布局模式参考 — 从原版 v1 Section 8（Creative Arsenal 布局部分完整提取）+ 原版 Section 9 布局部分。含每种布局的 CSS/Tailwind 实现要点和布局选择决策树。
---

# Layout Patterns — 布局模式参考

> 每种布局模式标注 CSS/Tailwind 实现要点、适用场景和三旋钮建议值。
> 布局选择决策树见底部。

---

## Bento Grid（Bento 网格）

非对称、基于 tile 的分组布局，灵感来自 Apple Control Center。内容块按重要性分配空间。

**适用场景：** Feature section、Dashboard 概览、作品集网格
**三旋钮建议：** VARIANCE 6-9 / MOTION 3-7 / DENSITY 3-6

### CSS / Tailwind 实现要点

```css
/* CSS Grid 基础 */
.bento-grid {
  display: grid;
  grid-template-columns: repeat(12, 1fr);
  gap: 1rem;
  grid-auto-flow: dense;
}

.bento-cell-large {
  grid-column: span 6;
  grid-row: span 2;
}

.bento-cell-medium {
  grid-column: span 4;
  grid-row: span 1;
}

.bento-cell-small {
  grid-column: span 3;
  grid-row: span 1;
}
```

```html
<!-- Tailwind 实现 -->
<div class="grid grid-cols-12 gap-4 auto-rows-[200px]">
  <div class="col-span-6 row-span-2">Large cell</div>
  <div class="col-span-3 row-span-1">Small cell</div>
  <div class="col-span-3 row-span-1">Small cell</div>
  <div class="col-span-4 row-span-1">Medium cell</div>
  <div class="col-span-4 row-span-1">Medium cell</div>
  <div class="col-span-4 row-span-1">Medium cell</div>
</div>
```

### 关键纪律

| 规则 | 说明 |
|------|------|
| 格子数 = 内容数 | N 项内容 → N 个格子，不留空单元格 |
| 背景多样性 | 至少 2-3 格有图片/渐变/有色背景，不全白底纯文字 |
| 有节奏 | 不堆叠 6 个左图右文行，交替全宽行和非对称 tile |
| 移动端退化 | < 768px 所有 `col-span` 重置为 `col-span-1`，单列堆叠 |
| Gapless | 用 `grid-flow-dense` + 数学验证 col-span/row-span 完美互锁 |

---

## Masonry Layout（瀑布流布局）

交错网格，无固定行高。每项高度不同，形成自然瀑布流。

**适用场景：** 作品集、博客列表、图片画廊、Pinterest 式内容浏览
**三旋钮建议：** VARIANCE 6-9 / MOTION 2-5 / DENSITY 4-7

### CSS / Tailwind 实现要点

```css
/* 方案 A：CSS columns（推荐，原生支持好） */
.masonry {
  column-count: 3;
  column-gap: 1rem;
}

.masonry-item {
  break-inside: avoid;
  margin-bottom: 1rem;
}

/* 方案 B：CSS Grid + dense（适合等宽列） */
.masonry-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 1rem;
  grid-auto-rows: min-content;
}
```

```html
<!-- Tailwind 实现（columns 方案） -->
<div class="columns-1 md:columns-2 lg:columns-3 gap-4">
  <div class="break-inside-avoid mb-4">
    <img src="..." class="w-full rounded-lg" />
    <p class="mt-2">Caption</p>
  </div>
  <!-- 更多项... -->
</div>
```

### 关键纪律

- `break-inside: avoid` 防止项跨列断裂
- 列数响应式：`columns-1 md:columns-2 lg:columns-3`
- 每项 `margin-bottom` 统一，保持垂直节奏
- 图片用 `w-full h-auto` 确保自适应列宽

---

## Split Screen Scroll（分屏滚动）

页面垂直分为左右两半，滚动时两侧以不同速度或方向移动。

**适用场景：** 对比展示（Before/After）、案例研究、品牌故事
**三旋钮建议：** VARIANCE 7-10 / MOTION 6-9 / DENSITY 2-4

### CSS / Tailwind 实现要点

```css
/* 基础分屏 */
.split-screen {
  display: flex;
  min-height: 100dvh;
}

.split-left,
.split-right {
  width: 50%;
  overflow: hidden;
}

/* 左侧固定内容，右侧滚动图片 */
.split-left {
  position: sticky;
  top: 0;
  height: 100dvh;
  display: flex;
  align-items: center;
  justify-content: center;
}

.split-right {
  /* 正常滚动 */
}
```

```html
<!-- Tailwind 实现 -->
<section class="flex min-h-[100dvh]">
  <!-- 左侧固定 -->
  <div class="sticky top-0 w-1/2 h-[100dvh] flex items-center justify-center p-12">
    <div>
      <h2 class="text-4xl font-bold">Before</h2>
      <p class="mt-4 text-gray-600 max-w-md">Description...</p>
    </div>
  </div>
  <!-- 右侧滚动 -->
  <div class="w-1/2">
    <div class="h-[100dvh] bg-gray-100 flex items-center justify-center">Image 1</div>
    <div class="h-[100dvh] bg-gray-200 flex items-center justify-center">Image 2</div>
    <div class="h-[100dvh] bg-gray-300 flex items-center justify-center">Image 3</div>
  </div>
</section>
```

### 变体

- **反向滚动：** 左右两侧以相反方向平移（GSAP ScrollTrigger）
- **上下分屏：** 上半和下半，上半固定，下半滚动
- **速度差：** 两侧以不同速度滚动（parallax 效果）

### 关键纪律

- 移动端 < 768px 退化为上下堆叠（左侧在上，右侧在下）
- 左侧固定内容高度 = 右侧滚动内容总高度，否则底部出现空白
- 用 `sticky top-0` 而非 `fixed`，避免脱离文档流

---

## Curtain Reveal（幕布展开）

Section 在滚动时像幕布一样从中间向两侧展开，露出内容。

**适用场景：** 产品揭幕、数据揭示、品牌故事高潮部分
**三旋钮建议：** VARIANCE 7-10 / MOTION 7-10 / DENSITY 2-4

### CSS / Tailwind 实现要点

```css
/* 方案 A：clip-path 动画 */
.curtain-reveal {
  clip-path: inset(0 50% 0 50%);
  transition: clip-path 1.5s cubic-bezier(0.16, 1, 0.3, 1);
}

.curtain-reveal.is-visible {
  clip-path: inset(0 0 0 0);
}

/* 方案 B：左右两半滑动 */
.curtain-left,
.curtain-right {
  position: absolute;
  top: 0;
  width: 50%;
  height: 100%;
  background: var(--color-surface);
  transition: transform 1.2s cubic-bezier(0.16, 1, 0.3, 1);
}

.curtain-left {
  left: 0;
  transform: translateX(0);
}

.curtain-right {
  right: 0;
  transform: translateX(0);
}

.curtain-reveal.is-visible .curtain-left {
  transform: translateX(-100%);
}

.curtain-reveal.is-visible .curtain-right {
  transform: translateX(100%);
}
```

### 关键纪律

- 用 IntersectionObserver 或 ScrollTrigger 触发 `is-visible`
- 内容在幕布后面预先渲染，幕布移开后显示
- 移动端退化为简单 fade-in（clip-path 在窄屏上效果不佳）
- 配合 `overflow: hidden` 防止幕布移动时出现滚动条

---

## Chroma Grid（变色网格）

网格边框或 tile 显示持续渐变的色彩动画。

**适用场景：** 科技品牌、AI 产品、创意 agency
**三旋钮建议：** VARIANCE 7-10 / MOTION 6-9 / DENSITY 3-5

### CSS / Tailwind 实现要点

```css
.chroma-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 1px;
  background: linear-gradient(135deg, #667eea, #764ba2, #f093fb);
  background-size: 200% 200%;
  animation: chroma-shift 8s ease infinite;
}

@keyframes chroma-shift {
  0% { background-position: 0% 50%; }
  50% { background-position: 100% 50%; }
  100% { background-position: 0% 50%; }
}

.chroma-item {
  background: white;
  padding: 2rem;
}
```

### 关键纪律

- 网格 `gap` 作为"边框"显示渐变
- 每项背景白色，网格背景渐变
- 移动端可减小 gap 或关闭动画

---

## 其他布局模式

### Sticky-Stack Sections（粘性堆叠 Section）

多个 section 在滚动时依次固定并堆叠。详见 motion-patterns.md 的 GSAP Sticky-Stack 骨架。

**实现要点：** GSAP ScrollTrigger `pin: true` + `start: "top top"`，每张卡片（最后一张除外）被 pin，前一张 scale/opacity 由下一张的 scroll trigger 驱动。

### Horizontal Scroll Hijack（水平滚动劫持）

垂直滚动转化为水平平移。详见 motion-patterns.md 的 GSAP Horizontal-Pan 骨架。

**实现要点：** wrapper 被 pin，内部 track 水平滑动。`end: "+=${distance}"` 滚动长度 = 水平滑动距离。

### Accordion Image Slider（手风琴图片滑块）

多张图片并排为窄竖条，hover 时当前条展开。

**实现要点：**
```css
.accordion-slider {
  display: flex;
  height: 400px;
}

.accordion-item {
  flex: 1;
  transition: flex 0.5s cubic-bezier(0.16, 1, 0.3, 1);
  overflow: hidden;
}

.accordion-item:hover {
  flex: 3;
}
```

### Zoom Parallax（缩放视差）

背景图片在滚动时缩放。

**实现要点：**
```css
.zoom-parallax {
  position: relative;
  overflow: hidden;
  height: 100dvh;
}

.zoom-parallax-bg {
  position: absolute;
  inset: -20%;
  background-size: cover;
  background-position: center;
  /* 用 GSAP ScrollTrigger 从 scale(1.2) 到 scale(1) */
}
```

---

## 布局选择决策树

### 第一步：确定内容类型

```
内容类型是什么？
├── 图片为主（画廊/作品集）
│   ├── 大量图片（>10） → Masonry / Drag-to-Pan Grid
│   ├── 精选图片（3-8） → Bento Grid / Accordion Slider
│   └── 单张 Hero 图片 → Asymmetric Split Hero
├── 文字为主（品牌/文章）
│   ├── 长篇叙事 → Split Screen Scroll / Sticky-Stack
│   ├── 短篇列表 → Bento Grid / 标准 Grid
│   └── 宣言式 → Editorial Manifesto Hero
├── 数据为主（Dashboard/规格）
│   ├── 概览 → Bento Grid / Chroma Grid
│   └── 详细 → 标准表格 / 卡片网格
└── 混合（图文并茂）
    ├── 对比展示 → Split Screen Scroll
    ├── 功能介绍 → Bento Grid / Sticky-Stack
    └── 案例研究 → Split Screen / Horizontal Pan
```

### 第二步：根据旋钮值筛选

```
DESIGN_VARIANCE:
├── 1-3（可预测）
│   → 标准 CSS Grid 12列、居中对齐、统一间距
│   → 避免 Bento / Masonry / Split Screen
├── 4-7（偏移）
│   → Bento Grid、非对称分栏、错位布局
│   → Split Screen、Accordion Slider
└── 8-10（非对称）
    → Masonry、极端留白、Sticky-Stack
    → Horizontal Pan、Curtain Reveal

MOTION_INTENSITY:
├── 1-3（静态）
│   → 无滚动动效的布局：标准 Grid、Bento（静态）
│   → 避免 Sticky-Stack、Horizontal Pan
├── 4-7（流畅）
│   → Bento + scroll-reveal、Split Screen
│   → Accordion Slider（hover 动效）
└── 8-10（编排）
    → Sticky-Stack、Horizontal Pan、Curtain Reveal
    → Zoom Parallax、Chroma Grid（动画版）

VISUAL_DENSITY:
├── 1-3（美术馆）
│   → 大留白、单列、少内容块
│   → 适合 Editorial Manifesto、Split Screen
├── 4-7（日常）
│   → Bento Grid、标准 Grid、Accordion
│   → 大多数场景的默认
└── 8-10（驾驶舱）
    → 紧凑 Grid、Masonry（信息密集）
    → 无卡片容器、细线分隔
```

### 第三步：检查布局多样性

```
一个页面有 N 个 section，至少需要 ceil(N/2) 种不同布局家族。

示例：8 个 section → 至少 4 种不同布局
├── Hero: Asymmetric Split
├── Feature: Bento Grid
├── Story: Sticky-Stack
├── Gallery: Masonry
├── Quote: 全宽居中
├── CTA: Split Screen
├── Stats: Chroma Grid
└── Footer: 标准三列

禁止连续 3 个 section 用同一布局家族。
Zigzag（左图右文 → 左文右图）最多连续 2 段。
```

### 第四步：移动端退化检查

```
每个多栏布局在 < 768px 必须声明退化方案：

Bento Grid:      所有 col-span → col-span-1，单列堆叠
Masonry:         columns-1，单列
Split Screen:    上下堆叠（左在上/右在下）
Sticky-Stack:    取消 sticky，改为普通顺序排列
Horizontal Pan:  取消水平滚动，改为垂直列表
Accordion:       改为普通 grid 或列表
Chroma Grid:     columns-2 或 columns-1
Curtain Reveal:  改为简单 fade-in

通用退化：w-full px-4 py-8，隐藏装饰性元素
```

### 第五步：最终检查清单

- [ ] 所选布局匹配内容类型（图片/文字/数据/混合）
- [ ] 布局在 VARIANCE 旋钮范围内
- [ ] 布局的动效需求在 MOTION 旋钮范围内
- [ ] 布局的信息密度匹配 DENSITY 旋钮
- [ ] 页面有足够的布局多样性（≥ ceil(N/2) 种）
- [ ] 无连续 3 个 section 用同一布局
- [ ] 移动端退化方案已声明
- [ ] Bento 格子数 = 内容数，无空单元格
- [ ] 非对称布局在 < 768px 退化为单列
