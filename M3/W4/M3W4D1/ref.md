# M3W4D1 参考资料

> 对照 M3W1D1 深化练习：后端 Codegen。本月最后一周，可做小结或综合练习。

---

## 一、基础资料（必先完成 M3W1D1）

请先阅读 **M3/W1/M3W1D1/ref.md**，掌握：
- 后端 Codegen 流程、ISel/RegAlloc 输入输出
- llc 调试选项、与 MLIR lowering 衔接点

---

## 二、深化任务所需资料

### 2.1 小结与综合

| 资料 | 位置/链接 | 用途 |
|------|-----------|------|
| **三月大纲第三部分** | 三月编译器学习大纲.md | 3.1 后端 Codegen、ISel、RegAlloc |
| **MLIR → LLVM → asm 全链路** | 已学 M3W1～W3 | 串联 Codegen 与 MLIR |
| **可选：简单后端扩展** | TableGen、SelectionDAG | 加深理解 |

### 2.2 综合练习建议

- 从 MLIR 图到可执行码的完整管线（mlir-opt → llc → 运行）
- 对比不同目标（x86/ARM）的 ISel/RegAlloc 输出
- 写一段小结：ISel/RegAlloc 在整条管线中的位置与输入输出

### 2.3 参考

- `llvm/lib/CodeGen/`、`mlir/lib/Conversion/`
- M3W1D1～M3W3D1 的 ref 与代码

---

## 三、推荐阅读顺序

1. 复习 M3W1D1/ref.md 与 M3W2D1、M3W3D1/ref.md（约 15 分钟）
2. 三月大纲第三部分 3.1 回顾（约 15 分钟）
3. 综合练习或小结（约 40 分钟）

---

## 四、代码组织提示

- `lib/`：若有小结工具或脚本
- `tools/`：MLIR→LLVM→llc 全链路脚本
- `test/`：端到端 .mlir 用例、FileCheck 验证

---

*在 M3W1D1 基础上，按本 ref 完成后端 Codegen 小结或综合练习。*
