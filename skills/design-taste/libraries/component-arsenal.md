---
library: component-arsenal
description: 设计模式参考词汇表 — 融合 oc v5 Section 9、原版 v1 Section 8、原版 Section 9，消除重复。每个模式含名称、描述、适用场景、三旋钮建议值。代码骨架见 motion-patterns.md。
---

# Component Arsenal — 设计模式参考词汇

> 这是词汇表，不是模板库。Agent 应该**知道这些模式名称**，以便在设计时引用、在 Design Read 中命名、在需要时 reach for。
> 每个模式标注了三旋钮建议值（VARIANCE / MOTION / DENSITY），超出范围时慎用。

---

## Hero 范式

### 1. Asymmetric Split Hero（非对称分屏 Hero）

文字在一侧（左或右），资产（图片/视频/3D）在另一侧，慷慨留白。避免居中排版。

- **描述：** 打破居中 Hero 的 AI 默认。左对齐文字 + 右侧高质视觉资产，或反之。文字区占 40-50% 宽度，资产区占剩余。视觉资产可以是产品图、场景摄影、抽象 3D 渲染或视频。
- **适用场景：** SaaS 首页、品牌官网、产品发布页。当 DESIGN_VARIANCE > 4 时优先选择。
- **三旋钮建议：** VARIANCE 5-8 / MOTION 4-7 / DENSITY 2-4

### 2. Editorial Manifesto Hero（编辑宣言 Hero）

大字排版，无视觉资产，几乎像海报。纯文字 + 留白作为主要视觉。

- **描述：** 依赖排版本身作为 Hero 的视觉焦点。超大标题（`text-6xl md:text-8xl`）、慷慨行距、克制配色。无图片、无视频、无 3D 渲染。文字即设计。
- **适用场景：** 品牌宣言页、About 页、产品发布声明、manifesto 式 landing page。仅当文案本身足够有力。
- **三旋钮建议：** VARIANCE 6-9 / MOTION 2-4 / DENSITY 1-2

### 3. Video / Media Mask Hero（视频蒙版 Hero）

文字作为视频或图片背景的透明窗口/蒙版。

- **描述：** 背景为全宽视频或动态媒体，前景文字通过 CSS `mix-blend-mode` 或 `background-clip: text` 实现"挖空"效果，让媒体透过文字显示。通常配合深色遮罩层确保可读性。
- **适用场景：** 娱乐/媒体品牌、电影级产品发布、创意 agency 首页。需要高质量背景视频素材。
- **三旋钮建议：** VARIANCE 7-10 / MOTION 8-10 / DENSITY 2-3

### 4. Kinetic-Type Hero（动态排版 Hero）

动画排版作为主要视觉，文字本身在运动。

- **描述：** 标题文字有入场动画（stagger 字母/单词飞入）、持续微动效（浮动/摇摆/呼吸）、或滚动驱动变形。排版本身就是 Hero 的"视觉资产"。
- **适用场景：** 创意 agency、个人作品集、实验性品牌。需要 MOTION_INTENSITY > 6。
- **三旋钮建议：** VARIANCE 8-10 / MOTION 7-10 / DENSITY 2-3

### 5. Curtain-Reveal Hero（幕布展开 Hero）

Hero 部分在滚动时像幕布一样从中间向两侧展开，露出下方内容。

- **描述：** Hero 固定在视口顶部，滚动时 Hero 从中间垂直或水平"撕裂"，露出背后的内容区。通常用 CSS `clip-path` 动画或 GSAP ScrollTrigger 实现。展开后 Hero 内容逐渐淡出或缩小。
- **适用场景：** 电影/媒体网站、产品发布页、叙事型 landing page。需要戏剧性过渡。
- **三旋钮建议：** VARIANCE 7-10 / MOTION 8-10 / DENSITY 2-3

### 6. Scroll-Pinned Hero（滚动固定 Hero）

Hero 保持固定在视口，内容在背后滚动覆盖。

- **描述：** Hero 内容 `position: sticky; top: 0`，后续 section 在滚动时覆盖 Hero。Hero 在覆盖过程中可做缩放/模糊/颜色变化。比 Curtain-Reveal 更轻量，不需要 clip-path。
- **适用场景：** 品牌首页、作品集、需要"层层揭开"叙事感的页面。
- **三旋钮建议：** VARIANCE 5-8 / MOTION 5-8 / DENSITY 2-4

---

## 导航 & 菜单

### 7. Magnetic Button（磁力按钮）

按钮向光标方向物理拉近，带弹簧物理反馈。

- **描述：** 按钮或导航项在鼠标悬停时，向光标方向轻微位移（通常 2-6px）。用 Motion `useMotionValue` + `useTransform` 实现，不触发 React re-render。配合 `scale: 1.02` 和弹簧缓动。
- **适用场景：** CTA 按钮、导航项、卡片交互。MOTION_INTENSITY > 5 时使用。
- **三旋钮建议：** VARIANCE 5-9 / MOTION 6-10 / DENSITY 2-5

### 8. Dynamic Island（动态岛）

变形 pill 状 UI 组件，根据状态变化改变形状。

- **描述：** 灵感来自 iPhone Dynamic Island。一个 pill 形状的组件在交互时流畅变形（宽度/高度/圆角变化），用于显示状态、通知、播放控制等。用 Motion `layout` 动画实现平滑变形。
- **适用场景：** 媒体播放器、通知中心、状态指示器。品牌调性偏 Apple/消费电子时使用。
- **三旋钮建议：** VARIANCE 6-9 / MOTION 6-9 / DENSITY 3-5

### 9. Mega Menu Reveal（大型菜单展开）

全屏或半屏下拉菜单，内容 staggered 渐入。

- **描述：** 导航项 hover/click 时，展开覆盖整个屏幕或大半屏的下拉面板。面板内内容按 stagger 节奏依次出现（`delay: i * 0.05`）。通常带 `backdrop-blur` 背景。适合有大量二级导航的网站。
- **适用场景：** 大型品牌官网、电商导航、内容丰富的企业站。
- **三旋钮建议：** VARIANCE 5-8 / MOTION 5-8 / DENSITY 4-7

### 10. Floating Speed Dial（浮动快捷拨号）

FAB（浮动操作按钮）点击后弹出弧形排列的次要操作。

- **描述：** 固定在屏幕右下角的圆形按钮，点击后弹出 3-5 个次要操作按钮，沿弧线或直线排列。每个子按钮带 staggered 入场动画。点击外部或再次点击主按钮收回。
- **适用场景：** 移动端优先的 Web 应用、创作工具、内容管理界面。
- **三旋钮建议：** VARIANCE 6-9 / MOTION 6-9 / DENSITY 4-6

### 11. Mac OS Dock Magnification（Dock 放大效果）

导航栏或图标在 hover 时放大，相邻元素推开。

- **描述：** 类似 macOS Dock 的物理效果。鼠标悬停的图标放大（`scale: 1.3-1.5`），相邻图标被推开以腾出空间。用 GSAP 或 Motion 的 `useMotionValue` 计算每个图标基于鼠标位置的缩放比例。
- **适用场景：** 创意工具 UI、媒体浏览器、Dock 式导航。
- **三旋钮建议：** VARIANCE 7-10 / MOTION 7-10 / DENSITY 3-5

### 12. Gooey Menu（粘性菜单）

子项像粘液一样从主按钮分离/融合。

- **描述：** 使用 SVG `<filter>` 的 `feGaussianBlur` + `feColorMatrix` 实现粘液效果。菜单项在展开/收起时看起来像粘稠液体在分离和融合。视觉上非常独特但需要 SVG 滤镜知识。
- **适用场景：** 创意 agency、游戏 UI、实验性品牌。MOTION_INTENSITY > 7。
- **三旋钮建议：** VARIANCE 9-10 / MOTION 8-10 / DENSITY 2-4

### 13. Contextual Radial Menu（上下文径向菜单）

在点击坐标处展开的环形菜单。

- **描述：** 右键或长按触发，菜单项从点击点沿圆形展开。每项等距分布在圆上，带旋转和缩放入场动画。适合触控板或鼠标右键交互。
- **适用场景：** 创意工具、绘图应用、自定义右键菜单。
- **三旋钮建议：** VARIANCE 8-10 / MOTION 7-10 / DENSITY 3-5

---

## 布局 & 网格

### 14. Bento Grid（Bento 网格）

非对称、基于 tile 的分组布局（Apple Control Center 风格）。

- **描述：** CSS Grid 实现，单元格大小不一（`col-span-2 row-span-2` 旁 `col-span-1`）。内容块按内容重要性分配空间。用 `grid-flow-dense` 自动填充空隙。格子数必须等于内容数，不留空单元格。
- **适用场景：** Feature section、Dashboard 概览、作品集网格。DESIGN_VARIANCE 5-9 时首选。
- **三旋钮建议：** VARIANCE 6-9 / MOTION 3-7 / DENSITY 3-6

### 15. Masonry Layout（瀑布流布局）

交错网格，无固定行高。

- **描述：** 列数固定但每项高度不同，形成自然的瀑布流效果。CSS 原生 `masonry` 仍在实验阶段，推荐用 `columns-3 gap-4` 或 JS 库（Masonry.js）。每项 `break-inside: avoid` 防止跨列断裂。
- **适用场景：** 作品集、博客列表、图片画廊、Pinterest 式内容浏览。
- **三旋钮建议：** VARIANCE 6-9 / MOTION 2-5 / DENSITY 4-7

### 16. Split-Screen Scroll（分屏滚动）

屏幕两半在滚动时向相反方向滑动。

- **描述：** 页面垂直分为左右两半（或上下两半），滚动时两侧内容以不同速度或方向移动。常见实现：左侧固定文字列表，右侧滚动图片。或左右两侧以相反方向平移。
- **适用场景：** 对比展示（Before/After）、案例研究、品牌故事叙述。
- **三旋钮建议：** VARIANCE 7-10 / MOTION 6-9 / DENSITY 2-4

### 17. Sticky-Stack Sections（粘性堆叠 Section）

多个 section 在滚动时依次固定并堆叠。

- **描述：** 每个 section 在到达视口顶部时被 `position: sticky` 固定，前一个 section 缩小/淡出，露出下一个。用 GSAP ScrollTrigger 实现 pin + scale/opacity 变换。详见 motion-patterns.md 的 GSAP Sticky-Stack 骨架。
- **适用场景：** 叙事型首页、产品功能介绍、品牌故事。MOTION_INTENSITY > 5。
- **三旋钮建议：** VARIANCE 6-9 / MOTION 6-9 / DENSITY 2-4

### 18. Chroma Grid（变色网格）

网格边框或 tile 显示持续渐变的色彩动画。

- **描述：** 网格项的边框或背景有缓慢流动的色彩渐变。用 CSS `@keyframes` 动画 `background-position` 或 `hue-rotate` 实现。每个网格项的颜色相位略有偏移，形成波浪效果。
- **适用场景：** 科技品牌、AI 产品、创意 agency。MOTION_INTENSITY > 5。
- **三旋钮建议：** VARIANCE 7-10 / MOTION 6-9 / DENSITY 3-5

### 19. Curtain Reveal（幕布展开 Section）

Section 在滚动时像幕布一样从中间展开。

- **描述：** 与 Hero 版类似但用于内容 section。用 `clip-path: inset(50% 0 50% 0)` 过渡到 `inset(0)`，或左右两半从中间向两侧滑动露出内容。适合"揭示"型内容。
- **适用场景：** 产品揭幕、数据揭示、品牌故事高潮部分。
- **三旋钮建议：** VARIANCE 7-10 / MOTION 7-10 / DENSITY 2-4

---

## 卡片 & 容器

### 20. Parallax Tilt Card（视差倾斜卡片）

3D 倾斜卡片追踪鼠标坐标。

- **描述：** 卡片在鼠标移动时沿 X/Y 轴 3D 旋转（通常 ±10-15°），配合 `perspective: 1000px`。用 Motion `useMotionValue` 计算旋转角度，不触发 re-render。内层元素可做反向位移增加深度感。
- **适用场景：** 作品集卡片、产品展示、团队成员卡片。MOTION_INTENSITY > 5。
- **三旋钮建议：** VARIANCE 6-9 / MOTION 6-9 / DENSITY 3-5

### 21. Spotlight Border Card（聚光边框卡片）

卡片边框在光标下动态发光。

- **描述：** 卡片边框上有一个"光点"跟随鼠标移动，照亮边框的对应位置。用 CSS `radial-gradient` 配合 `--mouse-x` 和 `--mouse-y` CSS 变量实现。光晕通常为白色/金色半透明。
- **适用场景：** 定价卡片、Feature 卡片、CTA 区域。premium 品牌首选。
- **三旋钮建议：** VARIANCE 5-8 / MOTION 5-8 / DENSITY 3-5

### 22. Glassmorphism Panel（玻璃态面板）

磨砂玻璃效果带内折射边框。

- **描述：** `backdrop-filter: blur(20px)` + 半透明背景 + 1px 内边框（`border-white/10`）+ 内阴影（`shadow-[inset_0_1px_0_rgba(255,255,255,0.1)]`）。提供 `prefers-reduced-transparency` 回退为纯色背景。
- **适用场景：** Premium 品牌、Apple 风格、媒体覆盖层。非 Dashboard/公共部门。
- **三旋钮建议：** VARIANCE 5-8 / MOTION 3-6 / DENSITY 2-4

### 23. Holographic Foil Card（全息箔片卡片）

卡片表面有虹彩光泽效果，在 hover 时变化。

- **描述：** 用多层 CSS 渐变（`linear-gradient` 多个角度）+ `background-size: 200%` + 动画 `background-position` 模拟全息箔片光泽。颜色在紫/蓝/粉/金之间过渡。
- **适用场景：** 限量版产品、会员卡、游戏道具、NFT 展示。
- **三旋钮建议：** VARIANCE 7-10 / MOTION 6-9 / DENSITY 2-4

### 24. Tinder Swipe Stack（Tinder 滑动堆叠）

卡片堆叠，可拖拽滑动 + 物理弹回。

- **描述：** 多张卡片叠放，最上层可拖拽。拖拽超过阈值时卡片飞出（左/右/上），下一张浮现。用 Motion `drag` + `onDragEnd` 判断方向和距离。配合弹簧弹回和飞出动画。
- **适用场景：** 推荐系统、决策工具、游戏化交互。MOTION_INTENSITY > 6。
- **三旋钮建议：** VARIANCE 7-10 / MOTION 7-10 / DENSITY 3-5

### 25. Morphing Modal（变形模态框）

按钮流畅展开为全屏对话框。

- **描述：** 点击按钮后，按钮本身通过 `layout` 动画变形为全屏或大尺寸模态框。内容在变形过程中 staggered 出现。关闭时反向动画回到按钮形态。共享 `layoutId` 是关键。
- **适用场景：** 登录/注册弹窗、快速预览、详情展开。MOTION_INTENSITY > 5。
- **三旋钮建议：** VARIANCE 6-9 / MOTION 6-9 / DENSITY 3-5

---

## 滚动动画

### 26. Sticky Scroll Stack（粘性滚动堆叠）

卡片在滚动时依次固定并物理堆叠。

- **描述：** 每张卡片在到达视口顶部时 `position: sticky` 固定，前一张卡片缩小并淡出。详见 motion-patterns.md 的 GSAP 规范骨架。
- **适用场景：** 产品功能介绍、时间线叙事、案例研究。
- **三旋钮建议：** VARIANCE 6-9 / MOTION 6-9 / DENSITY 2-4

### 27. Horizontal Scroll Hijack（水平滚动劫持）

垂直滚动转化为水平平移。

- **描述：** 一个 section 被 `pin` 在视口，内部轨道随垂直滚动水平滑动。详见 motion-patterns.md 的 GSAP 规范骨架。
- **适用场景：** 画廊展示、时间线、产品系列浏览。MOTION_INTENSITY > 6。
- **三旋钮建议：** VARIANCE 7-10 / MOTION 7-10 / DENSITY 3-5

### 28. Zoom Parallax（缩放视差）

中央背景图片在滚动时缩放。

- **描述：** 背景图片从 `scale: 1.2` 到 `scale: 1`（或反之），配合 `background-attachment: fixed` 或 GSAP ScrollTrigger。前景内容以不同速度移动，形成深度层次。
- **适用场景：** Hero 下方的内容 section、品牌故事、产品展示。
- **三旋钮建议：** VARIANCE 5-8 / MOTION 5-8 / DENSITY 2-4

### 29. Scroll Progress Path（滚动进度路径）

SVG 线条或路径沿滚动绘制自身。

- **描述：** SVG 路径的 `stroke-dashoffset` 随滚动进度从全长减少到 0，实现"路径自绘"效果。用 ScrollTrigger 将滚动进度映射到路径绘制进度。
- **适用场景：** 品牌故事、数据可视化、装饰性滚动指示器。
- **三旋钮建议：** VARIANCE 6-9 / MOTION 5-8 / DENSITY 2-4

### 30. Locomotive / Sequence Scroll（平滑滚动序列）

平滑滚动 + 滚动驱动的帧序列动画。

- **描述：** 使用 Locomotive Scroll 或类似库实现平滑滚动，同时滚动进度驱动视频帧序列或 3D 场景旋转。每帧对应一个滚动位置，形成电影级效果。
- **适用场景：** 产品 3D 展示、品牌电影、沉浸式叙事。
- **三旋钮建议：** VARIANCE 8-10 / MOTION 9-10 / DENSITY 2-3

### 31. Liquid Swipe Transition（液体滑动过渡）

页面/区块过渡像液体一样流动。

- **描述：** 过渡动画用 SVG 遮罩或 `clip-path` 实现液体般的流动效果。遮罩路径从一点扩散到全屏，或从一侧波浪式覆盖。通常配合 GSAP 或自定义 WebGL。
- **适用场景：** 创意 agency、作品集翻页、品牌体验网站。
- **三旋钮建议：** VARIANCE 8-10 / MOTION 9-10 / DENSITY 2-3

---

## 画廊 & 媒体

### 32. Dome Gallery（穹顶画廊）

3D 穹顶画廊，滚动时旋转。

- **描述：** 图片排列在 3D 穹顶或圆柱内表面，用户通过滚动或拖拽旋转视角。用 Three.js 或 CSS 3D transforms 实现。每张图片面向圆心，随视角变化角度。
- **适用场景：** 作品集、产品系列展示、沉浸式画廊。
- **三旋钮建议：** VARIANCE 8-10 / MOTION 8-10 / DENSITY 3-5

### 33. Coverflow Carousel（封面流轮播）

3D 轮播，中心聚焦，两侧斜角。

- **描述：** 当前项居中放大，左右两侧项缩小并旋转角度（`rotateY(45deg)`），形成 3D 封面流效果。用 CSS 3D transforms 或 GSAP 实现。
- **适用场景：** 专辑/媒体浏览、产品选择、作品集导航。
- **三旋钮建议：** VARIANCE 6-9 / MOTION 6-9 / DENSITY 3-5

### 34. Drag-to-Pan Grid（拖拽平移网格）

无边界的可拖拽画布。

- **描述：** 内容区域超出视口，用户通过拖拽（鼠标或触控）自由平移查看。用 Motion `drag` 或 `overflow: auto` + 自定义滚动条。适合大量内容的浏览方式。
- **适用场景：** 大型作品集、数据可视化、地图式内容浏览。
- **三旋钮建议：** VARIANCE 7-10 / MOTION 4-7 / DENSITY 5-8

### 35. Accordion Image Slider（手风琴图片滑块）

窄条在 hover 时展开为全宽图片。

- **描述：** 多张图片并排显示为窄竖条，hover 时当前条展开为全宽，其他条压缩。用 CSS `flex` 和 `transition` 实现。配合内容在展开时渐入。
- **适用场景：** 团队介绍、项目展示、品牌故事。
- **三旋钮建议：** VARIANCE 5-8 / MOTION 3-6 / DENSITY 3-5

### 36. Hover Image Trail（鼠标图片轨迹）

鼠标移动留下弹出/淡出的图片轨迹。

- **描述：** 鼠标移动时，在鼠标位置或附近依次"弹出"小图片，然后淡出。图片可以随机从一组图片中选取。用 Motion `AnimatePresence` 管理弹出和移除。
- **适用场景：** 创意作品集、品牌体验页、娱乐网站。
- **三旋钮建议：** VARIANCE 8-10 / MOTION 7-10 / DENSITY 2-4

### 37. Glitch Effect Image（故障效果图片）

RGB 通道位移/数字失真 hover 效果。

- **描述：** 图片在 hover 时产生 RGB 通道分离（`translate` 偏移）、扫描线、撕裂等数字故障效果。用 CSS `mix-blend-mode` 叠加三个偏移的伪元素，配合 `clip-path` 制造随机撕裂。
- **适用场景：** 科技/赛博朋克品牌、游戏网站、实验性作品集。
- **三旋钮建议：** VARIANCE 7-10 / MOTION 6-9 / DENSITY 2-4

---

## 排版 & 文字

### 38. Kinetic Marquee（动态跑马灯）

无尽文字条，滚动时反转方向或加速。

- **描述：** 文字在水平方向无限循环滚动。滚动到页面特定位置时反转方向、改变速度或暂停。用 CSS `@keyframes` + `translateX(-50%)` 无缝循环，配合 ScrollTrigger 控制行为。
- **适用场景：** 品牌标语、新闻滚动条、装饰性文字。全页最多 1 个 marquee。
- **三旋钮建议：** VARIANCE 6-9 / MOTION 6-9 / DENSITY 2-4

### 39. Text Mask Reveal（文字蒙版揭示）

大字作为透明窗口，露出背后的视频/图片。

- **描述：** 超大标题文字用 `background-clip: text` + `-webkit-text-fill-color: transparent`，背景为视频或动态图片。文字像"窗口"一样露出背景内容。
- **适用场景：** Hero、品牌标语展示、创意 section 标题。
- **三旋钮建议：** VARIANCE 7-10 / MOTION 6-9 / DENSITY 2-3

### 40. Text Scramble Effect（文字乱码效果）

Matrix 风格字符解码动画。

- **描述：** 文字在加载或 hover 时，字符快速随机变化（乱码），最终稳定为目标文字。用 JS 定时器在短时间内多次替换字符，每次随机选取 ASCII 字符。
- **适用场景：** 科技品牌 Hero、AI 产品标语、黑客风格页面。
- **三旋钮建议：** VARIANCE 7-10 / MOTION 6-9 / DENSITY 2-4

### 41. Circular Text Path（圆形文字路径）

文字沿旋转的圆形路径弯曲。

- **描述：** 文字沿 SVG `<textPath>` 或 CSS `shape-outside` 弯曲排列在圆形路径上。路径本身缓慢旋转，文字随之移动。适合 Logo 周围的装饰文字。
- **适用场景：** Logo 展示、品牌标识页、创意装饰。
- **三旋钮建议：** VARIANCE 6-9 / MOTION 4-7 / DENSITY 2-4

### 42. Gradient Stroke Animation（渐变描边动画）

轮廓文字，描边渐变沿路径流动。

- **描述：** `-webkit-text-stroke` 配合 `linear-gradient` 背景，用 `@keyframes` 动画 `background-position` 让渐变沿文字描边流动。文字填充透明，仅显示描边。
- **适用场景：** 大标题装饰、品牌标语、创意排版展示。
- **三旋钮建议：** VARIANCE 6-9 / MOTION 5-8 / DENSITY 2-4

### 43. Kinetic Typography Grid（动态排版网格）

网格中每个字母独立响应鼠标。

- **描述：** 一个字母网格（如品牌名每个字母一格），鼠标移入时附近字母旋转/位移/缩放。每个字母独立动画，形成波浪或排斥效果。用 Motion 或 GSAP 逐个控制。
- **适用场景：** 创意 agency Hero、品牌互动页、实验性作品集。
- **三旋钮建议：** VARIANCE 9-10 / MOTION 8-10 / DENSITY 2-4

---

## 微交互 & 效果

### 44. Particle Explosion Button（粒子爆炸按钮）

CTA 在成功时碎裂成粒子。

- **描述：** 点击按钮后，按钮碎裂成数十个小粒子向四周飞散，然后淡出。用 Canvas 或 Motion 的 `AnimatePresence` 管理粒子生命周期。粒子颜色取品牌色。
- **适用场景：** 表单提交成功、游戏化交互、庆祝动画。MOTION_INTENSITY > 7。
- **三旋钮建议：** VARIANCE 7-10 / MOTION 8-10 / DENSITY 2-4

### 45. Skeleton Shimmer（骨架屏闪烁）

移动光反射穿过占位符。

- **描述：** 加载占位符上有一条斜向移动的光带，模拟内容正在加载。用 CSS `@keyframes` + `linear-gradient` 从 -100% 到 200% 移动 `background-position`。
- **适用场景：** 所有需要 loading 状态的组件。默认骨架屏方案。
- **三旋钮建议：** VARIANCE 1-10 / MOTION 2-5 / DENSITY 3-7

### 46. Directional Hover-Aware Button（方向感知按钮）

hover 填充从鼠标进入的方向进入。

- **描述：** 按钮背景填充从鼠标进入的那一侧开始，而不是统一从下到上。用 JS 检测 `mouseenter` 方向（上/下/左/右），设置对应的 `transform-origin`。纯 CSS 可用伪元素 + `scale` 动画。
- **适用场景：** CTA 按钮、导航项、卡片 hover。MOTION_INTENSITY > 4。
- **三旋钮建议：** VARIANCE 5-8 / MOTION 5-8 / DENSITY 2-5

### 47. Ripple Click Effect（涟漪点击效果）

波纹从点击坐标扩散。

- **描述：** 点击按钮或卡片时，一个圆形波纹从点击位置向外扩散并淡出。用 Motion `AnimatePresence` 管理波纹元素，点击时在点击坐标创建一个圆形元素，`scale: 0 → 2` + `opacity: 1 → 0`。
- **适用场景：** Material 风格按钮、卡片点击、列表项交互。
- **三旋钮建议：** VARIANCE 4-7 / MOTION 4-7 / DENSITY 3-5

### 48. Mesh Gradient Background（网格渐变背景）

有机熔岩灯般流动的彩色斑点。

- **描述：** 多个模糊的彩色圆形/斑点缓慢移动和变色，形成有机流动的渐变背景。用 CSS `filter: blur(60px)` + `@keyframes` 移动每个斑点的位置。或用 SVG `<feGaussianBlur>`。
- **适用场景：** Hero 背景、品牌装饰、科技产品展示。
- **三旋钮建议：** VARIANCE 5-8 / MOTION 4-7 / DENSITY 1-3

### 49. Lens Blur Depth（镜头模糊景深）

背景 UI 模糊以聚焦前景操作。

- **描述：** 模态框或弹出层打开时，背景内容应用 `filter: blur(4px)` 和亮度降低，模拟摄影的浅景深效果。关闭时恢复。配合 `transition` 平滑切换。
- **适用场景：** 模态框、弹出菜单、聚焦模式。MOTION_INTENSITY > 4。
- **三旋钮建议：** VARIANCE 5-8 / MOTION 4-7 / DENSITY 3-5

### 50. Animated SVG Line Drawing（SVG 线条绘制）

SVG 路径从起点到终点动态绘制。

- **描述：** SVG 路径的 `stroke-dasharray` 设为路径全长，`stroke-dashoffset` 从全长动画到 0，实现"线条在绘制自身"的效果。可用 ScrollTrigger 将绘制进度绑定到滚动。
- **适用场景：** Logo 展示、插图动画、装饰性路径。
- **三旋钮建议：** VARIANCE 5-8 / MOTION 5-8 / DENSITY 2-4

### 51. Liquid Pull-to-Refresh（液体下拉刷新）

下拉刷新变成粘性液体变形。

- **描述：** 移动端下拉刷新指示器，下拉时出现粘性液体变形效果。用 SVG 路径动态计算下拉位移对应的液体形状。释放时液体弹回并触发刷新。
- **适用场景：** 移动端 Web 应用、创意品牌移动页。
- **三旋钮建议：** VARIANCE 7-10 / MOTION 7-10 / DENSITY 2-4

---

## 动画库选择指南

| 库 | 适用场景 | 禁止混用 |
|----|---------|---------|
| **Motion (`motion/react`)** | UI 交互、Bento 动效、状态变化、scroll-reveal | 不与 GSAP/Three.js 在同一组件树 |
| **GSAP + ScrollTrigger** | 全页滚动叙事、scroll-hijack、sticky-stack | 不与 Motion 在同一组件树 |
| **Three.js / WebGL** | Canvas 背景、3D 场景、粒子系统 | 不与 Motion 在同一组件树 |

**铁律：** 一个组件树只用一种动画库。GSAP/Three.js 隔离在专用叶子组件中，带 `useEffect` 清理函数。
