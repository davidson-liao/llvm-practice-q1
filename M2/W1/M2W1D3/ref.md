# M2W1D3 参考资料

> 对照学习计划「月份二 · 周三 · Pass / 融合（重点）」：Tile-and-Fuse、Linalg Fusion、Slice Analysis。

---

## 一、学习计划对应内容

本日对应 **三月编译器学习计划-每日拆解.md** 中「月份二 · 周三 · Pass / 融合（重点）」：

- 算子融合：生产者-消费者、数据局部性、减少 Load/Store
- Linalg Tile-and-Fuse：Tiling 消费端、Slice Analysis、把生产者塞进 Tile
- 数据流 / 使用-定义分析

---

## 二、必读官方文档

| 资料 | 链接 | 阅读重点 |
|------|------|----------|
| **Linalg Dialect** | https://mlir.llvm.org/docs/Dialects/Linalg/ | linalg.generic、索引映射 |
| **Transform Dialect** | https://mlir.llvm.org/docs/Dialects/Transform/ | tile-and-fuse、结构化变换 |
| **Linalg Fusion 讨论** | MLIR 文档 / 邮件列表 | Producer-Consumer 融合策略 |
| **Linalg 源码** | `mlir/lib/Dialect/Linalg/Transforms/` | Fusion、Tiling 实现 |

---

## 三、完成「手工融合验证」的关键资料

### 3.1 两段连续 Linalg Op

```mlir
// matmul + add
linalg.matmul ins(%A, %B : ...) outs(%C : ...)
linalg.generic {indexing_maps = [...], iterator_types = ["parallel","parallel"]}
  ins(%C : tensor<?x?xf32>) outs(%D : tensor<?x?xf32>) {
  ^bb0(%c: f32, %d: f32):
    %e = arith.addf %c, %broadcast : f32
    linalg.yield %e : f32
}
```

### 3.2 对比融合前后

- 融合前：两段独立，中间 tensor 分配、多次 load/store
- 融合后（手动 tiling 或 transform）：Producer 被塞进 Consumer 的 tile 内，减少中间内存

### 3.3 参考

- `mlir/test/Dialect/Linalg/` 中 fusion、tile-and-fuse 用例
- IREE / MLIR Linalg 教程

---

## 四、完成「Slice Analysis」的关键资料

### 4.1 概念

- Consumer 的某个 Tile 对应的迭代空间是子集
- Producer 需要的数据块由 Consumer 的索引映射 + Tile 范围反推
- 输出：Producer 的矩形/超平面索引范围

### 4.2 实现思路

- 使用 Linalg 的 `getIndexingMap`、`applyMapToValues`
- 或参考 `mlir/lib/Dialect/Linalg/Analysis/` 中的 Slice 相关工具
- 输入：Consumer Op、Tile 的循环边界；输出：Producer 的迭代范围

### 4.3 参考

- `LinalgInterfaces.td` 中 indexing_maps
- `mlir/lib/Dialect/Linalg/Transforms/Fusion.cpp`

---

## 五、完成「简单融合 Pass 或脚本」的关键资料

### 5.1 Transform Dialect 示例

```mlir
transform.sequence failures(propagate) {
^bb0(%arg0: !transform.any_op):
  %matmul = transform.structured.match ops{["linalg.matmul"]} in %arg0
  %tiled = transform.structured.tile %matmul [32, 32]
  %fused = transform.structured.fuse_into_containing_op %matmul into %tiled
}
```

### 5.2 C++ 融合 Pass

- 使用 `linalg::LinalgTilingOptions`、`linalg::tileAndFuse`
- 或调用 `populateLinalgTilingCanonicalizationPatterns` 等

### 5.3 FileCheck 验证

- 检查循环嵌套结构、Producer 是否在 Consumer 的 tile 内
- 检查 load/store 数量是否减少

---

## 六、推荐阅读顺序

1. Linalg Dialect 文档（约 30 分钟）
2. Transform Dialect 快速入门（约 25 分钟）
3. `mlir/lib/Dialect/Linalg/Transforms/Fusion.cpp` 浏览（约 30 分钟）
4. 运行 `mlir/test/Dialect/Linalg/` 中 tile-and-fuse 测试（约 15 分钟）

---

## 七、参考源码位置

- `mlir/include/mlir/Dialect/Linalg/IR/`
- `mlir/lib/Dialect/Linalg/Transforms/`（Fusion、Tiling）
- `mlir/lib/Dialect/Linalg/Analysis/`
- `mlir/test/Dialect/Linalg/`

---

*按此资料学习，即可完成月份二周三的 Pass/融合（重点）任务：手工融合验证、Slice Analysis、融合 Pass/脚本。*
