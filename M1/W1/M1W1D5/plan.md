# M1W1D5 学习与代码计划

## 学什么

- CMake 与 MLIR 构建：add_mlir_dialect_library、mlir_tablegen、依赖与生成 .inc 顺序、避免并发竞争。
- 单元测试：GTest 写 C++ API / Pass 逻辑测试。
- 回归测试：Lit + FileCheck，用 .mlir 输入、跑 Pass、检查输出 IR。

## 需要工具

| 工具 | 用途 |
|------|------|
| CMake 3.15+、Ninja | 构建 |
| LLVM/MLIR 的 lit、FileCheck | 回归测试 |
| Google Test (GTest) | 单元测试（通常随 LLVM 构建） |

## 需要写的代码

1. **CMake**
   - 整理/完善本周的 MLIR Dialect 工程：保证 `mlir_tablegen` 先于编译、正确生成 .inc；支持 `ninja check` 或 `ctest` 跑测试。
2. **GTest**
   - 为本周写的 Canonicalizer 或 Pattern 写 1～2 个 GTest：构造 Op/Region、应用 Pattern、断言结果 Op 或值符合预期。
3. **Lit + FileCheck**
   - 为 Canonicalize 或 Vector 片段写 Lit 测试：RUN 里调用 `mlir-opt`，用 FileCheck 检查关键指令是否存在/不存在。
4. **（可选）简单性能基准**
   - 用 GTest 或小脚本：对固定 .mlir 或 LLVM IR 跑 N 次 Pass，统计平均耗时，作为后续对比的基线。
