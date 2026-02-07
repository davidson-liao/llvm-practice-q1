# M2W1D1 · 周一 · LLVM/C++

核心期第 1 天：LLVM 内存优化分析、Alias Analysis、自定义 AA Pass。

## 在 Cursor 中执行

```bash
cmake -B build && cmake --build build
./build/daytool
ctest --test-dir build
```

## 目录说明

| 目录/文件 | 说明 |
|-----------|------|
| `include/` | 头文件 |
| `lib/` | 自定义 AA Pass（AAResultBase） |
| `tools/` | opt 封装或测试入口 |
| `test/` | 验证 LICM/AA 的测试 |
| `plan.md` | 本日学习与代码任务 |

## 今日目标

- 学：BasicAA/TBAA/SCEV AA、MustAlias/NoAlias/MayAlias、AAResultBase。
- 写：观察 AA 输出、自定义 NoAlias AA Pass、可选模板元编程。
