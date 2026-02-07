# M3W1D5 · 周五 · 终极验收

实战期第 5 天：端到端迷你算子图 Conv2D + BiasAdd + ReLU，全链路验证。

## 在 Cursor 中执行

```bash
cmake -B build && cmake --build build
./build/daytool
ctest --test-dir build
```

## 今日目标

- 学：Frontend→Optimization→Bufferization→Codegen→Runtime 全链路。
- 写：Conv+Add+ReLU 图、Fusion+Tiling+One-Shot Bufferize、CPU/GPU Codegen 与运行、验收清单。
