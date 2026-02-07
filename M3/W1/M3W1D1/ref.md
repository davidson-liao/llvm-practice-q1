# M3W1D1 参考资料

> 完成 plan.md 中后端 Codegen 观察、ISel/RegAlloc 理解、与 MLIR lowering 衔接任务所需的必读资料。

---

## 一、必读官方文档

| 资料 | 链接 | 阅读重点 |
|------|------|----------|
| **CodeGenerator** | https://llvm.org/docs/CodeGenerator.html | 后端流程概览、各阶段输入输出 |
| **Writing an LLVM Backend** | https://llvm.org/docs/WritingAnLLVMBackend.html | 目标描述、指令选择、寄存器分配 |
| **SelectionDAG** | `llvm/lib/CodeGen/SelectionDAG/` | DAG 构建、Legalize、ISel |
| **GlobalISel** | https://llvm.org/docs/GlobalISel/ | 新一代指令选择框架 |

---

## 二、完成「观察后端」的关键资料

### 2.1 llc 与调试选项

```bash
llc -mtriple=x86_64-unknown-linux-gnu -debug-only=isel input.ll -o - 2>&1 | head -200
llc -mtriple=x86_64-unknown-linux-gnu -print-after-all input.ll -o output.s 2>&1
```

### 2.2 关键阶段与 MIR

- **指令选择 (ISel)**：LLVM IR → SelectionDAG 或 GMIR；输出为机器相关 DAG 或 MIR。
- **寄存器分配 (RegAlloc)**：虚拟寄存器 → 物理寄存器；可加 `-debug-only=regalloc` 观察溢出与分配。
- **发射 (Emit)**：MIR → 汇编/机器码。

### 2.3 理解三种结果

| 阶段 | 输入 | 输出 |
|------|------|------|
| ISel | LLVM IR (Function/BasicBlock) | SelectionDAG 或 GlobalISel MIR |
| RegAlloc | 带虚拟寄存器的 MIR | 带物理寄存器的 MIR |
| Emit | 合法化 MIR | 汇编或目标文件 |

---

## 三、完成「（可选）简单后端或机器描述」的关键资料

### 3.1 TableGen 后端描述

- **指令定义**：`llvm/lib/Target/X86/X86InstrInfo.td` 等，def ADD32rr、pattern 等。
- **SelectionDAG 匹配**：`Pat<(add i32 $a, $b), (ADD32rr $a, $b)>` 形式，理解「IR 节点 → 机器节点」映射。
- **合法化**：Legalize 阶段将非法类型/操作展开为合法序列。

### 3.2 参考

- `llvm/docs/TableGen/` 与后端 .td 文件
- 简单目标（如 Lanai、MSP430）的 InstrInfo.td 便于阅读

---

## 四、完成「与 MLIR lowering 衔接」的关键资料

### 4.1 衔接点

- **MLIR → LLVM IR**：`mlir-opt -convert-scf-to-cf -convert-arith-to-llvm -convert-math-to-llvm -convert-memref-to-llvm -convert-func-to-llvm -reconcile-unrealized-casts` 等，最终得到 LLVM IR。
- **LLVM IR → 机器码**：将上述 LLVM IR 交给 `llc`（或 JIT 中的 LLVM Backend），即进入 ISel → RegAlloc → Emit。
- **总结笔记建议**：哪里生成 LLVM IR（MLIR Pass 管线终点）、哪里调 llc（或 ExecutionEngine）、ISel/RegAlloc 的输入输出各是什么。

### 4.2 参考

- MLIR 文档中「Lowering to LLVM」
- `mlir/test/Conversion/` 中的端到端用例

---

## 五、推荐阅读顺序

1. CodeGenerator 文档（约 25 分钟）
2. Writing an LLVM Backend 前几节（约 30 分钟）
3. 用 llc -debug-only=isel 观察一段简单 IR（约 20 分钟）

---

## 六、参考源码位置

- `llvm/include/llvm/CodeGen/`
- `llvm/lib/CodeGen/SelectionDAG/`
- `llvm/lib/CodeGen/RegAlloc/`
- `llvm/lib/Target/X86/`（或其它目标）

---

*按此资料学习，即可完成 plan.md 中的观察后端、ISel/RegAlloc 理解、与 MLIR 衔接总结任务。*
