cmake_minimum_required(VERSION 3.15)
project(M1W3D1 LANGUAGES CXX)

# M1 第3周 周一 · LLVM/C++（深化）
add_library(daylib lib/placeholder.cpp)
add_executable(daytool tools/main.cpp)
target_link_libraries(daytool PRIVATE daylib)
enable_testing()
add_test(NAME DayTest COMMAND daytool)
