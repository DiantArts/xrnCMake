include_guard()

include(${CMAKE_CURRENT_LIST_DIR}/StandardProjectSettings.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/Sanitizers.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/CompilerWarnings.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/CompilerFlags.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/StaticAnalyzers.cmake) # possible to add more static analyzers in the file
include(${CMAKE_CURRENT_LIST_DIR}/Shaders.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/Dependencies.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/Cache.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/Documentation.cmake) # documentation configuration in the file

macro(setup_filepaths)
    set(ALLOW_DUPLICATE_CUSTOM_TARGETS TRUE)

    set(XRN_ROOT_DIR_RELATIVE ${CMAKE_SOURCE_DIR})
    set(XRN_BUILD_DIR_RELATIVE ${CMAKE_BINARY_DIR})
    set(XRN_TOOLCHAIN_DIR_RELATIVE ${XRN_TOOLCHAIN_DIR})
    set(XRN_TOOLCHAIN_DETAILS_DIR_RELATIVE ${XRN_TOOLCHAIN_DETAILS_DIR})
    set(XRN_SOURCES_DIR_RELATIVE ${XRN_SOURCES_DIR})
    set(XRN_TESTS_DIR_RELATIVE ${XRN_TESTS_DIR})

    set(XRN_SHADERS_DIR_RELATIVE ${XRN_SHADERS_DIR})
    set(XRN_FRAGMENTS_DIR_RELATIVE ${XRN_SHADERS_DIR}/${XRN_FRAGMENTS_DIR})
    set(XRN_VERTEXES_DIR_RELATIVE ${XRN_SHADERS_DIR}/${XRN_VERTEXES_DIR})

    get_filename_component(XRN_ROOT_DIR ${CMAKE_SOURCE_DIR} REALPATH)
    get_filename_component(XRN_BUILD_DIR ${CMAKE_BINARY_DIR} REALPATH)
    get_filename_component(XRN_TOOLCHAIN_DIR ${XRN_TOOLCHAIN_DIR} REALPATH)
    get_filename_component(XRN_TOOLCHAIN_DETAILS_DIR ${XRN_TOOLCHAIN_DETAILS_DIR} REALPATH)
    get_filename_component(XRN_SOURCES_DIR ${XRN_SOURCES_DIR} REALPATH)
    get_filename_component(XRN_TESTS_DIR ${XRN_TESTS_DIR} REALPATH)
    get_filename_component(XRN_OUTPUT_DIR ${XRN_BUILD_DIR}/${XRN_OUTPUT_DIR} REALPATH)

    get_filename_component(XRN_SHADERS_DIR ${XRN_SHADERS_DIR} REALPATH)
    get_filename_component(XRN_VERTEXES_DIR ${XRN_VERTEXES_DIR_RELATIVE} REALPATH)
    get_filename_component(XRN_FRAGMENTS_DIR ${XRN_FRAGMENTS_DIR_RELATIVE} REALPATH)
endmacro()

macro(auto_find_files)
    get_filename_component(XRN_MAIN ${XRN_SOURCES_DIR}/main.cpp REALPATH)
    file(
        GLOB_RECURSE
        XRN_SOURCES
        ${XRN_SOURCES_DIR}/*.cpp
        ${XRN_SOURCES_DIR}/*.cxx
        ${XRN_SOURCES_DIR}/*.c
        ${XRN_SOURCES_DIR}/*.CC
        PARENT_SCOPE
    )
    file(
        GLOB_RECURSE
        XRN_HEADERS
        ${XRN_SOURCES_DIR}/*.hpp
        ${XRN_SOURCES_DIR}/*.hxx
        ${XRN_SOURCES_DIR}/*.h
        PARENT_SCOPE
    )
    file(
        GLOB_RECURSE
        XRN_FRAGMENTS
        ${XRN_FRAGMENTS_DIR}/*.glsl
        ${XRN_FRAGMENTS_DIR}/*.shader
        ${XRN_SHADERS_DIR}/*.vert
        ${XRN_SHADERS_DIR}/*.vertex
        ${XRN_SHADERS_DIR}/*.vs
        PARENT_SCOPE
    )
    file(
        GLOB_RECURSE
        XRN_VERTEXES
        ${XRN_VERTEXES_DIR}/*.glsl
        ${XRN_VERTEXES_DIR}/*.shader
        ${XRN_SHADERS_DIR}/*.vert
        ${XRN_SHADERS_DIR}/*.vertex
        ${XRN_SHADERS_DIR}/*.fs
        PARENT_SCOPE
    )
    list(REMOVE_ITEM XRN_SOURCES "${XRN_MAIN}")
endmacro()
