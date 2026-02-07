# M2W2D2 参考资料

> 对照 M2W1D2 深化练习：Interface、Verifier、Trait。

---

## 一、基础资料（必先完成 M2W1D2）

请先阅读 **M2/W1/M2W1D2/ref.md**，掌握：
- OpInterface、Concept-Model、ExternalModel
- Verifier、Trait、HasFolder、Commutative
- Pass 通过 Interface 操作多种 Op

---

## 二、深化任务所需资料

### 2.1 深化 Interface

| 资料 | 位置/链接 | 用途 |
|------|-----------|------|
| **多方法 Interface** | MLIR Interfaces 文档 | 定义含多个方法的 Interface |
| **RegionBranchOpInterface** | `mlir/include/mlir/Interfaces/` | 控制流 Interface |
| **LoopLikeOpInterface** | 同上 | 循环类 Op 的通用接口 |

### 2.2 深化 Verifier

- 跨 Op 的 Verifier（如 Region 内 Op 与外层约束一致）
- 更复杂的维度/类型推导检查
- 自定义 Diagnostic 与 fix-it 提示

### 2.3 深化 Trait

- 自定义 Trait（非内置）
- Trait 与 Interface 组合使用
- 观察不同 Trait 对 Canonicalize、DCE 的影响

### 2.4 参考

- `mlir/include/mlir/Dialect/Linalg/IR/LinalgInterfaces.td`
- `mlir/include/mlir/Interfaces/ControlFlowInterfaces.td`

---

## 三、推荐阅读顺序

1. 复习 M2W1D2/ref.md（约 10 分钟）
2. MLIR Interfaces 文档中多方法、Region 相关（约 25 分钟）
3. Linalg 的 Interface/Trait 定义（约 20 分钟）

---

## 四、代码组织提示

- `lib/`：Interface 实现、Op 实现
- `tools/`：测试工具
- `test/`：合法/非法 IR、Verifier 错误用例

---

*在 M2W1D2 基础上，按本 ref 完成 Interface、Verifier、Trait 深化任务。*
