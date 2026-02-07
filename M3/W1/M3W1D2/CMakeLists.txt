cmake_minimum_required(VERSION 3.15)
project(M3W1D2 LANGUAGES CXX)

# M3 第1周 周二 · Dialect 层级与跨方言 Conversion
add_library(daylib lib/placeholder.cpp)
add_executable(daytool tools/main.cpp)
target_link_libraries(daytool PRIVATE daylib)
enable_testing()
add_test(NAME DayTest COMMAND daytool)
