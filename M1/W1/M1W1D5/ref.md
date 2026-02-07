# M1W1D5 参考资料

> 完成 plan.md 中 CMake 整理、GTest、Lit+FileCheck、性能基准任务所需的必读资料。

---

## 一、必读官方文档

| 资料 | 链接 | 阅读重点 |
|------|------|----------|
| **MLIR CMake 构建** | https://mlir.llvm.org/docs/BuildSystem/ | add_mlir_dialect_library、mlir_tablegen 依赖 |
| **LLVM Testing Guide** | https://llvm.org/docs/TestingGuide.html | Lit、FileCheck、ctest |
| **Google Test 文档** | https://google.github.io/googletest/ | ASSERT_*、EXPECT_*、TEST |
| **LLVM GTest 集成** | LLVM 源码中 unittest/ | add_unittest、gtest_discover_tests |

---

## 二、完成「CMake 整理」的关键资料

### 2.1 mlir_tablegen 依赖顺序

```cmake
add_custom_command(OUTPUT MyOps.h.inc
  COMMAND mlir-tblgen ...
  DEPENDS MyOps.td)
add_custom_target(MyOpsInc DEPENDS MyOps.h.inc)
add_dependencies(MyDialect MyOpsInc)
```

确保编译 Dialect 前 `.inc` 已生成，避免并发竞争。

### 2.2 add_mlir_dialect_library 示例

```cmake
add_mlir_dialect_library(MyDialect
  MyOps.cpp MyTypes.cpp
  ADDITIONAL_HEADER_DIRS ${CMAKE_CURRENT_SOURCE_DIR}/../include
  DEPENDS MyDialectInc)
```

### 2.3 支持 ninja check / ctest

- 在项目根或 test 目录添加 `lit.cfg.py`
- `add_lit_testsuite()` 或 `add_subdirectory(test)` 配置 Lit
- 运行 `ninja check` 触发 Lit 测试

### 2.4 参考

- `mlir/CMakeLists.txt`、`mlir/lib/Dialect/.../CMakeLists.txt`
- https://mlir.llvm.org/docs/BuildSystem/

---

## 三、完成「GTest」的关键资料

### 3.1 最小测试结构

```cpp
#include "gtest/gtest.h"
#include "mlir/IR/MLIRContext.h"
#include "mlir/IR/Builders.h"
// ...

TEST(CanonicalizeTest, AddZeroFolds) {
  MLIRContext context;
  // 构建 Op: addi %x, 0
  // 应用 Pattern
  // EXPECT_EQ(结果, 预期);
}
```

### 3.2 构造 Op / Region

- `OpBuilder`、`ImplicitLocOpBuilder`
- `Block::create()`、`rewriter.create<Op>(...)`
- 参考：`mlir/test/Conversion/`、`mlir/unittests/` 中的 C++ 测试

### 3.3 应用 Pattern 并断言

```cpp
RewritePatternSet patterns(&context);
patterns.add<AddZeroPattern>(&context);
GreedyRewriteConfig config;
LogicalResult result = applyPatternsAndFoldGreedily(op, std::move(patterns), config);
EXPECT_TRUE(succeeded(result));
// 检查 op 是否被替换为预期形式
```

---

## 四、完成「Lit + FileCheck」的关键资料

### 4.1 Lit 测试格式

```mlir
// RUN: mlir-opt %s -canonicalize -split-input-file | FileCheck %s

// CHECK-LABEL: @add_zero
// CHECK: return %arg0
// CHECK-NOT: arith.addi
```

### 4.2 常用 FileCheck  directive

| Directive | 用途 |
|-----------|------|
| `CHECK:` | 必须出现 |
| `CHECK-NOT:` | 必须不出现 |
| `CHECK-LABEL:` | 标签，限制作用域 |
| `CHECK-DAG:` | 无序匹配 |
| `[[VAR]]` | 捕获变量，后续 `[[VAR]]` 可引用 |

### 4.3 参考

- `mlir/test/Dialect/Arithmetic/canonicalize.mlir`
- LLVM Testing Guide 的 Lit、FileCheck 章节

---

## 五、完成「简单性能基准（可选）」的关键资料

### 5.1 思路

- 对固定 .mlir 或 IR，循环 N 次运行 Pass
- 用 `std::chrono` 或 `llvm::Timer` 计时
- 输出平均耗时，作为后续优化对比基线

### 5.2 参考

- `mlir/lib/ExecutionEngine/` 中的 benchmark
- LLVM `opt -time-passes` 输出

---

## 六、推荐阅读顺序

1. MLIR BuildSystem 文档（约 20 分钟）
2. LLVM Testing Guide 的 Lit、FileCheck 部分（约 25 分钟）
3. GTest Primer（约 15 分钟）
4. 浏览 `mlir/test/`、`mlir/unittests/` 的 CMake 与测试结构（约 20 分钟）

---

*按此资料学习，即可完成 plan.md 中的 CMake、GTest、Lit+FileCheck、（可选）性能基准任务。*
