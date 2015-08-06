# Same as for test-shared, but statically link the plugin
include(../test-shared/CMakeLists.txt)
target_link_libraries(qsqlcipher-test qsqlcipher)
