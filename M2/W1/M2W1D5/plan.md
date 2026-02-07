# M2W1D5 学习与代码计划

## 学什么

- MLIR Python 绑定：C-API 封装、用 Python 构建 IR、跑 Pass、查看结果。
- 脚本自动化：不同输入规模（矩阵大小、向量长度）下跑同一管线，收集时间/吞吐。

## 需要工具

| 工具 | 用途 |
|------|------|
| MLIR C-API、Python bindings（pybind11/nanobind） | 从 Python 调 MLIR |
| Python 3、numpy（若做数值对比） | 脚本与数据 |
| 计时工具（time、perf 或 Python timeit） | 性能数据 |

## 需要写的代码

1. **Python 建 IR**
   - 用 Python 绑定创建一个简单 Module：几个 Linalg 或自定义 Dialect 的 Op，跑一次 canonicalize 或自定义 Pass，并打印 IR 或检查关键 Op。
2. **自动化性能脚本**
   - 写脚本：对矩阵乘法或向量加，规模从 64 到 1024 变化，每次生成 .mlir、跑 mlir-opt 管线、执行（或生成并跑 LLVM），记录时间并输出 CSV 或表格。
3. **与 GTest 联动**
   - 若有 C++ 跑通管线，在 Python 里用同一份 .mlir 或同一参数，对比 C++ 与 Python 路径的结果（IR 或数值）一致。
