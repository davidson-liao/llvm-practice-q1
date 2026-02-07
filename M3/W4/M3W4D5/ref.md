# M3W4D5 参考资料

> 对照 M3W1D5 深化练习：Conv+Add+ReLU 全链路、验收清单。三月计划收尾。

---

## 一、基础资料（必先完成 M3W1D5）

请先阅读 **M3/W1/M3W1D5/ref.md**，掌握：
- 迷你算子图、Fusion + Tiling + One-Shot Bufferize
- Codegen（CPU/GPU）、运行与验证
- 验收清单（Pass、验证、性能）

---

## 二、深化任务所需资料

### 2.1 三月收尾与综合

| 资料 | 位置/链接 | 用途 |
|------|-----------|------|
| **三月大纲第三部分** | 三月编译器学习大纲.md | 3.5 终极验收、端到端迷你算子图 |
| **全链路串联** | 已学 M3W1～W4 | 建图→优化→Bufferize→Codegen→运行 |
| **验收清单与文档** | M3W1D5 模板 | 每阶段 Pass、验证、性能 |

### 2.2 收尾建议

- 完成 Conv+Add+ReLU（或等价图）的完整管线：建图 → Fusion → Tiling → One-Shot Bufferize → Codegen（CPU 或 GPU）→ 运行并验证数值
- 文档化：每阶段 Pass、输入/输出方言、验证方式、性能测量（可选）
- 可选：CI 中跑全链路 + 数值 diff、性能回归

### 2.3 参考

- `mlir/test/Integration/`、IREE 端到端教程
- M3W1D5～M3W3D5 的 ref 与代码

---

## 三、推荐阅读顺序

1. 复习 M3W1D5/ref.md 与 M3W2D5、M3W3D5/ref.md（约 15 分钟）
2. 三月大纲 3.5 与结论回顾（约 20 分钟）
3. 全链路收尾与验收清单完善（约 50 分钟）

---

## 四、代码组织提示

- `lib/`：共享 Pass 或工具
- `tools/`：全链路脚本、性能跑分、验收脚本
- `test/`：集成测试、FileCheck、Lit 配置

---

*在 M3W1D5 基础上，按本 ref 完成三月计划收尾与终极验收。*
