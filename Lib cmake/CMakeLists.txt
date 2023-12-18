#
# Made by godison
# https://github.com/DisonGo
#
set(LIB_NAME g_gui)
file(GLOB_RECURSE ${LIB_NAME}_SRCS
    src/*.cc
    src/*.cpp
)
file(GLOB_RECURSE ${LIB_NAME}_HEADER
    include/*.h
    include/*.hpp
)
add_library(${LIB_NAME} STATIC
    ${${LIB_NAME}_SRCS}
    ${${LIB_NAME}_HEADER}
)
target_link_libraries(${LIB_NAME} PRIVATE
    godison
    ${P_NAME}
    imgui
    SDL3::SDL3
    GLAD
)
target_include_directories(${LIB_NAME} PUBLIC include)
