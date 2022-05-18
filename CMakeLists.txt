cmake_minimum_required(VERSION 3.12)
project(miniaudio VERSION 0.11.9)
set(CMAKE_C_STANDARD 17)

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR}/lib)

include_directories(${PROJECT_SOURCE_DIR})
add_library(${PROJECT_NAME} STATIC
    miniaudio.c
)
target_include_directories(${PROJECT_NAME} INTERFACE ${PROJECT_SOURCE_DIR})

