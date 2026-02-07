# M3W2D3 参考资料

> 对照 M3W1D3 深化练习：One-Shot Bufferization、RaW、DPS。

---

## 一、基础资料（必先完成 M3W1D3）

请先阅读 **M3/W1/M3W1D3/ref.md**，掌握：
- One-Shot Bufferization 分析、RaW 冲突检测
- 何时插入 Copy、何时复用 Buffer
- Destination Passing Style 与 Linalg/One-Shot 配合
- 可选：BufferizableOpInterface

---

## 二、深化任务所需资料

### 2.1 深化 One-Shot

| 资料 | 位置/链接 | 用途 |
|------|-----------|------|
| **AnalysisState** | Bufferization 源码 | 别名集、RaW 决策状态 |
| **BufferizableOpInterface 完整 API** | 文档 / 头文件 | 自定义 Op 参与分析 |
| **冲突解决策略** | 文档 #how-to-resolve-conflicts | 插入 copy 的位置与数量 |

### 2.2 深化 DPS

- 更多 Linalg Op 的 DPS 写法（conv、matmul 等）
- 与 Fusion 结合：融合后仍保持零中间分配
- 性能对比：DPS + One-Shot 前后 alloc/copy 数量

### 2.3 参考

- `mlir/lib/Dialect/Bufferization/Transforms/`
- `mlir/test/Dialect/Bufferization/` 复杂用例

---

## 三、推荐阅读顺序

1. 复习 M3W1D3/ref.md（约 10 分钟）
2. Bufferization 文档进阶（约 25 分钟）
3. 复杂图（多 Op、多分支）的 One-Shot 行为（约 30 分钟）

---

## 四、代码组织提示

- `lib/`：自定义 Op 的 BufferizableOpInterface（若做）
- `test/`：多段 Linalg IR、FileCheck 检查 alloc/copy

---

*在 M3W1D3 基础上，按本 ref 完成 Bufferization 深化任务。*
