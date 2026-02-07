cmake_minimum_required(VERSION 3.15)
project(M2W1D4 LANGUAGES CXX)

# M2 第1周 周四 · Tiling 与降级
add_library(daylib lib/placeholder.cpp)
add_executable(daytool tools/main.cpp)
target_link_libraries(daytool PRIVATE daylib)
enable_testing()
add_test(NAME DayTest COMMAND daytool)
