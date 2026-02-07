# M2W1D5 参考资料

> 完成 plan.md 中 Python 建 IR、自动化性能脚本、与 GTest 联动任务所需的必读资料。

---

## 一、必读官方文档

| 资料 | 链接 | 阅读重点 |
|------|------|----------|
| **MLIR C API** | https://mlir.llvm.org/docs/CAPI/ | MLIR 的 C 接口、从 Python 调用 |
| **Python Bindings** | llvm-project 中 `mlir/python/` | pybind11/nanobind 封装 |
| **MLIR Python 示例** | `mlir/examples/python/` | 构建 Module、跑 Pass |
| **numpy 集成** | 若需数值对比 | ndarray ↔ MemRef |

---

## 二、完成「Python 建 IR」的关键资料

### 2.1 环境与构建

- MLIR 需启用 `MLIR_ENABLE_BINDINGS_PYTHON`
- 或使用预编译的 MLIR Python 包（若存在）
- 参考：`mlir/python/CMakeLists.txt`、`mlir/examples/python/`

### 2.2 基本流程

```python
import mlir.ir as ir
import mlir.passmanager as pm

with ir.Context() as ctx:
    # 注册 Dialect
    # 构建 Module、添加 Op
    module = ir.Module.create()
    with ir.InsertionPoint(module.body):
        # 创建 func、linalg op 等
        pass
    # 跑 Pass
    pm.PassManager.parse("canonicalize").run(module)
    print(module)
```

### 2.3 参考

- `mlir/examples/python/` 中的示例
- MLIR C API 文档中 Module、Operation、Block 等

---

## 三、完成「自动化性能脚本」的关键资料

### 3.1 脚本结构

- 循环规模：64, 128, 256, 512, 1024
- 每轮：生成 .mlir（或参数化模板）→ 跑 mlir-opt 管线 → 执行（或编译+运行）→ 计时
- 输出：CSV 或 Markdown 表格

### 3.2 子进程调用

```python
import subprocess
import time

for n in [64, 128, 256, 512, 1024]:
    # 生成 input.mlir
    start = time.perf_counter()
    subprocess.run(["mlir-opt", "input.mlir", "-one-shot-bufferize", ...])
    elapsed = time.perf_counter() - start
    print(f"{n},{elapsed}")
```

### 3.3 参考

- Python `timeit`、`time.perf_counter`
- `perf stat` 获取更详细硬件计数

---

## 四、完成「与 GTest 联动」的关键资料

### 4.1 思路

- C++ 管线：读 .mlir → 跑 Pass → 输出 IR 或执行结果
- Python 管线：同一 .mlir、同一参数
- 对比：IR 关键 Op 一致，或数值结果一致

### 4.2 实现方式

- GTest 调用 C++ 管线，输出到临时文件
- Python 脚本调用 Python 管线，输出到另一临时文件
- 用 `diff` 或解析后逐项比较

---

## 五、推荐阅读顺序

1. MLIR C API 概览（约 20 分钟）
2. `mlir/examples/python/` 浏览（约 30 分钟）
3. 写一个最小 Python 建 IR 脚本（约 40 分钟）
4. 性能脚本框架（约 30 分钟）

---

## 六、注意点

- MLIR Python 绑定可能随版本变化，以当前 llvm-project 为准
- 若无法构建 Python 绑定，可用 `subprocess` 调用 `mlir-opt` 作为替代

---

*按此资料学习，即可完成 plan.md 中的 Python 建 IR、性能脚本、GTest 联动任务。*
