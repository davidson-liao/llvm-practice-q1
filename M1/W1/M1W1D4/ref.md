# M1W1D4 参考资料

> 完成 plan.md 中 Vector dialect、transfer_read/write、边界语义、AVX intrinsic 任务所需的必读资料。

---

## 一、必读官方文档

| 资料 | 链接 | 阅读重点 |
|------|------|----------|
| **Vector Dialect** | https://mlir.llvm.org/docs/Dialects/VectorOps/ | vector.transfer_read/write、broadcast、contract |
| **Lowering to LLVM** | https://mlir.llvm.org/docs/Dialects/LLVM/ | convert-vector-to-llvm |
| **Intel Intrinsics Guide** | https://www.intel.com/content/www/us/en/docs/intrinsics-guide/ | _mm256_add_ps 等 AVX 指令 |
| **AVX/AVX2 概览** | Intel 软件开发手册 或 SIMD 入门文档 | Lane 宽度、vaddps、256-bit 寄存器 |

---

## 二、完成「手写向量 IR」的关键资料

### 2.1 最小 transfer_read -> addf -> transfer_write 结构

```mlir
func.func @vector_add(%arg0: memref<64xf32>, %arg1: memref<64xf32>, %arg2: memref<64xf32>) {
  %c0 = arith.constant 0 : index
  %v0 = vector.transfer_read %arg0[%c0], %cf0 {in_bounds = [true]} : memref<64xf32>, vector<8xf32>
  %v1 = vector.transfer_read %arg1[%c0], %cf0 {in_bounds = [true]} : memref<64xf32>, vector<8xf32>
  %v2 = arith.addf %v0, %v1 : vector<8xf32>
  vector.transfer_write %v2, %arg2[%c0] {in_bounds = [true]} : vector<8xf32>, memref<64xf32>
  return
}
```

### 2.2 关键 Attribute

- `in_bounds = [true]`：明确无越界，可优化
- `padding`：越界时填充的值（如 `%cf0`）
- `permutation_map`：多维时的索引映射

### 2.3 降到 LLVM

```bash
mlir-opt input.mlir -convert-vector-to-llvm -convert-scf-to-cf -convert-arith-to-llvm -finalize-memref-to-llvm
```

---

## 三、完成「边界语义」的关键资料

### 3.1 长度非整数倍时的 Padding 行为

- 当 memref 长度不是 vector 宽度的整数倍时，`transfer_read` 对越界部分用 `padding` 值填充
- 去掉 `in_bounds = [true]` 或设为 `[false]`，让编译器生成带 mask 的代码或填 0
- 参考：Vector dialect 文档中「Out-of-bounds and padding」小节

### 3.2 验证方式

- 构造 `memref<10xf32>`，用 `vector<8xf32>` 读；最后 2 个 lane 应为 padding 值
- 用 `mlir-cpu-runner` 执行并打印部分结果，或写 C++ 参考实现对比

---

## 四、完成「AVX intrinsic（可选）」的关键资料

### 4.1 最小示例

```cpp
#include <immintrin.h>

void add_8floats(float* a, float* b, float* c) {
  __m256 va = _mm256_loadu_ps(a);
  __m256 vb = _mm256_loadu_ps(b);
  __m256 vc = _mm256_add_ps(va, vb);
  _mm256_storeu_ps(c, vc);
}
```

### 4.2 编译

```bash
clang -mavx -O2 -o test test.cpp
```

### 4.3 参考

- Intel Intrinsics Guide 搜索 `_mm256_add_ps`
- 对比：标量循环 8 次加 vs 一次 `_mm256_add_ps` 的结果一致性

---

## 五、推荐阅读顺序

1. Vector Dialect 文档中的 transfer_read/write、Out-of-bounds（约 30 分钟）
2. 浏览 `mlir/test/Dialect/Vector/` 中的 .mlir 用例（约 20 分钟）
3. Intel Intrinsics Guide 快速浏览 AVX 部分（约 15 分钟）
4. `convert-vector-to-llvm` Pass 源码（可选，约 20 分钟）

---

## 六、Lane 与寄存器宽度速查

| 指令集 | 位宽 | float Lane 数 |
|--------|------|---------------|
| SSE | 128 | 4 |
| AVX | 256 | 8 |
| AVX-512 | 512 | 16 |

---

*按此资料学习，即可完成 plan.md 中的手写向量 IR、边界语义、（可选）AVX intrinsic 任务。*
