# M2W1D3 · 周三 · Pass / 融合（重点）

核心期第 3 天：算子融合、Linalg Tile-and-Fuse、生产者-消费者数据流分析。

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
| `lib/` | Fusion Pass、Slice Analysis |
| `tools/` | Transform 或 C++ 融合管线 |
| `test/` | Linalg 融合前后 IR、FileCheck |
| `plan.md` | 本日学习与代码任务 |

## 今日目标

- 学：Fusion 经济学、Tile-and-Fuse、Slice Analysis、数据流。
- 写：Linalg 融合对比、Slice 推导工具、tile-and-fuse 应用与检查。
