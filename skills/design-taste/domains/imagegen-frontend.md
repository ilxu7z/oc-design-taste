---
domain: imagegen-frontend
description: 前端设计生图 + 图转码——Web/Mobile构图规则、Image-First工作流、AI痕迹检测
depends: [domains/web-design, domains/image-generation]
---

# imagegen-frontend 领域规则

## 概述

本领域融合三大能力：
1. **Web 端生图**——生成 Awwwards 级别的前端设计参考图，一 section 一图，永不合并
2. **Mobile 端生图**——生成 app-native 的移动端屏幕概念图，iOS/Android 平台感知
3. **Image-to-Code**——先生图→深度分析→再写代码的完整工作流

核心原则：**图片是设计源，代码是翻译层**。

---

## 1. 硬输出规则（Hard Output Rule）

### 1.1 一 Section 一图

**每 section 生成一张独立横向图片。永远如此，无例外。**

- 1 section → 1 张图
- 4 sections → 4 张图
- 8 sections → 8 张图
- 12 sections → 12 张图
- "landing page" 未指定数量 → 默认 6 sections → 6 张图
- "full website" → 默认 8 sections → 8 张图

如果模型一次只能生成一张图，**顺序输出**，标注 "Section X of N: <name>"，直到全部完成。

**禁止：**
- 多个 section 合并到一张图
- 返回一张长图包含整个页面
- 只返回一张 "最好的" 图跳过其余
- 用 collage 替代多张独立图

### 1.2 图片格式

- 始终横向：16:9、16:10 或 21:9（取决于密度）
- Hero 通常 16:9 或 21:9；内容 section 可用 16:10
- 每张图渲染一个聚焦的 section，高保真度

### 1.3 Section 尺寸多样性

跨页面混合 section 的野心级别：
- 部分 section 大、内容丰富、艺术指导强
- 部分 section 极小、极简、大量留白
- 部分 section 中等 editorial 块

这种节奏创造 premium 的滚动体验，而非均匀的 slab。

### 1.4 连续性规则

跨所有 section 图片强制同一个品牌世界：
- 相同的调色板和强调色逻辑
- 相同的字体系列和字号比例
- 相同的 CTA 家族（风格变化可以，身份不变）
- 相同的圆角语言
- 相同的图片处理（色调、材质、构图）
- 相同的语气

观众翻看所有图片时，必须读作同一个网站。

---

## 2. Web 端构图规则

### 2.1 Hero 构图偏差校正

**左文右图的 Hero 是最被滥用的 AI 模式。** 允许使用，但不应该是默认首选。

在伸手拿左文右图之前，考虑以下替代方案，选择最适合品牌的那个：

| 布局 | 描述 |
|------|------|
| Centered Statement | 全出血背景图上居中文字（文字在下 40%） |
| Bottom-Left Over Image | 文字在背景图左下角 |
| Bottom-Right Over Image | 文字在背景图右下角 |
| Top-Left Lead | 左上角主文字，右下角辅助 |
| Stacked Center | 标签/标题/副标题/CTA 全部居中，超极简 |
| Image-as-Canvas | 图片作为画布，文字在干净安全区叠加 |
| Right-Text / Left-Image | 反转经典布局 |
| Off-Grid Editorial | 不对称 editorial 偏移 |
| Mini Minimalist Hero | 极小 logo + 短陈述 + 细 CTA，大量留白 |

**预输出检查：** 渲染 Hero 前问自己："我是不是习惯性地用了左文右图？" 如果是，优先选择其他布局。

### 2.2 Hero 绝对规则

- Hero 必须像强有力的开场场景
- 保持 Hero 构图干净
- 不要拥挤第一个视口
- 主标题必须简短有力（5-10 个词，非段落）
- 辅助文字简洁
- 优先留白和对比
- 避免塞入 pills、假数据、badges、小 logo 和无意义细节

### 2.3 组合变化引擎（Web）

为避免重复的 AI 风格输出，根据 prompt 从每类中选择一项，坚定执行。

#### Theme Paradigm（选 1）
1. **Pristine Light Mode**——米白/奶油/纸色调，锐利深色文字，editorial 自信
2. **Deep Dark Mode**——炭灰/石墨/锌色，优雅发光（仅当合理时）
3. **Bold Studio Solid**——强烈控制色域（oxblood、royal blue、forest、vermilion、emerald）+ 清晰对比 UI
4. **Quiet Premium Neutral**——骨色、沙色、taupe、石色、烟色，柔和对比，克制奢华

#### Background Character（选 1）
1. 细微技术网格/点阵
2. 纯色块 + 柔和环境渐变深度
3. 全出血电影感图片 + 适当对比控制
4. 安静纹理纸/材质/触感表面

#### Typography Character（选 1）
1. Satoshi 风格干净 grotesk
2. Neue-Montreal 风格精致 grotesk
3. Cabinet/Clash 风格表现力 display
4. Monument 风格压缩 statement 字体
5. 优雅 editorial serif + sans 配对
6. Swiss 理性 sans + 极强层级

#### Hero Architecture（选 1）
1. 电影感居中极简
2. 不对称分割 Hero
3. 浮动 Polaroid 散射
4. 内联排版巨兽
5. Editorial 偏移构图
6. 大图优先 Hero + 克制文字

#### Section System（选 1）
1. 严格模块化 bento 节奏
2. 交替 editorial 块
3. 海报式堆叠叙事
4. 画廊主导视觉节奏
5. Swiss 网格纪律
6. 不对称 premium 营销流

#### Signature Component Set（选 4）
- 对角线交错方块 Masonry
- 3D 级联卡片堆
- Hover-Accordion 切片布局
- 无间隙 Bento Grid
- 无限品牌 Marquee 条
- 旋转 Polaroid 弧
- 垂直节奏线
- Off-Grid Editorial 布局
- Product UI Panel 堆叠
- 分割 Testimonial 引用墙
- 超大 Metrics 条
- 分层图片裁剪框

#### Motion-Implied Language（选 2）
- scrubbing text reveal energy
- pinned narrative section energy
- staggered float-up energy
- parallax image drift energy
- smooth accordion expansion energy
- cinematic fade-through energy

#### Composition Anchor（每 section 选 1，全页至少用 3 种不同 anchor）
- Centered statement
- Top-left lead, support bottom-right
- Bottom-left text over background image
- Bottom-right CTA cluster
- Left-third caption + right-two-thirds visual（经典——节制使用，不连续两次）
- Right-third caption + left-two-thirds visual（反转经典）
- Centered low（文字在 Hero 图下 40%）
- Off-grid editorial offset（不对称拉取）
- Stacked center（标签/标题/副标题/CTA 全居中）
- Image-as-canvas（文字在干净安全区叠加）

#### Background Mode（每 section 选 1，全页变化）
- Solid surface with inline asset
- Subtle texture/paper/grid as background
- Full-bleed image background + tonal overlay
- Editorial side-image（50/50, 60/40, 40/60——可反转）
- Image as entire visual + text overlaid in safe area
- Flat color block + small product/detail crop accent
- Cinematic tonal gradient（调色板匹配，低彩度，专业）
- Atmospheric photo + strong color grade
- Duotone treated image（双色照片处理）
- Soft radial vignette + product crop
- Micro-noise gradient over solid
- Color-blocked diptych（两个纯色域交汇）

#### CTA Variation（每 section 选 1，全页至少变化一次）
- Classic primary pill
- Outline/ghost
- Underlined inline link + arrow
- Banner-style full-width CTA
- Oversized headline + tiny CTA hint
- CTA as caption under strong visual

#### Hero Scale（每页选 1）
- **Giant Statement Hero**——大字号、大图、占满第一视口
- **Mid Editorial Hero**——平衡图文、电影感但不占满屏
- **Mini Minimalist Hero**——极小 logo + 短陈述 + 细 CTA，大量留白

### 2.4 叙事/概念脊柱（选 1）

让一个概念贯穿所有视觉和文案：
- **Artifact/Collectible**——证据、标本、珍品框架
- **Journey/Pilgrimage**——方向流、路标 section、路线图感
- **Tool/Precision Instrument**——机械细节、校准 UI、触感控制
- **Living System/Garden**——有机生长隐喻、分支布局、滋养语气
- **Stage/Spotlight**——戏剧对比、表演者+观众框架
- **Archive/Dossier**——索引行、标题、克制权威

### 2.5 Second-Read Moment（选 1）

在全页中精确放置一个不显眼但可读的 motif：
- 一个尊重层级的不对称出血
- 一个超大标点或数字服务于结构
- 一个意外的材质切换（纸 vs 光泽 vs 金属）
- 一个窄垂直侧轨 editorial 注释风格
- 一个自然携带品牌色的 macro crop

避免为 gimmick 而 gimmick：该 moment 必须辅助扫描顺序或品牌记忆。

### 2.6 跨 Section 对比

跨页面故意变化前景/背景强度至少两次（浅→丰富→平静），让滚动有节奏感。

### 2.7 Section 节奏规则

高端网站不像是重复的盒子。通过变化以下元素创造节奏：
- 密度
- 图文比
- 对齐方式
- 比例
- 留白
- 卡片分组
- 背景强度
- 视觉节奏

**重要：** 节奏变化不能破坏整体整洁。section 高度可以不同，但 section 间距应均匀可控。避免极小和极大 section 之间突兀跳跃。

---

## 3. Mobile 端构图规则

### 3.1 平台模式规则

每次生图前先决定平台模式：

1. **iOS-native premium**——更干净的顶部区域、tab-bar 清晰、safe-area 感知、优雅间距、克制 chrome
2. **Android-native premium**——更强的组件节奏、清晰的 app bar、底部导航、卡片/列表结构
3. **Cross-platform premium neutral**——干净 safe-area 处理、通用移动导航模式、更少平台特定装饰

不要随意混用 iOS 和 Android 模式。选一个主导平台感觉并保持一致。

### 3.2 移动端 Hero 布局

移动端 Hero 不同于 Web 端。优先以下布局：

| 布局 | 适用场景 |
|------|---------|
| Stacked Center | 品牌/欢迎页，文字垂直居中 |
| Bottom-Heavy | 图片在上，文字和 CTA 在下半部分 |
| Thumb-Driven | CTA 和关键操作在拇指热区（屏幕下半部） |
| Gesture-Native | 暗示滑动/滚动的视觉线索 |
| Image-Behind-Text | 图片作为背景，文字叠加（带渐变遮罩） |
| Full-Screen Visual | 全屏图片，CTA 在底部安全区 |

**移动端 Hero 规则：**
- 第一屏必须感觉平静、premium、立即可读
- 1 个主要焦点，不要多个竞争焦点
- 标题 1-3 行，辅助文字极简
- 不要塞入 stats、chips、tags、pills
- 如果图片在文字下方，用 fade/mask/scrim 保证可读性

### 3.3 Safe Area 和系统区域

始终感知移动屏幕现实：
- safe areas
- status bar 区域
- top bar / title 区域
- bottom navigation 区域
- home indicator 区域
- sheet docking 区域
- gesture space

**禁止：**
- 把重要内容挤进 unsafe 区域
- 忽略顶部和底部系统区域
- 让屏幕看起来像边缘到边缘的海报
- 把关键 UI 放在视觉不安全的位置

### 3.4 导航模式

移动端导航必须感觉有意图且可信：

- **Tab bar / bottom navigation**——主要 app section
- **Stack navigation**——drill-down 流程
- **Sheets**——次要任务
- **Segmented controls**——本地切换
- **App bars**——需要时使用

**禁止：**
- 超载底部导航
- 隐藏主要路径
- 让所有操作看起来同等重要
- 在 tabs、sheets、actions 之间创建模糊层级

### 3.5 移动端排版规则

- 文字**绝不能太小**。如果感觉小，设计还没完成。
- 优先可读的标题、清晰的正文、可读的标签和按钮
- 足够的对比度、足够的间距
- 强层级：标题 > 正文 > 辅助文字

**禁止：**
- 为了塞入更多 UI 而缩小文字
- 微小的装饰标签
- 正文变得难以阅读
- 为风格牺牲可读性
- 在繁忙图片上放文字而不保护

### 3.6 移动端触控友好

- 触控目标大小视觉上要足够（~44pt 等效）
- 操作在拇指热区（屏幕下半部）
- 间距要宽松，避免误触
- 堆叠顺序暗示合理的单列叙事

### 3.7 移动端组合变化引擎

#### Theme Paradigm（选 1）
1. Pristine light
2. Deep dark
3. Soft wellness neutral
4. Premium monochrome
5. Rich accent-driven
6. Editorial luxe
7. Playful consumer color
8. Calm productivity minimal

#### Typography Character（选 1）
1. Clean system-like sans
2. Refined grotesk
3. Expressive premium display + clean body
4. Soft humanist sans
5. Sharper product sans + disciplined hierarchy

#### Structure Bias（选 1）
1. List-led utility
2. Card-led modular
3. Dashboard-led overview
4. Media-led storytelling
5. Profile-led identity
6. Commerce-led browse & detail flow
7. Chat-led conversational flow
8. Wellness-led calm block rhythm

#### Image Art Direction Bias（选 1）
1. Editorial photography
2. Cinematic lifestyle imagery
3. Soft illustration-led
4. Tactile abstract compositions
5. Premium product imagery
6. Mixed photo + vector art direction
7. Moody atmospheric backdrops
8. Collage-lite layered imagery

#### Texture / Surface Treatment（选 1）
1. Ultra-subtle grain
2. Matte paper texture
3. Foggy gradient atmosphere
4. Soft noise wash
5. Blurred image haze
6. Clean flat + one textured hero area
7. Tactile monochrome surface
8. Low-opacity technical pattern

#### Palette Logic（选 1）
1. Restrained monochrome + one accent
2. Warm neutral palette + sharp dark contrast
3. Cool mineral palette + clean highlight accent
4. Editorial cream / charcoal / muted accent
5. Rich dark base + refined warm accent
6. Wellness soft palette + controlled saturation
7. Bright consumer palette + disciplined balance
8. Desaturated premium palette + one bold hit

#### Signature Component Set（选 4）
- Large hero metric card
- Compact stat strip
- Modular collection grid
- Media carousel
- Layered profile header
- Premium segmented control
- Bottom action sheet
- Framed product card stack
- Progress ring block
- Message bubble system
- Settings group cells
- Photo-led card strip
- Sticky mini player
- Collection shelf
- Habit tracker block
- Checkout summary card
- Journal entry card
- Achievement tile row

#### Decorative Asset Set（选 2）
- Minimal line icon cluster
- Abstract orbit lines
- Dotted arc accents
- Starburst micro-motif
- Rounded sticker accent
- Tiny directional arrow system
- Fine-grid motif
- Soft waveform line
- Clean badge glyphs
- Mini geometric markers

#### Motion-Implied Language（选 2）
- Springy card lift energy
- Sheet rise energy
- Tab transition calmness
- Staggered list reveal energy
- Soft dashboard fade-up energy
- Parallax header drift energy
- Carousel glide energy

### 3.8 移动端 Onboarding 规则

Onboarding 不应感觉像重复的模板幻灯片：
- 生成多个不同的 onboarding 屏幕
- 跨屏幕变化构图
- 变化图片、文字和 CTA 的平衡
- 保持流程连贯
- 文案简短
- 第一个屏幕尤其干净

**禁止：**
- 3 个仅图标和标题不同的相同屏幕
- 太多文案
- 巨大的抽象 blob 无产品意义
- 虚假激励填充语言
- 过早的评分/评价提示

### 3.9 移动端多屏幕一致性

如果生成多个屏幕，一致性是强制要求。

**保持一致：**
- 整体品牌情绪
- 字体层级
- 调色板
- Safe-area 处理
- 导航行为
- 组件家族
- 表面处理
- 卡片处理
- 背景逻辑
- 图片构图
- 装饰口音
- 设备 mockup 呈现

**允许变化：**
- 构图
- 功能重点
- 图片位置
- 屏幕目的
- 视觉节奏

**但不可变化：**
- 产品身份
- 设计系统
- Mockup 质量
- 核心间距逻辑

### 3.10 移动端逻辑流程

多张图片必须形成可信的 app 流程。屏幕顺序必须有意义：

- onboarding → auth → home
- home → browse → detail
- profile → settings → edit profile
- cart → checkout → confirmation
- dashboard → activity → detail

**自问：**
- 为什么屏幕 2 在屏幕 1 之后？
- 什么操作或导航导致下一个屏幕？
- 这是可信的用户旅程吗？
- UI 状态是否逻辑地向前传递？

### 3.11 移动端 Mockup 呈现

**默认规则：** 在干净的手机 mockup 中呈现移动端 UI，带有可见的设备边框。

- iOS 或中性 premium 概念 → iPhone 风格 mockup
- Android-native 概念 → Android 风格 mockup
- 跨平台概念 → 微妙的 premium 通用手机 mockup

**Mockup 规则：**
- 整个系列使用一致的设备风格
- 设备比例一致
- Mockup 居中或对齐清晰
- 设备周围的间距干净平衡
- 设备不接触画布边缘
- 阴影柔和可控
- 手机边框/框架可见且干净
- Mockup 支持屏幕，不压倒屏幕

**仅在以下情况移除设备边框：**
- 用户明确要求纯屏幕输出
- 概念明显受益于无边框呈现
- 用户要求 UI sheets 或 assets

### 3.12 移动端分类偏置

#### Fintech
信任、平静间距、清晰数字、克制强调色、少假图表、强交易清晰度

#### Health / Fitness
平静结构、强指标层级、激励但不嘈杂、可读进度模块、空气感间距

#### Productivity
清晰、列表和卡片纪律、导航简洁、平静密度、强任务层级

#### Social
Profile 和 feed 节奏、媒体时刻、创建和浏览的清晰层级、更强流程变化

#### Commerce
浏览/详情/购物车清晰、强产品图片、稳定产品卡片比例、干净结账层级

#### Wellness / Lifestyle
更软材质、平静排版、更少视觉噪音、呼吸空间、优雅图片、触感背景

---

## 4. 图片色彩/排版/资产/文案纪律

### 4.1 调色板纪律

使用一个受控的调色板贯穿整个网站/app：
- 1 主色（品牌锚点）
- 1 辅助色（支持色调）
- 1 强调色（节制使用，用于 CTA/高亮）
- 中性色阶（背景、表面、文字、分割线）

Section 级情绪变化必须复用同一调色板——不允许每 section 完全换主题。

### 4.2 背景图和谐

使用全出血图片背景时：
- 图片色调必须匹配调色板（不冲突）
- 使用 overlay（深色、浅色或色调）保持文字完全可读
- 品牌强调色无论背景图如何保持一致

### 4.3 渐变纪律

**允许（自信使用）：**
- 低彩度、调色板匹配的色调渐变（如 ink→graphite, cream→sand, ivory→warm grey）
- 单色大气等级在 Hero 摄影后
- 柔和 vignette 和径向深度引导视线
- 噪声纹理渐变增加触感深度
- Editorial 色彩 wash 匹配品牌情绪

**禁止（AI 渐变 slop）：**
- 彩虹/mesh blob 渐变
- 紫到蓝 "AI" 默认
- 粉到橙 "creator" 默认
- 霓虹边缘和发光光晕
- 渐变文字作为 "premium" 的捷径
- 与图片竞争而非支持的渐变

### 4.4 背景自信规则

不要默认退回到纯白表面。当 brief、品牌情绪或 section 工作需要氛围时，自信使用：
- 全出血图片
- Duotone 或分级照片
- 色调渐变
- 触感材质
- 自信的纯色域

### 4.5 材质感

适当时添加：
- 纸感
- 玻璃感
- 拉丝金属感
- 柔和模糊深度
- 触感哑光表面
- Editorial 照片处理

但始终保持前端结构可读。

### 4.6 排版纪律

排版是主要设计材料，不是填充物。

**始终确保：**
- 清晰的尺寸对比
- 明显的阅读顺序
- 强烈的 display 时刻
- 可读的正文
- 简洁的文案
- 强化结构的 section 标题

**Editorial 方向：** 让排版塑造构图
**Tech/Product 方向：** 让排版传达信任和精确

**禁止：**
- 超大标题 + 弱小的微小副标题
- 一页太多字体情绪
- 尴尬的换行
- 懒惰的全大写
- 渐变标题作为 "premium" 的捷径

### 4.7 图片/媒体方向

图片必须支持布局。

**允许：**
- 艺术指导的产品视觉
- 精致的 editorial 摄影
- UI 裁剪
- 有结构目的的抽象形式
- 构图对象
- Premium 纹理使用
- 活动风格视觉

**禁止：**
- 无关的风景
- 库存照片陈词滥调
- 装饰垃圾
- 压倒页面层级的视觉

### 4.8 文案纪律

文案必须：
- 简短
- 干净
- 适合产品
- 可读
- 对屏幕有用

**禁止通用文案：**
- unleash / elevate / revolutionize / next-gen / seamless / powerful solution / transformative platform

**禁止假品牌：**
- Acme / Nexus / Flowbit / Quantumly / NovaCore

使用简短、可信、设计友好的文案。

### 4.9 图片使用规则

图片不是可选的装饰。图片是前端设计语言的核心部分。

**强烈偏好：**
- 艺术指导的摄影
- 产品图片
- Editorial 图片
- 图片裁剪
- 构图图片面板
- 分层图片构图
- 图片主导的 Hero section
- 图片支持的叙事块

**用图片来：**
- 创建视觉层级
- 打破文字密集的布局
- 建立情绪和品牌性格
- 支持 section 过渡
- 使设计更容易解释和实现

**禁止：**
- 微小的无用缩略图
- 无结构作用的随机装饰图片
- 一张图片后全是文字
- 过度使用假 UI 面板替代真正的视觉变化

---

## 5. Image-to-Code 工作流

### 5.1 核心工作流

对于视觉重要的前端任务，必须遵循：

```
第一步：生成设计图片
第二步：深度分析图片
第三步：实现前端代码
```

**禁止：**
- 跳过图片生成直接写代码
- 先自由形式编码
- 描述网站而不先生成视觉参考
- 依赖 "好的前端品味" 的记忆而非实际参考

### 5.2 生成足够图片

生成足够多的图片使设计真正可读和可提取。

**不要懒惰于图片数量。**

如果更多图片能改善：
- 文字可读性
- 排版提取
- 间距分析
- 按钮分析
- 卡片分析
- 颜色提取
- 组件检查
- 实现保真度

那么生成更多图片。

**强规则：**
- 太多清晰图片 > 太少压缩图片
- 每 section 一张清晰图片 > 整站一张不可读的板
- 创建额外细节图片 > 之后猜测细节

### 5.3 禁止裁剪旧图片

当一个 section 需要专用图片或更近的细节视图时，**不要**从之前生成的大图中裁剪、切出、放大或切片。

**禁止：**
- 从全页板中裁剪 Hero
- 从大构图中裁剪定价区域
- 从多 section 图片中裁剪微小卡片
- 依赖现有图片的粗糙切出
- 使用提取的图片片段作为实现的主要来源

**改为：**
- 为该 section 生成全新的图片
- 保持相同的设计语言、调色板、排版情绪和组件家族
- 使新图片专门优化为可读性和可提取性

### 5.4 深度图片分析要求

在实现之前，深度分析生成的图片。不要只是扫一眼。把它们当作设计规范。

**仔细检查和提取：**
- 可读的可见文字
- Hero 标题措辞
- 副标题措辞
- CTA 措辞
- Section 标题
- 排版性格
- 字号比例关系
- 字体情绪
- 行数和换行行为
- 对齐逻辑
- Section 间距
- 内部间距
- Padding 和 gutter
- 卡片尺寸和节奏
- 圆角逻辑
- 描边/分割线使用
- 按钮形状和层级
- 按钮 padding
- 悬停暗示样式
- 调色板
- 强调色
- 背景处理
- 图片处理
- 图标处理
- 阴影/深度逻辑
- 网格逻辑
- 布局结构
- Section 排序
- Section 密度
- 视觉节奏
- 定义设计语言的重复 motif

### 5.5 排版提取

不要只注意到排版 "看起来不错"。正确分析它。

**提取和观察：**
- 尺寸关系
- 重量关系
- 行数
- 行高感觉
- 字距感觉
- Serif vs sans 行为
- Display vs body 对比
- Section 标题节奏
- CTA 文字比例

在实现中使用这些发现。不要将排版扁平化为通用编码层级。

### 5.6 间距提取

有意识地分析间距。

**检查：**
- 标题和副标题之间的距离
- 文字和按钮之间的距离
- 卡片之间的距离
- Section 顶部和底部间距
- 侧边 gutter
- 卡片 padding
- 图片到文字的距离
- 导航栏间距
- CTA 块间距
- 跨 section 的整体节奏

目标不是精确的像素 OCR，而是忠实的间距逻辑。

### 5.7 按钮/组件提取

按钮和组件必须分析，不能猜测。

**检查：**
- 按钮尺寸
- 按钮形状
- 按钮圆角
- 填充 vs 描边行为
- 图标使用
- 悬停暗示情绪
- 主要 vs 次要层级
- 卡片结构
- Badge 使用
- 分割线
- 阴影
- 边框
- Pill 逻辑
- 输入样式

如果按钮或卡片细节太小，生成更近的图片。

### 5.8 颜色提取

主动分析和提取颜色。

**检查：**
- 背景色
- 面板色
- 强调色
- 按钮填充色
- 文字颜色层级
- 边框颜色逻辑
- 阴影颜色情绪
- 图片色调/等级
- 渐变克制或强度

实现的网站应尽可能保留原始颜色逻辑。

### 5.9 设计到代码的复制纪律

生成和分析参考图片后，以复制为导向实现网站：

- 紧密跟随参考
- 保留布局逻辑
- 保留间距节奏
- 保留 section 顺序
- 保留图文平衡
- 保留排版情绪
- 保留组件风格
- 保留整体视觉整洁

**目标不是：** "受图片启发"
**目标是：** "在视觉上忠实于图片，翻译为真正的前端"

### 5.10 防漂移实现规则

一个常见的失败模式是设计漂移：生成的图片看起来很强，但编码结果变得通用。

**严格避免：**
- 简化为默认模板
- 用通用行替换独特 section
- 将慷慨间距压缩为密集布局
- 用普通层级替换强排版
- 为方便移除页面视觉身份
- 合并 section 逻辑为源图片中没有的重复模式
- 重新引入分析时有意移除的嵌套框复杂度

### 5.11 模糊细节解决

当从图片实现时，某些细节可能不清楚。

**按此顺序解决模糊：**
1. 保留可见的设计语言
2. 保留布局和间距逻辑
3. 保留组件家族
4. 保留情绪和润色水平
5. 如果需要，生成额外细节图片
6. 如果需要，重新生成 section 为全新独立图片
7. 然后选择最实现友好的忠实版本

**不要**太快用通用默认值填充模糊。

---

## 6. AI 生图痕迹检测

### 6.1 Web 端 AI 痕迹检测

#### 布局痕迹
- 无尽居中 section
- 相同卡片行重复 section 接 section
- 克隆的左文右图块
- 完美但无生命的对称
- 无层级的假复杂度
- 无目的的空装饰空间

#### 视觉痕迹
- 默认紫/蓝 AI 渐变
- 太多发光边缘
- 到处浮动球体/blob
- 无理由堆叠的 glassmorphism
- 无结构的随机未来细节
- 过度渲染的噪声隐藏布局

#### 排版痕迹
- 超大标题 + 弱微小副标题
- 一页太多字体情绪
- 尴尬换行
- 懒惰的全大写
- 渐变标题作为 "premium" 捷径

#### 密度痕迹
- 过度填充的 section
- 每块都卡片过载
- 主要 section 之间微小间距
- 视觉上令人疲惫的内容墙

#### Carousel/Marquee 痕迹
- 无限 logo 条重复相同 6 个 blob
- "Trusted by" ticker 不可读的蚊子 logo
- 自动播放风格 Hero 点无语义目的

#### 数据/KPI 痕迹
- 三个相同统计列（99% 满意度、$10 节省、∞ 规模）——除非用户要求 KPIs
- 假仪表盘带无意义图表

### 6.2 移动端 AI 痕迹检测

#### 视觉 AI 痕迹
- 紫蓝 fintech 渐变到处
- 随机玻璃卡片
- 无目的的环境 blob
- 假霓虹 premium 外观
- 通用 Dribbble 风格浮动 widget
- 所有东西超大圆角
- 无层级的光泽表面

#### 布局 AI 痕迹
- 假图表仪表盘垃圾
- 无产品原因的重复 stat 卡片
- 看起来像 12 个 widget 争夺注意力的首页
- 流程中克隆的屏幕
- 内容弱的大空卡片
- 手机形状的网站而非 app 屏幕

#### UI 杂乱痕迹
- 太多 pills
- 太多 badges
- 太多微小标签
- 假系统标记
- 无意义的头像行
- 随机图表插入
- 无产品意义的装饰开关

### 6.3 通用禁止列表

**禁止的渐变：**
- 彩虹/mesh blob 渐变
- 紫到蓝 "AI" 默认
- 粉到橙 "creator" 默认
- 霓虹边缘和发光光晕
- 渐变文字作为 "premium" 捷径

**禁止的文案：**
- unleash / elevate / revolutionize / next-gen / seamless / powerful solution / transformative platform

**禁止的假品牌名：**
- Acme / Nexus / Flowbit / Quantumly / NovaCore

**禁止的假复杂度：**
- 伪企业控制标签
- 装饰系统标记
- 填充状态微文案
- 假 operator/runtime/orchestration 术语

---

## 7. Pre-Flight Check

### 7.1 Web 端生图检查清单

输出前内部验证：

1. 层级是否明显？
2. Hero 是否足够干净？
3. 设计是否视觉独特？
4. 是否没有明显的 AI 痕迹？
5. 是否 premium 而非模板感？
6. 有人能据此编码吗？
7. 多张图片是否明显属于同一品牌？
8. 图片使用是否足够强（有变化，非重复裁剪）？
9. 页面是否呼吸，还是太密集？
10. Section 之间是否有足够间距？
11. 创意是否感觉有意图且 premium（概念脊柱可见，不杂乱）？
12. Section 间距是否均匀可控？
13. 小 section 是否有足够空间感觉干净？
14. 是否恰好有一个纪律的 "second-read" moment 辅助扫描顺序？
15. 构图是否跨 section 变化（anchors 和 background modes 混合）？
16. Hero scale（giant/mid/mini）是否选择并干净执行？
17. 即使在艺术性网站中是否有清晰的转化路径（hook → proof → action）？
18. 调色板是否跨所有 section 图片一致？
19. 每张图是否横向且仅一个 section？
20. 图片总数是否等于 section 数量（从不更