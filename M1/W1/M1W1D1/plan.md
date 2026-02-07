# M1W1D1 学习与代码计划

## 学什么

- LLVM 基础架构：Module / Function / BasicBlock / Instruction 层级、IR 的 SSA 形式。
- isa / cast / dyn_cast 工具库：轻量 RTTI、何时用 isa 检查、何时用 dyn_cast 做模式匹配、避免「先 isa 再 cast」的双重访问。
- 手写 LLVM IR 指令生成：IRBuilder、插入点、BasicBlock 内指令链、Phi 节点与多前驱合并。

## 需要工具

| 工具 | 用途 |
|------|------|
| LLVM 源码 / 预编译包 | 头文件与库，建议 15+ 版本 |
| CMake 3.15+ | 构建工程 |
| C++17 编译器 (Clang/GCC) | 编译 LLVM 相关代码 |
| LLVM Programmer's Manual | 查 isa/cast/dyn_cast 与 API |

## 需要写的代码

1. **小练习：isa/cast/dyn_cast**
   - 写一个遍历 `Function` 的 Pass（或独立工具）：用 `isa<ConstantInt>` 统计常量整数个数；用 `dyn_cast<BinaryOperator>` 匹配二元运算并打印。
   - 对比：错误用法「先 `isa<T>` 再 `cast<T>`」与正确用法「一次 `dyn_cast<T>`」的代码差异。
2. **手写 IR 生成**
   - 用 `IRBuilder` 生成「带 if-else 的简单函数」的 LLVM IR（例如 `max(a,b)` 或 `abs(x)`），包含 Phi 节点。
   - 用 `lli` 或写 JIT 跑通并验证结果。
