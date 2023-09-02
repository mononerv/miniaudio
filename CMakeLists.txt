cmake_minimum_required(VERSION 3.12)
project(miniaudio VERSION 0.11.9)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)         # Generate compile_commands.json for ccls
set_property(GLOBAL PROPERTY USE_FOLDERS ON)  # Group CMake targets inside a folder

# Install directory setup
include(GNUInstallDirs)
set(INC_DIR ${CMAKE_INSTALL_INCLUDEDIR})

set(HEADER_FILES "${PROJECT_SOURCE_DIR}/miniaudio.h")
set(SOURCE_FILES "miniaudio.cpp")

# Interface library
add_library(miniaudio INTERFACE)
target_include_directories(miniaudio
    INTERFACE
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
    $<INSTALL_INTERFACE:${INC_DIR}>
)
add_library(miniaudio::header-only ALIAS miniaudio)

# Static library
add_library(miniaudio_static STATIC ${HEADER_FILES} ${SOURCE_FILES})
target_include_directories(miniaudio_static
    PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
    $<INSTALL_INTERFACE:${INC_DIR}>
)
target_compile_features(miniaudio_static PRIVATE cxx_std_20)
add_library(miniaudio::miniaudio ALIAS miniaudio_static)

# Setup install targets
include(CMakePackageConfigHelpers)
set(MINIAUDIO_CMAKE_DIR ${CMAKE_INSTALL_LIBDIR}/cmake/miniaudio)
set(version_config "${PROJECT_BINARY_DIR}/miniaudio-config-version.cmake")
set(project_config "${PROJECT_BINARY_DIR}/miniaudio-config.cmake")
set(pkgconfig ${PROJECT_BINARY_DIR}/miniaudio.pc)
set(targets_export_name miniaudio-targets)
set(MINIAUDIO_LIB_NAME miniaudio)

write_basic_package_version_file(
    ${version_config}
    VERSION ${PROJECT_VERSION}
    COMPATIBILITY AnyNewerVersion
)

set(MINIAUDIO_LIB_DIR ${CMAKE_INSTALL_LIBDIR})
set(MINIAUDIO_PKGCONFIG_DIR ${CMAKE_INSTALL_LIBDIR}/pkgconfig)

# Create path
string(CONCAT libdir_for_pc_file "\${exec_prefix}" "/" "${MINIAUDIO_LIB_DIR}")
string(CONCAT includedir_for_pc_file "\${prefix}" "/" "${INC_DIR}")

# pkg-config support
configure_file(
    ${PROJECT_SOURCE_DIR}/support/cmake/miniaudio.pc.in  # Input file
    ${pkgconfig}
    @ONLY
)

# CMake package config
configure_package_config_file(
    ${CMAKE_CURRENT_SOURCE_DIR}/support/cmake/miniaudio.cmake.in
    ${project_config}
    INSTALL_DESTINATION ${MINIAUDIO_CMAKE_DIR}
)

# Setup install targets
set(INSTALL_TARGETS miniaudio miniaudio_static)

# Install library and headers
install(TARGETS ${INSTALL_TARGETS} EXPORT ${targets_export_name}
        LIBRARY DESTINATION ${MINIAUDIO_LIB_DIR}
        ARCHIVE DESTINATION ${MINIAUDIO_LIB_DIR}
        PUBLIC_HEADER DESTINATION "${INC_DIR}"
        RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
install(FILES ${HEADER_FILES} DESTINATION "${INC_DIR}")

export(TARGETS ${INSTALL_TARGETS} NAMESPACE miniaudio::
       FILE ${PROJECT_BINARY_DIR}/${targets_export_name}.cmake)

# Install version, config and target files.
install(
    FILES ${project_config} ${version_config}
    DESTINATION ${MINIAUDIO_CMAKE_DIR}
)
install(EXPORT ${targets_export_name} DESTINATION ${MINIAUDIO_CMAKE_DIR}
        NAMESPACE miniaudio::)

# TODO: pkg-config doesn't work as expected on Windows
install(FILES "${pkgconfig}" DESTINATION "${MINIAUDIO_PKGCONFIG_DIR}")
