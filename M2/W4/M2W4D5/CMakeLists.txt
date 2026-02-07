cmake_minimum_required(VERSION 3.15)
project(M2W4D5 LANGUAGES CXX)

# M2 第4周 周五 · Python 与性能（本月收尾）
add_library(daylib lib/placeholder.cpp)
add_executable(daytool tools/main.cpp)
target_link_libraries(daytool PRIVATE daylib)
enable_testing()
add_test(NAME DayTest COMMAND daytool)
