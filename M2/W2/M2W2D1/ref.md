# M2W2D1 参考资料

> 对照 M2W1D1 深化练习：Alias Analysis、自定义 AA Pass。

---

## 一、基础资料（必先完成 M2W1D1）

请先阅读 **M2/W1/M2W1D1/ref.md**，掌握：
- Alias Analysis 接口、MustAlias/NoAlias/MayAlias
- AAResultBase、alias()、getModRefInfo
- 注册到 PassManager、LICM 验证

---

## 二、深化任务所需资料

### 2.1 深化 Alias Analysis

| 资料 | 位置/链接 | 用途 |
|------|-----------|------|
| **TBAA** | https://llvm.org/docs/LangRef.html#tbaa-metadata | Type-based AA、metadata |
| **SCEV AA** | `llvm/lib/Analysis/ScalarEvolutionAliasAnalysis.cpp` | 基于 SCEV 的指针关系 |
| **AAResults 组合** | `llvm/include/llvm/Analysis/AAResults.h` | 多 AA 如何合并 |

### 2.2 深化自定义 AA Pass

- 扩展命名约定：更多前缀、正则匹配
- 支持 Function 内局部变量的 NoAlias（如不同 alloca）
- 与 TBAA 结合：根据类型标记返回 NoAlias

### 2.3 参考

- `llvm/lib/Analysis/` 下其他 AA 实现
- `opt -aa-pipeline` 查看默认 AA 管线

---

## 三、推荐阅读顺序

1. 复习 M2W1D1/ref.md（约 10 分钟）
2. TBAA 文档（约 20 分钟）
3. 浏览 SCEV AA 或 BasicAA 扩展实现（约 25 分钟）

---

## 四、代码组织提示

- `lib/`：AA Pass 实现
- `tools/`：opt 插件或独立工具
- `test/`：带指针的 .ll、验证 LICM 等优化效果

---

*在 M2W1D1 基础上，按本 ref 完成 Alias Analysis 深化任务。*
