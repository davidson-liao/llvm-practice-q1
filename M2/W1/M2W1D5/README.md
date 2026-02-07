# M2W1D5 · 周五 · Python 与性能

核心期第 5 天：MLIR Python 绑定、脚本自动化不同规模性能测试。

## 在 Cursor 中执行

```bash
cmake -B build && cmake --build build
./build/daytool
ctest --test-dir build
```

## 今日目标

- 学：MLIR C-API/Python 绑定、用 Python 建 IR/跑 Pass。
- 写：Python 建 Module 并跑 canonicalize、自动化性能脚本（规模 64～1024）、与 C++ 结果对比。
