# M2W3D1 参考资料

> 对照 M2W1D1 深化练习：Alias Analysis。

---

## 一、基础资料（必先完成 M2W1D1）

请先阅读 **M2/W1/M2W1D1/ref.md**，掌握：
- Alias Analysis 接口、自定义 AA Pass
- LICM 验证

---

## 二、深化任务所需资料

### 2.1 深化方向

| 资料 | 位置/链接 | 用途 |
|------|-----------|------|
| **Module-level AA** | 跨 Function 的别名分析 | 对调用图敏感 |
| **ModRefInfo** | getModRefInfo 实现 | 区分 Mod/Ref/NoModRef |
| **AA 管线调试** | opt -aa-pipeline -debug | 观察各 AA 的查询与结果 |

### 2.2 可选扩展

- 对特定 intrinsic 或 libcall 返回精确 ModRef
- 与 SCEV 结合：循环内指针的 NoAlias
- 写小结：AA 对实际优化 Pass 的影响

### 2.3 参考

- `llvm/lib/Analysis/` 下高级 AA
- M2W2D1/ref.md 中的 TBAA、SCEV AA

---

## 三、推荐阅读顺序

1. 复习 M2W1D1/ref.md（约 10 分钟）
2. 复习 M2W2D1/ref.md（约 10 分钟）
3. 选一个方向深化实现（约 40 分钟）

---

## 四、代码组织提示

- `lib/`、`tools/`、`test/`

---

*在 M2W1D1、M2W2D1 基础上，按本 ref 完成 Alias Analysis 进一步深化。*
