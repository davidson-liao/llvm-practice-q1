# M2W1D2 参考资料

> 完成 plan.md 中 Interface、Verifier、Trait 任务所需的必读资料。

---

## 一、必读官方文档

| 资料 | 链接 | 阅读重点 |
|------|------|----------|
| **Interfaces** | https://mlir.llvm.org/docs/Interfaces/ | OpInterface、Concept-Model、ExternalModel |
| **Traits** | https://mlir.llvm.org/docs/DefiningDialects/Traits/ | NoSideEffect、Commutative、HasFolder |
| **ODS Interfaces** | https://mlir.llvm.org/docs/DefiningDialects/Interfaces/ | 用 TableGen 定义 Interface |
| **ODS Traits** | 同上 Traits 文档 | 在 Op 上声明 Trait |

---

## 二、完成「定义 Interface」的关键资料

### 2.1 OpInterface 定义（TableGen）

```tablegen
def MyFoldable : OpInterface<"MyFoldable"> {
  let description = "Operations that can be folded";
  let methods = [
    InterfaceMethod<"FoldResult", "OpFoldResult",
      (ins "ArrayRef<Attribute>":$operands),
      "fold">,
  ];
}
```

### 2.2 为 Op 实现 Interface

```tablegen
def MyAddOp : MyDialect_Op<"add"> {
  // ...
  let interfaces = [MyFoldable];
}
```

或在 C++ 中用 `ExternalModel` 为已有 Op 添加实现：

```cpp
struct MyAddOpFoldableModel : public MyFoldable::ExternalModel<MyAddOpFoldableModel, MyAddOp> {
  static OpFoldResult fold(MyAddOp op, ArrayRef<Attribute> operands) {
    // 若两个操作数都是常量，返回折叠后的常量
  }
};
```

### 2.3 Pass 中调用 Interface

```cpp
if (auto foldable = dyn_cast<MyFoldable>(op)) {
  if (Optional<OpFoldResult> result = foldable.fold(operands)) {
    rewriter.replaceOp(op, {result->getValue()});
  }
}
```

### 2.4 参考

- `mlir/include/mlir/Interfaces/FoldInterfaces.td`
- `mlir/include/mlir/Dialect/Arithmetic/IR/ArithmeticOps.td`（HasFolder、FoldableOpInterface）

---

## 三、完成「Verifier」的关键资料

### 3.1 ODS 中声明

```tablegen
def MyOp : MyDialect_Op<"foo"> {
  let hasVerifier = 1;
}
```

### 3.2 verify() 实现

```cpp
LogicalResult MyOp::verify() {
  if (getLhs().getType() != getRhs().getType())
    return emitOpError("operand types must match");
  if (getDim() < 0 || getDim() > 2)
    return emitOpError("dim must be in [0, 2]");
  return success();
}
```

### 3.3 故意构造非法 IR 测试

- 写 .mlir 中类型不匹配或属性越界的 Op
- 运行 `mlir-opt`，应得到 verify 错误

---

## 四、完成「Trait」的关键资料

### 4.1 常用 Trait

| Trait | 作用 |
|-------|------|
| NoSideEffect | 无副作用，可被 DCE |
| Commutative | 操作数可交换 |
| HasFolder | 支持 fold，Canonicalize 会调用 |
| SameOperandsAndResultType | 操作数与结果类型相同 |

### 4.2 给 Op 加 Trait

```tablegen
def MyAddOp : MyDialect_Op<"add"> {
  let traits = [Commutative, NoSideEffect, HasFolder];
}
```

### 4.3 观察 Canonicalize 行为

- 有 `HasFolder` 且实现了 `fold()`，Canonicalize 会自动应用
- 必要时补 DRR（如 add x,0 -> x）配合

---

## 五、Interface 与 Trait 的区别

| 维度 | Interface | Trait |
|------|-----------|-------|
| 形式 | 可查询方法（getOpInterface<>） | 声明式属性 |
| 用途 | Pass 多态操作多种 Op | Canonicalize、DCE 等自动化 |
| 定义 | 有方法签名 | 纯声明 |

---

## 六、推荐阅读顺序

1. Interfaces 文档（约 35 分钟）
2. Traits 文档（约 20 分钟）
3. Arithmetic/Linalg 中 Interface、Trait 用法（约 25 分钟）

---

## 七、参考源码位置

- `mlir/include/mlir/Interfaces/`
- `mlir/include/mlir/Dialect/Arithmetic/IR/ArithmeticOps.td`
- `mlir/include/mlir/Dialect/Linalg/IR/LinalgOps.td`

---

*按此资料学习，即可完成 plan.md 中的 Interface、Verifier、Trait 三项任务。*
