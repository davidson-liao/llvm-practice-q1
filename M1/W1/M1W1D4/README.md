# M1W1D4 · 周四 · 向量化 / 硬件

基建期第 4 天：Intel SIMD、Vector 方言、transfer_read/write、Padding。

## 在 Cursor 中执行

```bash
cmake -B build && cmake --build build
./build/daytool
ctest --test-dir build
```

## 目录说明

| 目录/文件 | 说明 |
|-----------|------|
| `include/` | 头文件 |
| `lib/` | 向量 IR 或 AVX intrinsic 代码 |
| `tools/` | mlir-opt 或 C++ 向量示例 |
| `test/` | .mlir 用例、FileCheck |
| `plan.md` | 本日学习与代码任务 |

## 今日目标

- 学：SIMD/Lane、Vector dialect、transfer_read/write、Padding 语义。
- 写：手写向量 IR、边界 padding 用例、可选 AVX intrinsic 程序。
