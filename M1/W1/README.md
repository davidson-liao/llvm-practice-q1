# M1W1 · 第 1 周 · 基建期

一周一个 CMake 工程（扁平结构）：定义 daytool_d1～daytool_d5 等目标。

## 目录结构

```
M1/W1/
├── CMakeLists.txt       # daytool_d1, daytool_d2, ... 等目标
├── tools/
│   ├── d1_main.cpp
│   ├── d2_main.cpp
│   └── ...
├── lib/
└── plan.md              # 按天分节
```

## 构建与运行

```bash
# 进入 M1/W1/
cd M1/W1

# 若使用自编译 LLVM
cmake -B build -DLLVM_DIR=/path/to/llvm-build/lib/cmake/llvm
cmake --build build

# 运行
./build/daytool_d1
./build/daytool_d2
# ...
```

## 每周主题

| 天 | 主题 |
|----|------|
| D1 | LLVM/C++：isa/cast、手写 IR |
| D2 | MLIR ODS：TableGen、自定义 Op |
| D3 | Pass/融合：Canonicalization、DRR |
| D4 | 向量化/硬件：Vector、transfer_read/write |
| D5 | 工程/测试：CMake、GTest、Lit |
