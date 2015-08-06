cmake_minimum_required(VERSION 3.0)
project(qsqlcipher)

find_package(Qt5Sql REQUIRED)
find_package(PkgConfig REQUIRED)
pkg_check_modules(SQLCIPHER REQUIRED sqlcipher)

set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_AUTOMOC ON)

# Arrange output paths so that the plugin is found in the default search path
# relative to the test binary.
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR})
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/sqldrivers)

add_library(qsqlcipher MODULE
    smain.cpp
    qt-private/qsql_sqlite.cpp
)

target_include_directories(qsqlcipher PRIVATE
    ${Qt5Sql_PRIVATE_INCLUDE_DIRS}
    ${SQLCIPHER_INCLUDE_DIRS}
)

target_link_libraries(qsqlcipher
    Qt5::Sql
    ${SQLCIPHER_LIBRARIES}
)

add_subdirectory(test)
