# M1 · 月份一：夯实底层，建立编译器直觉（基建期）

M1 共 **4 周**，每周 5 个工作日（周一～周五）。一周一个目录，`plan.md` 按天分节。

## 目录结构

```
M1/
├── README.md
├── W1/                # 第 1 周（含 CMake、tools、lib）
│   ├── CMakeLists.txt
│   ├── plan.md
│   ├── README.md
│   ├── tools/
│   └── lib/
├── W2/ … W4/         # 第 2～4 周（plan.md + README.md）
│   ├── plan.md
│   └── README.md
```

## 每周主题（与 W1 对齐）

| 星期 | 主题 |
|------|------|
| 周一 | LLVM/C++：基础架构、isa/cast、手写 IR |
| 周二 | MLIR ODS：TableGen、自定义 Op、Attribute/Type |
| 周三 | Pass/融合基础：Canonicalization、PatternRewrite、DRR |
| 周四 | 向量化/硬件：Intel SIMD、Vector 方言、transfer_read/write |
| 周五 | 工程/测试：CMake、GTest、Lit+FileCheck |

W2～W4 在 W1 基础上**深化与练习**，详见各周 `plan.md`。
