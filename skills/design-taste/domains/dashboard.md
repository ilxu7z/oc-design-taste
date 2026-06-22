---
domain: dashboard
description: Dashboard/B端SaaS设计——高密度模式、Motion-Engine Bento、数据展示规则、5种卡片原型
depends: [domains/web-design]
---

# Dashboard / B端SaaS · 领域规则

> 覆盖：后台管理面板、数据仪表盘、SaaS 产品界面、KPI 概览页、数据监控面板
> 不覆盖：官网 Landing Page / 产品画册 / 品牌故事 / 邮件模板 / 生图

---

## 1. Dashboard 设计哲学

### 1.1 美学定位：Vercel-core meets Dribbble-clean

Dashboard 的设计美学介于两个极点之间：

| 极点 | 特征 | 适用场景 |
|------|------|---------|
| **Vercel-core** | 功能优先、极简、克制色彩、数据即装饰 | B端SaaS、数据分析、开发者工具 |
| **Dribbble-clean** | 精致卡片、柔和阴影、微动效、视觉层次丰富 | 面向客户的管理面板、营销分析、CRM |

**融合原则：** 取 Vercel 的信息层级克制 + Dribbble 的表面精致度。数据本身是装饰，不要用多余的插图或渐变。

### 1.2 Dashboard 与官网的核心区别

| 维度 | 官网/Landing Page | Dashboard |
|------|------------------|-----------|
| **信息密度** | 低-中（美术馆模式） | 高（驾驶舱模式） |
| **动效角色** | 叙事、吸引注意 | 状态反馈、数据更新 |
| **布局稳定性** | 灵活、可滚动 | 固定网格、信息区划 |
| **色彩角色** | 品牌表达 | 信息编码（红=告警，绿=正常） |
| **用户目标** | 说服、转化 | 监控、决策、操作 |
| **交互模式** | 线性浏览 | 多焦点扫描 |

---

## 2. 三旋钮 Dashboard 特化

Dashboard 场景下，三旋钮的默认值范围与官网显著不同。

### 2.1 Dashboard 旋钮范围

| 旋钮 | Dashboard 范围 | 官网默认范围 | 说明 |
|------|---------------|-------------|------|
| **VARIANCE** | 3-5 | 7-9 | Dashboard 需要结构化，不宜实验性布局 |
| **MOTION** | 6-8 | 6 | Dashboard 需要微动效保持活力，但不过度 |
| **DENSITY** | 7-10 | 3-5 | 数据密集，信息量大 |

### 2.2 场景预设

| 场景 | VARIANCE | MOTION | DENSITY |
|------|----------|--------|---------|
| **Dashboard 概览页** | 3-4 | 1-2 | 6-8 |
| **B端SaaS后台** | 4-5 | 2-3 | 5-7 |
| **数据监控面板** | 3-4 | 6-8 | 8-10 |
| **CRM/客户管理** | 4-5 | 4-6 | 6-8 |
| **分析报表页** | 3-4 | 1-3 | 7-9 |
| **SaaS 设置页** | 3-4 | 1-2 | 5-7 |
| **实时数据流面板** | 4-5 | 7-9 | 8-10 |

### 2.3 旋钮值驱动 Dashboard 决策

#### VARIANCE 3-5（结构化）

| 值 | 布局特征 | 适用场景 |
|----|---------|---------|
| 3 | 严格 12 列等分网格，全部对齐 | 金融/医疗等严肃 B端 |
| 4 | 轻微非对称（2fr 1fr 分栏），主次分明 | 大多数 SaaS Dashboard |
| 5 | 混合尺寸 Bento 网格，有节奏变化 | 营销分析/创意工具 |

**约束：** Dashboard 中 VARIANCE 不应超过 5。超过则信息层级混乱，用户无法快速扫描数据。

#### MOTION 6-8（微动效）

| 值 | 动效特征 | 适用场景 |
|----|---------|---------|
| 6 | 微交互：hover 反馈、数据刷新过渡、骨架屏 | 通用 SaaS |
| 7 | 持续动效：呼吸灯、轮播、打字机、自动排序 | 实时数据面板 |
| 8 | 丰富动效：layout 过渡、overshoot 弹窗、浮动工具栏 | 面向客户的分析面板 |

**Dashboard 动效原则：**
- 动效必须有信息目的（状态变化、数据更新、操作反馈）
- 禁止纯装饰性动效（飘落粒子、随机浮动）
- 数据更新用 `layout` 过渡，不用闪烁/渐变
- 实时数据用平滑过渡，不用硬刷新

#### DENSITY 7-10（高密度）

| 值 | 密度特征 | 适用场景 |
|----|---------|---------|
| 7 | 紧凑间距，`p-4` 内边距，无奢侈留白 | 通用 SaaS |
| 8 | 更紧凑，`p-3`，`gap-3`，细线分隔 | 数据密集型 |
| 9 | 驾驶舱模式，`p-2`，`text-sm`，等宽数字 | 监控面板 |
| 10 | 极限密度，`p-1`，`text-xs`，最小可读字号 | 交易终端/运维面板 |

---

## 3. 高密度模式规则（DENSITY > 7）

当 `VISUAL_DENSITY > 7` 时，以下规则**强制生效**：

### 3.1 卡片容器禁令

**禁止使用通用的白色卡片容器包裹数据指标。** 数据指标在纯布局中呼吸，用布局分组而非视觉容器分组。

| 规则 | 说明 |
|------|------|
| ❌ 禁止 `bg-white rounded-xl shadow-sm p-6` 式卡片 | 每项数据都包卡片 = 视觉噪音 |
| ✅ 用 `border-t` 或 `divide-y` 做分组 | 1px 细线分隔，保持视觉连贯 |
| ✅ 用负空间（间距）做分组 | `gap-4` 比卡片更干净 |
| ✅ 用 `bg-gray-50` 整行交替色 | 替代卡片做行级分组 |

**突破条件：** 当 elevation（z-index）在功能上需要表达层级时，可用卡片。例如：浮动工具栏、弹出面板、拖拽组件。

### 3.2 分隔规则

| 规则 | 实现 |
|------|------|
| 行分隔 | `border-t border-gray-200/50` |
| 列分隔 | `border-r border-gray-200/50` |
| 列表分隔 | `divide-y divide-gray-200/50` |
| 组分隔 | `border-l-2 border-gray-100`（左侧色条） |

**禁止：** 表格每行加 `border-b`。选其一：行底线 或 组顶部线，不要全加上。

### 3.3 数字排版

| 规则 | 实现 |
|------|------|
| 所有数字用等宽字体 | `font-mono` + `font-variant-numeric: tabular-nums` |
| 大数字 | `text-2xl md:text-3xl font-semibold tracking-tight` |
| 小数字/指标 | `text-sm font-mono` |
| 货币/百分比 | 对齐小数点，`tabular-nums` 确保等宽 |

### 3.4 紧凑 padding

| 层级 | 内边距 |
|------|--------|
| 页面级 | `p-4 md:p-6` |
| 区块级 | `p-3 md:p-4` |
| 表格单元格 | `px-3 py-2` |
| 列表项 | `px-3 py-2.5` |

### 3.5 无留白奢侈

| 规则 | 说明 |
|------|------|
| 大标题放卡片外 | 标题和描述在卡片外部下方，保持画廊式干净展示 |
| 最小化装饰性间距 | 不用 `py-16` 式大间距，用 `py-4` 或 `py-6` |
| 图标缩小 | 图标用 `w-4 h-4` 而非 `w-6 h-6` |
| 文字精简 | 副文本 ≤ 15 词，标签 ≤ 3 词 |

---

## 4. 色彩约束

### 4.1 Dashboard 色板规范

| 元素 | 值 | 说明 |
|------|-----|------|
| 背景 | `#f9fafb`（gray-50） | 浅灰背景，减少视觉疲劳 |
| 卡片/面板 | `#ffffff` | 纯白卡片表面 |
| 边框 | `1px border-slate-200/50` | 半透明细边框，柔和 |
| 圆角 | `rounded-[2.5rem]` | 大圆角主容器 |
| 阴影 | `shadow-[0_20px_40px_-15px_rgba(0,0,0,0.05)]` | 扩散阴影，深度不杂乱 |

### 4.2 语义色板

Dashboard 色彩承担信息编码功能，不仅是品牌表达：

| 语义 | 色值 | 用途 |
|------|------|------|
| 主色（Accent） | 品牌色，饱和度 < 70% | 按钮、链接、活跃状态 |
| 成功 | `emerald-500/600` | 正常、在线、完成 |
| 警告 | `amber-500/600` | 注意、待处理、临界 |
| 错误 | `red-500/600` | 告警、离线、失败 |
| 信息 | `blue-500/600` | 提示、通知、信息 |
| 中性 | `gray-500/600` | 次要文本、禁用、占位 |

### 4.3 图表配色

图表配色需要可区分且无障碍友好：

```
// 推荐图表色板（8色，色盲友好）
chart-colors: [
  '#3b82f6', // 蓝
  '#10b981', // 翠绿
  '#f59e0b', // 琥珀
  '#ef4444', // 红
  '#8b5cf6', // 紫
  '#06b6d4', // 青
  '#f97316', // 橙
  '#84cc16', // 黄绿
]
```

| 规则 | 说明 |
|------|------|
| 最多 8 色 | 超过则用堆叠或分组 |
| 色盲友好 | 避免红绿并列，用形状+颜色双重编码 |
| 饱和度 < 80% | 图表色饱和度低于纯色，减少视觉疲劳 |
| 背景对比 | 图表在 `#f9fafb` 背景上保持 3:1 对比度 |

### 4.4 色彩禁令

| ❌ 禁止 | 原因 | 替代 |
|---------|------|------|
| AI 紫/蓝渐变 | LLM 最爱"科技感"伪装 | 中性基色 + 单一强调色 |
| 纯黑 `#000` 背景 | 偷懒，视觉疲劳 | `#111` 或 `#1a1a1a` |
| 霓虹色强调 | 信息编码不清晰 | 降低饱和度至 < 70% |
| 多色混用 | 无色彩体系 | 单一强调色 + 一致灰色系 |
| 暖米咖喱色板 | "高级感"默认色 | 冷奢/森林/蓝铜等替代 |

---

## 5. 字体纪律

### 5.1 Dashboard 字体选择

| 元素 | 字体 | 说明 |
|------|------|------|
| 标题/显示 | Geist / Satoshi / Cabinet Grotesk | 现代无衬线，`tracking-tight` |
| 正文 | 同标题字体正文字重 | 保持字体一致性 |
| 数字/数据 | JetBrains Mono / Geist Mono / IBM Plex Mono | 等宽，`tabular-nums` |
| 代码 | JetBrains Mono / Geist Mono | 等宽，代码高亮 |

**❌ 禁止：** Inter（默认安全牌）、Serif（Dashboard 场景下硬禁止）

### 5.2 标题排版纪律

| 规则 | 说明 |
|------|------|
| 标题放卡片外 | 卡片标题在卡片外部下方，保持画廊式干净展示 |
| 大标题 | `text-lg md:text-xl font-semibold tracking-tight` |
| 中标题 | `text-base font-medium` |
| 小标题/标签 | `text-xs font-medium uppercase tracking-wider text-gray-500` |
| 数字 | `text-2xl md:text-3xl font-semibold font-mono tracking-tight` |

### 5.3 数据排版

| 规则 | 实现 |
|------|------|
| 等宽数字 | `font-mono font-variant-numeric: tabular-nums` |
| 数字对齐 | 右对齐（`text-right`），小数点对齐 |
| 单位/标签 | 小字（`text-xs text-gray-500`），在数字下方或右侧 |
| 变化趋势 | 绿色 `↑` + 红色 `↓`，或箭头图标 |
| 百分比 | 保留 1 位小数，`47.2%` 而非 `47%` |

---

## 6. Motion-Engine Bento 完整规则

> 来源：taste-skill-v1 Section 9 + oc-design-taste v4 5.F

### 6.A 设计哲学

| 维度 | 规范 |
|------|------|
| **美学** | 高端、极简、功能优先。Vercel-core meets Dribbble-clean |
| **色板** | 背景 `#f9fafb`，卡片纯白 `#ffffff`，1px 边框 `border-slate-200/50` |
| **表面** | `rounded-[2.5rem]` 主容器，扩散阴影 `shadow-[0_20px_40px_-15px_rgba(0,0,0,0.05)]` |
| **排版** | Geist / Satoshi / Cabinet Grotesk，标题 `tracking-tight` |
| **标签** | 标题和描述在卡片**外部下方**，保持画廊式干净展示 |
| **内边距** | `p-8` 或 `p-10`（正常密度）；DENSITY > 7 时 `p-4` 或 `p-3` |

### 6.B 动画引擎规格（Perpetual Motion）

所有卡片必须包含**永久微交互**，用 Framer Motion / Motion 原则：

#### Spring Physics（禁止线性 easing）

```tsx
// ✅ 正确：Spring physics
transition={{ type: "spring", stiffness: 100, damping: 20 }}

// ❌ 禁止：线性 easing
transition={{ duration: 0.3, ease: "linear" }}
```

| 参数 | 值 | 效果 |
|------|-----|------|
| stiffness | 100 | 弹性刚度，不过度弹跳 |
| damping | 20 | 阻尼系数，快速稳定 |
| mass | 1（默认） | 质量，可调至 0.8 更轻快 |

#### Layout Transitions

```tsx
// 平滑重排/缩放/共享元素过渡
<motion.div layout layoutId="card-1">
  {/* content */}
</motion.div>
```

| 规则 | 说明 |
|------|------|
| `layout` prop | 元素尺寸/位置变化时自动平滑过渡 |
| `layoutId` prop | 跨组件树共享元素动画（列表排序、视图切换） |
| `AnimatePresence` | 包裹动态列表，处理 enter/exit 动画 |

#### Infinite Loops

每张卡片必须有一个"活跃状态"无限循环（Pulse / Typewriter / Float / Carousel），确保 Dashboard 感觉"活着"。

| 类型 | 适用卡片 | 实现方式 |
|------|---------|---------|
| Pulse | 状态指示器、呼吸灯 | `animate={{ opacity: [1, 0.5, 1] }}` + spring |
| Typewriter | 搜索栏、AI 输入 | 循环 prompts，闪烁光标 |
| Float | 通知徽章、浮动工具栏 | `animate={{ y: [0, -4, 0] }}` |
| Carousel | 数据流、指标轮播 | `x: ["0%", "-100%"]` seamless loop |

#### 性能隔离（强制）

```tsx
// ✅ 正确：完全隔离的 Client Component
const LiveStatusDot = React.memo(function LiveStatusDot({ status }: { status: string }) {
  return (
    <motion.span
      animate={{ opacity: [1, 0.3, 1] }}
      transition={{ duration: 2, repeat: Infinity, ease: "easeInOut" }}
      className="inline-block w-2 h-2 rounded-full bg-emerald-500"
    />
  );
});

// ❌ 禁止：在父组件中直接写无限循环动画
function ParentCard() {
  return (
    <motion.div animate={{ /* infinite loop */ }}>
      {/* 这会导致父组件每帧 re-render */}
    </motion.div>
  );
}
```

| 规则 | 说明 |
|------|------|
| **React.memo** | 所有 perpetual motion 组件必须 memoized |
| **独立 Client Component** | 无限循环组件必须是隔离的叶子组件，`"use client"` |
| **不触发父级 re-render** | 父布局不感知子组件的动画帧 |
| **60fps 优化** | 用 `useMotionValue` + `useTransform` 而非 `useState` |

### 6.C Bento Grid 布局规范

#### 网格架构

```
Row 1: [  col-span-8  ] [  col-span-4  ]
Row 2: [  col-span-5  ] [  col-span-7  ]
Row 3: [  col-span-4  ] [  col-span-4  ] [  col-span-4  ]
```

| 规则 | 说明 |
|------|------|
| `grid-flow-dense` | 自动填充空位，无空单元格 |
| 格子数 = 内容数 | N 个内容项 = N 个格子，中间不留空格 |
| 背景多样性 | 至少 2-3 格有图片/渐变/有色背景，不全白底纯文本 |
| 节奏变化 | 不要堆叠 6 个等宽卡片，交替大小和比例 |
| 移动端退化 | 所有 `col-span` 在 < 768px 重置为 `col-span-1` |

---

## 7. 5 种卡片原型详细规范

> 来源：taste-skill-v1 Section 9.C — 完整提取

### 7.1 The Intelligent List（智能排序列表）

**描述：** 垂直列表项无限自动排序循环。用 `layoutId` 让项平滑交换位置，模拟 AI 实时优先级排序。

```tsx
"use client";
import { motion, AnimatePresence } from "motion/react";
import React from "react";

interface ListItem {
  id: string;
  label: string;
  priority: number;
}

const IntelligentList = React.memo(function IntelligentList({ items: initialItems }: { items: ListItem[] }) {
  const [items, setItems] = React.useState(initialItems);

  React.useEffect(() => {
    const interval = setInterval(() => {
      setItems(prev => {
        const shuffled = [...prev].sort(() => Math.random() - 0.5);
        return shuffled;
      });
    }, 3000);
    return () => clearInterval(interval);
  }, []);

  return (
    <div className="space-y-2">
      <AnimatePresence mode="popLayout">
        {items.map((item) => (
          <motion.div
            key={item.id}
            layout
            initial={{ opacity: 0, y: 10 }}
            animate={{ opacity: 1, y: 0 }}
            exit={{ opacity: 0, y: -10 }}
            transition={{ type: "spring", stiffness: 100, damping: 20 }}
            className="flex items-center justify-between px-4 py-3 bg-gray-50 rounded-xl"
          >
            <span className="text-sm font-medium">{item.label}</span>
            <span className="text-xs font-mono text-gray-400">#{item.priority}</span>
          </motion.div>
        ))}
      </AnimatePresence>
    </div>
  );
});
```

| 参数 | 值 |
|------|-----|
| 排序间隔 | 2-4 秒随机 |
| 动画 | `layout` + spring physics |
| 过渡模式 | `popLayout`（保持列表高度稳定） |
| 性能 | React.memo + 独立 Client Component |

### 7.2 The Command Input（命令输入栏）

**描述：** 搜索/AI 栏带多步打字机效果。循环展示复杂提示词，含闪烁光标和 shimmer 渐变加载状态。

```tsx
"use client";
import { motion } from "motion/react";
import React from "react";

const prompts = [
  "分析上月销售趋势...",
  "查找高价值客户...",
  "生成季度报告...",
  "对比产品线表现...",
];

const CommandInput = React.memo(function CommandInput() {
  const [promptIndex, setPromptIndex] = React.useState(0);
  const [charIndex, setCharIndex] = React.useState(0);
  const [isTyping, setIsTyping] = React.useState(true);

  React.useEffect(() => {
    if (isTyping) {
      if (charIndex < prompts[promptIndex].length) {
        const t = setTimeout(() => setCharIndex(c => c + 1), 50);
        return () => clearTimeout(t);
      } else {
        const t = setTimeout(() => setIsTyping(false), 2000);
        return () => clearTimeout(t);
      }
    } else {
      if (charIndex > 0) {
        const t = setTimeout(() => setCharIndex(c => c - 1), 30);
        return () => clearTimeout(t);
      } else {
        setPromptIndex(i => (i + 1) % prompts.length);
        setIsTyping(true);
      }
    }
  }, [charIndex, isTyping, promptIndex]);

  return (
    <div className="relative">
      <div className="flex items-center gap-2 px-4 py-3 bg-white border border-slate-200/50 rounded-2xl shadow-sm">
        <span className="text-xs text-gray-400 font-mono">
          {prompts[promptIndex].slice(0, charIndex)}
        </span>
        <motion.span
          animate={{ opacity: [1, 0] }}
          transition={{ duration: 0.5, repeat: Infinity }}
          className="w-[2px] h-4 bg-gray-400"
        />
        {!isTyping && (
          <motion.div
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            className="absolute inset-0 rounded-2xl bg-gradient-to-r from-transparent via-gray-100/50 to-transparent"
            style={{ backgroundSize: "200% 100%" }}
          />
        )}
      </div>
    </div>
  );
});
```

| 参数 | 值 |
|------|-----|
| 打字速度 | 50ms/字符 |
| 保持时间 | 2 秒（完整提示词显示后） |
| 删除速度 | 30ms/字符 |
| 循环 | 无限，回到第一个提示词 |
| 闪烁光标 | `opacity: [1, 0]`，0.5s 周期 |
| 加载状态 | shimmer 渐变覆盖层 |

### 7.3 The Live Status（实时状态）

**描述：** 调度界面带"呼吸"状态指示器。含弹出通知徽章，带 Overshoot spring 效果，停留 3 秒后消失。

```tsx
"use client";
import { motion, AnimatePresence } from "motion/react";
import React from "react";

const LiveStatusDot = React.memo(function LiveStatusDot({ status }: { status: "online" | "away" | "busy" }) {
  const colors = { online: "bg-emerald-500", away: "bg-amber-500", busy: "bg-red-500" };
  return (
    <motion.span
      animate={{ opacity: [1, 0.3, 1] }}
      transition={{ duration: 2, repeat: Infinity, ease: "easeInOut" }}
      className={`inline-block w-2.5 h-2.5 rounded-full ${colors[status]}`}
    />
  );
});

const NotificationBadge = React.memo(function NotificationBadge({ message }: { message: string }) {
  const [visible, setVisible] = React.useState(true);

  React.useEffect(() => {
    const t = setTimeout(() => setVisible(false), 3000);
    return () => clearTimeout(t);
  }, []);

  return (
    <AnimatePresence>
      {visible && (
        <motion.div
          initial={{ opacity: 0, y: 20, scale: 0.8 }}
          animate={{ opacity: 1, y: 0, scale: 1 }}
          exit={{ opacity: 0, y: -10, scale: 0.9 }}
          transition={{ type: "spring", stiffness: 300, damping: 15 }} // Overshoot spring
          className="px-4 py-2 bg-white border border-slate-200/50 rounded-xl shadow-lg"
        >
          <p className="text-sm font-medium">{message}</p>
        </motion.div>
      )}
    </AnimatePresence>
  );
});
```

| 参数 | 值 |
|------|-----|
| 呼吸灯周期 | 2s（1→0.3→1） |
| 通知停留 | 3 秒 |
| 弹出 spring | stiffness: 300, damping: 15（overshoot） |
| 消失 spring | stiffness: 200, damping: 20 |

### 7.4 The Wide Data Stream（宽数据流）

**描述：** 水平"无限轮播"数据卡片或指标。无缝循环（`x: ["0%", "-100%"]`），速度轻松不费力。

```tsx
"use client";
import { motion } from "motion/react";
import React from "react";

const metrics = [
  { label: "活跃用户", value: "12,847", change: "+12%" },
  { label: "收入", value: "$48.2k", change: "+8.3%" },
  { label: "转化率", value: "3.47%", change: "+0.6%" },
  { label: "平均订单", value: "$89.20", change: "-2.1%" },
  { label: "新客户", value: "1,243", change: "+23%" },
];

const WideDataStream = React.memo(function WideDataStream() {
  const duplicated = [...metrics, ...metrics]; // 双倍数据实现无缝

  return (
    <div className="overflow-hidden">
      <motion.div
        className="flex gap-4"
        animate={{ x: ["0%", "-50%"] }}
        transition={{ duration: 20, repeat: Infinity, ease: "linear" }}
      >
        {duplicated.map((metric, i) => (
          <div
            key={i}
            className="flex-shrink-0 w-48 p-4 bg-white border border-slate-200/50 rounded-2xl"
          >
            <p className="text-xs text-gray-500">{metric.label}</p>
            <p className="text-xl font-semibold font-mono tracking-tight mt-1">
              {metric.value}
            </p>
            <span className={`text-xs font-medium ${metric.change.startsWith('+') ? 'text-emerald-600' : 'text-red-600'}`}>
              {metric.change}
            </span>
          </div>
        ))}
      </motion.div>
    </div>
  );
});
```

| 参数 | 值 |
|------|-----|
| 动画 | `x: ["0%", "-50%"]`（数据翻倍，半程即完整循环） |
| 持续时间 | 20 秒（轻松速度） |
| easing | `linear`（匀速，无卡顿感） |
| 数据量 | 原始数据 × 2（无缝衔接） |
| 性能 | React.memo + 独立 Client Component |

### 7.5 The Contextual UI (Focus Mode)（上下文 UI）

**描述：** 文档视图，文字块交错高亮动画，随后浮动操作工具栏"飘入"带微图标。

```tsx
"use client";
import { motion } from "motion/react";
import React from "react";

const highlights = [
  "季度收入同比增长 23%",
  "主要增长来自亚太地区",
  "新客户获取成本降低 15%",
];

const ContextualUI = React.memo(function ContextualUI() {
  const [showToolbar, setShowToolbar] = React.useState(false);

  React.useEffect(() => {
    const t = setTimeout(() => setShowToolbar(true), 2000);
    return () => clearTimeout(t);
  }, []);

  return (
    <div className="relative p-6 bg-white border border-slate-200/50 rounded-[2.5rem]">
      <div className="space-y-4">
        {highlights.map((text, i) => (
          <motion.p
            key={i}
            initial={{ backgroundColor: "transparent" }}
            animate={{ backgroundColor: i === 1 ? "rgba(59, 130, 246, 0.08)" : "transparent" }}
            transition={{ delay: i * 0.3, duration: 0.5 }}
            className="px-2 py-1 rounded-lg text-sm leading-relaxed"
          >
            {text}
          </motion.p>
        ))}
      </div>

      <AnimatePresence>
        {showToolbar && (
          <motion.div
            initial={{ opacity: 0, y: 10 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ type: "spring", stiffness: 100, damping: 20 }}
            className="absolute -bottom-4 left-1/2 -translate-x-1/2 flex gap-1 px-3 py-2 bg-white border border-slate-200/50 rounded-full shadow-lg"
          >
            {["edit", "copy", "share", "more"].map((action) => (
              <button
                key={action}
                className="p-1.5 rounded-full hover:bg-gray-100 transition-colors"
              >
                <span className="w-4 h-4 block bg-gray-400 rounded" />
              </button>
            ))}
          </motion.div>
        )}
      </AnimatePresence>
    </div>
  );
});
```

| 参数 | 值 |
|------|-----|
| 高亮延迟 | 每段 0.3s 交错 |
| 工具栏出现 | 2 秒后飘入 |
| 工具栏动画 | spring, stiffness: 100, damping: 20 |
| 工具栏位置 | 绝对定位，居中于卡片底部 |

---

## 8. Dashboard 导航模式

### 8.1 四种导航模式对比

| 模式 | 优势 | 劣势 | 适用场景 |
|------|------|------|---------|
| **左侧栏** | 信息层级清晰、可容纳大量菜单项、用户习惯 | 占用水平空间、移动端需折叠 | 复杂 B端 SaaS、多层级菜单 |
| **顶栏** | 水平空间最大化、干净简洁 | 菜单项有限、深度层级不直观 | 简单 Dashboard、工具型产品 |
| **浮动命令菜单** | 极简、键盘友好、搜索驱动 | 发现性差、不适合新手 | 开发者工具、效率型 SaaS |
| **可折叠面板** | 灵活、可扩展、空间效率高 | 实现复杂度高、状态管理复杂 | 数据监控面板、多视图 Dashboard |

### 8.2 推荐选择

| 场景 | 推荐导航 | 理由 |
|------|---------|------|
| CRM / 客户管理 | 左侧栏 | 多层级菜单，频繁切换 |
| 分析面板 | 顶栏 + 浮动命令 | 视图少，搜索驱动 |
| 运维监控 | 可折叠面板 | 多视图并行 |
| 开发者工具 | 浮动命令菜单 | 键盘驱动，效率优先 |
| 通用 SaaS | 左侧栏（可折叠） | 平衡空间和功能 |

### 8.3 导航实现规范

| 规则 | 说明 |
|------|------|
| 桌面端单行 | 导航高度 ≤ 64px，单行显示 |
| 左侧栏宽度 | `w-56` 或 `w-64`，可折叠到 `w-16`（icon-only） |
| 顶栏高度 | `h-14` 或 `h-16` |
| 激活状态 | 左侧竖条 `border-l-2` 或背景色变化 |
| hover 状态 | 背景色 `bg-gray-100`，过渡 150ms |
| 移动端 | 左侧栏 → 底部 Tab 栏 或 汉堡菜单 |

---

## 9. 数据展示规则

### 9.1 图表配色

```css
/* 推荐图表色板（8色，色盲友好） */
--chart-1: #3b82f6;  /* 蓝 */
--chart-2: #10b981;  /* 翠绿 */
--chart-3: #f59e0b;  /* 琥珀 */
--chart-4: #ef4444;  /* 红 */
--chart-5: #8b5cf6;  /* 紫 */
--chart-6: #06b6d4;  /* 青 */
--chart-7: #f97316;  /* 橙 */
--chart-8: #84cc16;  /* 黄绿 */
```

| 规则 | 说明 |
|------|------|
| 最多 8 色 | 超过则用堆叠或分组 |
| 色盲友好 | 避免红绿并列，用形状+颜色双重编码 |
| 网格线 | `stroke: #e5e7eb`（gray-200），细线 1px |
| 坐标轴 | `stroke: #d1d5db`（gray-300） |
| 字体 | `font-mono` 用于坐标轴数字 |

### 9.2 表格排版

| 规则 | 实现 |
|------|------|
| 表头 | `text-xs font-medium uppercase tracking-wider text-gray-500` |
| 表头背景 | `bg-gray-50` |
| 表头底部 | `border-b border-gray-200` |
| 行 hover | `hover:bg-gray-50` |
| 行交替 | `even:bg-gray-50`
| 数字列 | `text-right font-mono tabular-nums`
| 操作列 | `text-right`，图标按钮
| 空状态 | 美观构图 + 指示如何填充
| 分页 | 简洁，`text-sm`，箭头按钮

### 9.3 KPI 卡片

| 规则 | 实现 |
|------|------|
| 数字 | `text-2xl md:text-3xl font-semibold font-mono tracking-tight`
| 标签 | `text-xs text-gray-500 font-medium`
| 变化趋势 | `text-xs font-medium`，绿色 `↑` + 红色 `↓`
| 图标 | `w-4 h-4`，灰色或语义色
| 间距 | `p-4`，`gap-2`
| 点击态 | `cursor-pointer hover:bg-gray-50`（可交互时）

**KPI 卡片布局：**
```
┌──────────────────┐
│ [图标]    标签    │
│                   │
│     12,847        │
│           ↑ +12%  │
│       较上月      │
└──────────────────┘
```

### 9.4 进度条

| 规则 | 实现 |
|------|------|
| 背景轨道 | `h-2 bg-gray-100 rounded-full`（浅灰轨道）
| 填充 | `h-2 rounded-full`，语义色填充
| 标签 | 左侧名称，右侧百分比
| 动画 | `transition: width 0.6s cubic-bezier(0.16, 1, 0.3, 1)`
| 多段 | 堆叠进度条用 `flex` + 不同语义色

```tsx
// 进度条组件
<div className="space-y-1">
  <div className="flex justify-between text-xs">
    <span className="text-gray-600 font-medium">完成率</span>
    <span className="font-mono text-gray-500">72%</span>
  </div>
  <div className="h-2 bg-gray-100 rounded-full overflow-hidden">
    <motion.div
      initial={{ width: 0 }}
      animate={{ width: "72%" }}
      transition={{ duration: 0.8, ease: [0.16, 1, 0.3, 1] }}
      className="h-full rounded-full bg-blue-500"
    />
  </div>
</div>
```

### 9.5 数据展示纪律

| 规则 | 说明 |
|------|------|
| 禁止假精确数字 | 不用 99.99% / 50% / $100.00，用 47.2% / 83% / $99.00
| 数字格式一致 | 千分位、小数位全页统一
| 空数据状态 | 美观展示，不显示 0 或 N/A
| 加载状态 | 骨架屏匹配最终布局形状
| 刷新指示 | 数据更新时用 layout 过渡，不用闪烁
| 对比基准 | 变化趋势必须标注基准（较上月/较上年）

---

## 10. Dashboard 常见 AI 痕迹检测清单

### 10.1 布局痕迹

| # | 痕迹 | 为什么是 AI 惯性 | 修复方法 |
|---|------|-------------|---------|
| D01 | 每项数据都包白色卡片 | LLM 默认| D01 | 每项数据都包白色卡片 | LLM 默认"卡片=设计" | DENSITY > 7 时用 border-t/divide-y 替代 |
| D02 | 三列等宽 KPI 卡片 | 最常见 AI 布局 | 非对称 2-1-1 或 3-2 分栏 |
| D03 | 居中 Hero + 抽象3D | Dashboard 不需要 Hero | 直接进入数据内容 |
| D04 | 每个 section 都有 eyebrow | AI 默认节奏 | 每 3 个 section 最多 1 个 |
| D05 | 纯文字 + 渐变色块 | 占位符，不是数据展示 | 必须有真实数据或骨架屏 |
| D06 | 表格每行 border-b | 懒人排版 | 选其一：行底线 或 组顶部线 |
| D07 | Bento 格子留空 | 规划失误 | N 个内容项 = N 个格子 |

### 10.2 色彩痕迹

| # | 痕迹 | 为什么是 AI 惯性 | 修复方法 |
|---|------|-------------|---------|
| D11 | AI 紫/蓝渐变背景 | LLM 最爱"科技感"伪装 | 中性基色 + 单一强调色 |
| D12 | 霓虹色强调按钮 | 过度设计 | 降低饱和度至 < 70% |
| D13 | 纯黑 #000 侧栏 | 偷懒 | off-black (#111 / #1a1a1a) |
| D14 | 暖米咖喱色板 | "高级感"默认色 | 冷奢/森林/蓝铜替代 |
| D15 | 多色混用 | 无色彩体系 | 单一强调色 + 一致灰色系 |

### 10.3 动效痕迹

| # | 痕迹 | 为什么是 AI 惯性 | 修复方法 |
|---|------|-------------|---------|
| D21 | 所有卡片同时淡入 | 懒人动画 | staggered 入场，每项 delay 50-100ms |
| D22 | 线性 easing 动画 | 廉价感 | 用 spring physics (stiffness: 100, damping: 20) |
| D23 | 装饰性飘落粒子 | 无信息目的 | 动效必须有信息目的 |
| D24 | 页面加载整体动画 | 卡顿 | 懒加载 + 骨架屏 |
| D25 | 无限循环无性能隔离 | 父组件 re-render | React.memo + 独立 Client Component |

### 10.4 文案痕迹

| # | 痕迹 | 为什么是 AI 惯性 | 修复方法 |
|---|------|-------------|---------|
| D31 | Em-dash `—` 任意位置 | LLM #1 文案痕迹 | 句号/逗号/连字符 |
| D32 | "Elevate/Seamless/Unleash" | 营销废话 | 具体动词 |
| D33 | 99.99%/50%/$100.00 | 假精确数字 | 47.2%/83%/$99.00 |
| D34 | "Acme/Nexus/SmartFlow" | 假品牌名 | 造符合语境的品牌名 |
| D35 | 装饰性状态圆点 | 假交互 | 仅真实语义状态 |
| D36 | 版本标签 (v0.6/BETA) | 假发布状态 | 仅产品发布页可用 |
| D37 | 中间点 `·` 过度使用 | 万能分隔符 | 换行/竖线/列 |

### 10.5 数据痕迹

| # | 痕迹 | 为什么是 AI 惯性 | 修复方法 |
|---|------|-------------|---------|
| D41 | 所有数据完美递增 | 假数据 | 用真实感数据，有波动 |
| D42 | 图表无标签/无单位 | 占位符 | 坐标轴标签 + 数据单位 |
| D43 | 进度条 100% | 假完成态 | 真实进度，有变化 |
| D44 | 空状态显示 0 | 偷懒 | 美观空状态 + 引导操作 |
| D45 | 表格无 hover 状态 | 静态输出 | 行 hover + 操作按钮 |

---

## 11. 性能与无障碍

### 11.1 Dashboard 性能目标

| 指标 | 目标 | 措施 |
|------|------|------|
| LCP | < 2.5s | 数据懒加载，骨架屏优先 |
| INP | < 200ms | 图表 Web Worker，繁重计算异步 |
| CLS | < 0.1 | 数据区域预留空间，骨架屏固定尺寸 |
| 帧率 | 60fps | 动画只动画 transform/opacity |

### 11.2 数据加载策略

| 策略 | 适用场景 |
|------|---------|
| 骨架屏 | 初始加载，匹配最终布局 |
| 渐进加载 | 先加载关键 KPI，后加载图表 |
| 懒加载 | 折叠屏以下的内容 |
| 轮询 | 实时数据，带刷新指示 |
| WebSocket | 实时推送，避免轮询 |

### 11.3 Reduced Motion（强制）

- MOTION > 3 时必须 honor `prefers-reduced-motion`
- Motion: 用 `useReducedMotion()` 退化为静态
- CSS: 用 `@media (prefers-reduced-motion: no-preference)` 或 `@media (prefers-reduced-motion: reduce)` 禁用
- 无限循环、轮播、呼吸灯必须退化为静态

### 11.4 无障碍

| 规则 | 说明 |
|------|------|
| 图表 | 提供文字替代描述（aria-label） |
| 颜色 | 不单独用颜色传达信息，用形状+文字辅助 |
| 键盘导航 | 所有可交互元素可键盘到达 |
| Focus ring | 可见焦点指示器 |
| 对比度 | WCAG AA 最小 4.5:1（正文）/ 3:1（大文本） |
| 数据表格 | 表头用 `<th>` + scope 属性 |

---

## 12. 领域范围（Out of Scope）

本领域规则不覆盖：
- 官网 / Landing Page（用 `domains/web-design`）
- 产品画册 / 品牌手册（用 `domains/b2b-print`）
- 邮件模板（用 `domains/email`）
- 生图（用 `domains/image-generation`）
- 重设计（用 `domains/redesign`）

如果 Brief 是以上之一，**明确说出来**，指向正确领域文件。
