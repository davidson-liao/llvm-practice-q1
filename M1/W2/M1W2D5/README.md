# M1W2D5 · 第2周 周五 · 工程/测试

基建期第 2 周第 5 天：深化 CMake、GTest、Lit+FileCheck。对照 M1/W1/M1W1D5。

## 在 Cursor 中执行

```bash
cmake -B build && cmake --build build
./build/daytool
ctest --test-dir build
```
