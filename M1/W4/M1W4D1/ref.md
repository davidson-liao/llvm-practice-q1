# M1W4D1 参考资料

> 对照 M1W1D1：本月最后一周，LLVM/C++ 小结或综合练习。

---

## 一、基础资料（必先完成 W1～W3）

请先阅读 **M1/W1/M1W1D1/ref.md**、**M1/W2/M1W2D1/ref.md**、**M1/W3/M1W3D1/ref.md**，掌握：
- isa/cast/dyn_cast、IRBuilder、Phi
- 遍历 Module/Function、带循环 IR、JIT、CFG 分析

---

## 二、综合练习建议

### 2.1 小结方向

| 主题 | 资料 | 建议输出 |
|------|------|----------|
| **isa/cast/dyn_cast** | Programmer's Manual | 写一段对比正确/错误用法的笔记 |
| **IR 生成** | Kaleidoscope | 总结 max/abs/循环的 IR 结构 |
| **Pass 框架** | WritingAnLLVMPass | 总结 Pass 注册与运行流程 |
| **JIT/CFG** | 前三周实践 | 总结 JIT 调用链、CFG 遍历要点 |

### 2.2 综合练习方向

- **小型分析工具**：遍历 Module，统计指令类型、BasicBlock 数量、CFG 特征，输出报告
- **IR 生成器**：支持简单表达式（含 if/loop）到 LLVM IR，并用 JIT 执行验证
- **与 M2 衔接**：预习 Alias Analysis 文档，理解为何 M2 要学 AA

### 2.3 参考资料

- LLVM Programmer's Manual（总览）
- Kaleidoscope 教程 1～9 章（可快速过一遍）
- https://llvm.org/docs/AliasAnalysis.html（M2 预热）

---

## 三、推荐阅读顺序

1. 回顾 W1～W3 的 ref.md 与代码（约 20 分钟）
2. 选一个「小结」或「综合练习」方向动手（约 60 分钟）
3. 若有时间：浏览 Alias Analysis 文档（约 15 分钟）

---

## 四、代码组织

- `lib/`、`tools/`：综合工具或小结 demo
- `test/`：验证用例
- 小结可写在 `README.md` 或项目根目录文档

---

*完成本月 LLVM/C++ 小结，为 M2 做准备。*
