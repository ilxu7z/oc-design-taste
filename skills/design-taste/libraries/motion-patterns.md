---
library: motion-patterns
description: 动效模式代码库 — 融合 oc v5 Section 5（GSAP 代码骨架）+ 原版 v1 Section 4（Framer Motion 规则）+ 原版 Section 5。包含 GSAP 完整骨架、Framer Motion 核心模式、动效纪律。
---

# Motion Patterns — 动效模式代码库

> 代码骨架完整可运行。每个模式标注适用场景和三旋钮要求。
> 动效纪律见底部。所有动效必须有动机——"看起来酷"不是理由。

---

## GSAP 完整代码骨架

### 1. Sticky-Stack（粘性堆叠）

多张卡片在滚动时依次固定并堆叠。前一张缩小淡出，下一张浮现。

**适用场景：** 产品功能介绍、时间线叙事、案例研究
**三旋钮要求：** VARIANCE 6-9 / MOTION 6-9 / DENSITY 2-4

```tsx
"use client";
import { useRef, useEffect } from "react";
import { gsap } from "gsap";
import { ScrollTrigger } from "gsap/ScrollTrigger";
import { useReducedMotion } from "motion/react";

gsap.registerPlugin(ScrollTrigger);

export function StickyStack({ cards }: { cards: React.ReactNode[] }) {
  const ref = useRef<HTMLDivElement>(null);
  const reduce = useReducedMotion();

  useEffect(() => {
    if (reduce || !ref.current) return;
    const ctx = gsap.context(() => {
      const cardEls = gsap.utils.toArray<HTMLElement>(".stack-card");
      cardEls.forEach((card, i) => {
        if (i === cardEls.length - 1) return;
        ScrollTrigger.create({
          trigger: card,
          start: "top top",                              // pin at viewport top
          endTrigger: cardEls[cardEls.length - 1],
          end: "top top",
          pin: true,
          pinSpacing: false,
        });
        gsap.to(card, {
          scale: 0.92,
          opacity: 0.55,
          ease: "none",
          scrollTrigger: {
            trigger: cardEls[i + 1],
            start: "top bottom",
            end: "top top",
            scrub: true,
          },
        });
      });
    }, ref);
    return () => ctx.revert();
  }, [reduce]);

  return (
    <div ref={ref} className="relative">
      {cards.map((card, i) => (
        <div
          key={i}
          className="stack-card sticky top-0 min-h-[100dvh] flex items-center justify-center"
        >
          {card}
        </div>
      ))}
    </div>
  );
}
```

**关键点：**
- `start: "top top"` — 卡片到达视口顶部时开始 pin
- `pin: true` — 每张卡片（最后一张除外）都被固定
- 前一张卡的 scale/opacity 由下一张卡的 scroll trigger 驱动
- `useReducedMotion()` 包裹 — 无障碍必须
- `gsap.context()` + `ctx.revert()` — 严格清理

---

### 2. Horizontal-Pan（水平平移）

垂直滚动转化为水平滑动。一个 section 被 pin 在视口，内部轨道水平滑动。

**适用场景：** 画廊展示、时间线、产品系列浏览
**三旋钮要求：** VARIANCE 7-10 / MOTION 7-10 / DENSITY 3-5

```tsx
"use client";
import { useRef, useEffect } from "react";
import { gsap } from "gsap";
import { ScrollTrigger } from "gsap/ScrollTrigger";
import { useReducedMotion } from "motion/react";

gsap.registerPlugin(ScrollTrigger);

export function HorizontalPan({ children }: { children: React.ReactNode }) {
  const wrap = useRef<HTMLDivElement>(null);
  const track = useRef<HTMLDivElement>(null);
  const reduce = useReducedMotion();

  useEffect(() => {
    if (reduce || !wrap.current || !track.current) return;
    const ctx = gsap.context(() => {
      const distance = track.current!.scrollWidth - window.innerWidth;
      gsap.to(track.current, {
        x: -distance,
        ease: "none",
        scrollTrigger: {
          trigger: wrap.current,
          start: "top top",                              // pin starts when section top hits viewport top
          end: () => `+=${distance}`,                    // scroll distance = track width minus viewport
          pin: true,
          scrub: 1,
          invalidateOnRefresh: true,
        },
      });
    }, wrap);
    return () => ctx.revert();
  }, [reduce]);

  return (
    <section ref={wrap} className="relative overflow-hidden">
      <div ref={track} className="flex h-[100dvh] items-center">
        {children}
      </div>
    </section>
  );
}
```

**关键点：**
- `start: "top top"` — section 到达视口顶部时开始 pin
- `end: "+=${distance}"` — 滚动长度 = 水平滑动距离
- `scrub: 1` — 滚动与动画 1:1 绑定
- `invalidateOnRefresh: true` — 窗口 resize 时重新计算距离
- 常见失败：`start` 不是 `"top top"` 导致动画提前触发

---

### 3. Scroll-Reveal Stagger（滚动渐入交错）

轻量方案：元素在进入视口时依次出现。无 pinning，用 Motion `whileInView` 替代 GSAP。

**适用场景：** 功能列表、推荐网格、Logo 墙、任何只需"滚动入场"的元素
**三旋钮要求：** VARIANCE 1-10 / MOTION 4-7 / DENSITY 2-6

```tsx
"use client";
import { motion, useReducedMotion } from "motion/react";

export function RevealStagger({ items }: { items: string[] }) {
  const reduce = useReducedMotion();
  return (
    <ul className="grid gap-6">
      {items.map((item, i) => (
        <motion.li
          key={item}
          initial={reduce ? false : { opacity: 0, y: 24 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true, amount: 0.3 }}
          transition={{
            duration: 0.6,
            delay: i * 0.06,
            ease: [0.16, 1, 0.3, 1],
          }}
        >
          {item}
        </motion.li>
      ))}
    </ul>
  );
}
```

**关键点：**
- `whileInView` — 进入视口时触发，不需要 ScrollTrigger
- `viewport: { once: true }` — 只触发一次，不重复
- `delay: i * 0.06` — 交错延迟，形成瀑布效果
- `useReducedMotion()` — 退化为静态
- 保存 GSAP 给实际 pin/scrub 工作

---

## Framer Motion / Motion 核心模式

### 4. Spring Physics（弹簧物理）

所有交互动效默认使用弹簧物理，无 linear easing。

**适用场景：** 所有交互动效（hover/click/enter/exit）
**三旋钮要求：** MOTION 4-10

```tsx
// 弹簧物理 — 默认动效配置
const springConfig = {
  type: "spring",
  stiffness: 100,
  damping: 20,
  mass: 1,
};

// 使用示例
<motion.div
  whileHover={{ scale: 1.05 }}
  whileTap={{ scale: 0.95 }}
  transition={springConfig}
>
  Hover me
</motion.div>

// 入场弹簧（更夸张的 overshoot）
const springOvershoot = {
  type: "spring",
  stiffness: 200,
  damping: 12,  // 更低阻尼 = 更多 overshoot
};

<motion.div
  initial={{ scale: 0, opacity: 0 }}
  animate={{ scale: 1, opacity: 1 }}
  transition={springOvershoot}
/>
```

**纪律：**
- 禁止 `ease: "linear"` 或 `ease: "ease-in-out"` 用于交互动效
- 滚动入场可用自定义 cubic-bezier：`ease: [0.16, 1, 0.3, 1]`
- `stiffness` 控制速度，`damping` 控制弹跳程度

---

### 5. Magnetic Button（磁力按钮）

按钮向光标方向物理拉近。

**适用场景：** CTA 按钮、导航项、卡片交互
**三旋钮要求：** VARIANCE 5-9 / MOTION 6-10 / DENSITY 2-5

```tsx
"use client";
import { motion, useMotionValue, useTransform } from "motion/react";
import { useRef } from "react";

export function MagneticButton({ children }: { children: React.ReactNode }) {
  const ref = useRef<HTMLDivElement>(null);
  const x = useMotionValue(0);
  const y = useMotionValue(0);

  const handleMouseMove = (e: React.MouseEvent) => {
    const rect = ref.current?.getBoundingClientRect();
    if (!rect) return;
    const centerX = rect.left + rect.width / 2;
    const centerY = rect.top + rect.height / 2;
    const distX = e.clientX - centerX;
    const distY = e.clientY - centerY;
    x.set(distX * 0.15);   // 位移系数，控制磁力强度
    y.set(distY * 0.15);
  };

  const handleMouseLeave = () => {
    x.set(0);
    y.set(0);
  };

  return (
    <motion.div
      ref={ref}
      onMouseMove={handleMouseMove}
      onMouseLeave={handleMouseLeave}
      style={{ x, y }}
      transition={{ type: "spring", stiffness: 150, damping: 15 }}
    >
      {children}
    </motion.div>
  );
}
```

**关键点：**
- 用 `useMotionValue` 而非 `useState` — 不触发 re-render
- 位移系数 0.15 控制磁力强度，可调整
- `handleMouseLeave` 复位到原点
- 必须包裹在 `"use client"` 组件中

---

### 6. Liquid Glass（液态玻璃）

磨砂玻璃效果，超越基础 `backdrop-blur`。

**适用场景：** Premium 品牌、Apple 风格、媒体覆盖层
**三旋钮要求：** VARIANCE 5-8 / MOTION 3-6 / DENSITY 2-4

```tsx
"use client";
import { motion } from "motion/react";

export function LiquidGlassPanel({ children }: { children: React.ReactNode }) {
  return (
    <motion.div
      className="relative overflow-hidden rounded-[24px]"
      initial={{ opacity: 0, y: 20 }}
      whileInView={{ opacity: 1, y: 0 }}
      viewport={{ once: true }}
      transition={{ duration: 0.8, ease: [0.16, 1, 0.3, 1] }}
    >
      {/* Glass background */}
      <div
        className="absolute inset-0"
        style={{
          background: "rgba(255, 255, 255, 0.08)",
          backdropFilter: "blur(40px) saturate(1.4)",
          WebkitBackdropFilter: "blur(40px) saturate(1.4)",
          border: "0.5px solid rgba(255, 255, 255, 0.15)",
          boxShadow:
            "inset 0 1px 0 rgba(255, 255, 255, 0.2), 0 8px 32px rgba(0, 0, 0, 0.12)",
        }}
      />
      {/* Content */}
      <div className="relative z-10 p-8">{children}</div>
    </motion.div>
  );
}
```

**CSS 关键点：**
- `backdrop-filter: blur(40px) saturate(1.4)` — 基础玻璃效果
- `border: 0.5px solid rgba(255, 255, 255, 0.15)` — 内折射边框
- `box-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.2)` — 边缘高光
- 必须提供 `prefers-reduced-transparency` 回退为纯色背景

---

### 7. Perpetual Micro-Interactions（永久微交互）

无限循环的微动效，让界面"活"起来。

**适用场景：** Bento Grid 卡片、Dashboard、状态指示器
**三旋钮要求：** MOTION 5-10 / DENSITY 3-6

```tsx
"use client";
import { motion } from "motion/react";

// 脉冲呼吸效果 — 用于状态指示器
export function BreathingDot() {
  return (
    <motion.div
      className="w-2 h-2 rounded-full bg-emerald-400"
      animate={{
        scale: [1, 1.3, 1],
        opacity: [0.7, 1, 0.7],
      }}
      transition={{
        duration: 2,
        repeat: Infinity,
        ease: "easeInOut",
      }}
    />
  );
}

// 浮动效果 — 用于卡片/图标
export function FloatAnimation({ children }: { children: React.ReactNode }) {
  return (
    <motion.div
      animate={{ y: [0, -6, 0] }}
      transition={{
        duration: 3,
        repeat: Infinity,
        ease: "easeInOut",
      }}
    >
      {children}
    </motion.div>
  );
}

// 打字机效果 — 用于 AI 输入框
export function TypewriterEffect({ texts }: { texts: string[] }) {
  return (
    <motion.span
      className="text-gray-400"
      animate={{ opacity: [1, 0.3, 1] }}
      transition={{ duration: 1.5, repeat: Infinity }}
    >
      {texts.map((text, i) => (
        <motion.span
          key={text}
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          exit={{ opacity: 0 }}
          transition={{ duration: 0.5 }}
        >
          {text}
          {i < texts.length - 1 && <span className="ml-1">|</span>}
        </motion.span>
      ))}
    </motion.span>
  );
}
```

**性能关键：**
- 每个 perpetual motion 必须 `React.memo` 隔离在独立 Client Component
- 不在父布局中触发 re-render
- Reduced Motion 时退化为静态

---

### 8. Layout Transitions（布局过渡）

用 `layout` 和 `layoutId` 实现平滑重排/缩放/共享元素过渡。

**适用场景：** 列表重排、模态框展开、路由过渡、状态变化
**三旋钮要求：** MOTION 4-8

```tsx
"use client";
import { motion, AnimatePresence } from "motion/react";
import { useState } from "react";

// 列表重排 — 用 layoutId 实现平滑位置交换
export function SortableList({ items }: { items: string[] }) {
  const [sorted, setSorted] = useState(items);

  return (
    <div className="space-y-2">
      {sorted.map((item) => (
        <motion.div
          key={item}
          layout
          className="p-4 bg-white rounded-lg shadow-sm"
          transition={{ type: "spring", stiffness: 200, damping: 25 }}
        >
          {item}
        </motion.div>
      ))}
    </div>
  );
}

// 共享元素过渡 — 列表项展开为详情
export function SharedElementDemo() {
  const [selectedId, setSelectedId] = useState<string | null>(null);

  return (
    <>
      {items.map((item) => (
        <motion.div
          key={item.id}
          layoutId={item.id}
          onClick={() => setSelectedId(item.id)}
          className="p-4 bg-white rounded-lg cursor-pointer"
        >
          {item.title}
        </motion.div>
      ))}

      <AnimatePresence>
        {selectedId && (
          <motion.div
            layoutId={selectedId}
            className="fixed inset-0 z-50 flex items-center justify-center"
            onClick={() => setSelectedId(null)}
          >
            <motion.div className="bg-white p-8 rounded-2xl max-w-lg">
              {/* 展开后的详情内容 */}
            </motion.div>
          </motion.div>
        )}
      </AnimatePresence>
    </>
  );
}
```

**关键点：**
- `layout` prop 让 Motion 自动计算位置变化并动画过渡
- `layoutId` 在不同组件间建立共享元素关联
- `AnimatePresence` 管理进入/离开动画
- 不包裹静态内容"for safety" — 增加测量成本

---

### 9. Staggered Orchestration（交错编排）

列表/网格项按顺序瀑布式出现。

**适用场景：** 列表入场、Bento Grid 揭示、菜单展开
**三旋钮要求：** MOTION 4-8

```tsx
"use client";
import { motion } from "motion/react";

// 方案 A：staggerChildren（Motion variants）
const containerVariants = {
  hidden: {},
  visible: {
    transition: {
      staggerChildren: 0.06,
      delayChildren: 0.1,
    },
  },
};

const itemVariants = {
  hidden: { opacity: 0, y: 20 },
  visible: {
    opacity: 1,
    y: 0,
    transition: { duration: 0.5, ease: [0.16, 1, 0.3, 1] },
  },
};

export function StaggerGrid({ items }: { items: React.ReactNode[] }) {
  return (
    <motion.div
      variants={containerVariants}
      initial="hidden"
      whileInView="visible"
      viewport={{ once: true, amount: 0.2 }}
      className="grid grid-cols-3 gap-6"
    >
      {items.map((item, i) => (
        <motion.div key={i} variants={itemVariants}>
          {item}
        </motion.div>
      ))}
    </motion.div>
  );
}

// 方案 B：CSS animation-delay（轻量替代，无 Motion 依赖）
// .stagger-item { animation: fadeUp 0.5s ease-out both; }
// .stagger-item:nth-child(1) { animation-delay: 0ms; }
// .stagger-item:nth-child(2) { animation-delay: 60ms; }
// .stagger-item:nth-child(3) { animation-delay: 120ms; }
```

**关键点：**
- Parent（`variants`）和 Children 必须在同一 Client Component 树
- 异步获取数据时，将数据作为 props 传入集中式 Parent Motion wrapper
- `staggerChildren` 在父级定义，子级用 `variants` 响应
- CSS `animation-delay: calc(var(--index) * 100ms)` 是零依赖替代

---

## 动效纪律

### 禁用列表（硬禁止）

| 模式 | 原因 | 替代方案 |
|------|------|---------|
| `window.addEventListener("scroll", ...)` | 每帧触发、卡顿、无批处理 | Motion `useScroll()` / ScrollTrigger / IntersectionObserver / CSS `scroll-driven animations` |
| 自定义 `window.scrollY` + React `useState` | 每帧 re-render | `useMotionValue` + `useTransform` |
| `requestAnimationFrame` 循环操作 React state | 每帧 re-render | Motion values |
| GSAP/Three.js 与 Motion 在同一组件树 | 争抢同一帧 | 隔离在不同叶子组件 |
| 动画 `top`/`left`/`width`/`height` | 触发 layout reflow | 只动画 `transform` 和 `opacity` |
| 噪点/颗粒滤镜在滚动容器上 | 连续 GPU repaint | 仅用于 fixed、`pointer-events-none` 伪元素 |

### 性能约束

- **Reduced Motion（强制）：** MOTION > 3 时必须 honor `prefers-reduced-motion`。用 `useReducedMotion()` 退化为静态。无限循环、视差、scroll-hijack、磁力物理必须退化为静态/即时。
- **硬件加速：** 只动画 `transform` 和 `opacity`。`will-change: transform` 仅用于实际会动画的元素。
- **DOM 成本：** Motion 不小。Three.js 很大。折叠屏以上的内容懒加载。
- **Z-Index 约束：** 禁止随意 `z-50`/`z-10`。仅用于系统层级上下文（sticky nav、modal、overlay、grain）。

### 声明 = 实现规则

- 如果设定 `MOTION_INTENSITY > 4`，页面必须实际有动画：Hero 入场、scroll-reveal、hover 物理、CTA 反馈，至少这些。
- 静态页面声称 `MOTION_INTENSITY: 7` = 输出失败。
- 反之，如果 scope 内无法实现工作动效，将旋钮降到 ≤3，交付干净静态页面。
- 从不半构建动效（截断的 ScrollTrigger、跳跃的入场、缺失的清理）。

### 动效必须有动机

在添加任何动画前问："这个动画传达什么？"

| 有效答案 | 无效答案 |
|---------|---------|
| 层级（引导注意力到正确位置） | "看起来酷" |
| 叙事（按顺序揭示内容，匹配故事线） | "GSAP 可用所以用一下" |
| 反馈（确认用户操作） | "其他页面也这么做" |
| 状态过渡（显示某事已变化） | "不加动画太静态" |

每个 ScrollTrigger、每个 marquee、每个 pinned section 都需要一个理由。如果一句话说不清，去掉动画。
