# M3W1D4 · 周四 · GPU

实战期第 4 天：GPU 并行模型 (SIMT)、gpu.launch、多级存储、gpu.barrier。

## 在 Cursor 中执行

```bash
cmake -B build && cmake --build build
./build/daytool
ctest --test-dir build
```

## 今日目标

- 学：SIMT、Warp、Grid/Block/Thread、Warp Divergence；gpu.launch、Shared Memory、barrier。
- 写：gpu.launch kernel、Shared 搬数+barrier、可选 warp divergence 对比。
