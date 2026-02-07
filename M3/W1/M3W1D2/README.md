# M3W1D2 · 周二 · Dialect 与 Conversion

实战期第 2 天：完整 Dialect 层级、跨方言转换 (TypeConverter、Materialization)。

## 在 Cursor 中执行

```bash
cmake -B build && cmake --build build
./build/daytool
ctest --test-dir build
```

## 今日目标

- 学：Tensor→MemRef→LLVM 层次；TypeConverter、Materialization、unrealized_conversion_cast。
- 写：TypeConverter、Materialization 观察、自定义 Op 降到 LLVM 小管线。
