# M2W1D1 参考资料

> 完成 plan.md 中 Alias Analysis 观察、自定义 AA Pass、LICM 验证任务所需的必读资料。

---

## 一、必读官方文档

| 资料 | 链接 | 阅读重点 |
|------|------|----------|
| **Alias Analysis** | https://llvm.org/docs/AliasAnalysis.html | 接口、MustAlias/NoAlias/MayAlias、AAResults |
| **Writing an LLVM Pass** | https://llvm.org/docs/WritingAnLLVMPass.html | AAManager、AnalysisManager |
| **BasicAA** | `llvm/lib/Analysis/BasicAliasAnalysis.cpp` | 实现参考 |
| **AAResultBase** | `llvm/include/llvm/Analysis/AliasAnalysis.h` | 自定义 AA 基类 |

---

## 二、完成「观察 AA」的关键资料

### 2.1 opt 命令

```bash
opt -basic-aa -aa-eval -print-all-alias-modref-info -disable-output input.ll
```

### 2.2 构造带指针的 C/IR

- 两个指针参数 `%p`, `%q`，或全局 `@input_*`, `@weight_*`
- 在函数内对它们做 load/store，观察 AA 输出 Must/No/May

### 2.3 理解三种结果

| 结果 | 含义 | 优化影响 |
|------|------|----------|
| MustAlias | 一定指向同一内存 | 可做激进优化 |
| NoAlias | 一定不重叠 | LICM、向量化可移动 load |
| MayAlias | 不确定 | 需保守处理 |

---

## 三、完成「自定义 AA Pass」的关键资料

### 3.1 继承 AAResultBase

```cpp
struct MyAAResult : public AAResultBase<MyAAResult> {
  AliasResult alias(const MemoryLocation &LocA, const MemoryLocation &LocB,
                    AAQueryInfo &AAQI);
  ModRefInfo getModRefInfo(const CallBase *Call, const MemoryLocation &Loc,
                           AAQueryInfo &AAQI);
};
```

### 3.2 实现 alias()

- 检查 `LocA.Ptr`、`LocB.Ptr` 的来源（GlobalValue、Argument）
- 若符合约定（如 `input_*` 与 `weight_*` 不同前缀），返回 `NoAlias`
- 否则返回 `AliasResult::MayAlias`（保守）

### 3.3 注册到 PassManager

```cpp
AnalysisKey MyAA::Key;
PreservedAnalyses MyAA::run(Function &F, FunctionAnalysisManager &AM) {
  AM.registerResult<MyAAResult>(Key, Result);
  return PreservedAnalyses::all();
}
```

并在 PassPipeline 中加入 `getCFGAAAnalysis`、自定义 AA 等。

### 3.4 验证 LICM 能多移动负载

- 写一段 IR：循环内 load 与 `input_*`/`weight_*` 相关
- 无自定义 AA 时 LICM 不移动；有 NoAlias 后 LICM 将 load 提升到循环外
- 用 `opt -licm -print-after=licm` 观察 IR 变化

---

## 四、完成「C++ 模板元编程（可选）」的关键资料

| 资料 | 用途 |
|------|------|
| TBAA 元数据 | Type-based AA，通过类型标记区分指针 |
| 模板 Kind 区分 | 编译期生成不同 Kind 的包装类型 |
| LLVM TBAA 文档 | 理解 metadata 与 AA 的配合 |

---

## 五、推荐阅读顺序

1. AliasAnalysis 文档（约 30 分钟）
2. BasicAA 源码浏览（约 25 分钟）
3. 写一个最小 AAResultBase 子类并注册（约 40 分钟）

---

## 六、参考源码位置

- `llvm/include/llvm/Analysis/AliasAnalysis.h`
- `llvm/lib/Analysis/BasicAliasAnalysis.cpp`
- `llvm/lib/Passes/PassBuilder.cpp`（AA 管线注册）

---

*按此资料学习，即可完成 plan.md 中的观察 AA、自定义 AA Pass、LICM 验证任务。*
