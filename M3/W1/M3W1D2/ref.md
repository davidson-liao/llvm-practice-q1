# M3W1D2 参考资料

> 完成 plan.md 中 Dialect 层级、TypeConverter、Materialization、小管线 Conversion 任务所需的必读资料。

---

## 一、必读官方文档

| 资料 | 链接 | 阅读重点 |
|------|------|----------|
| **Dialect Conversion** | https://mlir.llvm.org/docs/DialectConversion/ | ConversionTarget、TypeConverter、Pattern |
| **Type Converter** | 同上 | 类型映射、Source Materialization |
| **Unrealized Conversion Cast** | MLIR 文档 / 源码 | 桥接未转换使用者、合法化后消除 |
| **Lowering to LLVM** | https://mlir.llvm.org/docs/TargetLLVMIR/ | 多步 Conversion 管线 |

---

## 二、完成「TypeConverter」的关键资料

### 2.1 自定义类型到 MemRef/LLVM

```cpp
class MyTypeConverter : public TypeConverter {
public:
  MyTypeConverter() {
    addConversion([](MyType type) { return type; });
    addConversion([](MemRefType type) { return type; });
    addTargetMaterialization(...);  // 目标类型 → 插入 cast
    addSourceMaterialization(...);  // 源类型 → 插入 cast
  }
};
```

### 2.2 ConversionPattern 与类型转换

- 在 Pattern 的 `matchAndRewrite` 中，操作数/结果可能已是「目标类型」或仍为「源类型」。
- 使用 `getTypeConverter()->convertType(op.getResult(0).getType())` 得到目标类型。
- 若使用者尚未转换，框架会插入 `unrealized_conversion_cast` 桥接。

### 2.3 参考

- `mlir/lib/Conversion/` 下各 ToLLVM、ToGPU 等
- `mlir/include/mlir/Conversion/LLVMCommon/TypeConverter.h`

---

## 三、完成「Materialization」的关键资料

### 3.1 故意制造「使用者尚未转换」场景

- 先只转换部分 Op（如只转换 A、B，不转换使用 A 结果的 C）。
- 观察框架为 A 的结果与 C 的操作数之间插入的 `unrealized_conversion_cast`。
- 全部合法化后：若转换完备，cast 应成对消除；若残留，则报错或需补 Pattern。

### 3.2 关键点

| 概念 | 作用 |
|------|------|
| addTargetMaterialization | 目标类型→源类型时插入 cast（使用者仍期望源类型） |
| addSourceMaterialization | 源类型→目标类型时插入 cast（生产者已产出目标类型） |
| PartialConversion | 允许部分未转换，配合 materialization 逐步合法化 |

---

## 四、完成「小管线」的关键资料

### 4.1 多步 Conversion 示例

```bash
mlir-opt input.mlir \
  -convert-my-dialect-to-memref \
  -convert-memref-to-llvm \
  -convert-func-to-llvm \
  -reconcile-unrealized-casts
```

### 4.2 自定义 Dialect 2～3 个 Op 降到 LLVM

- 为每个 Op 写 `ConversionPattern`：match 原 Op，rewrite 为 LLVM 等价 Op（如 llvm.load、llvm.store、llvm.call）。
- 在 Pass 中注册 `ConversionTarget`（仅保留 LLVM Dialect）、`TypeConverter`、所有 Pattern。
- 用 `applyPartialConversion` 或 `applyFullConversion` 跑通并生成 LLVM IR。

### 4.3 参考

- `mlir/lib/Conversion/FuncToLLVM/`
- `mlir/test/Conversion/`

---

## 五、推荐阅读顺序

1. Dialect Conversion 文档（约 35 分钟）
2. TypeConverter 与 Materialization 小节（约 25 分钟）
3. 选一个现有 Conversion（如 FuncToLLVM）浏览（约 30 分钟）

---

## 六、参考源码位置

- `mlir/include/mlir/Conversion/`
- `mlir/lib/Conversion/`
- `mlir/include/mlir/Conversion/LLVMCommon/TypeConverter.h`

---

*按此资料学习，即可完成 plan.md 中的 TypeConverter、Materialization 观察、小管线 Conversion 任务。*
