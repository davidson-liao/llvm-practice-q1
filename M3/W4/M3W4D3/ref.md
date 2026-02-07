# M3W4D3 参考资料

> 对照 M3W1D3 深化练习：One-Shot Bufferization、RaW、DPS。

---

## 一、基础资料（必先完成 M3W1D3）

请先阅读 **M3/W1/M3W1D3/ref.md**，掌握：
- One-Shot Bufferization、RaW 冲突、何时 Copy/复用
- DPS 与 Linalg/One-Shot 配合
- 可选 BufferizableOpInterface

---

## 二、深化任务所需资料

### 2.1 小结与综合

| 资料 | 位置/链接 | 用途 |
|------|-----------|------|
| **三月大纲第三部分** | 三月编译器学习大纲.md | 3.3 One-Shot、RaW、DPS |
| **零中间分配管线** | 已学 M3W1～W3 | Fusion + One-Shot 串联 |
| **可选：自定义 BufferizableOpInterface** | 文档 / 源码 | 加深理解 |

### 2.2 综合练习建议

- 在 Conv+Add+ReLU 或类似图上验证：Fusion + One-Shot 后 alloc/copy 数量
- 构造 RaW 与非 RaW 用例，对比 One-Shot 行为
- 写一段小结：One-Shot 与 DPS 在解决内存瓶颈中的作用

### 2.3 参考

- `mlir/lib/Dialect/Bufferization/`、`mlir/test/Dialect/Bufferization/`
- M3W1D3～M3W3D3 的 ref 与代码

---

## 三、推荐阅读顺序

1. 复习 M3W1D3/ref.md 与 M3W2D3、M3W3D3/ref.md（约 15 分钟）
2. 三月大纲 3.3 回顾（约 15 分钟）
3. 综合练习或小结（约 40 分钟）

---

## 四、代码组织提示

- `lib/`：若有自定义 BufferizableOpInterface
- `test/`：多段 Linalg IR、RaW 用例、FileCheck 检查 alloc/copy

---

*在 M3W1D3 基础上，按本 ref 完成 Bufferization 小结或综合练习。*
