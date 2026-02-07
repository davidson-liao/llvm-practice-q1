cmake_minimum_required(VERSION 3.15)
project(M1W1D2 LANGUAGES CXX)

# 周二 · MLIR ODS：TableGen、自定义 Op、Attribute/Type
add_library(daylib lib/placeholder.cpp)
add_executable(daytool tools/main.cpp)
target_link_libraries(daytool PRIVATE daylib)
enable_testing()
add_test(NAME DayTest COMMAND daytool)
