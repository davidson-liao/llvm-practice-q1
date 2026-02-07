# M2W1D3 学习与代码计划

## 学什么

- 算子融合 (Fusion)：生产者-消费者、数据局部性、减少 Load/Store 次数。
- Linalg Tile-and-Fuse：Tiling 消费端、Slice Analysis 推导生产者区域、把生产者塞进 Tile 内。
- 数据流/使用-定义分析：谁消费谁的结果、循环携带依赖、融合合法性。

## 需要工具

| 工具 | 用途 |
|------|------|
| MLIR Linalg 文档与 transform 教程 | Tile-and-Fuse、Fusion 讨论 |
| mlir-opt、transform dialect（可选） | 跑 fusion 与 tiling |
| Linalg 源码：Fusion 相关 Pass | 理解 Slice 与循环结构 |

## 需要写的代码

1. **手工融合验证**
   - 写两个连续的 Linalg Op（如 matmul + add），先不融合跑一遍，再用手动 tiling 或现有 fusion 脚本融合，对比 IR 中 load/store 数量或循环结构。
2. **Slice Analysis**
   - 对「Consumer 的某个 Tile」写一个小工具或脚本：根据索引映射推导 Producer 需要的数据块（矩形/超平面），输出索引范围或对应 IR 片段。
3. **简单融合 Pass 或脚本**
   - 用 Transform Dialect 或 C++：对「Producer-Linalg -> Consumer-Linalg」应用一次 tile-and-fuse，用 FileCheck 检查循环嵌套和 Op 顺序。
