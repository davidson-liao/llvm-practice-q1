# M3W1D1 · 周一 · 后端 Codegen

实战期第 1 天：编译器后端 Codegen 原理、指令选择 (ISel)、寄存器分配。

## 在 Cursor 中执行

```bash
cmake -B build && cmake --build build
./build/daytool
ctest --test-dir build
```

## 今日目标

- 学：IR→ISel→调度→RegAlloc→发射；SelectionDAG/GlobalISel；图着色 vs 线性扫描。
- 写：用 llc 观察 ISel/RegAlloc 结果；可选 TableGen 机器描述；总结与 MLIR lowering 衔接点。
