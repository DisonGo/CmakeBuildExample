#
# Made by godison
# https://github.com/DisonGo
#

set(EXE_NAME g_viewer)
file(GLOB_RECURSE ${EXE_NAME}_SRCS
    src/*.cc
    src/*.cpp
)
file(GLOB_RECURSE ${EXE_NAME}_HEADER
    includes/*.h
    includes/*.hpp
)
add_executable(${EXE_NAME}
    MACOSX_BUNDLE
    ${${EXE_NAME}_SRCS}
    ${${EXE_NAME}_HEADER}
)
target_link_libraries(${EXE_NAME} PRIVATE
godison
${P_NAME}
g_gui
SDL3::SDL3
imgui   
GLAD
SOIL
TinyFileDialogs
)

foreach(RESOURCE_FILE ${RESOURCE_FILES})
    add_custom_command(
        TARGET ${EXE_NAME} POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_if_different
            ${CURRENT_DIRECTORY}/${RESOURCE_FILE}
            $<TARGET_FILE_DIR:${EXE_NAME}>/${RESOURCE_FILE}
    )
endforeach()
target_include_directories(${EXE_NAME} PUBLIC 
    ./includes
)
string(TOUPPER ${EXE_NAME} GUI_ID)
set_target_properties(${EXE_NAME} PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER ${GUI_ID}
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
)
