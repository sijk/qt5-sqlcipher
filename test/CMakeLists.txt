set(CMAKE_BUILD_TYPE Debug)
set(CMAKE_CXX_FLAGS "-std=c++14")

add_executable(qsqlcipher-test main.cpp)
target_link_libraries(qsqlcipher-test Qt5::Sql)
