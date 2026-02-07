# M3W3D3 参考资料

> 对照 M3W1D3 深化练习：One-Shot Bufferization、RaW、DPS。

---

## 一、基础资料（必先完成 M3W1D3）

请先阅读 **M3/W1/M3W1D3/ref.md**，掌握：
- One-Shot 分析、RaW 冲突、何时 Copy/复用
- DPS 与 Linalg/One-Shot 配合
- 可选 BufferizableOpInterface

---

## 二、深化任务所需资料

### 2.1 深化 Bufferization

| 资料 | 位置/链接 | 用途 |
|------|-----------|------|
| **One-Shot 源码** | mlir/lib/Dialect/Bufferization/Transforms/ | 分析算法、冲突检测 |
| **BufferizableOpInterface 完整** | 文档 / 头文件 | 自定义 Op 参与分析 |
| **与 Fusion 结合** | Linalg Fusion + One-Shot | 融合后零中间分配 |

### 2.2 深化 RaW 与 DPS

- 复杂图（多分支、多 consumer）的 RaW 分析
- DPS 风格写更多 Linalg Op（conv、matmul）
- 性能：alloc/copy 数量与运行时间对比

### 2.3 参考

- `mlir/lib/Dialect/Bufferization/`
- `mlir/test/Integration/` 中 bufferization 用例

---

## 三、推荐阅读顺序

1. 复习 M3W1D3/ref.md（约 10 分钟）
2. One-Shot 源码或文档进阶（约 30 分钟）
3. 复杂图 One-Shot 行为与 DPS 实践（约 35 分钟）

---

## 四、代码组织提示

- `lib/`：自定义 Op 的 BufferizableOpInterface（若做）
- `test/`：多段 Linalg IR、FileCheck 检查 alloc/copy、RaW 用例

---

*在 M3W1D3 基础上，按本 ref 完成 Bufferization 深化任务。*
