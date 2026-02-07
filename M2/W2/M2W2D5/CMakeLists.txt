cmake_minimum_required(VERSION 3.15)
project(M2W2D5 LANGUAGES CXX)

add_library(daylib lib/placeholder.cpp)
add_executable(daytool tools/main.cpp)
target_link_libraries(daytool PRIVATE daylib)
enable_testing()
add_test(NAME DayTest COMMAND daytool)
