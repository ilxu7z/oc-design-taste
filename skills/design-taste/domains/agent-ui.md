---
domain: agent-ui
description: >-
  Agent 声明式 UI 设计规范 — 融合 A2UI 邻接表思维与 Design Taste 体系。
  覆盖：AI Agent 生成/输出 UI 界面的设计规范、组件白名单、骨架-数据分离、增量构建、安全性检查。
  适配：LLM 直接生成前端代码、Agent 驱动的动态界面、AI Chat UI、Copilot 面板、工具调用结果可视化。
depends: [knowledge/declarative-ui, domains/web-design]
---

# Agent UI · 领域规则

> **核心定位**：当 AI Agent 需要生成或输出 UI 界面时，本 Domain 提供设计规范。
> **灵感来源**：Google A2UI 协议（邻接表模型、组件白名单、数据/结构分离）
> **覆盖**：Agent 驱动的动态 UI、Chat 中的富交互卡片、工具调用结果可视化、AI Copilot 面板、LLM 直接生成的前端代码
> **不覆盖**：人类手写的静态 UI（用 `web-design`）、Dashboard 数据面板（用 `dashboard`）、生图（用 `image-generation`）

---

## 1. Agent UI 的核心设计哲学

### 1.1 与传统 Web 设计的区别

| 维度 | 传统 Web 设计 | Agent UI |
|------|-------------|---------|
| **生成者** | 人类设计师/开发者 | AI Agent（LLM） |
| **信任边界** | 单一信任域 | 跨信任边界（Agent → Client） |
| **输出形式** | 直接 HTML/CSS/JS | 声明式描述 → 渲染 |
| **变化频率** | 低（版本发布） | 高（每次对话可能不同） |
| **可预测性** | 高（设计稿→代码） | 中（LLM 输出有方差） |
| **风险** | 设计质量 | 安全注入 + 设计一致性 |

### 1.2 三大铁律

| # | 铁律 | 说明 |
|---|------|------|
| **1** | **组件先于布局** | 先确定用哪些组件（积木），再决定如何排列（房子） |
| **2** | **数据与结构分离** | 骨架（布局）和内容（数据）分开生成，独立更新 |
| **3** | **白名单思维** | 只使用已验证的组件模式，不发明"新组件" |

---

## 2. 邻接表思维：Agent 如何安全生成复杂 UI

> 理论基础见 `knowledge/declarative-ui.md` §2.2

### 2.1 核心原则

Agent 生成复杂 UI 时，**不要用深度嵌套的结构**。采用扁平化思维：

**❌ 嵌套思维（AI 默认陷阱）**：
```
Page → Column → Card → Row → Button
                    ↘ Row → Text
```
任何一层出错，整体崩溃。LLM 难以一次生成正确的深度嵌套。

**✅ 邻接表思维（推荐）**：
```
组件清单（扁平）：
  page-header    [Column, parentId=null]
  hero-card      [Card, parentId=page-header]
  hero-title     [Text, parentId=hero-card]
  hero-row       [Row, parentId=hero-card]
  confirm-btn    [Button, parentId=hero-row]
  hero-desc      [Text, parentId=hero-card]
```

### 2.2 实践方法

在 Agent 生成 UI 代码时：

1. **先列组件清单**：输出所有需要的组件，标注 parentId
2. **逐个生成**：按清单顺序逐个生成组件代码
3. **最后组装**：按 parentId 关系组装

**示例工作流**：
```
Step 1: 组件清单
  - HeroSection (parentId: null)
  - HeroTitle (parentId: HeroSection)
  - HeroSubtitle (parentId: HeroSection)
  - CTAButton (parentId: HeroSection)
  - FeatureGrid (parentId: null)
  - FeatureCard × 4 (parentId: FeatureGrid)

Step 2: 逐个生成代码
Step 3: 组装为完整页面
```

### 2.3 代码中的邻接表思维

当 Agent 直接生成 React/HTML 代码时，保持浅嵌套：

```tsx
// ❌ 深嵌套（3+ 层）
<div className="container">
  <div className="grid grid-cols-3">
    <div className="card">
      <div className="card-inner">
        <div className="card-content">
          <h3>Title</h3>
        </div>
      </div>
    </div>
  </div>
</div>

// ✅ 浅嵌套（≤2 层），语义化组件
<Section>
  <Card>
    <h3>Title</h3>
    <p>Description</p>
  </Card>
</Section>
```

---

## 3. 骨架-数据分离

### 3.1 核心思路

将 UI 生成分为两步：

| 步骤 | 产出 | 变更频率 |
|------|------|---------|
| **骨架（Structure）** | 布局框架、组件结构、交互模式 | 低 |
| **数据（Data）** | 文字内容、图片 URL、数值、状态 | 高 |

### 3.2 实践方法

#### 方法 A：组件 props 分离

```tsx
// ✅ 数据通过 props 传入，组件本身是纯骨架
interface HeroProps {
  title: string;
  subtitle: string;
  ctaLabel: string;
  ctaUrl: string;
  backgroundImage?: string;
}

function Hero({ title, subtitle, ctaLabel, ctaUrl, backgroundImage }: HeroProps) {
  return (
    <section className="relative min-h-[80dvh] flex items-center">
      {backgroundImage && <BackgroundImage src={backgroundImage} />}
      <div className="max-w-4xl">
        <h1>{title}</h1>
        <p>{subtitle}</p>
        <Button href={ctaUrl}>{ctaLabel}</Button>
      </div>
    </section>
  );
}

// 数据层
const heroData: HeroProps = {
  title: "智能营销引擎",
  subtitle: "AI 驱动的全渠道营销自动化",
  ctaLabel: "免费试用",
  ctaUrl: "/demo"
};
```

#### 方法 B：数据文件分离

```tsx
// components/Hero.tsx — 骨架
export function Hero({ data }: { data: HeroData }) { ... }

// data/hero.ts — 数据
export const heroData: HeroData = { ... };
```

### 3.3 何时需要分离

| 场景 | 分离？ | 理由 |
|------|--------|------|
| Agent 一次生成完整页面 | 可选（结构简单时） | 单次输出，分离收益不大 |
| Agent 分步构建复杂页面 | **必须** | 骨架稳定，数据频繁更新 |
| Agent 需要动态替换内容 | **必须** | 换数据不需要重写组件 |
| 多 Agent 协作（一个写骨架，一个填数据） | **必须** | 各司其职，避免冲突 |

---

## 4. Agent UI 组件白名单

### 4.1 概念

Agent 生成 UI 时，**优先使用以下已验证的组件模式**。不在这个列表中的"自创组件"需要额外审查。

### 4.2 标准组件清单

#### 布局组件

| 组件 | 用途 | Agent 使用注意 |
|------|------|---------------|
| `Section` | 页面区块容器 | 必须有 id/aria-label，max-width 限制 |
| `Grid` | CSS Grid 布局容器 | 指定列数，移动端退化 |
| `Row` | 水平排列 | Flex，gap 间距 |
| `Column` | 垂直排列 | Flex-col，间距 |
| `Container` | 居中容器 | max-w-7xl + mx-auto |

#### 展示组件

| 组件 | 用途 | Agent 使用注意 |
|------|------|---------------|
| `Heading` | 标题（h1-h6） | 字号/字重/字间距受控 |
| `Text` | 正文段落 | max-width 65ch/40em |
| `Image` | 图片 | 必须有 alt，必须有尺寸占位 |
| `Icon` | 图标 | 用图标库，禁止手写 SVG path |
| `Badge` | 标签/状态 | 语义色，禁用纯装饰 |
| `Divider` | 分隔线 | 1px 细线，不滥用 |

#### 交互组件

| 组件 | 用途 | Agent 使用注意 |
|------|------|---------------|
| `Button` | 按钮/CTA | 必须有明确 intent，必须有 hover/active 状态 |
| `Link` | 导航链接 | 禁止 `href="#"` |
| `Input` | 文本输入 | Label 在上方，不在内部 |
| `Select` | 下拉选择 | 有默认值 |
| `Checkbox` | 复选框 | Label 文字清晰 |
| `Toggle` | 开关 | 状态明确 |
| `Card` | 信息卡片 | 仅用于层级，高密度时用 border-t 替代 |
| `Modal` | 弹窗 | 有关闭方式，有 backdrop |
| `Tabs` | 标签页 | 初始有活跃 tab |
| `Accordion` | 折叠面板 | 初始可展开 |
| `Table` | 数据表格 | 表头用 th，数字列右对齐 |
| `Form` | 表单容器 | 有验证、有提交反馈 |
| `Toast` | 轻提示 | 自动消失，有类型（成功/警告/错误） |

#### 复合组件

| 组件 | 用途 | 来源 |
|------|------|------|
| `HeroSection` | 页面顶部大图/标题区 | `component-arsenal.md` |
| `FeatureGrid` | 功能特性展示 | `component-arsenal.md` |
| `PricingTable` | 定价对比 | `component-arsenal.md` |
| `TestimonialCarousel` | 客户评价轮播 | `component-arsenal.md` |
| `StatCard` | 数据指标卡片 | `dashboard` domain |
| `CommandInput` | AI 输入栏 | `dashboard` domain |

### 4.3 自定义组件规则

当业务需要标准清单外的组件时：

1. **定义接口**：明确 props 和行为
2. **在白名单中注册**：添加到本清单
3. **审查安全性**：确保无 XSS/注入风险
4. **写使用示例**：给 Agent 看的正确用法

**❌ 禁止**：Agent 在运行时"发明"未注册的组件模式。

---

## 5. Agent UI 的安全检查

### 5.1 代码级安全检查

| 检查项 | 规则 | 风险 |
|--------|------|------|
| **无 `dangerouslySetInnerHTML`** | 永远禁止 | XSS 注入 |
| **无 `eval()`** | 永远禁止 | 代码注入 |
| **无 `innerHTML`** | 永远禁止 | XSS 注入 |
| **无动态 `src` 拼接** | 图片/脚本 src 必须来自可信源 | 恶意资源加载 |
| **无 `window.open` 未过滤** | URL 必须白名单或 rel=noopener | Tab-nabbing |
| **无 inline event handler 字符串** | 用 JSX onClick，不用字符串 | 注入 |
| **CSS 无 `expression()`** | IE 特有，现代浏览器已禁，但 Agent 可能生成 | 注入 |
| **无外部 script 引入** | Agent 生成中不引入第三方 script | 供应链攻击 |

### 5.2 内容级安全检查

| 检查项 | 规则 |
|--------|------|
| **链接安全** | 所有 `href` 必须是合法 URL 或内部路由，禁止 `javascript:` |
| **图片安全** | 所有图片 URL 来自可信源或 picsum seed |
| **表单安全** | 所有表单 action 指向真实端点 |
| **数据校验** | 用户输入的数据必须类型校验（Zod/Yup） |

### 5.3 Agent 输出质量检查

| 检查项 | 规则 |
|--------|------|
| **组件闭合** | 所有 JSX 标签正确闭合 |
| **嵌套深度** | ≤ 3 层 div 嵌套 |
| **Props 完整** | 必需 props 无遗漏 |
| **无死代码** | 无 `// TODO`、`// ...`、裸 `...` 省略 |
| **语义化** | 使用 header/main/footer/nav/section/article |
| **无障碍** | 所有图片有 alt，所有按钮有文本，所有表单有 label |

---

## 6. Agent UI 的交互设计规范

### 6.1 Chat UI 中的富卡片

当 Agent 在对话中输出富交互 UI（如搜索结果、产品卡片、数据图表）时：

| 规则 | 说明 |
|------|------|
| **轻量优先** | 卡片是信息密度，不是页面。≤ 5 行核心信息 |
| **可操作** | 每张卡片有 1-2 个明确操作 |
| **可折叠** | 详细信息可展开/收起 |
| **视觉一致** | 与宿主 UI 风格统一 |
| **加载状态** | 异步数据先显示骨架 |

### 6.2 工具调用结果可视化

当 Agent 调用工具后需要展示结果时：

| 数据类型 | 推荐展示方式 |
|---------|-------------|
| 简单值 | 内联文本 + 复制按钮 |
| 结构化数据 | Card / Table |
| 列表数据 | CompactList / Table |
| 图表数据 | MiniChart（sparkline） |
| 文件操作 | 进度条 + 结果摘要 |
| 搜索结果 | CompactCard 列表 |

### 6.3 渐进式展示

复杂 UI 应该**分步展示**，不是一次性全量输出：

```
Step 1: 骨架 + 骨架屏（给用户"正在构建"的感觉）
Step 2: 核心内容填充（标题 + 主要数据）
Step 3: 交互元素激活（按钮可点击、表单可填写）
Step 4: 次要内容 + 装饰（图片、描述、链接）
```

---

## 7. Agent UI 的三旋钮特化

### 7.1 默认旋钮

当路由到此 Domain 时，三旋钮的基线不同：

```
DESIGN_VARIANCE: 4-6（Agent UI 需要可预测性，不能太实验）
MOTION_INTENSITY: 3-5（适度微动效，保持响应感）
VISUAL_DENSITY: 4-6（标准密度，信息清晰）
```

### 7.2 场景预设

| 场景 | VARIANCE | MOTION | DENSITY | 说明 |
|------|----------|--------|---------|------|
| **Chat 内嵌卡片** | 3-4 | 2-3 | 5-7 | 紧凑，信息优先 |
| **Copilot 侧边栏** | 3-4 | 3-4 | 5-7 | 工具面板风格 |
| **工具结果面板** | 4-5 | 3-4 | 6-8 | 数据密度高 |
| **AI 生成完整页面** | 5-7 | 4-6 | 3-5 | 参考 web-design domain |
| **Agent 配置界面** | 4-5 | 2-3 | 5-7 | 表单密集 |
| **多步骤引导** | 3-4 | 4-6 | 3-4 | 步骤感，进度反馈 |

### 7.3 VARIANCE 特殊约束

Agent UI 的 DESIGN_VARIANCE 有额外约束：

| 档位 | 约束 | 理由 |
|------|------|------|
| **1-3** | 严格 Grid 等分，居中对齐 | Agent 输出的 UI 需要可预测 |
| **4-6** | 轻微非对称，左对齐标题 | **Agent UI 的最佳区间** |
| **7-10** | ⚠️ 需要用户明确确认 | Agent 输出实验性布局风险高 |

---

## 8. Agent UI 常见 AI 痕迹

### 8.1 结构痕迹

| # | 痕迹 | 为什么是 AI 惯性 | 修复 |
|---|------|-----------------|------|
| A01 | 深度嵌套 div（4+ 层） | LLM 习惯递归生成 | 用语义组件，≤3 层 |
| A02 | 组件间强耦合 | 不做抽象，内联样式 | 提取可复用组件 |
| A03 | 一次性输出完整页面 | 缺乏分步思维 | 骨架→数据→交互，分步构建 |
| A04 | 硬编码内容在组件内 | 数据/结构不分离 | props 传入或数据文件分离 |
| A05 | 自创"通用"组件名 | 如 `<InfoBox>` `<ContentBlock>` | 用标准组件名 |

### 8.2 交互痕迹

| # | 痕迹 | 修复 |
|---|------|------|
| A11 | 按钮无 hover/active 状态 | 加 transition + scale/translateY |
| A12 | 表单无验证反馈 | 加 inline error + success state |
| A13 | 加载状态用 spinner | 用骨架屏匹配布局 |
| A14 | 错误状态用 alert() | 用 inline error message |
| A15 | 无键盘导航支持 | 所有交互元素 focusable |

### 8.3 数据痕迹

| # | 痕迹 | 修复 |
|---|------|------|
| A21 | 工具结果直接 dump JSON | 格式化为可视 UI |
| A22 | 表格无 hover/focus 状态 | 加行 hover + focus ring |
| A23 | 数据无格式化 | 数字 tabular-nums，货币符号，百分比 |
| A24 | 空状态无引导 | 空状态 + 操作提示 |

---

## 9. Agent UI 输出模板

### 9.1 Chat 内嵌卡片模板

```tsx
interface AgentCardProps {
  title: string;
  description: string;
  actions: Array<{ label: string; onClick: string }>;
  status?: "loading" | "success" | "error";
}

function AgentCard({ title, description, actions, status }: AgentCardProps) {
  return (
    <div className="rounded-xl border border-gray-200/50 p-4 bg-white shadow-sm">
      <h4 className="text-sm font-semibold text-gray-900">{title}</h4>
      <p className="text-xs text-gray-500 mt-1">{description}</p>
      {status === "loading" && <SkeletonShimmer />}
      {actions.length > 0 && (
        <div className="flex gap-2 mt-3">
          {actions.map(action => (
            <button
              key={action.label}
              className="text-xs px-3 py-1.5 rounded-lg bg-gray-100 hover:bg-gray-200 transition-colors"
              onClick={() => /* handle */}
            >
              {action.label}
            </button>
          ))}
        </div>
      )}
    </div>
  );
}
```

### 9.2 工具结果展示模板

```tsx
interface ToolResultProps {
  tool: string;
  status: "success" | "error" | "partial";
  data: Record<string, unknown>;
  summary?: string;
}

function ToolResult({ tool, status, data, summary }: ToolResultProps) {
  return (
    <div className="rounded-xl border border-gray-200/50 bg-gray-50 p-4">
      <div className="flex items-center gap-2 mb-2">
        <span className={`w-2 h-2 rounded-full ${status === "success" ? "bg-emerald-500" : status === "error" ? "bg-red-500" : "bg-amber-500"}`} />
        <span className="text-xs font-mono text-gray-400">{tool}</span>
      </div>
      {summary && <p className="text-sm text-gray-700">{summary}</p>}
      <pre className="text-xs font-mono text-gray-600 mt-2 bg-white rounded-lg p-3 overflow-x-auto">
        {JSON.stringify(data, null, 2)}
      </pre>
    </div>
  );
}
```

---

## 10. 领域范围（Out of Scope）

本领域规则不覆盖：
- 人类手写的静态 Web 页面（用 `domains/web-design`）
- Dashboard / 数据面板（用 `domains/dashboard`）
- 邮件模板（用 `domains/email`）
- 生图 / 图片生成（用 `domains/image-generation`）
- 画册 / 品牌手册（用 `domains/b2b-print`）

如果 Brief 是以上之一，**明确说出来**，指向正确领域文件。
