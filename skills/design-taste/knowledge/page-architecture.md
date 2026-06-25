---
knowledge: page-architecture
description: 页面结构框架 — AIDA强制结构、Gapless Bento数学验证、Section级间距规则、Hero架构选项。来自 gpt-tasteskill 的精华融合。
---

# 页面结构框架 · Page Architecture

> 页面不是组件的堆砌——它是有呼吸的叙事结构。
> 本文件定义页面的**宏观架构**，不涉及组件内部细节。

---

## 1. AIDA 页面结构（默认策略，非强制）

AIDA 是推荐起点，但根据三旋钮可降级。**AIDA 不是法律——是默认结构。**

### 各段要求

| 阶段 | 目的 | 视觉特征 | 最小高度 |
|------|------|---------|---------|
| **Attention** | 抓住第一眼 | 电影感、干净、宽布局 | `min-h-[90dvh]` |
| **Interest** | 展示核心价值 | 高密度、数学完美的网格或交互排版 | `py-32 md:py-48` |
| **Desire** | 激发拥有欲 | 固定区域、水平滚动、文字揭示 | `py-32 md:py-48` |
| **Action** | 推动转化 | 巨大高对比 CTA + 干净 Footer | `py-24 md:py-32` |

### 三旋钮降级规则

| 三旋钮组合 | AIDA 降级 | 说明 |
|-----------|---------|------|
| VARIANCE ≤ 3 且 DENSITY ≤ 3 | 省略 Desire 段 | 极简页面不需要 GSAP 媒体展示 |
| MOTION ≤ 3 | Desire 段降级为静态展示 | 无滚动动画 |
| DENSITY ≥ 8 | Interest + Desire 可合并 | 驾驶舱密度不需要分章节 |
| Product 寄存器 / 工具页 | 整个 AIDA 不适用 | 走 Product 寄存器规则 |
| 单 section 页面 | 只有 Attention | 不需要结构框架 |

### AIDA 验证清单

在 `<design_plan>` 中确认：
- [ ] Navigation 存在且风格匹配
- [ ] Attention (Hero) 存在且 ≤3 行标题
- [ ] Interest (Features/Bento) 存在且无空洞格子
- [ ] Desire (GSAP/媒体) 存在且有交互
- [ ] Action (CTA/Footer) 存在且 CTA 对比度充足

---

## 2. Section 间距规则

Section 之间必须有巨大的垂直间距，让每个 section 感觉像独立的电影章节。

```
py-32 md:py-48  ← 主要 section 间（Interest, Desire）
py-24 md:py-32  ← 次要 section 间（Action, 辅助内容）
py-16 md:py-24  ← 紧密 section 间（子功能组）
```

**禁止：** 紧凑排列 section（`py-8`/`py-12`）。拥挤 = 廉价。

---

## 3. Hero 架构选项

Hero 必须呼吸。不能是窄容器 6 行文字墙。

### 容器宽度规则

H1 必须使用超宽容器：`max-w-5xl`、`max-w-6xl`、`w-full`。
让文字水平流动，不要垂直堆叠。

### 行数铁律

H1 **绝对不超过 2-3 行**。4/5/6 行是灾难性失败。
解决：缩小字号到 `clamp(2.5rem, 5vw, 5rem)`，加宽容器。

### Hero 布局选项

| # | 布局 | 描述 | 适用 VARIANCE |
|---|------|------|-------------|
| 1 | **Cinematic Center** | 文字居中、超宽、两个高对比 CTA 在下方、全出血背景图 + 暗色径向渐变 | 6-8 |
| 2 | **Artistic Asymmetry** | 文字偏左、艺术浮动图从右下重叠文字 | 8-10 |
| 3 | **Editorial Split** | 文字左、图片右、巨大负空间 | 5-7 |
| 4 | **Bottom-Left Over Image** | 文字在左下角、全屏背景图 | 6-8 |
| 5 | **Mini Minimalist** | 小字号、大量留白、单行标题 | 3-5 |
| 6 | **Stacked Center** | 文字居中、图片在下方、垂直堆叠 | 4-6 |

### Hero 禁令

- ❌ 文字上方浮动 stamp/badge 图标
- ❌ Hero 下方 pill-tag 标签
- ❌ Hero 中放原始数据/统计数字
- ❌ 窄容器（`max-w-2xl`/`max-w-3xl`）做 Hero 标题
- ❌ 4 行以上的标题

### 按钮对比度

- 深色背景 → 白色文字按钮
- 浅色背景 → 深色文字按钮
- **不可见文字 = 失败**

---

## 4. Gapless Bento Grid（无空洞网格）

### 问题

LLM 在 CSS Grid 中留下空白死格。这是 AI 生成的标志性缺陷。

### 解决方案

```css
.grid {
  grid-auto-flow: dense; /* 强制填充空洞 */
}
```

### 数学验证

在 `<design_plan>` 中验证：
```
Grid: 12 columns
Card 1: col-span-8 row-span-2  → 占 8×2 = 16 cells
Card 2: col-span-4 row-span-1  → 占 4×1 = 4 cells
Card 3: col-span-4 row-span-1  → 占 4×1 = 4 cells
Card 4: col-span-6 row-span-1  → 占 6×1 = 6 cells
Card 5: col-span-6 row-span-1  → 占 6×1 = 6 cells
─────────────────────────────────────────
Row 1: 8 + 4 = 12 ✓
Row 2: 8 + 4 = 12 ✓
Row 3: 6 + 6 = 12 ✓
Total: 3 rows, 36 cells, 0 empty ✓
```

### 卡片数量限制

3-5 张高度有意的精美卡片 > 8 张杂乱的卡片。
每张卡片填充：大图、密集排版、或 CSS 效果——不能是空壳。

---

## 5. 布局多样性强制

### 连续布局限制

| 布局模式 | 连续上限 | 第 N+1 次换什么 |
|---------|---------|---------------|
| Zigzag（左图右文） | 2 组 | 换全宽、Bento、水平滚动 |
| 三列卡片 | 0（永远禁止） | 换 Zigzag、Bento、Masonry |
| 居中对称 | 1 个 section | 换非对称 |
| 全宽背景图 | 2 个 section | 换纯色/纹理背景 |

### 布局轮换示例

```
Section 1 (Hero):     Cinematic Center
Section 2 (Features): 2-col Zigzag
Section 3 (Showcase): Bento Grid (3 cards)
Section 4 (Stats):    Horizontal Scroll
Section 5 (CTA):      Full-width Dark
```

---

## 6. Meta-Label 禁令

以下标签**永远禁止**出现在页面上：
- "SECTION 01" / "SECTION 04"
- "QUESTION 05"
- "ABOUT US"（作为装饰标签，不是导航）
- "FEATURES"（作为 section 眉毛）
- "OUR PROCESS"

这些是 AI 的脚手架标记，不是设计元素。它们让页面看起来廉价和不专业。

**例外：** 作为导航链接文字（不是装饰标签）时可以使用。

---

## 7. 图片策略

### 占位图片

使用 `https://picsum.photos/seed/{keyword}/{width}/{height}`，keyword 匹配品牌 vibe。

### CSS 滤镜提升

对占位图片应用 CSS 滤镜，让它们不看起来像无聊的 stock photo：
```css
.image-enhanced {
  filter: grayscale(0.2) contrast(1.1) brightness(0.95);
  mix-blend-mode: luminosity; /* 与背景融合 */
}
```

### 背景氛围

注入微妙的专业氛围：
- 深层径向模糊
- 颗粒网格渐变
- 偏移暗色叠加
- 避免平面纯色

---

## 8. 水平溢出防护

```html
<main class="overflow-x-hidden w-full max-w-full">
  <!-- 所有内容 -->
</main>
```

绝对防止屏幕外动画造成的水平滚动条。这是生产级必须。
