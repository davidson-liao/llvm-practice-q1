# M3W2D5 参考资料

> 对照 M3W1D5 深化练习：Conv+Add+ReLU 全链路、验收清单。

---

## 一、基础资料（必先完成 M3W1D5）

请先阅读 **M3/W1/M3W1D5/ref.md**，掌握：
- 迷你算子图（Conv2D + BiasAdd + ReLU）、优化管线
- Fusion + Tiling + One-Shot Bufferize、Codegen 与运行
- 验收清单（Pass、验证、性能）

---

## 二、深化任务所需资料

### 2.1 深化全链路

| 资料 | 位置/链接 | 用途 |
|------|-----------|------|
| **多规模/多配置** | 不同 N/C/H/W、tile size | 验证正确性 + 性能曲线 |
| **CPU 与 GPU 双路径** | 同一图跑 CPU 与 GPU | 数值一致、性能对比 |
| **Lit/FileCheck 自动化** | test 目录 | 每阶段 IR 的回归测试 |

### 2.2 深化验收

- 文档化：每阶段 Pass 列表、输入/输出方言、验证方式
- 性能：GFLOPS 或带宽、与 baseline 对比
- 可选：CI 中跑全链路 + 数值 diff

### 2.3 参考

- `mlir/test/Integration/` 完整示例
- IREE 端到端教程

---

## 三、推荐阅读顺序

1. 复习 M3W1D5/ref.md（约 10 分钟）
2. 扩展图规模或增加算子（约 40 分钟）
3. 完善验收清单与自动化测试（约 30 分钟）

---

## 四、代码组织提示

- `lib/`：若有共享 Pass 或工具
- `tools/`：全链路脚本、性能跑分脚本
- `test/`：集成测试、FileCheck、Lit 配置

---

*在 M3W1D5 基础上，按本 ref 完成全链路与验收深化任务。*
