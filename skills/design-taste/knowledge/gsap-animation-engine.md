---
knowledge: gsap-animation-engine
description: GSAP 动画引擎深度融合 — 与 oc-design-taste 三旋钮模型的精确映射、Motion 决策树、Easing 品味映射、ScrollTrigger 反模式、插件效果映射、性能铁律、Framework 集成、matchMedia + reduced-motion、autoAlpha 规则、水平滚动陷阱。来自 greensock/gsap-skills 8 个 SKILL.md + greensock/GSAP 的融合成果。
---

# GSAP Animation Engine — 深度融合知识

> 本文件是 GSAP 与 oc-design-taste 的桥梁。GSAP 是 MOTION_INTENSITY ≥6 时的主力引擎。
> 动效纪律和代码骨架见 `libraries/motion-patterns.md`。本文件聚焦**品味映射和陷阱规避**。

---

## 1. Motion 决策树：CSS vs Motion vs GSAP

```
MOTION_INTENSITY 1-3 → CSS transition + :hover/:focus 状态
MOTION_INTENSITY 4-5 → Motion (motion/react) — spring physics、whileInView、layout
MOTION_INTENSITY 6-7 → GSAP（轻量）— ScrollTrigger toggleActions、batch()
MOTION_INTENSITY 8-10 → GSAP（全量）— ScrollTrigger scrub + pin + Timeline 编排
```

**具体判断：**
| 需求 | 用什么 | 原因 |
|------|--------|------|
| hover / active 微交互 | CSS `transition` | 无需 JS，最轻量 |
| 入场动画（出现/消失） | Motion `whileInView` / `AnimatePresence` | React 生态原生，零 GSAP 依赖 |
| 弹簧物理、磁力、手势 | Motion `useMotionValue` + spring | 帧级性能，JSX 声明式 |
| Scroll-linked 进度动画 | **GSAP ScrollTrigger scrub** | scrub 将动画进度与滚动位置绑定，CSS/Motion 做不到 |
| Pin（固定某 section）| **GSAP ScrollTrigger pin** | 固定视口中的元素，需要 JS |
| 多步骤时间编排 | **GSAP Timeline** | 精确控制序列、暂停/倒放/seek |
| 视差/水平劫持滚动 | **GSAP ScrollTrigger** | 需要 scrub + pin 组合 |
| SVG 描边/变形/路径动画 | **GSAP 插件** (DrawSVG/MorphSVG/MotionPath) | Motion 无对应能力 |
| 逐字/逐词/逐行动画 | **GSAP SplitText** | Motion 无对应能力 |
| FLIP 布局过渡 | **GSAP Flip** | Motion 的 `layout` prop 可替代简单场景，复杂场景用 Flip |
| 鼠标跟随（高频更新）| **GSAP quickTo()** 或 Motion `useMotionValue` | 都可以，GSAP quickTo 更轻 |
| 减少动效（无障碍）| **GSAP matchMedia** 或 Motion `useReducedMotion` | 两者都支持 |
| IntersectionObserver 类行为 | **GSAP ScrollTrigger.batch()** 或 IO 原生 | 轻量用 IO，需要编排用 batch() |

---

## 2. GSAP ↔ 三旋钮精确映射

### MOTION_INTENSITY 档位 → GSAP 模式

| MOTION 档位 | GSAP 使用级别 | 典型配置 |
|-------------|--------------|---------|
| **1-3 静态** | ❌ 不用 GSAP | 纯 CSS transition |
| **4-5 流畅** | ⚠️ 按需（入场动画用 Motion，GSAP 仅在需要 scrub 时） | `toggleActions: "play none none none"` + `once: true` |
| **6-7 丰富** | ✅ 中度（ScrollTrigger + 简单 Timeline） | scrub: true、batch()、简单 stagger |
| **8-10 编排** | ✅ 全量（ScrollTrigger scrub:1 + pin + 嵌套 Timeline + 插件） | `scrub: 1`、`pin: true`、labels、position parameter |

### DESIGN_VARIANCE 档位 → GSAP easing 方向

| VARIANCE 档位 | Easing 品味 | GSAP ease 名称 |
|---------------|------------|----------------|
| **1-3 可预测** | 线性/极微弯 | `"none"` 或 `"power1.out"` |
| **4-5 偏移** | 标准减速（略有个性）| `"power2.out"` 或 `"power3.out"` |
| **6-7 非对称** | 明显减速感 | `"power3.out"` / `"power4.out"` / `"expo.out"` |
| **8-10 极端** | 戏剧化减速或 overshoot | `"expo.out"` / `"back.out(1.2)"` / CustomEase |

### VISUAL_DENSITY → GSAP stagger 策略

| DENSITY 档位 | stagger 方式 |
|-------------|--------------|
| **1-3 美术馆** | 大 stagger（0.1-0.15s），元素少 |
| **4-7 日常** | 中 stagger（0.06-0.1s）|
| **8-10 驾驶舱** | 小 stagger（0.03-0.05s）或无 stagger（同时出现），元素多 |

---

## 3. Easing 品味映射（§4.H → GSAP ease name）

oc-design-taste §4.H 推荐 `ease-out-quart` / `ease-out-quint` / `ease-out-expo`。
对应 GSAP 的精确 ease name：

| oc §4.H 推荐 | CSS cubic-bezier 等价 | **GSAP ease name** | 品味定位 |
|-------------|----------------------|-------------------|---------|
| ease-out-quart | `(0.25, 1, 0.5, 1)` | **`"power3.out"`** | 标准减速，B端默认 |
| ease-out-quint | `(0.22, 1, 0.36, 1)` | **`"power4.out"`** | 更陡减速，高端 |
| ease-out-expo | `(0.16, 1, 0.3, 1)` | **`"expo.out"`** | 戏剧减速，品牌 Hero |
| — | — | `"sine.out"` | 微妙柔和，轻交互 |
| — | — | `"circ.out"` | 接近 quart 但更圆滑 |
| — | — | `"back.out(1.2)"` | 微 overshoot，品牌入口 |

**⚠️ 禁止的 GSAP ease：**
| GSAP ease | CSS 等价 | 为什么禁止 |
|-----------|---------|-----------|
| `"bounce.out"` / `"bounce.inOut"` | — | §4.H 禁止 bounce/elastic |
| `"elastic.out"` | — | §4.H 禁止 |
| `"none"`（在交互反馈时）| `linear` | 反馈动画禁止线性，仅用于 scrub 绑定 |

**线性例外：** ScrollTrigger `scrub` 模式下 `ease: "none"` **必须使用**，否则滚动→动画映射不线性。

---

## 4. ScrollTrigger 反模式清单（Agent 最容易犯的 8 个错）

| # | 反模式 | 为什么错 | 正确做法 |
|---|--------|---------|---------|
| **ST01** | `scrub` 和 `toggleActions` 同时用 | scrub 优先，toggleActions 被忽略——代码意图混乱 | 选一个：离散触发用 `toggleActions`，连续绑定用 `scrub` |
| **ST02** | ScrollTrigger 放在 Timeline **内部子 tween** 上 | 子 tween 的 ScrollTrigger 会在 Timeline 播放时反复触发 | ScrollTrigger **只在顶层 Timeline 或独立 Tween 上** |
| **ST03** | `containerAnimation` 用了非 `"none"` 的 ease | 水平滚动位置与垂直滚动不对应 | **必须** `ease: "none"` |
| **ST04** | 异步创建 ScrollTrigger 不设 `refreshPriority` | refresh 按 creation 顺序执行，异步创建导致 pin spacing 错误 | 设 `refreshPriority`，或保证按页面从上到下顺序创建 |
| **ST05** | 忘记 `ScrollTrigger.refresh()` | 动态内容（字体/图片/异步数据）加载后触发位置不准 | DOM 变更后手动 refresh |
| **ST06** | `markers: true` 留在生产代码 | 调试标记泄漏到线上 | 生产前设 `markers: false` 或删除 |
| **ST07** | pin 了触发元素本身再动画它的 transform | pin 用 fixed，再动画 transform 会导致抖动 | **pin 父容器，动画子元素** |
| **ST08** | 嵌套 gsap.context() 在 matchMedia 内部 | matchMedia 内部已创建 context，嵌套导致重复 revert | matchMedia 内不嵌套 context，用 `mm.revert()` 清理 |

---

## 5. 插件 → 设计效果映射

> ⚠️ **GSAP Club License 警告：** 以下插件需要付费会员：
> | 插件 | 最低会员等级 | 免费替代 |
> |------|:----------:|---------|
> | **SplitText** | 🟢 Shockingly Green | CSS `text-wrap: balance` + 手动 `<span>` 分割 |
> | **MorphSVG** | 🟢 Shockingly Green | CSS `clip-path` transition |
> | **DrawSVG** | 🟢 Shockingly Green | CSS `stroke-dasharray` + `stroke-dashoffset` 动画 |
> | **ScrollSmoother** | 🟢 Shockingly Green | Lenis（免费开源） |
> | **InertiaPlugin** | 🟢 Shockingly Green | Motion `useSpring` / 手动 momentum 计算 |
> | **ScrambleText** | 🟢 Shockingly Green | 自定义字符替换动画 |
> | **Flip** | ✅ 免费 | 包含在核心包中 |
> | **CustomEase** | ✅ 免费 | 包含在核心包中 |
> | **Observer** | ✅ 免费 | 包含在核心包中 |
> | **ScrollToPlugin** | ✅ 免费 | 包含在核心包中 |
> | **MotionPath** | ✅ 免费 | 包含在核心包中 |
> | **Draggable** | ✅ 免费 | 包含在核心包中 |
>
> **Agent 生成代码前必须确认项目是否有 Club license。无 license 时使用免费替代方案。**

| 设计效果 | GSAP 插件 | MOTION 档位要求 | 代码骨架 |
|---------|----------|----------------|---------|
| 布局过渡（网格重排/折叠展开）| **Flip** | 5-8 | `Flip.getState()` → DOM 变更 → `Flip.from(state, {...})` |
| 逐字揭示标题 | **SplitText** | 6-9 | `SplitText.create(".heading", {type:"chars"})` → `gsap.from(split.chars, {stagger:0.03})` |
| 逐词淡入段落 | **SplitText** | 5-7 | `{type:"words"}` → stagger words |
| 文字 scramble/故障效果 | **ScrambleText** | 7-9 | `gsap.to(el, {scrambleText:{text:"...", chars:"01"}})` |
| SVG 描边动画（logo/图标）| **DrawSVG** | 6-9 | `gsap.from("#path", {drawSVG:0})` |
| SVG 形状变形（图标变形）| **MorphSVG** | 7-10 | `gsap.to("#icon1", {morphSVG:"#icon2"})` |
| 元素沿路径运动 | **MotionPath** | 7-10 | `gsap.to(el, {motionPath:{path:"#curve", autoRotate:true}})` |
| 拖拽+惯性（滑块/卡片排序）| **Draggable + Inertia** | 6-9 | `Draggable.create(el, {type:"x", inertia:true})` |
| 手势方向检测 | **Observer** | 4-8 | `Observer.create({onLeft, onRight, tolerance:10})` |
| 滚动到锚点 | **ScrollToPlugin** | 3-5 | `gsap.to(window, {scrollTo:{y:"#section"}})` |
| 平滑滚动 | **ScrollSmoother** | 6-10 | 需要特定 DOM 结构（smooth-wrapper > smooth-content） |
| 鼠标跟随高频更新 | **quickTo()**（核心，非插件）| 5-8 | `let xTo = gsap.quickTo(el, "x", {...})` |
| 2D 物理（抛射/弹跳）| **Physics2D** | 7-10 | `gsap.to(ball, {physics2D:{velocity:250, angle:80, gravity:500}})` |
| 自定义缓动曲线 | **CustomEase** | 任意 | `CustomEase.create("name", ".17,.67,.83,.67")` |

**安装注意：** 所有 GSAP 插件都包含在 `gsap` npm 包中（Webflow 收购后免费开放），import 路径为 `gsap/SplitText`、`gsap/MorphSVGPlugin` 等。

### 5.1 SplitText 高级选项

基础用法：`new SplitText(el, { type: "words,chars" })`

**高级选项（从 gsap-plugins 融合）：**

| 选项 | 类型 | 说明 |
|------|------|------|
| `type` | string | `"chars,words,lines"` 组合 |
| `autoSplit` | boolean | 自动分割（默认 true），false 时手动调 `split()` |
| `onSplit` | function | 分割完成回调，可在此修改生成的 DOM |
| `mask` | boolean | 为每个元素创建 mask（clip-path），用于 reveal 动画 |
| `deepSlice` | boolean | 深度分割嵌套元素内的文本 |
| `smartWrap` | boolean | 智能换行，保持单词完整 |
| `wordDelimiter` | string/regex | 单词分隔符（默认空格），中文用 `""` |
| `prepareText` | function | 分割前预处理文本 |
| `propIndex` | boolean | 为每个元素添加 `data-prop-index` 属性 |
| `linesClass` | string | 行元素的 class（默认 `"line"`） |
| `wordsClass` | string | 词元素的 class（默认 `"word"`） |
| `charsClass` | string | 字符元素的 class（默认 `"char"`） |

**SplitText 最佳实践：**

```javascript
import SplitText from "gsap/SplitText";
gsap.registerPlugin(SplitText);

// 基础分割 + 动画
const split = new SplitText(".heading", { type: "words,chars" });
gsap.from(split.chars, {
  opacity: 0,
  y: 50,
  rotationX: -90,
  stagger: 0.02,
  duration: 0.6,
  ease: "power3.out",
});

// 中文分割（无空格分隔符）
const split = new SplitText(".cn-heading", {
  type: "chars",
  wordDelimiter: "",  // 中文不需要单词分隔
});

// mask reveal 效果
const split = new SplitText(".reveal-text", {
  type: "lines",
  mask: true,  // 自动创建 clip-path mask
});
gsap.from(split.lines, {
  yPercent: 100,
  stagger: 0.1,
  duration: 0.8,
  ease: "power4.out",
});

// 清理（组件卸载时）
split.revert();  // 恢复原始 HTML
```

### 5.2 MorphSVG 高级选项

基础用法：`gsap.to("#shape1", { morphSVG: "#shape2" })`

**高级选项（从 gsap-plugins 融合）：**

| 选项 | 类型 | 说明 |
|------|------|------|
| `type` | string | `"rotational"`（绕中心变形）或 `"linear"`（默认线性插值） |
| `map` | string | `"size"` / `"position"` / `"complexity"` — 控制映射策略 |
| `shapeIndex` | number/string | 手动指定起始点索引或 `"auto"` |
| `smooth` | boolean | 平滑路径（默认 true） |
| `curveMode` | string | `"auto"` / `"linear"` / `"cubic"` — 路径段曲线类型 |
| `precompile` | boolean | 预编译为数值数组（性能优化，默认 true） |
| `render` | function | 自定义渲染函数 |
| `origin` | boolean | 是否使用 transformOrigin（默认 true） |

**MorphSVG 最佳实践：**

```javascript
import MorphSVGPlugin from "gsap/MorphSVGPlugin";
gsap.registerPlugin(MorphSVGPlugin);

// 形状变形 + 旋转类型
MorphSVGPlugin.convertToPath("circle, rect");  // 先转换基本形状

gsap.to("#circle", {
  morphSVG: {
    shape: "#rect",
    type: "rotational",  // 绕中心旋转变形
    shapeIndex: "auto",  // 自动找最佳起始点
  },
  duration: 1.5,
  ease: "power2.inOut",
  repeat: -1,
  yoyo: true,
});

// findMorphIndex 调试工具
const indices = MorphSVGPlugin.findMorphIndex("#shape1", "#shape2");
console.log(indices);  // 查看最佳起始点
```

### 5.3 DrawSVG 高级选项

基础用法：`gsap.from("path", { drawSVG: 0 })`

**segment 格式：**

```javascript
// 完整路径
{ drawSVG: "0% 100%" }

// 中间 50%
{ drawSVG: "25% 75%" }

// 从 30% 到终点
{ drawSVG: "30% 100%" }

// 绝对长度
{ drawSVG: "50 200" }

// 从起点到 80%
{ drawSVG: "0 80%" }
```

**辅助方法：**
```javascript
// 获取路径长度
DrawSVGPlugin.getLength("#path");

// 获取路径上某位置的点
DrawSVGPlugin.getPosition("#path", 0.5);  // 50% 位置
```

### 5.4 Flip 高级选项

基础用法：`Flip.from(state, { targets: ".card" })`

| 选项 | 类型 | 说明 |
|------|------|------|
| `absolute` | boolean | 使用绝对定位（默认 true，布局变化时推荐） |
| `nested` | boolean | 同时动画子元素（默认 false） |
| `scale` | boolean | 使用 scale 而非 width/height（默认 true，性能更好） |
| `simple` | boolean | 简化模式，只记录 transform（默认 false） |
| `fade` | boolean | 自动淡入淡出（默认 true） |
| `targets` | selector/array | 目标元素 |
| `duration` | number | 动画时长 |
| `onEnter` | function | 新元素入场回调 |
| `onLeave` | function | 旧元素退场回调 |

**Flip 最佳实践：**

```javascript
import { Flip } from "gsap/Flip";

// 1. 记录当前状态
const state = Flip.getState(".cards", { props: "borderRadius,backgroundColor" });

// 2. 改变布局（添加/删除/重排元素）
container.classList.toggle("grid-layout");

// 3. 动画到新状态
Flip.from(state, {
  targets: ".cards",
  duration: 0.6,
  ease: "power2.inOut",
  absolute: true,  // 布局变化时推荐
  scale: true,      // 用 scale 而非 width/height
  onEnter: (el) => gsap.from(el, { opacity: 0, scale: 0 }),
  onLeave: (el) => gsap.to(el, { opacity: 0, scale: 0 }),
});
```

### 5.5 ScrollTrigger 高级选项补充

| 选项 | 类型 | 说明 |
|------|------|------|
| `scrollerProxy()` | method | 集成第三方平滑滚动库（Lenis、Locomotive Scroll） |
| `snap` | number/object | 吸附到特定进度值（分页/步骤导航） |
| `toggleClass` | object/string | 激活时自动添加/移除 class |
| `once` | boolean | 触发一次后自动 kill |
| `refreshPriority` | number | 非顺序创建的 ScrollTrigger 需要此参数避免布局错乱 |
| `standalone create()` | method | 无关联 tween 的纯回调 ScrollTrigger |

**scrollerProxy 集成 Lenis：**
```javascript
import Lenis from "lenis";
const lenis = new Lenis();
function raf(time) { lenis.raf(time); requestAnimationFrame(raf); }
requestAnimationFrame(raf);

// 告诉 ScrollTrigger 使用 Lenis 的滚动容器
ScrollTrigger.scrollerProxy(document.body, {
  scrollTop(value) {
    if (arguments.length) { lenis.scrollTo(value); }
    return lenis.scroll;
  },
  getBoundingClientRect() { return { top: 0, left: 0, width: window.innerWidth, height: window.innerHeight }; },
});

// 每次 Lenis 滚动后刷新
lenis.on("scroll", ScrollTrigger.update);
```

**snap 分页：**
```javascript
gsap.to(".panels", {
  xPercent: -100 * (panels.length - 1),
  ease: "none",
  scrollTrigger: {
    trigger: ".container",
    pin: true,
    scrub: 1,
    snap: 1 / (panels.length - 1),  // 吸附到每个面板
    end: () => "+=" + container.offsetWidth,
  },
});
```

---

## 6. 性能铁律

### 6.1 transform + opacity 优先（绝对规则）

```
✅ 动画：x, y, z, xPercent, yPercent, scale, scaleX, scaleY, rotation, rotationX, rotationY, skewX, skewY, opacity, autoAlpha
❌ 避免：width, height, top, left, marginTop, padding, fontSize, lineHeight, backgroundColor（高成本）
```

**原因：** transform + opacity 只走 compositor，不走 layout/paint。其他属性触发 reflow。

### 6.2 will-change 策略

```css
/* ✅ 正确：只在实际动画的元素上 */
.will-animate {
  will-change: transform;
}
```

```
❌ 错误：全局设置
* { will-change: transform; }  /* 浪费 GPU 内存 */
```

- 仅对**即将动画**的元素设置
- 动画结束后移除（GSAP `clearProps` 或 CSS class toggle）
- 大量元素同时动画时，考虑虚拟化（只动画可视区元素）

### 6.3 gsap.quickTo() — 鼠标/手势高频更新

```javascript
// ✅ 高性能鼠标跟随
let xTo = gsap.quickTo("#follower", "x", { duration: 0.4, ease: "power3" });
let yTo = gsap.quickTo("#follower", "y", { duration: 0.4, ease: "power3" });

container.addEventListener("mousemove", (e) => {
  xTo(e.pageX);
  yTo(e.pageY);
});

// ❌ 错误：每次创建新 tween
container.addEventListener("mousemove", (e) => {
  gsap.to("#follower", { x: e.pageX, duration: 0.4 });  // 每帧创建新 tween
});
```

### 6.4 batch reads/writes

GSAP 内部已批处理。混合直接 DOM 操作时：
```javascript
// ✅ 先读后写
const positions = elements.map(el => el.getBoundingClientRect());  // 批量读
elements.forEach((el, i) => {
  el.style.transform = `translateX(${positions[i].x}px)`;  // 批量写
});

// ❌ 交替读写（强制同步布局）
elements.forEach(el => {
  const rect = el.getBoundingClientRect();  // 读
  el.style.left = rect.x + 10 + "px";     // 写 → 触发 reflow → 下一次读又要重新计算
});
```

### 6.5 ScrollTrigger pin 性能

- 只 pin 必要的元素（pin 代价高——提升为固定层）
- scrub 用小数值（`scrub: 1`）而非 `scrub: true`（给浏览器喘息）
- 低端设备测试：减少同时 pin 的 section 数量

### 6.6 减少同时动画数

- 长列表用 stagger 而非多个独立 tween
- 不可见区域的动画暂停/kill
- 复用 Timeline，避免每帧创建新的

---

## 7. Framework 集成最小正确模式

### 7.1 React（useGSAP）

```tsx
"use client";
import { useRef } from "react";
import { gsap } from "gsap";
import { ScrollTrigger } from "gsap/ScrollTrigger";
import { useGSAP } from "@gsap/react";

gsap.registerPlugin(ScrollTrigger, useGSAP);

export function GsapSection() {
  const container = useRef<HTMLDivElement>(null);

  useGSAP(() => {
    // ✅ 所有 GSAP 代码在此范围内
    // ✅ scope 自动限定到 container
    // ✅ 卸载时自动清理
    gsap.to(".box", { x: 100, duration: 1 });
  }, { scope: container });

  return <div ref={container}>...</div>;
}
```

**关键规则：**
- `gsap.registerPlugin(useGSAP)` 必须在使用前调用
- `scope` 限定选择器范围——不会匹配组件外的元素
- cleanup 自动执行，不需要手动 `ctx.revert()`
- 事件处理函数中的 GSAP 动画需要 `contextSafe` 包裹

### 7.2 React（useEffect 手动模式，无 @gsap/react）

```tsx
"use client";
import { useRef, useEffect } from "react";
import { gsap } from "gsap";
import { ScrollTrigger } from "gsap/ScrollTrigger";

gsap.registerPlugin(ScrollTrigger);

export function GsapSection() {
  const container = useRef<HTMLDivElement>(null);

  useEffect(() => {
    if (!container.current) return;
    const ctx = gsap.context(() => {
      gsap.to(".box", { x: 100, duration: 1 });
    }, container.current);
    return () => ctx.revert();  // ✅ 必须清理
  }, []);

  return <div ref={container}>...</div>;
}
```

### 7.3 Vue 3（Composition API）

```vue
<script setup>
import { onMounted, onUnmounted, ref } from "vue";
import { gsap } from "gsap";
import { ScrollTrigger } from "gsap/ScrollTrigger";

gsap.registerPlugin(ScrollTrigger);  // once per app

const container = ref(null);
let ctx;

onMounted(() => {
  ctx = gsap.context(() => {
    gsap.to(".box", { x: 100 });
  }, container.value);
});

onUnmounted(() => {
  ctx?.revert();  // ✅ 必须清理
});
</script>
```

### 7.4 Svelte

```svelte
<script>
  import { onMount } from "svelte";
  import { gsap } from "gsap";

  let container;

  onMount(() => {
    const ctx = gsap.context(() => {
      gsap.to(".box", { x: 100 });
    }, container);
    return () => ctx.revert();  // ✅ Svelte onMount 支持返回 cleanup
  });
</script>

<div bind:this={container}>
  <div class="box">Box</div>
</div>
```

### 7.5 SSR 安全铁律

- GSAP 只在浏览器运行
- 不在 Server Component / setup() 中调用 gsap.*
- React: 用 `useGSAP` 或 `useEffect` 保证只在客户端执行
- Vue: 在 `onMounted` 之后
- Top-level import 不会执行 GSAP（只要不调用 gsap 方法），SSR 安全

---

## 8. matchMedia + reduced-motion

### 8.1 为什么比 CSS @media 更强大

`gsap.matchMedia()` 不仅检测断点，还能：
- **自动 revert** 不匹配的动画和 ScrollTrigger（CSS @media 不会销毁已运行的 JS 动画）
- 支持多条件组合（桌面 + 非减弱动效）
- scope 限定到组件容器

### 8.2 正确用法

```javascript
const mm = gsap.matchMedia();

mm.add({
  isDesktop: "(min-width: 800px)",
  isMobile: "(max-width: 799px)",
  reduceMotion: "(prefers-reduced-motion: reduce)",
}, (context) => {
  const { isDesktop, reduceMotion } = context.conditions;

  if (reduceMotion) {
    // ✅ 跳过动画或设 duration: 0
    gsap.set(".box", { x: 100 });  // 直接设置终态
    return;
  }

  // 桌面：完整动画；移动端：简化动画
  gsap.to(".box", {
    x: isDesktop ? 500 : 100,
    duration: isDesktop ? 1.5 : 0.8,
    ease: "power3.out",
  });
});

// 组件卸载时
mm.revert();
```

### 8.3 与 oc-design-taste §4.H 的衔接

§4.H 要求：`@media (prefers-reduced-motion: reduce)` 将所有动画设为 0.01ms。
GSAP 对应做法：

```javascript
// ✅ GSAP 方式
gsap.matchMedia().add("(prefers-reduced-motion: reduce)", () => {
  // 这里什么都不做——matchMedia 自动 revert 之前的动画
  // 或：gsap.set(".animated", { clearProps: "all" });
});

// ✅ 同时保留 CSS 兜底
// @media (prefers-reduced-motion: reduce) { * { transition-duration: 0.01ms !important; animation-duration: 0.01ms !important; } }
```

**双重保障：** CSS `prefers-reduced-motion` 作为兜底，GSAP `matchMedia` 作为主动降级。

---

## 9. autoAlpha vs opacity

### 为什么 autoAlpha 是"正确答案"

```javascript
// ❌ opacity: 0 → 元素不可见但仍阻挡点击
gsap.to(el, { opacity: 0 });

// ✅ autoAlpha: 0 → opacity:0 + visibility:hidden（不阻挡点击）
gsap.to(el, { autoAlpha: 0 });

// autoAlpha: 非零值 → opacity 恢复 + visibility: inherit
gsap.to(el, { autoAlpha: 1 });
```

| 属性 | opacity:0 | autoAlpha:0 |
|------|-----------|-------------|
| 可见 | ❌ | ❌ |
| 阻挡点击/事件 | ✅ 阻挡 | ❌ 不阻挡 |
| GPU 合成 | ✅ | ✅ |
| 推荐用法 | 仅需要保持可点击时 | **默认选择** |

**oc-design-taste 映射：** §4.G 八状态的 Disabled/Loading 状态，用 `autoAlpha` 而非 `opacity` 更安全。

---

## 10. 水平劫持滚动陷阱

### containerAnimation 的坑

水平滚动是 MOTION 8-10 的典型效果，但 Agent 最容易在这里犯错：

**最常见的 3 个错：**
1. **忘了 `ease: "none"`** — 水平位移必须无缓动，否则滚动进度和水平位置不对应
2. **Pin 了动画元素本身** — 应该 pin 父容器，动画子元素
3. **在 containerAnimation 的 ScrollTrigger 上用 pin/snap** — 这两者不可用

### 正确骨架

```javascript
// 1. pin 父容器，动画内部轨道
const scrollTween = gsap.to(trackEl, {
  x: () => -(trackEl.scrollWidth - window.innerWidth),
  ease: "none",  // ✅ 必须 none
  scrollTrigger: {
    trigger: sectionEl,         // ✅ pin section，不 pin track
    pin: true,
    scrub: true,
    end: () => `+=${trackEl.scrollWidth - window.innerWidth}`,
  },
});

// 2. 内部元素用 containerAnimation 引用
gsap.from(".inner-card", {
  y: 100,
  opacity: 0,
  scrollTrigger: {
    trigger: ".inner-card",
    containerAnimation: scrollTween,  // ✅ 引用水平 tween
    start: "left center",
    toggleActions: "play none none reverse",
  },
});
```

---

## 附录 A：GSAP 数学工具箱（gsap.utils 精选）

动效中最常用的工具，按使用频率排序：

| 工具 | 用途 | 示例场景 |
|------|------|---------|
| `clamp(min, max, value)` | 约束范围 | 鼠标位移限制在 ±100px |
| `mapRange(inMin, inMax, outMin, outMax, value)` | 范围映射 | scroll progress (0-1) → rotation (0-360) |
| `normalize(min, max, value)` | 归一化到 0-1 | 任意范围 → progress |
| `interpolate(start, end, progress)` | 线性插值 | 颜色渐变、位置插值 |
| `snap(increment, value)` | 吸附到最近倍数 | 20px 网格对齐 |
| `wrap(min, max, value)` | 循环包裹 | 无限轮播、角度循环 |
| `pipe(fn1, fn2, fn3)` | 函数组合 | normalize → mapRange → snap 一步到位 |
| `selector(scope)` | 作用域选择器 | 组件内限定查询范围 |
| `toArray(value)` | 统一转数组 | NodeList → Array |
| `random(min, max, snap)` | 随机数 | 初始位置随机分散 |

**函数形式：** 大部分工具省略最后一个 `value` 参数会返回函数，适合在事件回调中复用：

```javascript
const mapFn = gsap.utils.mapRange(0, 1, -100, 100);  // 返回函数
ScrollTrigger.create({
  trigger: el,
  start: "top bottom",
  end: "bottom top",
  onUpdate: (self) => {
    gsap.set(el, { x: mapFn(self.progress) });  // 复用
  },
});
```

---

## 附录 B：GSAP Transform 别名速查

| GSAP 属性 | 等价 CSS | 备注 |
|-----------|---------|------|
| `x`, `y`, `z` | `translateX/Y/Z` | 默认单位 px |
| `xPercent`, `yPercent` | `translateX/Y %` | 百分比位移，SVG 也能用 |
| `scale`, `scaleX`, `scaleY` | `scale()` | `scale` 同时设 X/Y |
| `rotation` | `rotate()` | 默认 deg |
| `rotationX`, `rotationY` | `rotateX/Y()` | 3D 旋转 |
| `skewX`, `skewY` | `skewX/Y()` | deg |
| `transformOrigin` | `transform-origin` | `"left top"`, `"50% 50%"` |
| `svgOrigin` | SVG 全局坐标系原点 | 多元素绕同一点旋转 |
| `autoAlpha` | `opacity` + `visibility` | **推荐替代 opacity** |
| `clearProps` | 删除 inline style | `"all"` 或逗号分隔属性名 |

**方向旋转后缀：** `"_short"`（最短路径）、`"_cw"`（顺时针）、`"_ccw"`（逆时针）
例：`rotation: "-170_short"` → 20° 顺时针而非 340° 逆时针

**immediateRender 陷阱：**
多个 `from`/`fromTo` 动画叠加时，第二个及之后的 tween 必须设 `immediateRender: false`：
```javascript
// ❌ 错误：第二个 from 的 immediateRender 覆盖第一个
gsap.from(".box", { x: -100, duration: 1 });
gsap.from(".box", { y: -100, duration: 1 });  // 覆盖了 x 的起始值

// ✅ 正确
gsap.from(".box", { x: -100, duration: 1 });
gsap.from(".box", { y: -100, duration: 1, immediateRender: false });

// ✅ 更好：用 fromTo 或 Timeline
gsap.fromTo(".box", { x: -100, y: -100 }, { x: 0, y: 0, duration: 1 });
```

**function-based values：**
```javascript
gsap.to(".cards", {
  x: (i, target, targets) => i * 50,  // 按索引计算
  backgroundColor: (i) => ["#ff0000", "#00ff00", "#0000ff"][i % 3],
  duration: 0.5,
  stagger: 0.1,
});
```

**relative values：**
```javascript
gsap.to(el, { x: "+=50" });   // 相对当前位置 +50px
gsap.to(el, { x: "-=20" });   // 相对当前位置 -20px
gsap.to(el, { rotation: "+=90_short" });  // 相对旋转 + 最短路径
```
