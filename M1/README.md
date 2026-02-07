# M1 · 月份一：夯实底层，建立编译器直觉（基建期）

M1 共 **4 周**，每周 5 个工作日（周一～周五）。

## 目录结构

```
M1/
├── README.md          # 本说明
├── W1/                # 第 1 周（详细计划见「每日拆解」）
│   ├── M1W1D1/        # 周一 · LLVM/C++
│   ├── M1W1D2/        # 周二 · MLIR ODS
│   ├── M1W1D3/        # 周三 · Pass/融合基础
│   ├── M1W1D4/        # 周四 · 向量化/硬件
│   └── M1W1D5/        # 周五 · 工程/测试
├── W2/                # 第 2 周（深化 W1 主题）
│   ├── M1W2D1/ … M1W2D5/
├── W3/                # 第 3 周（深化）
│   ├── M1W3D1/ … M1W3D5/
└── W4/                # 第 4 周（深化 / 收尾）
    ├── M1W4D1/ … M1W4D5/
```

## 每周主题（与 W1 对齐）

| 星期 | 主题 |
|------|------|
| 周一 | LLVM/C++：基础架构、isa/cast、手写 IR |
| 周二 | MLIR ODS：TableGen、自定义 Op、Attribute/Type |
| 周三 | Pass/融合基础：Canonicalization、PatternRewrite、DRR |
| 周四 | 向量化/硬件：Intel SIMD、Vector 方言、transfer_read/write |
| 周五 | 工程/测试：CMake、GTest、Lit+FileCheck |

W2～W4 在 W1 基础上**深化与练习**，每日 `plan.md` 中注明「对照 M1/W1/M1WxDx」。

## 在 Cursor 中执行

进入任意一天目录（如 `M1/W1/M1W1D1`），在终端执行：

```bash
cmake -B build
cmake --build build
./build/daytool
ctest --test-dir build
```
