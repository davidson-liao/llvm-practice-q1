# M2W1D4 参考资料

> 完成 plan.md 中 Tiling、降级管线、性能对比任务所需的必读资料。

---

## 一、必读官方文档

| 资料 | 链接 | 阅读重点 |
|------|------|----------|
| **Linalg Tiling** | https://mlir.llvm.org/docs/Dialects/Linalg/ | LinalgTilingOptions、tile |
| **Bufferization** | https://mlir.llvm.org/docs/Bufferization/ | one-shot-bufferize、tensor→memref |
| **Linalg to Loops** | `mlir/lib/Dialect/Linalg/Transforms/` | convert-linalg-to-loops |
| **Transform Dialect Tiling** | https://mlir.llvm.org/docs/Dialects/Transform/ | structured.tile、tile_sizes |

---

## 二、完成「Tiling」的关键资料

### 2.1 循环平铺理论

- **工作集**：Tile 内数据量应适配 L1（32KB～64KB）、L2（256KB～512KB）
- **Tile 形状**：正方形 vs 矩形，对矩阵乘法影响 cache 命中率
- **伪共享 (False Sharing)**：多核下同一 cache 行被不同 core 写，需边界对齐

### 2.2 Linalg Tiling 用法

```mlir
// Transform Dialect
%tiled = transform.structured.tile %matmul [32, 32, 16]
```

或 C++：
```cpp
LinalgTilingOptions opts;
opts.setTileSizes({32, 32});
linalg::tile(opts, rewriter, op);
```

### 2.3 观察生成的 scf.for

- 循环边界：`arith.constant`、`min`、`ceildiv`
- 步长：tile size
- 参考：`mlir/test/Dialect/Linalg/tile-and-fuse.mlir`

---

## 三、完成「降级管线」的关键资料

### 3.1 完整 pipeline 顺序

```
linalg (tensor)
  → one-shot-bufferize     # tensor → memref
  → convert-linalg-to-loops  # linalg.generic → scf.for + 内部 body
  → (可选) convert-scf-to-cf
```

### 3.2 mlir-opt 命令示例

```bash
mlir-opt input.mlir \
  -one-shot-bufferize \
  -convert-linalg-to-loops \
  -canonicalize
```

### 3.3 关键 IR 检查点

- **one-shot-bufferize 后**：tensor 消失，出现 memref.alloc、memref.copy
- **convert-linalg-to-loops 后**：scf.for 嵌套、scf.parallel 或 linalg 的 region 展开为循环 body

### 3.4 参考

- `mlir/test/Integration/Dialect/Linalg/CPU/matmul-v2.mlir`
- MLIR Bufferization 文档

---

## 四、完成「性能对比（可选）」的关键资料

### 4.1 思路

- 固定问题规模（如 128x128 matmul）
- 不同 tile size：16x16、32x32、64x64
- 用 `mlir-cpu-runner` 或 lowering 到 LLVM 后执行，计时

### 4.2 参考

- `time`、`perf stat`、Python `timeit`
- 输出 CSV：tile_size, time_ms

---

## 五、推荐阅读顺序

1. Linalg 文档中 Tiling 小节（约 25 分钟）
2. Bufferization 文档（约 30 分钟）
3. 运行 `mlir/test/Integration/Dialect/Linalg/` 中的测试（约 20 分钟）

---

## 六、参考源码位置

- `mlir/lib/Dialect/Linalg/Transforms/Tiling.cpp`
- `mlir/lib/Dialect/Linalg/Transforms/ConvertToLoops.cpp`
- `mlir/lib/Dialect/Bufferization/Transforms/OneShotBufferize.cpp`

---

*按此资料学习，即可完成 plan.md 中的 Tiling、降级管线、性能对比任务。*
