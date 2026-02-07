# M2W1D1 学习与代码计划

## 学什么

- LLVM 内存优化分析：为何需要别名信息、LICM/向量化对 NoAlias 的依赖。
- Alias Analysis：BasicAA、TBAA、SCEV AA；MustAlias / NoAlias / MayAlias 三种结果。
- 自定义 Alias Analysis Pass：继承 AAResultBase、实现 alias()、在 PassManager 中注册。

## 需要工具

| 工具 | 用途 |
|------|------|
| LLVM 源码：AliasAnalysis.h、BasicAA、AAResults | 接口与组合 |
| opt -aa-eval 或自定义 Pass | 观察 AA 结果 |
| C++ 模板 / 元编程（若做模板优化） | 与 AA 结合的可选深入 |

## 需要写的代码

1. **观察 AA**
   - 写一段带指针参数的 C/LLVM IR，用 `opt -basic-aa -aa-eval -print-all-alias-modref-info` 看 Must/No/MayAlias 输出。
2. **自定义 AA Pass**
   - 实现一个简单的 Module/Function AA：对特定函数或全局命名约定（如 `input_*` / `weight_*`）返回 NoAlias；写测试验证 LICM 或其它 Pass 能因此多移动一条负载。
3. **（可选）C++ 模板元编程**
   - 若时间允许：写一个小工具，用模板在编译期区分不同「Kind」的指针类型，与 LLVM 的 Type-based 信息结合理解 TBAA。
