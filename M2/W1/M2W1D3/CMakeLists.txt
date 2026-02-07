cmake_minimum_required(VERSION 3.15)
project(M2W1D3 LANGUAGES CXX)

# 周三 · Pass/融合（重点）：算子融合、Tile-and-Fuse、数据流分析
add_library(daylib lib/placeholder.cpp)
add_executable(daytool tools/main.cpp)
target_link_libraries(daytool PRIVATE daylib)
enable_testing()
add_test(NAME DayTest COMMAND daytool)
