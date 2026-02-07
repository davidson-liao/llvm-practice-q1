# M2W2D5 参考资料

> 对照 M2W1D5 深化练习：Python 绑定、性能脚本。

---

## 一、基础资料（必先完成 M2W1D5）

请先阅读 **M2/W1/M2W1D5/ref.md**，掌握：
- MLIR Python 绑定、C API
- Python 建 IR、跑 Pass
- 自动化性能脚本、与 GTest 联动

---

## 二、深化任务所需资料

### 2.1 深化 Python 绑定

| 资料 | 位置/链接 | 用途 |
|------|-----------|------|
| **完整 Pass 管线** | Python 中组合多 Pass | 复现 C++ 的 mlir-opt 管线 |
| **自定义 Pass 调用** | 从 Python 调 C++ Pass | 需 C API 暴露 |
| **IR 解析与生成** | 读 .mlir、写 .mlir | 与文件 I/O 结合 |

### 2.2 深化性能脚本

- 多维度参数：矩阵大小、tile size、向量宽度
- 并行跑多组（multiprocessing）
- 绘图：matplotlib 输出曲线

### 2.3 参考

- `mlir/examples/python/` 进阶示例
- Python `subprocess`、`multiprocessing`

---

## 三、推荐阅读顺序

1. 复习 M2W1D5/ref.md（约 10 分钟）
2. 扩展 Python 脚本支持多参数（约 30 分钟）
3. 集成绘图或报告生成（约 20 分钟）

---

## 四、代码组织提示

- `tools/`：Python 脚本
- `test/`：脚本输入、预期输出

---

*在 M2W1D5 基础上，按本 ref 完成 Python 与性能脚本深化任务。*
