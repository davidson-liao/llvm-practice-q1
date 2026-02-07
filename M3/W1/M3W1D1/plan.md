# M3W1D1 学习与代码计划

## 学什么

- 编译器后端 Codegen 概览：IR -> 指令选择 -> 调度 -> 寄存器分配 -> 发射。
- 指令选择 (ISel)：SelectionDAG 与 GlobalISel、模式匹配、合法化。
- 寄存器分配：图着色 vs 线性扫描、虚拟寄存器到物理寄存器、溢出。

## 需要工具

| 工具 | 用途 |
|------|------|
| LLVM 文档：WritingAnLLVMBackend、CodeGenerator | 后端流程 |
| llc -debug 或 -print-after-all | 看 ISel/RegAlloc 结果 |
| TableGen 后端 .td 文件 | 目标描述与匹配模式 |

## 需要写的代码

1. **观察后端**
   - 用 `llc` 把一段 LLVM IR 编到 x86/ARM，加 `-debug-only=isel` 或 `-print-after-all`，找到指令选择与寄存器分配后的 MIR。
2. **（可选）简单后端或机器描述**
   - 若有兴趣：在 TableGen 里为一个简单目标加一条指令描述和一条 SelectionDAG 匹配规则，理解「IR 节点 -> 机器节点」的映射。
3. **总结**
   - 写一段简短笔记：ISel 输入/输出、RegAlloc 输入/输出、与 MLIR lowering 到 LLVM 的衔接点（哪里生成 LLVM IR、哪里调 llc）。
