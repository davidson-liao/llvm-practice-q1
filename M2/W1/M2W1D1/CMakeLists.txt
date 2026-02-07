cmake_minimum_required(VERSION 3.15)
project(M2W1D1 LANGUAGES CXX)

# 周一 · LLVM/C++：内存优化、Alias Analysis、自定义 AA Pass
add_library(daylib lib/placeholder.cpp)
add_executable(daytool tools/main.cpp)
target_link_libraries(daytool PRIVATE daylib)
enable_testing()
add_test(NAME DayTest COMMAND daytool)
