cmake_minimum_required(VERSION 3.15)
project(M1W1 LANGUAGES CXX)

# M1 第 1 周 · 一周一个 CMake 工程（扁平结构）
# 定义 daytool_d1, daytool_d2, ... 等目标
# 在 Cursor 中：打开 M1/W1/ -> cmake -B build && cmake --build build
# 若使用自编译 LLVM：cmake -B build -DLLVM_DIR=/path/to/llvm-build/lib/cmake/llvm

add_library(daylib lib/placeholder.cpp)

# d1 需要 LLVM
find_package(LLVM REQUIRED CONFIG)
include_directories(${LLVM_INCLUDE_DIRS})
separate_arguments(LLVM_DEFINITIONS_LIST NATIVE_COMMAND ${LLVM_DEFINITIONS})
add_definitions(${LLVM_DEFINITIONS_LIST})
llvm_map_components_to_libnames(llvm_libs Support Core)

add_executable(daytool_d1 tools/d1_main.cpp)
target_link_libraries(daytool_d1 PRIVATE daylib ${llvm_libs})

# d2～d5 简单占位
add_executable(daytool_d2 tools/d2_main.cpp)
target_link_libraries(daytool_d2 PRIVATE daylib)

add_executable(daytool_d3 tools/d3_main.cpp)
target_link_libraries(daytool_d3 PRIVATE daylib)

add_executable(daytool_d4 tools/d4_main.cpp)
target_link_libraries(daytool_d4 PRIVATE daylib)

add_executable(daytool_d5 tools/d5_main.cpp)
target_link_libraries(daytool_d5 PRIVATE daylib)

enable_testing()
add_test(NAME Day1 COMMAND daytool_d1)
add_test(NAME Day2 COMMAND daytool_d2)
add_test(NAME Day3 COMMAND daytool_d3)
add_test(NAME Day4 COMMAND daytool_d4)
add_test(NAME Day5 COMMAND daytool_d5)
