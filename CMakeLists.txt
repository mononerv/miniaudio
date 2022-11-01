cmake_minimum_required(VERSION 3.12)
project(miniaudio VERSION 0.11.9)
set(CMAKE_CXX_STANDARD 20)

set(TARGET ${PROJECT_NAME})
add_library(${TARGET} STATIC miniaudio.cpp)
target_include_directories(${TARGET} INTERFACE ${PROJECT_SOURCE_DIR})
if (NOT MSVC)
    target_compile_options(${TARGET} PRIVATE
        "-Wall"
        "-Wextra"
        "-Wpedantic"
        "-Werror"

        "-Wno-deprecated-declarations"
        "-Wno-unused-but-set-variable"
        "-Wno-unused-parameter"
    )
else()
    target_compile_options(${TARGET} PRIVATE
        "/W4"
        "/WX"
        "/wd4100"
    )
endif()

