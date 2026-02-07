# M3W2D1 参考资料

> 对照 M3W1D1 深化练习：ISel、RegAlloc、与 MLIR lowering 衔接。

---

## 一、基础资料（必先完成 M3W1D1）

请先阅读 **M3/W1/M3W1D1/ref.md**，掌握：
- 后端 Codegen 流程、ISel 输入/输出、RegAlloc 输入/输出
- llc -debug-only=isel、-print-after-all
- 与 MLIR lowering 到 LLVM 的衔接点

---

## 二、深化任务所需资料

### 2.1 深化 ISel

| 资料 | 位置/链接 | 用途 |
|------|-----------|------|
| **SelectionDAG Legalize** | llvm/lib/CodeGen/SelectionDAG/ | 合法化阶段、类型展开 |
| **GlobalISel** | https://llvm.org/docs/GlobalISel/ | 新一代 ISel、GMIR |
| **TableGen 匹配规则** | 目标 .td 文件 | Pat、ComplexPattern |

### 2.2 深化 RegAlloc

- 图着色 vs 线性扫描：编译时间与代码质量权衡
- 溢出（Spilling）：何时插入 load/store、栈槽分配
- 与 MLIR 衔接：MLIR 生成 LLVM IR 后，由 llc 做 ISel/RegAlloc

### 2.3 参考

- `llvm/lib/CodeGen/RegAlloc/` 下不同实现
- `opt -O2 | llc -debug-only=regalloc` 观察分配结果

---

## 三、推荐阅读顺序

1. 复习 M3W1D1/ref.md（约 10 分钟）
2. SelectionDAG 或 GlobalISel 文档（约 25 分钟）
3. 观察不同目标的 ISel/RegAlloc 输出（约 20 分钟）

---

## 四、代码组织提示

- `lib/`：若有自定义分析或辅助工具
- `tools/`：调用 llc、对比 MLIR→LLVM→asm 的脚本
- `test/`：.ll 输入、FileCheck 验证 MIR 或 asm 片段

---

*在 M3W1D1 基础上，按本 ref 完成 ISel、RegAlloc、与 MLIR 衔接的深化任务。*
