cmake_minimum_required(VERSION 3.15)
project(M1W2D5 LANGUAGES CXX)

# M1 第2周 周五 · 工程/测试（深化）
add_library(daylib lib/placeholder.cpp)
add_executable(daytool tools/main.cpp)
target_link_libraries(daytool PRIVATE daylib)
enable_testing()
add_test(NAME DayTest COMMAND daytool)
