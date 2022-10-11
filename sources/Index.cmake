include_guard()

cmake_minimum_required(VERSION 3.20 FATAL_ERROR)

# =========================================================================
# Setup interfaces and configurations
# =========================================================================

# debug
if (ENABLE_CMAKE_DEBUG)
    SET(CMAKE_VERBOSE_MAKEFILE TRUE)
endif ()

# generate sources list without the main
list(REMOVE_ITEM XRN_SOURCES "${XRN_MAIN}")



# =========================================================================
# Options
# =========================================================================

string(REPLACE "-src" "-build" XRN_BIN_NAME ${XRN_BIN_NAME})

set(XRN_${XRN_BIN_NAME}_DEPENDENCY_DIR ${XRN_BUILD_DIR}/_deps/${XRN_BIN_NAME})
set(CMAKE_MODULE_PATH ${XRN_BUILD_DIR} ${XRN_${XRN_BIN_NAME}_DEPENDENCY_DIR})
add_library(${XRN_BIN_NAME}_project_options INTERFACE)

# basic useful actions controlled by the options/
include(${CMAKE_CURRENT_LIST_DIR}/StandardProjectSettings.cmake)
set_standard_project_settings(${XRN_BIN_NAME}_project_options ${XRN_CXX_VERSION})

# sanitizer options if supported by compiler
include(${CMAKE_CURRENT_LIST_DIR}/Sanitizers.cmake)
enable_sanitizers(${XRN_BIN_NAME}_project_options)



# =========================================================================
# Warnings and flags
# =========================================================================

add_library(${XRN_BIN_NAME}_project_warnings INTERFACE)

# compiler warnings
include(${CMAKE_CURRENT_LIST_DIR}/CompilerWarnings.cmake)
set_compiler_warnings(${XRN_BIN_NAME}_project_warnings)

# compiler flags
include(${CMAKE_CURRENT_LIST_DIR}/CompilerFlags.cmake)
set_compiler_flags(${XRN_BIN_NAME}_project_warnings)



# =========================================================================
# Dependencies
# =========================================================================

add_library(${XRN_BIN_NAME}_project_dependencies INTERFACE)

# compile shaders
include(${CMAKE_CURRENT_LIST_DIR}/Shaders.cmake)
compile_shaders(${XRN_BIN_NAME}_project_dependencies)

# download dependencies
include(${CMAKE_CURRENT_LIST_DIR}/Dependencies.cmake)
download_dependencies(${XRN_BIN_NAME}_project_dependencies "${XRN_LIBRARIES_REQUIRED}")



# =========================================================================
# Others
# =========================================================================

# cache if supported by compiler
include(${CMAKE_CURRENT_LIST_DIR}/Cache.cmake)
enable_cache()

# enable documentation
include(${CMAKE_CURRENT_LIST_DIR}/Documentation.cmake) # documentation configuration in the file
extract_documentation()

# allow for static analysis options
include(${CMAKE_CURRENT_LIST_DIR}/StaticAnalyzers.cmake) # possible to add more static analyzers in the file
run_static_analysis()
