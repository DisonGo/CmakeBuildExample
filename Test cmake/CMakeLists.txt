#
# Made by godison
# https://github.com/DisonGo
#
set(TESTS_NAME TESTING)
AUX_SOURCE_DIRECTORY(./src ${TESTS_NAME}_SRCS)
add_executable(${TESTS_NAME}
    ${${TESTS_NAME}_SRCS}
)
target_link_libraries(${TESTS_NAME}
    ${P_NAME}_Backend
    gtest
)
include(GoogleTest)
gtest_discover_tests(${TESTS_NAME})
add_test(NAME SomeTests COMMAND SomeTests)