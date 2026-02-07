# M3W1D3 参考资料

> 完成 plan.md 中 One-Shot Bufferization 观察、RaW 冲突、DPS、可选 BufferizableOpInterface 任务所需的必读资料。

---

## 一、必读官方文档

| 资料 | 链接 | 阅读重点 |
|------|------|----------|
| **Bufferization** | https://mlir.llvm.org/docs/Bufferization/ | One-Shot、RaW、DPS、接口 |
| **One-Shot Bufferize** | 同上 #what-is-one-shot-bufferize | 全局分析、Use-Def、冲突检测 |
| **RaW 冲突与 Copy** | 同上 #how-to-resolve-conflicts | 何时插入 alloc+copy |
| **BufferizableOpInterface** | 源码 / 文档 | 为自定义 Op 参与 One-Shot |

---

## 二、完成「观察 One-Shot」的关键资料

### 2.1 两段 Linalg IR 对比

**可原位（elementwise 写回输入）：**

```mlir
%0 = linalg.generic ins(%arg0 : tensor<?xf32>) outs(%arg0 : tensor<?xf32>) { ... }
// 或 DPS 风格 outs 与某输入复用
```

**有 RaW 依赖：**

```mlir
%0 = some.op %a
use(%0)   // 读
write(%0) // 写：若写回 %0 的 buffer，则 use 读到的是旧值，冲突
```

### 2.2 运行与观察

```bash
mlir-opt -one-shot-bufferize input.mlir
```

- 可原位：alloc 少、无多余 copy。
- 有 RaW：One-Shot 插入 copy（或额外 alloc）破除依赖；用 FileCheck 数 alloc/copy。

### 2.3 参考

- `mlir/test/Dialect/Bufferization/`
- `mlir/lib/Dialect/Bufferization/Transforms/OneShotBufferize.cpp`

---

## 三、完成「RaW 冲突」的关键资料

### 3.1 最小 RaW 用例

```mlir
%0 = tensor.empty() : tensor<4xf32>
// 若某 Op 写 %0，且后面还有 read %0 依赖写前值 → RaW
// One-Shot 会插入 copy：先读到临时，再写 %0，再用临时供后面读
```

- 构造最小用例：`%0 = ...; use(%0); write_to(%0)`，确认 One-Shot 插入 copy。
- 改 IR 消除「读后写」依赖（如先写再读、或不同 buffer），确认 copy 消失。

### 3.2 概念表

| 概念 | 含义 |
|------|------|
| RaW (Read-After-Write) | 写覆盖了某 buffer，但后续读仍依赖写前的值 |
| One-Shot 决策 | 无 RaW 且 Op 支持 → 复用 buffer；有 RaW → 插入 copy |
| DPS | 显式 outs，便于表达「写回某 buffer」，利于 One-Shot 分析 |

---

## 四、完成「（可选）BufferizableOpInterface」的关键资料

### 4.1 接口要点

- 实现 `bufferize()`：给定 Op 与 Rewriter，分配或复用 MemRef，生成等价 memref Op。
- 声明 `getBufferType()` 等，供 One-Shot 分析使用。
- 参考 Linalg/Arithmetic 等已有实现：`BufferizableOpInterface`、`AnalysisState`。

### 4.2 参考

- `mlir/include/mlir/Dialect/Bufferization/IR/BufferizableOpInterface.h`
- `mlir/lib/Dialect/Linalg/Transforms/Bufferization.cpp`

---

## 五、推荐阅读顺序

1. Bufferization 文档（约 30 分钟）
2. One-Shot 与 RaW 小节（约 25 分钟）
3. 写两段 Linalg IR 跑 one-shot-bufferize 并对比（约 30 分钟）

---

## 六、参考源码位置

- `mlir/lib/Dialect/Bufferization/Transforms/OneShotBufferize.cpp`
- `mlir/include/mlir/Dialect/Bufferization/IR/BufferizableOpInterface.h`
- `mlir/test/Dialect/Bufferization/`

---

*按此资料学习，即可完成 plan.md 中的观察 One-Shot、RaW 验证、可选 BufferizableOpInterface 任务。*
