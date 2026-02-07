# M3W1D3 · 周三 · Bufferization

实战期第 3 天：One-Shot Bufferization、RaW 冲突、DPS，解决内存分配瓶颈。

## 在 Cursor 中执行

```bash
cmake -B build && cmake --build build
./build/daytool
ctest --test-dir build
```

## 今日目标

- 学：Tensor→MemRef、In-Place、One-Shot 分析、RaW 检测、DPS。
- 写：可原位 vs RaW 两段 IR 对比、最小 RaW 用例、可选 BufferizableOpInterface。
