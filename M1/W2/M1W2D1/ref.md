# M1W2D1 参考资料

> 对照 M1W1D1 深化练习：遍历 Module、统计指令、生成带循环的 IR。

---

## 一、基础资料（必先完成 M1W1D1）

请先阅读 **M1/W1/M1W1D1/ref.md**，掌握：
- isa / cast / dyn_cast
- IRBuilder、Phi 节点
- Function / BasicBlock / Instruction 层级

---

## 二、深化任务所需资料

### 2.1 遍历 Module 内所有 Function

| 资料 | 位置/链接 | 用途 |
|------|-----------|------|
| **Module 迭代** | `llvm/include/llvm/IR/Module.h` | `for (Function &F : M)` |
| **Instruction 类型统计** | `Instruction::getOpcode()`、`Instruction::getOpcodeName()` | 统计各指令数量 |
| **FunctionPass / ModulePass** | https://llvm.org/docs/WritingAnLLVMPass.html | 写完整 Pass 框架 |

### 2.2 生成带循环的 IR（如 sum 0..n）

| 资料 | 位置/链接 | 用途 |
|------|-----------|------|
| **Kaleidoscope 第 7 章** | https://llvm.org/docs/tutorial/MyFirstLanguageFrontend/LangImpl07.html | for 循环的 LLVM IR 生成 |
| **CreateAdd / CreateMul** | IRBuilder API | 累加器更新 |
| **CreateBr / CreateCondBr** | IRBuilder API | 循环条件与回边 |
| **Phi 在循环中的用法** | Kaleidoscope 第 7 章 | 循环变量、累加器合并 |

### 2.3 循环 IR 结构示意

```
entry:
  %acc = phi i32 [ 0, entry ], [ %acc.next, loop ]
  br loop
loop:
  %i = phi i32 [ 0, entry ], [ %i.next, loop ]
  %cond = icmp slt %i, %n
  br cond, body, exit
body:
  %acc.next = add %acc, %i
  %i.next = add %i, 1
  br loop
exit:
  ret %acc
```

注意：实际入口需正确设置 Phi 的前驱，首次进入从 entry 来，后续从 body 回边来。

---

## 三、推荐阅读顺序

1. 复习 M1W1D1/ref.md（约 10 分钟）
2. Kaleidoscope 第 7 章（约 25 分钟）
3. 浏览 `llvm/lib/Transforms/IPO/` 或 `Scalar/` 中遍历 Module 的 Pass（约 15 分钟）

---

## 四、代码组织提示

- `lib/`：Pass 或工具逻辑
- `tools/`：main、opt 注册或独立可执行文件
- `test/`：输入 .ll 或 .c、预期输出、脚本验证

---

*在 M1W1D1 基础上，按本 ref 完成遍历 Module 与带循环 IR 的深化任务。*
