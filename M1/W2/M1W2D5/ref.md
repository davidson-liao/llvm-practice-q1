# M1W2D5 参考资料

> 对照 M1W1D5 深化练习：整合 W2 工程、增加 GTest 覆盖、补全 Lit 测试目录。

---

## 一、基础资料（必先完成 M1W1D5）

请先阅读 **M1/W1/M1W1D5/ref.md**，掌握：
- add_mlir_dialect_library、mlir_tablegen 依赖
- GTest 写 C++ 测试
- Lit + FileCheck 配置

---

## 二、深化任务所需资料

### 2.1 整合 W2 代码到同一 CMake 工程

| 资料 | 位置/链接 | 用途 |
|------|-----------|------|
| **MLIR BuildSystem** | https://mlir.llvm.org/docs/BuildSystem/ | 多 Dialect、多库的 add_subdirectory |
| **LLVM 根 CMake** | `llvm/CMakeLists.txt` | 顶层架构、add_subdirectory 顺序 |
| **依赖图** | 确保 tblgen 先于编译 | 避免并发生成 .inc 冲突 |

建议：将 W2 的 Dialect、Pass、工具、测试统一到同一工程，根 CMakeLists 组织子目录。

### 2.2 增加 GTest 覆盖

| 资料 | 位置/链接 | 用途 |
|------|-----------|------|
| **add_llvm_unittest** | LLVM CMake 模块 | 注册 C++ 单元测试 |
| **gtest_discover_tests** | CMake 3.10+ | 自动发现 TEST 宏 |
| **mlir/unittests/** | `mlir/unittests/` | 参考测试结构与依赖 |

建议：为 W2 的 Canonicalizer、Pattern、Type/Attribute 各写 1～2 个 GTest。

### 2.3 补全 Lit 测试目录

| 资料 | 位置/链接 | 用途 |
|------|-----------|------|
| **lit.cfg.py** | LLVM/MLIR 的 test/ | 配置 suffixes、test_format、子目录 |
| **add_lit_testsuite** | LLVM CMake | 将 Lit 集成到 ninja check |
| **mlir/test/** | `mlir/test/` | 目录结构、RUN 行格式 |

建议：`test/Dialect/MyDialect/` 下按功能分子目录（canonicalize、type、parser 等），每个目录有 lit.cfg.py 或继承根配置。

---

## 三、推荐阅读顺序

1. 复习 M1W1D5/ref.md（约 10 分钟）
2. MLIR BuildSystem 多库整合（约 20 分钟）
3. 浏览 `mlir/test/` 与 `mlir/unittests/` 的 CMake 与目录结构（约 25 分钟）
4. 动手整合并跑通 `ninja check`（实践）

---

## 四、验收清单

- [ ] 根 CMakeLists 能正确构建 W2 所有子目录
- [ ] `ninja check` 或 `ctest` 能跑 Lit 与 GTest
- [ ] GTest 覆盖 Canonicalizer / Pattern / Type 至少各一个
- [ ] Lit 测试覆盖本周主要 Dialect 功能

---

*在 M1W1D5 基础上，按本 ref 完成 W2 工程整合、GTest 覆盖、Lit 测试补全。*
