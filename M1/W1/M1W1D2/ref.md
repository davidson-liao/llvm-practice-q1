# M1W1D2 参考资料

> 完成 plan.md 中 ODS、Attribute、Type 任务所需的必读资料与代码参考。

---

## 一、必读官方文档

| 资料 | 链接 | 阅读重点 |
|------|------|----------|
| **Defining Dialects** | https://mlir.llvm.org/docs/DefiningDialects/ | Dialect 定义、cppNamespace、initialize |
| **Operation Definition Specification (ODS)** | https://mlir.llvm.org/docs/DefiningDialects/Operations/ | def、class、Operand、Attribute、Result、Traits |
| **Defining Dialect Attributes and Types** | https://mlir.llvm.org/docs/DefiningDialects/AttributesAndTypes/ | Storage 类、Uniquer、自定义 Attribute/Type |
| **TableGen 语言参考** | https://llvm.org/docs/TableGen/ | def、class、dag、list、继承 |
| **Creating a Dialect 教程** | https://mlir.llvm.org/docs/Tutorials/CreatingADialect/ | 完整从零创建 Dialect 流程 |

---

## 二、完成「ODS 定义 2～3 个 Op」的关键资料

### 2.1 最小 Op 模板

```tablegen
def MyAddOp : MyDialect_Op<"add"> {
  let summary = "Add two values";
  let arguments = (ins AnyType:$lhs, AnyType:$rhs);
  let results = (outs AnyType:$result);
  let traits = [Commutative, NoSideEffect];
}
```

### 2.2 Operand / Attribute / Result 语法

- **Operand**：`ins F32Tensor:$input`、`ins I32Attr:$dim`
- **Attribute**：`IntegerAttr`、`StringAttr`、`DenseElementsAttr`
- **Result**：`outs F32Tensor:$output`
- **Traits**：`NoSideEffect`、`Commutative`、`SameOperandsAndResultType`

### 2.3 C++ Verifier 嵌入方式

```tablegen
def MyOp : MyDialect_Op<"foo"> {
  // ...
  let hasVerifier = 1;
}
```

在 `MyOp.cpp` 中实现 `LogicalResult MyOp::verify()`。

### 2.4 参考 Dialect 示例

- `mlir/include/mlir/Dialect/Arithmetic/IR/` — 简单算术 Op
- `mlir/include/mlir/Dialect/Linalg/IR/` — 复杂 Operand、Attribute
- `mlir/examples/toy/` — Toy 教程中的 Dialect 定义

---

## 三、完成「自定义 Attribute/Type」的关键资料

### 3.1 自定义 Attribute 的 Storage 模式

```cpp
struct MyRangeAttrStorage : public AttributeStorage {
  using KeyTy = std::pair<int64_t, int64_t>;
  MyRangeAttrStorage(int64_t lo, int64_t hi) : lo(lo), hi(hi) {}
  bool operator==(const KeyTy &key) const { return key == KeyTy(lo, hi); }
  static MyRangeAttrStorage *construct(AttributeStorageAllocator &allocator,
                                       const KeyTy &key) {
    return new (allocator.allocate<MyRangeAttrStorage>()) MyRangeAttrStorage(key.first, key.second);
  }
  int64_t lo, hi;
};
```

### 3.2 自定义 Type 的 Storage 与 Uniquer

- 参考：`Defining Dialect Attributes and Types` 中 Type 小节
- 关键：继承 `TypeStorage`、实现 `KeyTy`、`construct`、`operator==`
- 在 Dialect 的 `initialize()` 中注册 `addTypes<MyType>()`

### 3.3 参考实现位置

- `mlir/include/mlir/IR/BuiltinAttributes.td` — IntegerAttr、StringAttr 等
- `mlir/include/mlir/IR/BuiltinTypes.td` — 内置类型
- `mlir/lib/IR/BuiltinAttributes.cpp` — Storage 实现

---

## 四、CMake 构建 ODS

```cmake
set(LLVM_TARGET_DEFINITIONS MyOps.td)
mlir_tablegen(MyOps.h.inc -gen-op-decls)
mlir_tablegen(MyOps.cpp.inc -gen-op-defs)
add_mlir_dialect_library(MyDialect MyOps.cpp.inc
  DEPENDS MyOps.h.inc)
```

确保 `mlir_tablegen` 在编译前完成，`.inc` 生成顺序正确。

---

## 五、推荐阅读顺序

1. Creating a Dialect 教程（约 45 分钟）
2. ODS 文档中 Operand/Attribute/Result、Traits（约 30 分钟）
3. AttributesAndTypes 文档（约 30 分钟）
4. 浏览 `Arithmetic` 或 `Tensor` Dialect 的 .td 文件（约 20 分钟）

---

*按此资料学习，即可完成 plan.md 中的 TableGen/ODS 与 Attribute/Type 两项任务。*
