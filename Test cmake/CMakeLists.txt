#
# Made by godison
# https://github.com/DisonGo
#
set(LIB_NAME TESTING)
AUX_SOURCE_DIRECTORY(./src ${LIB_NAME}_SRCS)
add_executable(${LIB_NAME}
    ${${LIB_NAME}_SRCS}
)
target_link_libraries(${LIB_NAME}
    ${P_NAME}_Backend
    Qt${QT_VERSION_MAJOR}::Widgets
    gtest
)
include(GoogleTest)
gtest_discover_tests(${LIB_NAME})
add_test(NAME TestMyCode COMMAND TestMyCode)