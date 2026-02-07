# M1W3D1 参考资料

> 对照 M1W1D1 深化：小型 JIT、遍历 CFG 做简单分析。

---

## 一、基础资料（必先完成 W1D1/W2D1）

请先阅读 **M1/W1/M1W1D1/ref.md** 与 **M1/W2/M1W2D1/ref.md**，掌握：
- isa / cast / dyn_cast、IRBuilder、Phi
- 遍历 Module/Function、生成带循环的 IR

---

## 二、深化任务所需资料

### 2.1 小型 JIT

| 资料 | 链接/位置 | 用途 |
|------|-----------|------|
| **HowToUseJIT** | `llvm/examples/HowToUseJIT/` | Kaleidoscope 风格 JIT 框架 |
| **Kaleidoscope 第 8 章** | https://llvm.org/docs/tutorial/MyFirstLanguageFrontend/LangImpl08.html | 简单 JIT 实现 |
| **OrcJIT / LLJIT** | `llvm/include/llvm/ExecutionEngine/Orc/` | 现代 JIT API |
| **ExecutionEngine** | https://llvm.org/docs/ExecutionEngine/ | JIT 概念与 API |

建议：用 IRBuilder 生成简单函数，通过 LLJIT 编译并执行，验证返回值。

### 2.2 遍历 CFG 做简单分析

| 资料 | 链接/位置 | 用途 |
|------|-----------|------|
| **CFG 接口** | `llvm/include/llvm/IR/CFG.h` | successors、predecessors |
| **DominatorTree** | `llvm/include/llvm/Support/GenericDomTree.h` | 支配树（可选） |
| **DFS/BFS 遍历** | 图遍历算法 | 按 CFG 顺序访问 BasicBlock |

示例：统计每个 Block 的前驱/后继数、识别单前驱单后继的「链」、简单控制流可视化。

---

## 三、推荐阅读顺序

1. 复习 M1W1D1/ref.md、M1W2D1/ref.md（约 10 分钟）
2. Kaleidoscope 第 8 章 或 HowToUseJIT 示例（约 30 分钟）
3. CFG.h 与 successors/predecessors API（约 15 分钟）

---

## 四、代码组织

- `lib/`：JIT 封装、CFG 分析逻辑
- `tools/`：main 入口
- `test/`：输入 IR、脚本验证 JIT 输出或分析结果

---

*在 W1/W2 基础上，完成 JIT 与 CFG 分析深化任务。*
