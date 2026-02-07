# M1W3D5 参考资料

> 对照 M1W1D5 深化：CMake、GTest、Lit，整合 W3 工程。

---

## 一、基础资料（必先完成 W1D5/W2D5）

请先阅读 **M1/W1/M1W1D5/ref.md** 与 **M1/W2/M1W2D5/ref.md**，掌握：
- add_mlir_dialect_library、mlir_tablegen 依赖
- GTest、Lit + FileCheck、ninja check

---

## 二、深化任务所需资料

### 2.1 整合 W3 工程

| 资料 | 链接/位置 | 用途 |
|------|-----------|------|
| **MLIR BuildSystem** | https://mlir.llvm.org/docs/BuildSystem/ | 多周/多 Dialect 整合 |
| **LLVM/MLIR 根 CMake** | 源码顶层 | 依赖图、add_subdirectory 顺序 |
| **ninja check** | LLVM 文档 | 统一跑所有测试 |

### 2.2 GTest 覆盖

| 资料 | 链接/位置 | 用途 |
|------|-----------|------|
| **add_llvm_unittest** | LLVM CMake | 注册 C++ 测试 |
| **mlir/unittests/** | MLIR 源码 | 测试结构参考 |

建议：为 W3 新增的 JIT、CFG 分析、ODS、Pattern、Vector 各补 GTest。

### 2.3 Lit 补全

| 资料 | 链接/位置 | 用途 |
|------|-----------|------|
| **lit.cfg.py** | LLVM/MLIR test/ | 配置、子目录 |
| **FileCheck 变量** | FileCheck 文档 | 复杂 CHECK 模式 |

---

## 三、推荐阅读顺序

1. 复习 M1W1D5/ref.md、M1W2D5/ref.md（约 10 分钟）
2. 动手整合 W3 各日代码到同一工程（约 40 分钟）
3. 补全 GTest、Lit，跑通 ninja check

---

## 四、验收清单

- [ ] W3 所有子目录可由根 CMake 统一构建
- [ ] ninja check 通过
- [ ] GTest 覆盖本周主要功能
- [ ] Lit 测试覆盖本周 Dialect/Pass/Vector

---

*在 W1/W2 基础上，完成 W3 工程整合与测试补全。*
