# M2W2D3 参考资料

> 对照 M2W1D3 深化练习：Fusion、Tile-and-Fuse、Slice Analysis。

---

## 一、基础资料（必先完成 M2W1D3）

请先阅读 **M2/W1/M2W1D3/ref.md**，掌握：
- 手工融合验证、Slice Analysis、融合 Pass/脚本
- Linalg matmul + add、Transform Dialect tile-and-fuse

---

## 二、深化任务所需资料

### 2.1 深化 Fusion

| 资料 | 位置/链接 | 用途 |
|------|-----------|------|
| **多 Producer 融合** | Linalg Fusion 源码 | Producer A + Producer B → Consumer |
| **Fusion 合法性** | 数据流、RaW 依赖 | 何时不能融合 |
| **Elementwise + Reductive** | Linalg 文档 | 不同迭代类型的融合 |

### 2.2 深化 Tile-and-Fuse

- 不同 tile 形状对融合结果的影响
- 多级 tiling（如 tile 后再 tile）
- 用 Transform Dialect 写出完整 fusion 脚本

### 2.3 深化 Slice Analysis

- 非矩形 Producer 区域（如 stencil）
- 与索引映射 (AffineMap) 的对应关系
- 输出可执行的 IR 片段或循环边界

### 2.4 参考

- `mlir/lib/Dialect/Linalg/Transforms/Fusion.cpp`
- `mlir/test/Dialect/Linalg/tile-and-fuse-sequence.mlir`

---

## 三、推荐阅读顺序

1. 复习 M2W1D3/ref.md（约 10 分钟）
2. Linalg Fusion 源码深入（约 35 分钟）
3. Transform 多步 fusion 用例（约 20 分钟）

---

## 四、代码组织提示

- `lib/`：C++ Fusion Pass 或扩展
- `test/`：.mlir 融合用例、FileCheck 验证

---

*在 M2W1D3 基础上，按本 ref 完成 Fusion 深化任务。*
