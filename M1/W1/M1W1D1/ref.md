# M1W1D1 参考资料

> 完成 plan.md 中编程任务所需的必读资料与代码参考。

---

## 一、必读官方文档

| 资料 | 链接 | 阅读重点 |
|------|------|----------|
| **LLVM Programmer's Manual** | https://llvm.org/docs/ProgrammersManual.html | 全文；重点「Casting (isa, cast, dyn_cast)」小节 |
| **LLVM Programmer's Manual - Casting** | https://llvm.org/docs/ProgrammersManual.html#the-isa-cast-and-dyn-cast-templates | isa/cast/dyn_cast 用法、避免双重访问 |
| **Casting.h 源码** | `llvm/include/llvm/Support/Casting.h` | 理解实现、isa_impl、cast_convert_val |
| **Kaleidoscope: Code generation** | https://llvm.org/docs/tutorial/MyFirstLanguageFrontend/LangImpl09.html | IRBuilder、插入点、Phi 节点 |
| **LLVM Language Reference** | https://llvm.org/docs/LangRef.html | SSA 形式、Phi 节点语法 |

---

## 二、完成「isa/cast/dyn_cast 小练习」的关键资料

### 2.1 正确 vs 错误用法对比

```cpp
// ❌ 错误：双重类型访问
if (isa<ConstantInt>(val)) {
  ConstantInt* ci = cast<ConstantInt>(val);  // 又读了一次 Kind
  // ...
}

// ✅ 正确：一次 dyn_cast 完成检查+转换
if (auto* ci = dyn_cast<ConstantInt>(val)) {
  // ci 已可用
}
```

### 2.2 遍历 Function 的典型代码结构

- 参考：`llvm/lib/Passes/` 下任意分析 Pass
- 关键：`for (Instruction &I : F) { ... }` 或 `for (BasicBlock &BB : F) { for (Instruction &I : BB) { ... } }`
- 用 `isa<ConstantInt>(&I)` 统计；用 `dyn_cast<BinaryOperator>(&I)` 匹配二元运算

### 2.3 参考资料位置

- **opt 写 Pass 框架**：https://llvm.org/docs/WritingAnLLVMPass.html
- **FunctionPass / ModulePass**：`llvm/include/llvm/IR/PassManager.h`、`llvm/lib/Passes/`

---

## 三、完成「手写 IR 生成」的关键资料

### 3.1 IRBuilder 核心 API

| API | 用途 |
|-----|------|
| `IRBuilder::CreateCondBr()` | 条件分支，创建 if-else 的 Merge 块 |
| `IRBuilder::CreatePHI()` | Phi 节点，合并多前驱的值 |
| `IRBuilder::SetInsertPoint()` | 切换插入点 |
| `IRBuilder::CreateICmpSGT/CreateSelect` | 比较与选择（可选） |

### 3.2 max(a,b) 或 abs(x) 的 IR 结构

```
entry:
  cond = icmp sgt a, b
  br cond, then_bb, else_bb
then_bb:
  br merge_bb
else_bb:
  br merge_bb
merge_bb:
  result = phi [a, then_bb], [b, else_bb]
  ret result
```

### 3.3 代码示例来源

- **Kaleidoscope Codegen**：生成 if/then/else 与 Phi 的完整流程
- **lli 运行 IR**：`lli module.ll` 或 `lli -extra-module=...`
- **JIT 简单示例**：`llvm/examples/Kaleidoscope/`、`llvm/examples/HowToUseJIT/`

---

## 四、推荐阅读顺序

1. Programmer's Manual 的 Casting 小节（约 10 分钟）
2. Kaleidoscope 第 9 章 Code generation（约 30 分钟）
3. 打开 `Casting.h` 浏览 isa/cast/dyn_cast 声明（约 5 分钟）
4. 参考 `llvm/lib/Transforms/Utils/` 下简单 Pass，看如何遍历 Function

---

## 五、可复制的 LLVM 构建与链接

```cmake
find_package(LLVM REQUIRED CONFIG)
include_directories(${LLVM_INCLUDE_DIRS})
add_executable(my_tool tools/main.cpp lib/pass.cpp)
target_link_libraries(my_tool LLVM)
llvm_map_components_to_libnames(llvm_libs Support Core IR)
target_link_libraries(my_tool ${llvm_libs})
```

---

*按此资料顺序学习，即可完成 plan.md 中的两项编程任务。*
