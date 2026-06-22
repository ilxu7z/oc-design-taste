---
profile: clean-minimalist
description: 干净编辑风格美学预设 — 暖单色调色板、排版对比、扁平 bento 网格、柔和粉彩、无渐变无重阴影
dial-suggestion: VARIANCE 4-5 / MOTION 2-3 / DENSITY 2-3
---

# 协议：高端功利极简主义与编辑 UI 架构师

## 1. 协议概述

**名称：** 高端功利极简主义与编辑 UI
**描述：** 一个高级前端工程指令，用于生成高度精致、超极简、"文档风格"的 Web 界面，类似于顶级工作空间平台。本协议严格执行高对比度暖单色调色板、定制排版层次、细致结构宏观留白、bento-grid 布局，以及带有刻意柔和粉彩强调的超扁平组件架构。它主动拒绝标准的通用 SaaS 设计趋势。

## 2. 绝对负面约束（禁止元素）

AI 必须严格避免以下通用 Web 开发默认值：
- 禁止使用 "Inter"、"Roboto" 或 "Open Sans" 字体。
- 禁止使用通用细线图标库如 "Lucide"、"Feather" 或标准 "Heroicons"。
- 禁止使用 Tailwind 的默认重投影（例如 `shadow-md`、`shadow-lg`、`shadow-xl`）。阴影必须几乎不存在，或重度定制为超扩散和低透明度（< 0.05）。
- 禁止为大型元素或区块使用主色背景（例如无亮蓝、绿或红色 Hero 区域）。
- 禁止使用渐变、霓虹色或 3D 玻璃态（超出微妙的导航栏模糊）。
- 禁止对大型容器、卡片或主按钮使用 `rounded-full`（药丸形状）。
- 禁止在代码、标记、文本内容、标题或 alt 文本中的任何位置使用 emoji。用适当的图标或干净的 SVG 原语替代。
- 禁止使用通用占位名称如 "John Doe"、"Acme Corp" 或 "Lorem Ipsum"。使用真实、上下文相关的内容。
- 禁止使用 AI 文案陈词滥调："Elevate"、"Seamless"、"Unleash"、"Next-Gen"、"Game-changer"、"Delve"。写平实、具体的语言。

## 3. 排版架构

界面必须依靠极端排版对比和优质字体选择来建立编辑感。
- **主无衬线（正文、UI、按钮）：** 使用有特色的干净几何或系统原生字体。目标：`font-family: 'SF Pro Display', 'Geist Sans', 'Helvetica Neue', 'Switzer', sans-serif`。
- **编辑衬线（Hero 标题与引用）：** 目标：`font-family: 'Lyon Text', 'Newsreader', 'Playfair Display', 'Instrument Serif', serif`。应用紧密字距（`letter-spacing: -0.02em` 到 `-0.04em`）和紧密行高（`1.1`）。
- **等宽（代码、按键、元数据）：** 目标：`font-family: 'Geist Mono', 'SF Mono', 'JetBrains Mono', monospace`。
- **文字颜色：** 正文绝不能用绝对黑色（`#000000`）。使用近黑/炭色（`#111111` 或 `#2F3437`），配合宽松的 `line-height` 为 `1.6` 以保证可读性。次要文字应为柔和灰色（`#787774`）。

## 4. 调色板（暖单色 + 点缀粉彩）

色彩是稀缺资源，仅用于语义含义或微妙强调。
- **画布 / 背景：** 纯白 `#FFFFFF` 或暖骨色/米白 `#F7F6F3` / `#FBFBFA`。
- **主表面（卡片）：** `#FFFFFF` 或 `#F9F9F8`。
- **结构边框 / 分隔线：** 超浅灰 `#EAEAEA` 或 `rgba(0,0,0,0.06)`。
- **强调色：** 独占使用高度去饱和、洗白的粉彩用于标签、内联代码背景或微妙图标背景。
  - 淡红：`#FDEBEC`（文字：`#9F2F2D`）
  - 淡蓝：`#E1F3FE`（文字：`#1F6C9F`）
  - 淡绿：`#EDF3EC`（文字：`#346538`）
  - 淡黄：`#FBF3DB`（文字：`#956400`）

## 5. 组件规格

- **Bento Box 功能网格：**
  - 使用非对称 CSS Grid 布局。
  - 卡片必须有精确的 `border: 1px solid #EAEAEA`。
  - 圆角必须干脆：最大 `8px` 或 `12px`。
  - 内边距必须慷慨（例如 `24px` 到 `40px`）。
- **主行动号召（按钮）：**
  - 实色背景 `#111111`，文字 `#FFFFFF`。
  - 轻微圆角（`4px` 到 `6px`）。无 box-shadow。
  - Hover 状态应为微妙的颜色变化至 `#333333` 或微缩放 `transform: scale(0.98)`。
- **标签与状态徽章：**
  - 药丸形状（`border-radius: 9999px`），非常小的排版（`text-xs`），全大写带宽字距（`letter-spacing: 0.05em`）。
  - 背景必须使用定义的柔和粉彩。
- **手风琴（FAQ）：**
  - 移除所有容器框。仅用 `border-bottom: 1px solid #EAEAEA` 分隔项目。
  - 使用干净、锐利的 `+` 和 `-` 图标表示切换状态。
- **按键微 UI：**
  - 使用 `<kbd>` 标签将快捷键渲染为物理按键：`border: 1px solid #EAEAEA`、`border-radius: 4px`、`background: #F7F6F3`，使用等宽字体。
- **伪 OS 窗口 Chrome：**
  - 模拟软件时，将其包裹在极简容器中，顶部为白色栏，包含三个小的浅灰色圆点（复制 macOS 窗口控件）。

## 6. 图标与图像指令

- **系统图标：** 使用 "Phosphor Icons（Bold 或 Fill 重量）" 或 "Radix UI Icons"，以获得技术性、稍粗描边的美学。标准化所有图标的描边宽度。
- **插图：** 单色、粗糙的连续线条墨笔素描在白色背景上，配以单个偏移几何形状，填充柔和粉彩色。
- **摄影：** 使用高质量、去饱和的图像，带暖色调。应用微妙覆盖层（`opacity: 0.04` 暖颗粒）将照片融入单色调色板。绝不过度使用饱和的库存照片。当真实资产不可用时，使用可靠的占位图如 `https://picsum.photos/seed/{context}/1200/800`。
- **Hero 与 Section 背景：** Section 不应感觉空荡平坦。使用极低透明度的微妙全宽背景图像、柔和径向光斑（`radial-gradient` 带暖色调 `opacity: 0.03`），或最小几何线条图案，在不破坏干净美学的前提下增加深度。

## 7. 微妙动效与微动画

动效应感觉无形——存在但从不分散注意力。目标是安静的精致，而非奇观。
- **滚动入场：** 元素在进入视口时柔和淡入。使用 `translateY(12px)` + `opacity: 0` 在 `600ms` 内解析为 `translateY(0)` + `opacity: 1`，使用 `cubic-bezier(0.16, 1, 0.3, 1)`。使用 `IntersectionObserver`，绝不用 `window.addEventListener('scroll')`。
- **Hover 状态：** 卡片通过超微妙的阴影变化抬起（`box-shadow` 从 `0 0 0` 过渡到 `0 2px 8px rgba(0,0,0,0.04)` 在 `200ms` 内）。按钮在 `:active` 时响应 `scale(0.98)`。
- **交错揭示：** 列表和网格项以级联延迟进入（`animation-delay: calc(var(--index) * 80ms)`）。绝不同时挂载所有内容。
- **背景环境动效：** 可选。单个极慢移动的径向渐变斑点（`animation-duration: 20s+`、`opacity: 0.02-0.04`）在 Hero 区域后漂移。必须应用于 `position: fixed; pointer-events: none` 层。绝不在滚动容器上。
- **性能：** 独占通过 `transform` 和 `opacity` 动画。无触发布局的属性（`top`、`left`、`width`、`height`）。克制使用 `will-change: transform`，仅用于实际动画中的元素。

## 8. 执行协议

当被要求编写前端代码（HTML、React、Tailwind、Vue）或设计布局时：
1. 首先建立宏观留白。在 section 之间使用巨大垂直内边距（例如 Tailwind 中的 `py-24` 或 `py-32`）。
2. 将主要排版内容宽度限制为 `max-w-4xl` 或 `max-w-5xl`。
3. 立即应用自定义排版层次和单色颜色变量。
4. 确保每张卡片、分隔线和边框严格遵守 `1px solid #EAEAEA` 规则。
5. 为所有主要内容块添加滚动入场动画。
6. 确保 section 通过图像、环境渐变或微妙纹理具有视觉深度——无空荡平坦背景。
7. 提供原生反映这种高端、整洁、编辑美学的代码，无需手动调整。
