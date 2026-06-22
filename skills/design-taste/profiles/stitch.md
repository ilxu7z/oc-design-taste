---
profile: stitch
description: Stitch 语义设计系统美学预设 — 面向 Google Stitch 屏幕生成的 DESIGN.md 文件，强制 premium、反通用 UI 标准
dial-suggestion: VARIANCE 6-8 / MOTION 6-8 / DENSITY 3-5
---

# Stitch 设计品味 — 语义设计系统技能

## 概述
此技能生成针对 Google Stitch 屏幕生成优化的 `DESIGN.md` 文件。它将经过实战检验的反低质前端工程指令转化为 Stitch 的原生语义设计语言——描述性、自然语言的规则配合精确的值，Stitch 的 AI Agent 可以解释这些规则以产生 premium、非通用的界面。

生成的 `DESIGN.md` 作为提示 Stitch 生成新屏幕的**单一事实来源**，这些屏幕与精心策划的高品质设计语言保持一致。Stitch 通过**"视觉描述"**配合特定颜色值、排版规格和组件行为来解释设计。

## 前提条件
- 通过 [labs.google/stitch](https://labs.google/stitch) 访问 Google Stitch
- 可选：Stitch MCP Server 用于与 Cursor、Antigravity 或 Gemini CLI 的程序化集成

## 目标
生成一个 `DESIGN.md` 文件，编码以下内容：
1. **视觉氛围** — 情绪、密度和设计哲学
2. **色彩校准** — 中性色、强调色和禁止模式，带 hex 代码
3. **排版架构** — 字体栈、层次比例和反模式
4. **组件行为** — 按钮、卡片、输入框及其交互状态
5. **布局原则** — 网格系统、间距哲学、响应式策略
6. **动效哲学** — 动画引擎规格、弹簧物理、永久微交互
7. **反模式** — AI 设计陈词滥调的明确禁止列表

## 分析与综合说明

### 1. 定义氛围
评估目标项目的意图。使用品味谱系中的唤起性形容词：
- **密度：** "Art Gallery Airy"（1-3）→ "Daily App Balanced"（4-7）→ "Cockpit Dense"（8-10）
- **变化：** "Predictable Symmetric"（1-3）→ "Offset Asymmetric"（4-7）→ "Artsy Chaotic"（8-10）
- **动效：** "Static Restrained"（1-3）→ "Fluid CSS"（4-7）→ "Cinematic Choreography"（8-10）

默认基线：Variance 8、Motion 6、Density 4。根据用户的氛围描述动态调整。

### 2. 映射调色板
为每种颜色提供：**描述性名称** + **Hex 代码** + **功能角色**。

**强制约束：**
- 最多 1 个强调色。饱和度低于 80%
- "AI 紫/蓝霓虹"美学严格禁止——无紫色按钮发光，无霓虹渐变
- 使用绝对中性基色（Zinc/Slate）配合高对比度单一强调色
- 整个输出坚持一个调色板——无暖/冷灰波动
- 绝不用纯黑（`#000000`）——使用 Off-Black、Zinc-950 或 Charcoal

### 3. 建立排版规则
- **显示/标题：** 紧密字距、受控比例。不喊叫。通过重量和颜色而非仅靠巨大尺寸建立层次
- **正文：** 宽松行高，每行最多 65 字符
- **字体选择：** `Inter` 在 premium/创意上下文中禁止。强制独特字符：`Geist`、`Outfit`、`Cabinet Grotesk` 或 `Satoshi`
- **衬线禁令：** 通用衬线字体（`Times New Roman`、`Georgia`、`Garamond`、`Palatino`）禁止。如果 editorial/创意上下文需要衬线，仅使用独特的现代衬线：`Fraunces`、`Gambarino`、`Editorial New` 或 `Instrument Serif`。衬线在仪表盘或软件 UI 中始终禁止
- **仪表盘约束：** 独占使用无衬线配对（`Geist` + `Geist Mono` 或 `Satoshi` + `JetBrains Mono`）
- **高密度覆盖：** 当密度超过 7 时，所有数字必须使用等宽字体

### 4. 定义 Hero 区域
Hero 是第一印象，必须创意、引人注目且绝不通用：
- **内联图像排版：** 在标题的单词或字母之间嵌入小的、上下文相关的照片或视觉元素。图像以 type-height 内联放置，圆角，充当视觉标点。这是标志性创意技术
- **无重叠：** 文字绝不能与图像或其他文字重叠。每个元素占据自己干净的空间区域
- **无填充文字：** "Scroll to explore"、"Swipe down"、滚动箭头图标、弹跳 chevron 全部禁止。内容应自然吸引用户
- **非对称结构：** 当 variance 超过 4 时，居中 Hero 布局禁止。使用分屏（50/50）、左对齐文字/右视觉，或带大空区域的不对称留白
- **CTA 克制：** 最多一个主 CTA。无次要 "Learn more" 链接

### 5. 描述组件样式
对每种组件类型，描述形状、颜色、阴影深度和交互行为：
- **按钮：** 活跃状态下的触觉按压反馈。无霓虹外发光。无自定义鼠标光标
- **卡片：** 仅当 elevation 传达层次时使用。将阴影色调调整为背景色。对于高密度布局，用 border-top 分隔线或负空间替代卡片
- **输入框/表单：** 标签在输入框上方，帮助文字可选，错误文字在下方。标准间距
- **加载状态：** 匹配布局尺寸的骨架加载器——无通用圆形 spinner
- **空状态：** 指示如何填充数据的构图
- **错误状态：** 清晰、内联的错误报告

### 6. 定义布局原则
- 无重叠元素——每个元素占据自己清晰的空间区域。无绝对定位的内容堆叠
- 当 variance 超过 4 时，居中 Hero 区域禁止——强制分屏、左对齐或不对称留白
- 通用"3 张等宽卡片水平排列"功能行禁止——使用 2 列 Zig-Zag、不对称网格或水平滚动
- CSS Grid 优先于 Flexbox 数学——绝不用 `calc()` 百分比 hack
- 使用 max-width 约束包含布局（例如 1400px 居中）
- 全高 section 必须使用 `min-h-[100dvh]`——绝不用 `h-screen`（iOS Safari 灾难性跳跃）

### 7. 定义响应式规则
每个设计必须在所有视口上完美工作：
- **移动优先退化（< 768px）：** 所有多列布局退化为单列。无例外
- **无水平滚动：** 移动端水平溢出是严重失败
- **排版缩放：** 标题通过 `clamp()` 缩放。正文最小 `1rem`/`14px`
- **触摸目标：** 所有交互元素最小 `44px` 触摸目标
- **图像行为：** 内联排版图像（单词间的照片）在移动端堆叠在标题下方
- **导航：** 桌面水平导航退化为干净移动菜单
- **间距：** 垂直 section 间距按比例缩小（`clamp(3rem, 8vw, 6rem)`）

### 8. 编码动效哲学
- **弹簧物理默认：** `stiffness: 100, damping: 20`——premium、有重量的感觉。无 linear easing
- **永久微交互：** 每个活跃组件应有无限循环状态（Pulse、Typewriter、Float、Shimmer）
- **交错编排：** 绝不同时挂载列表——使用级联延迟实现瀑布揭示
- **性能：** 独占通过 `transform` 和 `opacity` 动画。绝不动画 `top`、`left`、`width`、`height`。颗粒/噪点滤镜仅用于固定伪元素

### 9. 列出反模式（AI 痕迹）
在 DESIGN.md 中将这些编码为明确的"绝不"规则：
- 无 emoji 在任何位置
- 无 `Inter` 字体
- 无通用衬线字体（`Times New Roman`、`Georgia`、`Garamond`）——仅在需要时使用独特的现代衬线
- 无纯黑（`#000000`）
- 无霓虹/外发光阴影
- 无过度饱和的强调色
- 无大型标题上的过度渐变文字
- 无自定义鼠标光标
- 无重叠元素——始终保持干净空间分离
- 无 3 列等宽卡片布局
- 无通用名称（"John Doe"、"Acme"、"Nexus"）
- 无假整数（`99.99%`、`50%`）
- 无 AI 文案陈词滥调（"Elevate"、"Seamless"、"Unleash"、"Next-Gen"）
- 无填充 UI 文字："Scroll to explore"、"Swipe down"、滚动箭头、弹跳 chevron
- 无损坏的 Unsplash 链接——使用 `picsum.photos` 或 SVG 头像
- 无居中 Hero 区域（对于高 variance 项目）

---

# 设计系统：品味标准
**技能：** stitch-design-taste

---

## 配置 — 设置你的风格
在使用此设计系统前调整这些旋钮。它们控制输出的创意性、密度和动画程度。选择适合你项目的级别。

| 旋钮 | 级别 | 描述 |
|------|------|------|
| **Creativity** | `8` | `1` = 超极简、瑞士、安静、单色。`5` = 平衡、干净但有性格。`10` = 表现力、编辑、大胆排版实验、标题中的内联图像、强不对称。默认：`8` |
| **Density** | `4` | `1` = 画廊通风、大量留白。`5` = 平衡 section。`10` = 驾驶舱密集、数据重。默认：`4` |
| **Variance** | `8` | `1` = 可预测、对称网格。`5` = 微妙偏移。`10` = 艺术混乱、无两个 section 相同。默认：`8` |
| **Motion Intent** | `6` | `1` = 静态、无动画。`5` = 微妙 hover/入场提示。`10` = 电影编排在每个组件中。默认：`6` |

> **如何使用：** 更改上面的数字以匹配你项目的氛围。在 **Creativity 1-3** 时，系统产生干净、安静、Notion 风格的界面。在 **Creativity 7-10** 时，期望内联图像排版、戏剧性比例对比和强编辑布局。其余规则根据你选择的级别调整。

---

## 1. 视觉主题与氛围
一个克制、画廊通风的界面，带有自信的非对称布局和流畅的弹簧物理动效。氛围临床而温暖——像一个光线充足的建筑工作室，每个元素通过功能赢得自己的位置。密度平衡（Level 4），variance 高（Level 8）以防止对称无聊，动效流畅但不过分戏剧化（Level 6）。整体印象：昂贵、有意图、有生命力。

## 2. 调色板与角色
- **Canvas White**（#F9FAFB）— 主背景表面。暖中性，绝不含临床蓝白
- **Pure Surface**（#FFFFFF）— 卡片和容器填充。配合 Whisper Shadow 使用以表达 elevation
- **Charcoal Ink**（#18181B）— 主文字。Zinc-950 深度——绝不用纯黑
- **Steel Secondary**（#71717A）— 正文、描述、元数据。Zinc-500 温暖
- **Muted Slate**（#94A3B8）— 三级文字、时间戳、禁用状态
- **Whisper Border**（rgba(226,232,240,0.5)）— 卡片边框、结构 1px 线。半透明以增加深度
- **Diffused Shadow**（rgba(0,0,0,0.05)）— 卡片 elevation。宽扩散、40px 模糊、-15px 偏移。绝不生硬

### 强调色选择（每个项目选 ONE）
- **Emerald Signal**（#10B981）— 用于增长、成功、积极数据仪表盘
- **Electric Blue**（#3B82F6）— 用于生产力、SaaS、开发者工具
- **Deep Rose**（#E11D48）— 用于创意、编辑、时尚相关项目
- **Amber Warmth**（#F59E0B）— 用于社区、社交、暖色调产品

### 禁止颜色
- 紫/紫罗兰霓虹渐变——"AI 紫"美学
- 纯黑（#000000）——始终用 Off-Black 或 Zinc-950
- 饱和度超过 80% 的过度饱和强调色
- 一个项目内混合暖/冷灰系统

## 3. 排版规则
- **显示：** `Geist`、`Satoshi`、`Cabinet Grotesk` 或 `Outfit`——紧密字距（`-0.025em`）、受控流式比例、重量驱动层次（700-900）。不喊叫。行高压缩（`1.1`）。强制替代——`Inter` 在 premium 上下文中禁止
- **正文：** 同族重量 400——宽松行高（`1.65`）、65ch 最大宽度、Steel Secondary 颜色（#71717A）
- **等宽：** `Geist Mono` 或 `JetBrains Mono`——用于代码块、元数据、时间戳。当密度超过 Level 7 时，所有数字切换到等宽
- **比例：** 显示 `clamp(2.25rem, 5vw, 3.75rem)`。正文 `1rem/1.125rem`。等宽元数据 `0.8125rem`

### 禁止字体
- `Inter`——在 premium/创意上下文中所有位置禁止
- 通用衬线字体（`Times New Roman`、`Georgia`、`Garamond`、`Palatino`）——禁止。如果 editorial/创意需要衬线，仅使用独特的现代衬线如 `Fraunces`、`Gambarino`、`Editorial New` 或 `Instrument Serif`。绝不用默认浏览器衬线堆栈。衬线在仪表盘或软件 UI 中始终禁止

## 4. 组件样式
* **按钮：** 平坦表面，无外发光。主按钮：强调色填充 + 白色文字。次按钮：ghost/outline。活跃状态：`-1px translateY` 或 `scale(0.98)` 实现触觉按压。Hover：微妙背景变化，绝无发光
* **卡片/容器：** 慷慨圆角（`2.5rem`）。纯白填充。Whisper 边框（`1px`，半透明）。扩散阴影（`0 20px 40px -15px rgba(0,0,0,0.05)`）。内部内边距 `2rem-2.5rem`。仅当 elevation 传达层次时使用——高密度布局用 `border-top` 分隔线或负空间替代卡片
* **输入框/表单：** 标签位于输入框上方。帮助文字可选。错误文字在下方，Deep Rose 颜色。焦点环为强调色，`2px` 偏移。无浮动标签。标准 `0.5rem` 标签-输入框-错误堆叠间距
* **导航：** 流畅、粘性。图标在 hover 时缩放（可选 Dock Magnification）。桌面端无汉堡菜单。干净水平排列，带慷慨间距
* **加载器：** 匹配精确布局尺寸和圆角的骨架 shimmer。移动光反射穿过占位符形状。绝不用圆形 spinner
* **空状态：** 构图插图或图标组合，带指导文字。绝不只是 "No data found"
* **错误状态：** 内联、上下文相关。红色强调下划线或边框。清晰恢复操作

## 5. Hero 区域
Hero 是第一印象——必须引人注目、创意且绝不通用。
- **内联图像排版：** 在标题的单词或字母之间嵌入小的、上下文相关的照片或视觉元素。示例："We build [photo of hands typing] digital [photo of screen] products"——图像以 type-height 内联放置，圆角，充当单词间的视觉标点。这是标志性创意技术
- **无重叠元素：** 文字绝不能与图像或其他文字重叠。每个元素有自己的清晰空间区域。无 z-index 内容层堆叠，无绝对定位标题在图像上。始终干净分离
- **无填充文字：** "Scroll to explore"、"Swipe down"、滚动箭头图标、弹跳 chevron 和任何指导性 UI chrome 全部禁止。用户知道如何滚动。让内容自然吸引他们
- **非对称结构：** 在此 variance 级别，居中 Hero 布局禁止。使用分屏（50/50）、左对齐文字/右视觉，或带大空区域的不对称留白
- **CTA 克制：** 最多一个主 CTA 按钮。无次要 "Learn more" 链接。无标题下方冗余微文案

## 6. 布局原则
- **网格优先：** CSS Grid 用于所有结构布局。绝不用 flexbox 百分比数学（`calc(33% - 1rem)` 禁止）
- **无重叠：** 元素绝不能相互重叠。无绝对定位层堆叠内容。每个元素占据自己的网格单元或流位置。干净、分离的空间区域
- **功能区域：** "3 张等宽卡片在一行"模式禁止。使用 2 列 Zig-Zag、不对称 Bento 网格（2fr 1fr 1fr）或水平滚动画廊
- **包含：** 所有内容在 `max-width: 1400px` 内，居中。慷慨水平内边距（移动端 `1rem`、平板 `2rem`、桌面 `4rem`）
- **全高：** 使用 `min-height: 100dvh`——绝不用 `height: 100vh`（iOS Safari 地址栏跳跃）
- **Bento 架构：** 对于功能网格，使用 Row 1：3 列 | Row 2：2 列（70/30 分割）。每个 tile 包含一个永久微动画

## 7. 响应式规则
每个屏幕必须在所有视口上完美工作。**响应式不是可选的——它是硬性要求。每个元素必须在 375px、768px 和 1440px 下测试。**
- **移动优先退化（< 768px）：** 所有多列布局退化为严格单列。`width: 100%`、`padding: 1rem`、`gap: 1.5rem`。无例外
- **无水平滚动：** 移动端水平溢出是严重失败。所有元素必须适应视口宽度。如果任何元素导致水平滚动，设计已损坏
- **排版缩放：** 标题通过 `clamp()` 优雅缩小。正文保持 `1rem` 最小。绝不让正文小于 `14px`。标题必须在 375px 屏幕上保持可读
- **触摸目标：** 所有交互元素最小 `44px` 触摸目标。可点击项目之间慷慨间距。按钮在移动端必须全宽
- **图像行为：** Hero 和内联图像按比例缩放。内联排版图像（单词间的照片）在移动端堆叠在标题下方而非内联
- **导航：** 桌面水平导航退化为干净移动菜单（滑入或全屏覆盖）。无不带标签的微小汉堡图标
- **卡片与网格：** Bento 网格和不对称布局恢复为堆叠单列全宽卡片。保持内部内边距（`1rem`）
- **间距一致性：** 垂直 section 间距在移动端按比例缩小（`clamp(3rem, 8vw, 6rem)`）。绝不拥挤，绝不过分通风
- **测试视口：** 设计必须在以下视口验证：`375px`（iPhone SE）、`390px`（iPhone 14）、`768px`（iPad）、`1024px`（小笔记本）、`1440px`（桌面）

## 8. 动效与交互（代码阶段意图）
> **注意：** Stitch 生成静态屏幕——它不动画。本节记录了**预期的动效行为**，以便编码 Agent（Antigravity、Cursor 等）在将导出设计构建为实际产品时确切知道如何实现动画。

- **物理引擎：** 独占基于弹簧。`stiffness: 100, damping: 20`。无 linear easing 在任何位置。所有交互元素上的 premium、有重量感
- **永久微循环：** 每个活跃仪表盘组件有无限循环状态——状态点上的 Pulse、搜索栏上的 Typewriter、功能图标上的 Float、加载状态上的 Shimmer
- **交错编排：** 列表和网格以级联延迟挂载（`animation-delay: calc(var(--index) * 100ms)`）。瀑布揭示，绝无即时挂载
- **布局过渡：** 通过共享元素 ID 平滑重排。项目以物理方式交换位置，模拟实时智能
- **硬件规则：** 仅动画 `transform` 和 `opacity`。绝不动画 `top`、`left`、`width`、`height`。颗粒/噪点滤镜仅用于固定、pointer-events-none 伪元素
- **性能：** CPU 密集型永久动画隔离在微小的叶子组件中。绝不在父级触发重渲染。目标最低 60fps

## 9. 反模式（禁止）
- 无 emoji——在 UI、代码或 alt 文本中任何位置
- 无 `Inter` 字体——使用 `Geist`、`Outfit`、`Cabinet Grotesk`、`Satoshi`
- 无通用衬线字体（`Times New Roman`、`Georgia`、`Garamond`）——如果需要衬线，仅使用独特的现代衬线（`Fraunces`、`Instrument Serif`）
- 无纯黑（`#000000`）——仅 Off-Black 或 Zinc-950
- 无霓虹外发光或默认 box-shadow 发光
- 无饱和度超过 80% 的过度饱和强调色
- 无大型标题上的过度渐变文字
- 无自定义鼠标光标
- 无重叠元素——文字绝不与图像或其他内容重叠。始终干净空间分离
- 无 3 列等宽卡片布局用于功能
- 无居中 Hero 区域（在此 variance 级别）
- 无填充 UI 文字："Scroll to explore"、"Swipe down"、"Discover more below"、滚动箭头、弹跳 chevron——全部禁止
- 无通用名称："John Doe"、"Sarah Chan"、"Acme"、"Nexus"、"SmartFlow"
- 无假整数：`99.99%`、`50%`、`1234567`——使用有机数据：`47.2%`、`+1 (312) 847-1928`
- 无 AI 文案陈词滥调："Elevate"、"Seamless"、"Unleash"、"Next-Gen"、"Revolutionize"
- 无损坏的 Unsplash 链接——使用 `picsum.photos/seed/{id}/800/600` 或 SVG UI 头像
- 无通用 `shadcn/ui` 默认值——自定义半径、颜色、阴影以匹配此系统
- 无 `z-index` 滥用——仅用于 Navbar、Modal、Overlay 层上下文
- 无 `h-screen`——始终 `min-h-[100dvh]`
- 无圆形加载 spinner——仅骨架 shimmer
