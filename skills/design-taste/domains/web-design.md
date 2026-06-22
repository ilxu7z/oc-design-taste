---
domain: web-design
description: Web 设计工程核心规则——排版、色彩、布局、动效、交互状态、性能、无障碍
depends: [knowledge/font-pairings, knowledge/color-science]
---

# Web 设计工程 · 领域规则

> 覆盖：官网 / Landing Page / 产品页 / 品牌故事 / 案例页
> 不覆盖：Dashboard / 管理后台 / 数据表 / 多步骤表单 / 代码编辑器 / 原生移动端

---

## 1. 默认架构（Default Architecture）

当 Design Read 未选择特定设计系统时，使用以下默认值。

### 1.1 技术栈

| 项目类型 | 默认栈 |
|---------|--------|
| 官网 / Landing Page | Next.js + Tailwind v4 + Motion（`motion/react`） |
| 静态页面 | Tailwind v4 + 原生 CSS |
| B端SaaS后台 | Preact/React + CSS Variables + 自建组件库 |

**字体加载：** 始终用 `next/font`（Next.js）或 `@font-face` + `font-display: swap`。生产环境禁止用 `<link>` 加载 Google Fonts。

### 1.2 RSC 安全规则（来自原版 taste-skill）

| 规则 | 说明 |
|------|------|
| **Global state 只在 Client Component 中工作** | 在 Next.js 中，Provider 必须封装在 `"use client"` 组件内。Server Component 不能持有或传递全局状态 |
| **交互隔离** | 任何使用 Motion、scroll listener 或 pointer physics 的组件，必须是隔离的叶子组件，顶部标注 `"use client"` |
| **Server Component 只渲染静态布局** | 所有交互逻辑、动画、状态管理必须下沉到 Client Component 叶子节点 |
| **`"use client"` 边界清晰** | 不要在布局层大范围标注 `"use client"`，只在真正需要交互的最小叶子组件上标注 |

### 1.3 状态管理

| 场景 | 方案 |
|------|------|
| 局部 UI 状态 | `useState` / `useReducer` |
| 深层 prop drilling | Zustand / Jotai / React Context |
| 鼠标/滚动连续值 | Motion `useMotionValue` + `useTransform`（禁止 `useState`） |

**❌ 禁止：** `useState` 追踪鼠标位置、滚动进度、物理交互——每帧 re-render，移动端崩溃。

### 1.4 图标库

| 优先级 | 库 | 备注 |
|--------|-----|------|
| 1 | `@phosphor-icons/react` | 默认首选 |
| 2 | `hugeicons-react` | 备选 |
| 3 | `@radix-ui/react-icons` | 轻量 |
| 4 | `@tabler/icons-react` | 备选 |
| ❌ 谨慎 | `lucide-react` | 仅用户明确要求或项目已有 |

**铁律：** 一个项目只用一种图标库。不混搭。**禁止手写 SVG 图标路径。**

### 1.5 Emoji 政策

默认禁止在代码和可见文本中使用 emoji。用图标库替代。

**突破条件：** 用户明确要求活泼/社交/聊天风格，且使用克制。

### 1.6 响应式与布局机制

| 规则 | 说明 |
|------|------|
| 标准断点 | `sm 640` / `md 768` / `lg 1024` / `xl 1280` / `2xl 1536` |
| 页面容器 | `max-w-[1400px] mx-auto` 或 `max-w-7xl` |
| ❌ 禁止 `h-screen` | 用 `min-h-[100dvh]`（防 iOS Safari 地址栏跳变） |
| ❌ 禁止 flex 百分比数学 | `w-[calc(33%-1rem)]` → 用 CSS Grid（`grid grid-cols-1 md:grid-cols-3 gap-6`） |

### 1.7 依赖验证（强制）

引入任何第三方库前，先检查 `package.json`。缺少则先输出安装命令。**永远不要假设库已存在。**

---

## 2. 排版规则（Typography）

### 2.1 字体选择纪律

**默认用无衬线（Sans-Serif）。** "有设计感就用衬线" 是 AI 最大的排版幻觉之一。

| 场景 | 推荐 | 避免 | 突破条件 |
|------|------|------|---------|
| 官网/Landing Page 标题 | Geist / Outfit / Cabinet Grotesk / Satoshi | Inter（默认安全牌） | 品牌已有 Inter 或用户明确要求 |
| 正文 | 同标题字体或其正文字重变体 | 换另一套字体 | 明确的编辑排版需求 |
| 数字/数据 | 等宽字体（JetBrains Mono / IBM Plex Mono） | 比例字体显示数据 | 仅 1-2 个数字可用比例字体 |
| 中文标题 | 思源黑体（Source Han Sans SC） | 宋体做标题 | 编辑/文学类场景 |
| 中文正文 | 思源宋体（Source Han Serif SC） | 黑体做长文 | 标题+正文配对时 |

**字体配对知识：**
- Geist + Geist Mono
- Satoshi + JetBrains Mono
- Cabinet Grotesk + Inter Tight
- 思源黑体 + 思源宋体（中文 editorial 配对）
- Outfit + IBM Plex Mono

### 2.2 Serif 纪律（完整版，来自原版 taste-skill）

**Serif 非常不鼓励作为任何项目的默认字体。** 以下是 6 条理由：

| # | 理由 | 说明 |
|---|------|------|
| 1 | **AI 最大排版惯性** | "创意 brief = serif" 是生产测试中验证率最高的 AI 签名之一 |
| 2 | **默认心理模型错误** | Agent 的默认思维认为"创意/高端/编辑风格 = 衬线"，这是训练数据偏差 |
| 3 | **无衬线才是现代默认** | Sans display 字体不"无聊"——它们是现代设计的默认，正如黑色是时尚的默认 |
| 4 | **混用衬线做强调是业余** | 在无衬线标题中插入随机衬线词做强调，是 AI 最常见手法之一 |
| 5 | **Serif 选择范围窄** | 多数 AI 默认回退到 Fraunces / Instrument Serif，导致项目间无差异化 |
| 6 | **Serif 需要品牌理由** | 不是"感觉有设计感"就够——需要品牌文档或明确的 editorial/luxury 定位 |

**Serif 仅当以下之一明确成立时才可用：**
- 品牌 brief 明确命名了一款衬线字体
- 美学方向是 editorial / luxury / publication / manuscript / heritage / vintage，且你能说清为什么这款特定衬线适合这个特定品牌

**❌ 禁止的默认衬线：** Fraunces、Instrument Serif（AI 最爱）

**强调规则：** 标题中要强调某个词时，用同一字体的 italic/bold，**不要**在无衬线标题中插入随机衬线词。同字族 italic/bold 强调是正确的做法，混族强调是业余的。

**Serif 轮换池（15+ 款，禁止连续复用）：**

| # | 字体 | 风格 |
|---|------|------|
| 1 | PP Editorial New | 现代 editorial |
| 2 | GT Sectra Display | 高对比度显示 |
| 3 | Cardinal Grotesque | 怪诞衬线 |
| 4 | Reckless Neue | 混合风格 |
| 5 | Tiempos Headline | 新闻标题 |
| 6 | Recoleta | 圆润复古 |
| 7 | Cormorant Garamond | 经典文艺 |
| 8 | Playfair Display | 高对比度显示 |
| 9 | EB Garamond | 经典正文 |
| 10 | IvyPresto | 优雅现代 |
| 11 | Migra | 实验性衬线 |
| 12 | Editorial Old | 复古编辑 |
| 13 | Saol Display | 粗衬线显示 |
| 14 | Domaine Display | 精致显示 |
| 15 | Canela | 温暖精致 |
| 16 | Schnyder | 高对比度奢华 |
| 17 | Tobias | 现代手写感 |
| 18 | NB Architekt | 建筑感衬线 |
| 19 | ITC Galliard | 经典书卷 |

**轮换规则：** 如果上一个项目用了衬线，这个项目必须用无衬线。不要连续两个项目用同一款衬线。

### 2.3 中文排版特化

| 规则 | 说明 | 突破条件 |
|------|------|---------|
| 中文行宽 ≤ 40em | 中文阅读舒适宽度，超过导致阅读疲劳 | 表格、数据密集区 |
| 中文正文两端对齐 | `text-justify` 或 `text-left` + 合理断行 | 短文本（< 3 行）可左对齐 |
| 思源黑体做标题 + 思源宋体做正文 | 标准中文 editorial 配对 | 品牌已有字体体系 |
| 中文标题不自动全大写 | 中文无大小写概念，全大写中文标题是 AI 痕迹 | 品牌风格要求 |
| 中文段落首行不缩进 | Web 排版惯例 | 印刷风格 editorial 页面 |
| 中英文混排加空格 | 中英之间加 `&nbsp;` 或普通空格 | 无 |

### 2.4 通用排版纪律

| 规则 | 说明 | 突破条件 |
|------|------|---------|
| 英文行宽 ≤ 65ch | 超过导致阅读疲劳 | 窄栏引用、数据表 |
| 显示/标题字号 | 默认 `text-4xl md:text-6xl tracking-tighter leading-none` | 内容驱动 |
| 正文字号 | 默认 `text-base text-gray-600 leading-relaxed max-w-[65ch]` | 内容驱动 |
| `<br>` 不断标题 | "for thirty<br>*years.*" 式花活是 AI 痕迹 | 用户明确要求，或 editorial 大字排版 |
| Italic 下延字母 clearance | 斜体含 y/g/j/p/q 时，`leading-[1.1]` 最低 + `pb-1` | 会裁切下延字母 |
| 孤词修复 | 标题最后一行只剩一个词 → `text-wrap: balance` 或 `text-wrap: pretty` | 无 |
| 数字用等宽 | 数据密集区域用 `font-variant-numeric: tabular-nums` | 仅 1-2 个数字 |
| 全大写副标题节制 | 全大写标签太多 → 用小写斜体、首字母大写或小型大写 | 品牌风格要求 |

---

## 3. 色彩规则（Color）

### 3.1 基础纪律

| 规则 | 说明 | 突破条件 |
|------|------|---------|
| 单一强调色 | 全页只用 1 个 accent color | 品牌本身有多色体系且用户确认 |
| 饱和度 < 80% | B端 < 60%，消费者 < 80% | 品牌色本身就是高饱和（如可口可乐红） |
| 单一灰色系 | Zinc/Slate/Stone 择一，全页一致 | 无 |
| 不用纯黑 #000 + 纯白 #FFF | 用 #111 + #FAFAFA 或品牌色系 | 纯黑用于印刷（CMYK 100%K） |
| Color Consistency Lock | 选定 accent 后，全页所有 section 一致 | 无——这是铁律 |
| 阴影调色 | 阴影色调匹配背景色，不用纯黑 drop shadow | 无 |
| 光源方向一致 | 全页阴影暗示同一光源方向 | 无 |

### 3.2 ⚠️ Premium Consumer 色板禁令

**这是 AI 第二大色板惯性。** 高端消费品（厨具/保健品/奢侈品/手工艺/DTC家居），AI 默认输出：

- 背景：`#f5f1ea`、`#f7f5f1`、`#fbf8f1`、`#ece6db`（暖米/奶油/粉笔/骨色）
- 强调：`#b08947`、`#b6553a`、`#9a2436`（黄铜/陶土/牛血红）
- 文字：`#1a1714`、`#1a1814`（浓缩咖啡近黑）

**禁令：** 除非品牌本身是暖色调/复古工艺定位，否则不要默认 reach for 这个色板。

**替代方案（轮换使用，不要连续两个项目用同一个）：**
- 冷奢：银灰 + 铬色 + 烟熏（特斯拉/AW 风格）
- 森林：深绿 + 骨白 + 琥珀点缀（Patagonia 风格）
- 蓝铜：钴蓝 + 奶油单一中性色（无黄铜）
- 陶土石板：暖锈红 + 冷灰（无黄铜）
- 黑褐：纯近黑 + 暖褐，高对比，无米色
- 纯单色 + 单一饱和点缀：近白 + 近黑 + 一个亮色（电蓝/翠绿/热粉）

### 3.3 ⚠️ 紫色/蓝色 AI 渐变禁令

"AI 紫/蓝发光"审美默认禁止。不要自动用紫色按钮发光、随机霓虹渐变。用中性基色（Zinc/Slate/Stone）+ 高对比单一强调色（翠绿、电蓝、深玫红、焦橙等）。

**突破条件：** 品牌或 Brief 明确要求紫色/紫罗兰色。但执行要刻意：一致调色板、协调中性色、克制渐变。

---

## 4. 布局规则（Layout）

### 4.1 Hero 规范

| 规则 | 说明 | 突破条件 |
|------|------|---------|
| 文字元素 ≤ 4 个 | 眉毛标签(0-1) + 标题 + 副文本 + CTA | 无 |
| 标题 ≤ 2 行（桌面） | 超过 = 字号太大或文案太长 | 无——先减小字号，后精简文案 |
| 副文本 ≤ 20 词 / ≤ 4 行 | 超过说明价值主张不清晰 | 无 |
| Hero top padding ≤ `pt-24` | 更大 = 内容浮在视口中部，像 bug | 无——要更多空间就增大字号或图片 |
| CTA 不换行（桌面） | 主 CTA 最多 3 个词 | 无 |
| Logo wall 在 Hero 下方 | Hero 只放价值主张 + CTA | 无 |
| Hero 必须有视觉元素 | 纯文字 + 渐变色块 = 占位符，不是 Hero | Editorial manifesto 风格，用户明确要求 |
| Hero 字号规划 | 标题 >6 词时不要从 `text-7xl` 开始，默认 `text-4xl md:text-5xl lg:text-6xl` | 标题 3-5 词时可用 `text-6xl md:text-7xl` |
| Hero 中禁止： | 标签行在 CTA 下方、信任微条、定价预告、功能列表、社交证明头像行 | 无——移到 Hero 下方的专属 section |

### 4.2 Section 级纪律

| 规则 | 说明 | 突破条件 |
|------|------|---------|
| Eyebrow 约束 | 每 3 个 section 最多 1 个 eyebrow。Hero 算 1 个 | 无——这是最常见的 AI 痕迹 |
| Section Layout 不重复 | 8 个 section 至少 4 种不同 layout family | 无——"每个 section 用同一套布局"是 AI 惯性 |
| Zigzag 交替上限 | 图片+文字交替排列连续最多 2 段，第 3 段必须换布局 | 无 |
| Split Header 禁令 | "左大标题 + 右小段落"浮动布局禁止 | 右侧有真实交互元素时（非纯文本） |
| 导航单行 | 桌面端导航必须单行，高度 ≤ 80px | 无 |
| Bento 格子数 = 内容数 | N 个内容项 = N 个格子，中间不留空格 | 无——空格是规划失误 |
| Bento 背景多样性 | 至少 2-3 格有图片/渐变/有色背景，不全白底纯文本 | 无 |
| Page Theme Lock | 全页一个主题（light/dark/auto），section 不反转 | 用户明确要求 Color Block Story |
| Shape Consistency Lock | 选一个圆角体系全页一致 | 有文档化规则时可混用 |
| 卡片仅用于层级表达 | 否则用 `border-t` / `divide-y` / 负空间分组 | 无 |
| DENSITY > 7 时禁止卡片 | 数据指标在纯布局中呼吸 | 无 |

### 4.3 内容密度

| 规则 | 说明 | 突破条件 |
|------|------|---------|
| Section 默认形态 | 短标题(≤8词) + 短段落(≤25词) + 1个视觉 | 内容驱动型 section |
| 长列表换组件 | >5 项不用 `<ul>` + `divide-y`，用卡片网格/Tab/手风琴/横向滚动 | 数据表 |
| 表格不要每行底线 | 选其一：行底线 或 组顶部线，不要全加上 | 数据密集型对比表 |
| 引用 ≤ 3 行 | 超过就截断 | 无 |
| 引用归属：姓名+角色+(公司) | 不能只有 "- Sarah" | 无 |
| 引用用真实引号 `""` | 不用 ASCII 直引号 `"` | 无 |
| 规格表替代方案 | 2列卡片网格 / 横向滚动 pills / 分组块 / 精选+折叠 | 用户明确要求传统表格 |

### 4.4 移动端退化

所有多栏布局在 < 768px **必须**声明退化为单列：
- `w-full px-4 py-8`
- 非对称分栏 → 上下堆叠
- 隐藏装饰性元素
- Bento 中所有 `col-span` 重置为 `col-span-1`

**不是可选的。** "Tailwind 会处理" 的假设不可接受。

---

## 5. 交互状态（Interactive UI States）

LLM 默认只输出"静态成功态"。必须实现完整周期：

| 状态 | 要求 |
|------|------|
| **Loading** | 骨架屏匹配最终布局形状。避免通用圆形 spinner |
| **Empty** | 美观构图，指示如何填充 |
| **Error** | 清晰、内联（表单）或上下文（toast 仅临时） |
| **触觉反馈** | `:active` 时用 `-translate-y-[1px]` 或 `scale-[0.98]` |
| **按钮对比度** | WCAG AA 最小 4.5:1（正文）/ 3:1（大文本 18px+） |
| **CTA 不换行** | 桌面端按钮文字必须单行。超过 3 词则缩短 |
| **CTA intent 不重复** | 同一 intent 的 CTA 全页用同一个标签 |
| **表单对比度** | placeholder、focus ring、helper text、error text 都通过 WCAG AA |
| **Label 在 input 上方** | 禁止 placeholder 当 label |
| **Focus ring** | 键盘导航可见焦点指示器 |
| **死链接** | 按钮不链到 `#`，要么链到真实目标，要么视觉禁用 |

---

## 6. 视觉资产（Image & Visual Asset）

### 6.1 资产优先级链

| 优先级 | 来源 | 适用场景 |
|--------|------|----------|
| 1. 品牌实际图片 | 用户提供的 URL/文件 | 最佳——永远优先用真实素材 |
| 2. 生图工具 | GLM-5.1 prompt → 生图模型 | Hero、场景图、产品特写 |
| 3. Picsum-seed | `picsum.photos/seed/{描述}/{w}/{h}` | 占位图，seed 必须描述内容 |
| 4. 明确标注占位 | `<!-- TODO: hero photo 1600x1200 -->` | 前三者都不可用时 |

**❌ 永远不做：** 用 `<div>` 矩形模拟截图、手绘 SVG 图标当装饰、纯文字页面称"极简"。

### 6.2 Logo Wall 纪律

- Logo = logo only，不加行业标签（不要 `Stripe + payments`）
- 用真实 SVG logo（Simple Icons CDN / devicon / 品牌实际 logo）
- 造品牌名 → 造 SVG 标志（单字母圆形/双字母组合），不要用纯文本
- 确保 logo 在 light/dark 两种模式下都可见
- Logo wall 在 Hero 下方，不在 Hero 内部

---

## 7. 动效规则（Motion）

### 7.1 动效纪律

| 规则 | 说明 | 突破条件 |
|------|------|---------|
| 动效必须有动机 | 每个动画一句话说清传达什么（层级/叙事/反馈/状态） | "看起来酷"不是理由 |
| 声明 = 实现 | 设定 MOTION > 4 但页面是静态的 → 输出失败 | 做不了动效就把旋钮降到 ≤3 |
| Marquee 最多 1 个/页 | 水平滚动文字条全页最多一个 | 无 |
| 禁止 `window.addEventListener('scroll')` | 每帧触发、卡顿 | 用 Motion `useScroll()` / ScrollTrigger / IntersectionObserver |
| 禁止 `useState` 追踪连续值 | 每帧 re-render | 用 `useMotionValue` + `useTransform` |
| 硬件加速 | 只动画 `transform` 和 `opacity` | 无 |
| Reduced Motion | MOTION > 3 时必须 honor `prefers-reduced-motion` | 无——不可协商 |
| 禁止 GSAP/Three.js 与 Motion 混用 | 争抢同一帧 | 一个组件树只用一种动画库 |

### 7.2 动效骨架引用（不在此处复制代码）

具体代码骨架（Sticky-Stack、Horizontal-Pan、Scroll-Reveal Stagger）存储在：
```
libraries/motion-patterns.md
```

关键实现原则：
- **Sticky-Stack：** `start: "top top"`、`pin: true`、每张卡（最后一张除外）都被 pin，前一张卡的 scale/opacity 由下一张卡的 scroll trigger 驱动
- **Horizontal-Pan：** `start: "top top"`、`pin: true`、`end: "+=${distance}"`（滚动长度 = 水平滑动距离）、`scrub: 1`
- **Scroll-Reveal：** 用 Motion `whileInView`，轻量无 GSAP 依赖

### 7.3 禁止的动效模式

- **`window.addEventListener("scroll", ...)`** — 硬禁止
- **自定义 `window.scrollY` 计算 + React state** — 每帧 re-render
- **`requestAnimationFrame` 循环操作 React state** — 用 motion values
- **Layout Transitions** — 用 Motion `layout` / `layoutId`，不包裹静态内容
- **Staggered Orchestration** — 用 `staggerChildren`（Motion）或 CSS `animation-delay: calc(var(--index) * 100ms)`

---

## 8. 性能与无障碍（Performance & Accessibility）

### 8.1 硬件加速

- 只动画 `transform` 和 `opacity`。禁止动画 `top`、`left`、`width`、`height`
- `will-change: transform` 仅用于实际会动画的元素

### 8.2 Reduced Motion（强制）

- MOTION > 3 时必须 honor `prefers-reduced-motion`。不可协商
- Motion: 用 `useReducedMotion()` 退化为静态
- CSS: 用 `@media (prefers-reduced-motion: no-preference)` 或 `@media (prefers-reduced-motion: reduce)` 禁用
- 无限循环、视差、scroll-hijack、磁力物理必须退化为静态/即时

### 8.3 Dark Mode（消费者面向页面强制）

| 规则 | 说明 |
|------|------|
| 从开始就设计两种模式 | 禁止只输出 light-only 或 dark-only |
| 策略选择 | 用 Tailwind `dark:` variant 或 CSS variables。一个项目选一种 |
| 系统偏好 | 尊重 `prefers-color-scheme: dark`。默认系统偏好，除非品牌坚持一种模式 |
| 对比度 | 两种模式都通过 WCAG AA（正文 AAA） |
| 颜色 | 不用纯 `#000000` 和纯 `#ffffff`，用 off-black 和 off-white |

### 8.4 Core Web Vitals 目标

| 指标 | 目标 | 措施 |
|------|------|------|
| LCP | < 2.5s | Hero 图片必须 `next/image priority` 或 preload |
| INP | < 200ms | 繁重工作脱离主线程 |
| CLS | < 0.1 | 图片、字体、嵌入预留空间 |

交付前运行 Lighthouse。

### 8.5 DOM 成本

- 噪点/颗粒滤镜仅用于 fixed、`pointer-events-none` 伪元素。禁止在滚动容器上使用
- Motion 不小。Three.js 很大。折叠屏以上的内容懒加载

### 8.6 Z-Index 约束

禁止随意 `z-50` / `z-10`。z-index 仅用于系统层级上下文（sticky nav、modal、overlay、grain）。在项目常量文件中记录 z-index 层级。

---

## 9. 文案自审（Copy Self-Audit）

交付前逐条重读每个可见字符串，标记并重写：

| 问题类型 | 示例 | 修复 |
|---------|------|------|
| 语法破碎 | "free on its past" | 重写为自然语句 |
| 指代不清 | "we plan to stay that way" | 明确指代 |
| AI 幻觉文案 | 强行文艺、假工匠感标签 | 替换为平实功能句 |
| 假精确数字 | 92%、4.1×、48k | 要么来自真实数据，要么标注为 mock |
| 多语气混用 | 技术 mono + 营销 punch 混在同一页 | 统一为一种语气 |
| 感叹号滥用 | "操作成功！" | 去掉感叹号，自信但不吵 |
| "Oops!" 错误信息 | "出错了！" | 直接："连接失败，请重试" |
| 被动语态 | "修改已保存" | 主动语态："保存成功" |
| 所有标题大写 | "联系我们" | 首字母大写即可 |
| 假谦虚行业引用 | "We respect the French ones" | 直接引用或跳过 |

---

## 10. Em-Dash 全面禁令

**Em-dash（`—`）和 En-dash（`–`）在所有可见文本中完全禁止。**

这是 LLM #1 文案痕迹。AI 用 em-dash 当万能分隔符、修辞手段、设计元素。

| 禁止位置 | 替代方案 |
|---------|---------|
| 标题 | 用句号或逗号 |
| 副标题/标签/按钮/图片说明/导航 | 用换行、竖线或空格 |
| 正文 | 拆成两句话，或用逗号/括号/冒号 |
| 引用归属 | 用普通连字符 ` - ` 或换行 + 小字 |

**唯一允许的 dash：** 普通连字符 `-`（复合词、数字范围）。零 em-dash，零例外。

---

## 11. 页面主题锁定（Page Theme Lock）

| 规则 | 说明 |
|------|------|
| 全页一个主题 | light/dark/auto 择一，section 不反转 |
| 例外 | 用户明确要求 Color Block Story，且是刻意编排（全页一次主题切换，带强过渡） |
| 默认行为 | 在页面级别选择 light/dark/auto（`prefers-color-scheme`），锁定 |
| 设计系统内置主题 | 在 `layout.tsx` 或页面根节点设置一次，section 不覆盖 |
| 颜色规范 | 不用纯 `#000000` 和纯 `#ffffff`，用 off-black 和 off-white |

---

## 12. 材料质感与形状（Materiality & Shape）

| 规则 | 说明 | 突破条件 |
|------|------|---------|
| 卡片仅用于层级表达 | 否则用 `border-t` / `divide-y` / 负空间分组 | 无 |
| 阴影调色 | 阴影色调匹配背景色，不用纯黑 drop shadow | 无 |
| Shape Consistency Lock | 选一个圆角体系全页一致 | 有文档化规则时可混用 |
| 圆角选项 | 全直角(0) / 全圆角(12-16px) / 全 pill（交互元素全圆） | 有文档化规则 |
| 混用规则 | 圆角按钮 + 直角卡片 = 破损设计 | 有文档化规则（如"按钮 pill，卡片 16px，输入框 8px"） |

---

## 13. 数据与表单模式（Data & Form Patterns）

| 规则 | 说明 |
|------|------|
| Label 在 input 上方 | 标准 `gap-2` 输入块 |
| Helper text | 可选但存在于 markup 中 |
| Error text | 在 input 下方 |
| 禁止 placeholder 当 label | 永远不要 |
| 表单对比度 | placeholder、focus ring、helper text、error text 都通过 WCAG AA |
| 按钮对比度 | WCAG AA 最小 4.5:1（正文）/ 3:1（大文本 18px+） |

---

## 14. 布局多样性强制

LLM 默认总是选第一个布局选项。为防止此偏差，每次布局前执行：

1. **模拟随机选择** — 用用户 prompt 的字符数作为 seed，选择：
   - 1 种 Hero 架构
   - 1 种排版组合（Satoshi/Cabinet Grotesk/Outfit/Geist — 禁止 Inter）
   - 2-3 种不同组件架构（Bento/Sticky-Stack/Split-Screen/Editorial）
   - 1-2 种动效范式（Scroll-Reveal/Sticky-Stack/Horizontal-Pan）
2. **禁止连续两次输出相同组合** — 记录上次选择的组合，下次必须不同
3. **移动端覆盖** — 所有非对称布局在 < 768px 退化为单列

**突破条件：** 用户明确要求特定布局。

---

## 15. 领域范围（Out of Scope）

本领域规则不覆盖：
- Dashboard / 密集产品 UI / 管理后台（用 Fluent / Carbon / Atlaskit / Polaris）
- 数据表（用 TanStack Table / AG Grid）
- 多步骤表单 / 向导（用表单特定模式）
- 代码编辑器（用 Monaco / CodeMirror 官方皮肤）
- 原生移动端（用 Apple HIG / Material 直接）
- 实时协作 UI（presence、cursor、OT-aware）

如果 Brief 是以上之一，**明确说出来**，指向正确工具，仅将本领域的营销页/关于页/Landing 页部分应用到适用的表面。
