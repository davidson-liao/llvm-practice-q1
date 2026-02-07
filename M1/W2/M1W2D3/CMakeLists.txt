cmake_minimum_required(VERSION 3.15)
project(M1W2D3 LANGUAGES CXX)

# M1 第2周 周三 · Pass/融合基础（深化）
add_library(daylib lib/placeholder.cpp)
add_executable(daytool tools/main.cpp)
target_link_libraries(daytool PRIVATE daylib)
enable_testing()
add_test(NAME DayTest COMMAND daytool)
