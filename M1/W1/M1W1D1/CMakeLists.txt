cmake_minimum_required(VERSION 3.15)
project(M1W1D1 LANGUAGES CXX)

# 周一 · LLVM/C++：基础架构、isa/cast、手写 IR
# 在 Cursor 中：打开本目录 -> 终端执行 cmake -B build && cmake --build build && ctest --test-dir build

add_library(daylib lib/placeholder.cpp)
add_executable(daytool tools/main.cpp)
target_link_libraries(daytool PRIVATE daylib)

enable_testing()
add_test(NAME DayTest COMMAND daytool)
