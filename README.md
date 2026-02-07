# 三月编译器学习计划（LLVM/MLIR）

三个月、按周按日拆解的 LLVM/MLIR 学习工程：M1 基建期 → M2 核心期 → M3 实战期。**一周一个目录**，`plan.md` 按天分节。

---

## 目录结构

```
llvm-practice-q1/
├── README.md
├── 三月编译器学习计划-每日拆解.md
├── 三月编译器学习大纲.md
├── M1/  W1..W4/  plan.md + README.md  # 月份一：基建期（M1W1 含 CMake/tools/lib）
├── M2/  W1..W4/  plan.md + README.md  # 月份二：核心期
└── M3/  W1..W4/  plan.md + README.md  # 月份三：实战期
```

每周目录含：`plan.md`（按天分节）、`README.md`。M1/W1 含完整 CMake 工程（tools/、lib/）。

---

## 在 Cursor 中执行

M1/W1 已配置 CMake 工程：

```bash
cd M1/W1
cmake -B build -DLLVM_DIR=/path/to/llvm-build/lib/cmake/llvm
cmake --build build
./build/daytool_d1
```

---

## 有效的 AI 提示词

在 Cursor（或其它 AI 助手）中可直接复用的提示词，便于按计划推进并保持代码结构一致。

### 1. 按当日计划实现任务

- **「按 M1/W1/plan.md 的 D1 帮我实现今天的代码任务，代码放在 M1/W1 的 lib/、tools/、test/ 里。」**
- **「参照 M2/W1/plan.md 的 D3，依次实现：Linalg 融合对比、Slice 推导、tile-and-fuse 应用；并写 FileCheck 验证。」**
- **「按 M3/W1/plan.md 的 D5 实现 Conv+Add+ReLU 迷你图与全链路验收，输出验收清单。」**

### 2. LLVM/MLIR 概念与写法

- **「解释 LLVM 里 isa、cast、dyn_cast 的区别；为什么不要先 isa 再 cast，而应直接用 dyn_cast？给一段正确/错误对比代码。」**
- **「在 MLIR 里写一个 Canonicalization Pattern：匹配 addi x, 0 或 muli x, 1，重写为 x。用 C++ RewritePattern 或 DRR 都可以。」**
- **「MLIR 的 One-Shot Bufferization 如何检测 RaW 冲突？什么情况下会插入 copy？用一小段 Linalg IR 举例。」**
- **「gpu.launch 和 gpu.thread_id 在 MLIR 里怎么用？写一段最小 kernel：用 thread_id 做线性索引并做一次 arith.addf。」**

### 3. 工程与构建

- **「按 M1/W1 的 CMakeLists.txt，把当前周目录配置成可链接 LLVM 的工程，库放 lib/，入口放 tools/。」**
- **「当前目录是 MLIR Dialect 工程，需要 add_mlir_dialect_library 和 mlir_tablegen；请按 ref.md 或 M1W1D2 的约定补全 CMakeLists.txt，保证 .inc 先生成再编译。」**
- **「为当前目录写一个 Lit 测试：输入 .mlir，跑 canonicalize，用 FileCheck 检查某条指令被消掉或替换。」**

### 4. 代码放在哪

- **「按 M1/W1 结构放代码：lib/ 放 Pass 或 Dialect 实现，tools/ 放可执行入口，test/ 放 .mlir 或 .ll 用例和 FileCheck。」**
- **「今天任务是 Python 绑定 + 性能脚本：脚本放 tools/，输入/预期输出放 test/，按 M2/W1/plan.md 的 D5 组织。」**

### 5. 对照与深化

- **「本周是 M1 第 2 周，对照 M1/W1/plan.md 的 D2 深化：在已有 Dialect 上增加一个 Op 和自定义 Attribute，并写 Verifier。」**
- **「对照 M2/W1/plan.md 的 D4，实现从 linalg (tensor) 到 scf.for + memref 的降级管线，用 FileCheck 检查关键步骤。」**

### 6. 文档与验收

- **「根据 plan.md 的「需要写的代码」给当前周目录写一个简短的 ref.md，包含：必读文档链接、关键 API/步骤。」**
- **「按 M3/W1/plan.md 的 D5 写验收清单：每个阶段用的 Pass、输入/输出方言、如何验证数值正确、如何测性能。」**

---

## 使用建议

- 问具体某周时，用 **`Mx/Wy/plan.md`** 引用该周计划，AI 会结合 plan 回答。
- 实现代码时说明 **「代码放在 M1/W1 的 lib/、tools/、test/」**（或其他周目录），便于与现有结构一致。
- 全量每日计划见 **[三月编译器学习计划-每日拆解.md](./三月编译器学习计划-每日拆解.md)**；各月总览见 **M1/README.md、M2/README.md、M3/README.md**。
