cmake_minimum_required(VERSION 3.15)
project(M1W1D4 LANGUAGES CXX)

# 周四 · 向量化/硬件：Intel SIMD、Vector 方言、transfer_read/write
add_library(daylib lib/placeholder.cpp)
add_executable(daytool tools/main.cpp)
target_link_libraries(daytool PRIVATE daylib)
enable_testing()
add_test(NAME DayTest COMMAND daytool)
