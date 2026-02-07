cmake_minimum_required(VERSION 3.15)
project(M2W1D5 LANGUAGES CXX)

# M2 第1周 周五 · Python 绑定与性能脚本
add_library(daylib lib/placeholder.cpp)
add_executable(daytool tools/main.cpp)
target_link_libraries(daytool PRIVATE daylib)
enable_testing()
add_test(NAME DayTest COMMAND daytool)
