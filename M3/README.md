# M3 · 月份三：架构协同，实现模型加速（实战期）

M3 共 **4 周**，每周 5 个工作日（周一～周五）。

## 目录结构

```
M3/
├── README.md          # 本说明
├── W1/                # 第 1 周（详细计划见「每日拆解」）
│   ├── M3W1D1/        # 周一 · 后端 Codegen（ISel、RegAlloc）
│   ├── M3W1D2/        # 周二 · Dialect 层级与 Conversion
│   ├── M3W1D3/        # 周三 · Bufferization（内存瓶颈）
│   ├── M3W1D4/        # 周四 · GPU（SIMT、gpu.launch、Shared Memory）
│   └── M3W1D5/        # 周五 · 终极验收（Conv+Add+ReLU 全链路）
├── W2/ … W3/ … W4/    # 第 2～4 周（深化 W1 主题）
```

## 每周主题（与 W1 对齐）

| 星期 | 主题 |
|------|------|
| 周一 | LLVM/C++：后端 Codegen、ISel、寄存器分配 |
| 周二 | MLIR：Dialect 层级、跨方言 Conversion、TypeConverter |
| 周三 | Pass：Bufferization、One-Shot、RaW、DPS |
| 周四 | GPU：SIMT、gpu.launch、Shared Memory、barrier |
| 周五 | 工程/验收：Conv+Add+ReLU 全链路、验收清单 |

W2～W4 在 W1 基础上**深化与练习**，每日 `plan.md` 中注明「对照 M3/W1/M3W1Dx」。W4D5 为三月计划收尾。

## 在 Cursor 中执行

进入任意一天目录（如 `M3/W4/M3W4D1`），在终端执行：

```bash
cmake -B build
cmake --build build
./build/daytool
ctest --test-dir build
```
