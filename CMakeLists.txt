cmake_minimum_required(VERSION 3.12)
project(miniaudio VERSION 0.11.9)
set(CMAKE_C_STANDARD 17)

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR}/lib)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR}/lib)

# warnings and errors
if (NOT MSVC)
    string(JOIN " " CMAKE_C_FLAGS
        "-Wall"
        "-Wextra"
        "-Wpedantic"
        "-Werror"

        "-Wno-deprecated-declarations"
        "-Wno-unused-but-set-variable"
        "-Wno-unused-parameter"
    )
else()
    string(JOIN " " CMAKE_C_FLAGS
        "/W4"
        "/WX"
        "/wd4100"
    )
    # stdalign.h not found when in C11+
    set(CMAKE_C_STANDARD 99)
endif()

include_directories(${PROJECT_SOURCE_DIR})
add_library(${PROJECT_NAME} STATIC
    miniaudio.c
)
target_include_directories(${PROJECT_NAME} INTERFACE ${PROJECT_SOURCE_DIR})

