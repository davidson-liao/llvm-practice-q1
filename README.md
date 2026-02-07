# 三月编译器学习计划（LLVM/MLIR）

三个月、按周按日拆解的 LLVM/MLIR 学习工程：M1 基建期 → M2 核心期 → M3 实战期。每个工作日独立目录，可在 Cursor 中直接打开并构建。

---

## 目录结构

```
llvm-q1/
├── README.md                    # 本说明 + 有效 AI 提示词
├── 三月编译器学习计划-每日拆解.md   # 全量每日计划
├── 三月编译器学习大纲.md
├── M1/  README.md, W1..W4/  M1W1D1..M1W4D5/   # 月份一：基建期
├── M2/  README.md, W1..W4/  M2W1D1..M2W4D5/   # 月份二：核心期
└── M3/  README.md, W1..W4/  M3W1D1..M3W4D5/   # 月份三：实战期
```

每日目录（如 `M1/W1/M1W1D1`）含：`CMakeLists.txt`、`include/`、`lib/`、`tools/`、`test/`、`README.md`、`plan.md`，部分含 `ref.md`。

---

## 在 Cursor 中执行

进入任意一天目录后：

```bash
cmake -B build
cmake --build build
./build/daytool
ctest --test-dir build
```

---

## 有效的 AI 提示词

在 Cursor（或其它 AI 助手）中可直接复用的提示词，便于按计划推进并保持代码结构一致。

### 1. 按当日计划实现任务

- **「按 @llvm-q1/M1/W1/M1W1D1/plan.md 和 ref.md 帮我实现今天的代码任务，代码放在该目录的 lib/、tools/、test/ 里。」**
- **「参照 M2W1D3 的 plan.md 里「需要写的代码」三条，依次实现：Linalg 融合对比、Slice 推导、tile-and-fuse 应用；并写 FileCheck 验证。」**
- **「按 M3W1D5 的 plan.md 实现 Conv+Add+ReLU 迷你图与全链路验收，输出验收清单。」**

### 2. LLVM/MLIR 概念与写法

- **「解释 LLVM 里 isa、cast、dyn_cast 的区别；为什么不要先 isa 再 cast，而应直接用 dyn_cast？给一段正确/错误对比代码。」**
- **「在 MLIR 里写一个 Canonicalization Pattern：匹配 addi x, 0 或 muli x, 1，重写为 x。用 C++ RewritePattern 或 DRR 都可以。」**
- **「MLIR 的 One-Shot Bufferization 如何检测 RaW 冲突？什么情况下会插入 copy？用一小段 Linalg IR 举例。」**
- **「gpu.launch 和 gpu.thread_id 在 MLIR 里怎么用？写一段最小 kernel：用 thread_id 做线性索引并做一次 arith.addf。」**

### 3. 工程与构建

- **「按 M1W1D1 的 ref.md 里「可复制的 LLVM 构建与链接」CMake 片段，把当前目录配置成可链接 LLVM 的工程，库放 lib/，入口放 tools/main.cpp。」**
- **「当前目录是 MLIR Dialect 工程，需要 add_mlir_dialect_library 和 mlir_tablegen；请按 ref.md 或 M1W1D2 的约定补全 CMakeLists.txt，保证 .inc 先生成再编译。」**
- **「为当前目录写一个 Lit 测试：输入 .mlir，跑 canonicalize，用 FileCheck 检查某条指令被消掉或替换。」**

### 4. 代码放在哪

- **「按本目录 ref.md 的「代码组织提示」放代码：lib/ 放 Pass 或 Dialect 实现，tools/ 放可执行入口，test/ 放 .mlir 或 .ll 用例和 FileCheck。」**
- **「今天任务是 Python 绑定 + 性能脚本：脚本放 tools/，输入/预期输出放 test/，按 M2W1D5 的 ref.md 组织。」**

### 5. 对照与深化

- **「本周是 M1 第 2 周，对照 M1/W1/M1W1D2 的 plan.md 深化：在已有 Dialect 上增加一个 Op 和自定义 Attribute，并写 Verifier。」**
- **「对照 M2/W1/M2W1D4 的 plan.md，实现从 linalg (tensor) 到 scf.for + memref 的降级管线，用 FileCheck 检查关键步骤。」**

### 6. 文档与验收

- **「根据 plan.md 的「需要写的代码」和 ref.md 的推荐阅读顺序，给当前目录写一个简短的 ref.md，包含：必读文档链接、关键 API/步骤、代码组织提示。」**
- **「按 M3W1D5 的 plan.md 写验收清单：每个阶段用的 Pass、输入/输出方言、如何验证数值正确、如何测性能。」**

---

## 使用建议

- 问具体某天时，用 **`@llvm-q1/Mx/Wy/MxWyDz`** 或 **`@llvm-q1/Mx/Wy/MxWyDz/plan.md`** 引用该目录或文件，AI 会结合 plan/ref 回答。
- 实现代码时说明 **「代码放在当前打开的 MxWyDz 目录的 lib/、tools/、test/」**，便于与现有结构一致。
- 全量每日计划见 **[三月编译器学习计划-每日拆解.md](./三月编译器学习计划-每日拆解.md)**；各月总览见 **M1/README.md、M2/README.md、M3/README.md**。
