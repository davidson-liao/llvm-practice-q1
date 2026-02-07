# M2 · 月份二：掌握变换，解决性能瓶颈（核心期）

M2 共 **4 周**，每周 5 个工作日（周一～周五）。

## 目录结构

```
M2/
├── README.md          # 本说明
├── W1/                # 第 1 周（详细计划见「每日拆解」）
│   ├── M2W1D1/        # 周一 · Alias Analysis
│   ├── M2W1D2/        # 周二 · Interface / Verifier / Trait
│   ├── M2W1D3/        # 周三 · Fusion（重点）
│   ├── M2W1D4/        # 周四 · Tiling 与降级
│   └── M2W1D5/        # 周五 · Python 与性能
├── W2/ … W3/ … W4/    # 第 2～4 周（深化 W1 主题）
```

## 每周主题（与 W1 对齐）

| 星期 | 主题 |
|------|------|
| 周一 | LLVM/C++：内存优化、Alias Analysis、自定义 AA Pass |
| 周二 | MLIR：Interface、Verifier、Trait |
| 周三 | Pass/融合：Fusion、Tile-and-Fuse、Slice Analysis |
| 周四 | Tiling 与降级：Linalg→MemRef、one-shot-bufferize、scf.for |
| 周五 | 工程/测试：Python 绑定、自动化性能脚本 |

W2～W4 在 W1 基础上**深化与练习**，每日 `plan.md` 中注明「对照 M2/W1/M2W1Dx」。W4D5 为本月收尾，与 M3（实战期）衔接。

## 在 Cursor 中执行

进入任意一天目录（如 `M2/W4/M2W4D1`），在终端执行：

```bash
cmake -B build
cmake --build build
./build/daytool
ctest --test-dir build
```
