---
profile: dark-developer
description: 暗色/开发者工具/DevTool 美学预设 — 深色背景、monospace、terminal 氛围、cyan/coral accents
dial-suggestion: VARIANCE 5-7 / MOTION 4-6 / DENSITY 5-8
---

# 美学预设：Dark Developer（暗色开发者）

## 1. 氛围概述

Dark Developer 是面向开发者工具、基础设施、DevOps、AI Builder 等产品的美学方向。它模拟高端终端界面、代码编辑器、命令行工具的视觉语言。核心气质：**精确、锐利、自信、builder-native**。

- **密度**：中到高（DENSITY 5-8）。信息密集但有序
- **变化**：中等偏移（VARIANCE 5-7）。非对称布局，但保持可预测性
- **动效**：流畅到编排（MOTION 4-6）。微交互丰富，但不花哨

## 2. 色板

### 2.1 主色板

| 角色 | 色值 | 说明 |
|------|------|------|
| 画布背景 | `#0A0A0A` | 近黑 — 模拟 deactivated CRT，避免纯 `#000000` |
| 二级表面 | `#141416` | 卡片/容器背景 — 比画布稍亮 |
| 三级表面 | `#1C1C1E` | 输入框、代码块背景 |
| 主文字 | `#EAEAEA` | 白色磷光 — 主文字颜色 |
| 副文字 | `#8E8E93` | 灰 — 描述、元数据 |
| 三级文字 | `#636366` | 深灰 — 时间戳、禁用状态 |
| 分隔线 | `rgba(255,255,255,0.06)` | 极淡发丝线 |

### 2.2 强调色

| 角色 | 色值 | 说明 |
|------|------|------|
| **主强调 — 青色** | `#00D4AA` | CTA、链接、活跃状态、焦点环 |
| **次强调 — 珊瑚** | `#FF6B6B` | 错误、危险操作、警告 |
| **终端绿** | `#4AF626` | 仅用于特定状态指示器（如在线状态） |
| **蓝色** | `#5E9CFF` | 信息、链接（备选） |

### 2.3 终端绿使用规则

- 仅用于**一个**特定 UI 元素（如一个状态指示器或一个数据读数）
- 不作为通用文字颜色
- 如果不服务于明确目的，完全省略

### 2.4 禁令

- ❌ 纯黑 `#000000` — 用 `#0A0A0A` 替代
- ❌ 高饱和霓虹色（除青色和珊瑚外）
- ❌ 暖色调背景（无米色、奶油色、象牙色）
- ❌ 渐变背景（终端/命令行氛围无渐变）
- ❌ AI 紫蓝发光

## 3. 排版体系

### 3.1 字体选择

| 层级 | 推荐字体 | 参数 |
|------|---------|------|
| **Display/标题** | `Geist`, `Satoshi`, `Cabinet Grotesk`, `Outfit` | Sans-Serif，`letter-spacing: -0.03em`，`line-height: 1.1`，重量 700-900 |
| **正文** | `Geist`, `Satoshi` | Sans-Serif，`line-height: 1.6`，重量 400 |
| **代码/数据** | `JetBrains Mono`, `Geist Mono`, `IBM Plex Mono` | Monospace — 用于代码块、终端输出、元数据、所有数字 |
| **终端装饰** | `VT323`, `Courier Prime` | 复古终端字体 — 仅用于装饰性终端模拟 |

### 3.2 字号比例

```
Display: clamp(2.5rem, 5vw, 4.5rem)  — 标题
Subhead: clamp(1.125rem, 2vw, 1.5rem) — 副标题
Body:    0.9375rem / 1rem             — 正文（稍小以适应高密度）
Code:    0.8125rem / 0.875rem         — 代码块
Mono Meta: 0.75rem                    — 元数据、时间戳
Caption: 0.6875rem                    — 脚注
```

### 3.3 排版纪律

- **全大写用于元数据** — 导航、标签、时间戳、单位 ID 用全大写 + 宽 tracking
- **等宽数字** — 所有数字用 `font-variant-numeric: tabular-nums`，确保表格对齐
- **DENSITY > 7 时所有数字用 Monospace** — 强制
- **无 Serif** — 暗色开发者场景永远不用衬线字体
- **无 Inter** — 用 Geist / Satoshi / Outfit 替代
- **Em-dash 禁令** — 零 em-dash

### 3.4 终端/命令行排版

```css
/* 终端输出样式 */
.terminal-output {
  font-family: 'JetBrains Mono', monospace;
  font-size: 0.8125rem;
  line-height: 1.5;
  color: #EAEAEA;
  background: #0A0A0A;
  padding: 1rem;
  border: 1px solid rgba(255,255,255,0.06);
  border-radius: 8px;
}

/* 命令行提示符 */
.prompt::before {
  content: '$ ';
  color: #00D4AA;
}

/* 终端光标闪烁 */
.cursor-blink {
  animation: blink 1s step-end infinite;
}

@keyframes blink {
  50% { opacity: 0; }
}
```

## 4. 布局原则

### 4.1 页面节奏

- **Section padding** — `py-16` 到 `py-24`（比 editorial 紧凑）
- **不对称分栏** — 60/40、70/30、或侧边栏布局
- **内容宽度** — `max-w-6xl` 或 `max-w-7xl`
- **网格优先** — CSS Grid，无 flex 百分比数学

### 4.2 Hero 规范

- **Asymmetric Split Hero** — 左文右终端模拟/代码截图
- **Split Screen** — 50/50，一半文字一半交互式命令行
- **文字元素 ≤ 4 个** — 眉毛标签(0-1) + 标题 + 副文本 + CTA
- **Hero 必须有视觉元素** — 终端窗口、代码片段、命令行界面
- **无版本标签**（除非真实发布页）
- **无滚动提示**

### 4.3 终端/命令行视觉元素

- **终端窗口** — 模拟 macOS 终端窗口（红黄绿圆点 + 标题栏 + 内容）
- **代码块** — 语法高亮代码片段作为装饰或 Hero 视觉
- **命令行提示符** — `$` 或 `>` 前缀
- **安装命令** — `npm install`、`pip install`、`brew install` 格式
- **API 响应** — JSON 格式化输出

### 4.4 Section 多样性

- 至少 4 种不同布局家族在 8 个 section 中
- Bento Grid 适合 feature 展示
- Sticky-Stack 适合产品叙事
- 无三列等宽卡片

### 4.5 卡片与容器

- 卡片用 `rounded-[1rem]` 或 `rounded-[1.5rem]`
- 边框 `1px solid rgba(255,255,255,0.06)`
- 背景 `#141416`
- 无阴影 — 用边框和背景区分层级
- DENSITY > 7 时用 `border-t` 分隔替代卡片

## 5. 组件规范

### 5.1 按钮

```css
/* 主 CTA */
.btn-primary {
  background: #00D4AA;
  color: #0A0A0A;
  font-family: 'Geist', sans-serif;
  font-weight: 600;
  padding: 0.75rem 1.5rem;
  border-radius: 8px;
  border: none;
  transition: all 200ms cubic-bezier(0.16, 1, 0.3, 1);
}
.btn-primary:hover {
  background: #00BFA0;
  transform: scale(0.98);
}
.btn-primary:active {
  transform: scale(0.96);
}

/* 次按钮 — Ghost */
.btn-ghost {
  background: transparent;
  color: #EAEAEA;
  border: 1px solid rgba(255,255,255,0.12);
  padding: 0.75rem 1.5rem;
  border-radius: 8px;
  font-family: 'Geist', sans-serif;
  font-weight: 500;
}
.btn-ghost:hover {
  background: rgba(255,255,255,0.05);
  border-color: rgba(255,255,255,0.2);
}
```

### 5.2 输入框

```css
.input-dark {
  background: #1C1C1E;
  border: 1px solid rgba(255,255,255,0.08);
  border-radius: 8px;
  padding: 0.75rem 1rem;
  color: #EAEAEA;
  font-family: 'Geist Mono', monospace;
  font-size: 0.875rem;
}
.input-dark:focus {
  border-color: #00D4AA;
  outline: none;
  box-shadow: 0 0 0 2px rgba(0, 212, 170, 0.2);
}
```

### 5.3 状态徽章

```css
.badge-success {
  background: rgba(0, 212, 170, 0.1);
  color: #00D4AA;
  border-radius: 9999px;
  padding: 0.25rem 0.75rem;
  font-size: 0.75rem;
  font-family: 'Geist Mono', monospace;
  text-transform: uppercase;
  letter-spacing: 0.05em;
}
.badge-error {
  background: rgba(255, 107, 107, 0.1);
  color: #FF6B6B;
}
```

### 5.4 代码块

```css
.code-block {
  background: #1C1C1E;
  border: 1px solid rgba(255,255,255,0.06);
  border-radius: 12px;
  padding: 1.5rem;
  font-family: 'JetBrains Mono', monospace;
  font-size: 0.8125rem;
  line-height: 1.6;
  overflow-x: auto;
}
```

## 6. 纹理与效果

### 6.1 CRT 扫描线

```css
/* CRT 扫描线 — 仅用于终端/命令行区域 */
.crt-scanlines::after {
  content: '';
  position: absolute;
  inset: 0;
  pointer-events: none;
  background: repeating-linear-gradient(
    0deg,
    transparent,
    transparent 2px,
    rgba(0, 0, 0, 0.08) 2px,
    rgba(0, 0, 0, 0.08) 4px
  );
}
```

### 6.2 磷光发光

```css
/* 青色磷光发光 — 用于强调元素 */
.phosphor-glow {
  box-shadow: 0 0 20px rgba(0, 212, 170, 0.15),
              0 0 40px rgba(0, 212, 170, 0.05);
}
```

### 6.3 网格背景

```css
/* 终端网格背景 */
.terminal-grid {
  background-image:
    linear-gradient(rgba(255,255,255,0.02) 1px, transparent 1px),
    linear-gradient(90deg, rgba(255,255,255,0.02) 1px, transparent 1px);
  background-size: 40px 40px;
}
```

## 7. 动效哲学

- **流畅优先** — MOTION 4-6，微交互丰富但不花哨
- **Spring Physics** — `stiffness: 100, damping: 20`，无 linear easing
- **入场动画** — `translateY(12px)` + `opacity: 0` → `translateY(0)` + `opacity: 1`，600ms
- **Hover 状态** — 颜色变化 + 轻微缩放
- **终端光标闪烁** — 无限循环
- **加载状态** — 骨架屏 shimmer，无圆形 spinner
- **Reduced Motion** — 必须 honor

## 8. 品牌套件应用

当生成品牌套件时，使用 Dark Developer / Builder 视觉模式：

- 近黑面板
- 等宽强调
- 命令行界面
- 终端窗口
- 提示栏
- 微妙网格
- 青色、蓝色、珊瑚或石灰强调
- 像素或 CRT 纹理（如适用）

Logo 逻辑：
- 光标 + 框架
- 螺栓 + 构建速度
- 脚手架 + 字母组合
- 终端符号 + 标记
- 模块化构建标记

## 9. 禁令清单

- ❌ Em-dash `—` 在任何位置
- ❌ Inter / Roboto / Arial / Open Sans 字体
- ❌ 纯黑 `#000000` 背景
- ❌ 暖色调色板（米色、奶油色、象牙色）
- ❌ 渐变背景
- ❌ AI 紫蓝发光
- ❌ Serif 字体
- ❌ 三列等宽卡片
- ❌ 序号 eyebrow
- ❌ 版本标签在 Hero（除非真实发布）
- ❌ 滚动提示
- ❌ 装饰性状态圆点
- ❌ Emoji 当图标
- ❌ `h-screen` — 用 `min-h-[100dvh]`
- ❌ 纯文字 + 渐变色块 Hero
- ❌ 通用假品牌名（"Acme", "Nexus", "SmartFlow"）
- ❌ AI 文案痕迹（"Elevate", "Seamless", "Unleash"）
- ❌ 假精确数字（99.99%）

## 10. 适用场景

| 场景 | 推荐度 | 备注 |
|------|--------|------|
| 开发者工具官网 | ⭐⭐⭐ | 核心场景 |
| CLI / 终端产品 | ⭐⭐⭐ | 核心场景 |
| DevOps / 基础设施 | ⭐⭐⭐ | 核心场景 |
| AI Builder / 编码 Agent | ⭐⭐⭐ | 核心场景 |
| API 文档 / 开发者门户 | ⭐⭐⭐ | 核心场景 |
| SaaS 管理后台 | ⭐⭐ | 可降低 DENSITY |
| Dashboard | ⭐⭐ | 数据密集型适用 |
| 安全产品 | ⭐⭐ | 调整为深海军蓝基调 |
| 奢侈品/生活方式 | ❌ | 不适用 |
| 邮件模板 | ❌ | 不适用 |
