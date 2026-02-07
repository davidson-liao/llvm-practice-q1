# M1W2 学习与代码计划（按天分节）

本周主题与 **M1W1** 一致，在 W1 基础上**深化与练习**。对照 M1/W1/plan.md。

---

## D1 · 周一 · LLVM/C++

- 复习：Module/Function/BasicBlock、isa/cast/dyn_cast、IRBuilder、Phi。
- 深化：写完整小 Pass 遍历 Module 内所有 Function 统计各指令类型；或生成带循环的 IR（如 sum 0..n）并跑通。
- 代码：`lib/`、`tools/`、`test/`。

---

## D2 · 周二 · MLIR ODS

- 复习：ODS、Operand/Attribute/Result、Traits、Verifier、自定义 Attribute/Type。
- 深化：为自定义 Dialect 增加更多 Op 或更复杂 Verifier；或实现第二个自定义 Type。
- 代码：`lib/`、`tools/`、`test/`。

---

## D3 · 周三 · Pass/融合基础

- 复习：Canonicalization、Match-Rewrite、GreedyPatternRewriteDriver、DRR。
- 深化：增加更多 DRR 规则（如 sub x,0 -> x）；或写 C++ Pattern 匹配更复杂子图；补充 Lit 用例。
- 代码：`lib/`、`test/`（Lit + FileCheck）。

---

## D4 · 周四 · 向量化/硬件

- 复习：SIMD/Lane、Vector dialect、transfer_read/write、Padding。
- 深化：多维 vector 的 transfer；不同 vector 宽度的 padding；或更多 AVX intrinsic 组合。
- 代码：`lib/`、`tools/`、`test/`（.mlir + FileCheck）。

---

## D5 · 周五 · 工程/测试

- 复习：add_mlir_dialect_library、mlir_tablegen、GTest、Lit/FileCheck。
- 深化：整合 W2 本周代码到同一 CMake 工程；增加 GTest 覆盖；补全 Lit 测试目录。
- 代码：`test/`、根 CMakeLists 与子目录依赖。
