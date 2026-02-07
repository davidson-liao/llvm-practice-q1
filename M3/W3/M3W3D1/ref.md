# M3W3D1 参考资料

> 对照 M3W1D1 深化练习：后端 Codegen、ISel、RegAlloc。

---

## 一、基础资料（必先完成 M3W1D1）

请先阅读 **M3/W1/M3W1D1/ref.md**，掌握：
- 后端 Codegen 流程、ISel/RegAlloc 输入输出
- llc 调试选项、与 MLIR lowering 衔接点

---

## 二、深化任务所需资料

### 2.1 深化后端 Codegen

| 资料 | 位置/链接 | 用途 |
|------|-----------|------|
| **SelectionDAG 深入** | llvm/lib/CodeGen/SelectionDAG/ | DAG 构建、Legalize、ISel |
| **GlobalISel 管线** | https://llvm.org/docs/GlobalISel/ | GMIR、IRTranslator、Legalizer |
| **多目标对比** | x86 / ARM / AArch64 | 不同 ISel/RegAlloc 策略 |

### 2.2 深化与 MLIR 衔接

- MLIR → LLVM IR 的完整 Pass 链
- 从 mlir-opt 到 llc 的脚本化管线
- 可选：自定义 Target 或简单后端扩展

### 2.3 参考

- `llvm/lib/CodeGen/` 各阶段源码
- `mlir/lib/Conversion/` 到 LLVM 的 Conversion

---

## 三、推荐阅读顺序

1. 复习 M3W1D1/ref.md（约 10 分钟）
2. SelectionDAG 或 GlobalISel 深入（约 35 分钟）
3. 跑通 MLIR→LLVM→asm 全链路（约 25 分钟）

---

## 四、代码组织提示

- `lib/`：若有自定义分析或辅助工具
- `tools/`：MLIR→LLVM→llc 管线脚本
- `test/`：.mlir / .ll 输入、FileCheck 验证 MIR/asm

---

*在 M3W1D1 基础上，按本 ref 完成后端 Codegen 深化任务。*
