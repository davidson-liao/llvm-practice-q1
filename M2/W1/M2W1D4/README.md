# M2W1D4 · 周四 · Tiling 与降级

核心期第 4 天：循环平铺 (Tiling)、缓存一致性、Linalg (tensor) → one-shot-bufferize → scf.for。

## 在 Cursor 中执行

```bash
cmake -B build && cmake --build build
./build/daytool
ctest --test-dir build
```

## 今日目标

- 学：Tiling 理论、工作集与缓存、伪共享；Linalg→MemRef 降级管线。
- 写：2D/3D tiling、完整降级 pipeline、可选性能对比。
