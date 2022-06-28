# =========================================================================
# find dependencies
# =========================================================================

# Boost specific
# set(Boost_USE_STATIC_LIBS OFF)
# set(Boost_USE_MULTITHREADED ON)
# set(Boost_USE_STATIC_RUNTIME OFF)

# packages
# find_package(Boost 1.78.0 COMPONENTS)
find_package(fmt REQUIRED)
find_package(sfml REQUIRED)
# find_package(Qt5 COMPONENTS Widgets CONFIG)



# =========================================================================
# Create binaries
# =========================================================================
# ${Boost_LIBRARIES}
# CONAN_PKG::Widgets
# CONAN_PKG::Core

add_library(XRN_BIN_OBJECTS OBJECT ${XRN_SOURCES})
target_link_libraries(
    project_dependencies
    INTERFACE
        fmt::fmt
        sfml::sfml
)

if (ENABLE_BINARY)
    add_executable(${XRN_BIN_NAME} ${XRN_MAIN} $<TARGET_OBJECTS:XRN_BIN_OBJECTS>)
    target_link_libraries(
        ${XRN_BIN_NAME}
        PRIVATE
            project_options
            project_warnings
            project_dependencies
    )
endif ()

set_property(TARGET XRN_BIN_OBJECTS PROPERTY POSITION_INDEPENDENT_CODE 1)
if (ENABLE_STATIC_LIBRARY)
    add_library(${XRN_BIN_NAME}_static STATIC $<TARGET_OBJECTS:XRN_BIN_OBJECTS>)
    set_target_properties(${XRN_BIN_NAME}_static PROPERTIES OUTPUT_NAME ${XRN_BIN_NAME})
endif ()

if (ENABLE_SHARED_LIBRARY)
    add_library(${XRN_BIN_NAME}_shared SHARED $<TARGET_OBJECTS:XRN_BIN_OBJECTS>)
    set_target_properties(${XRN_BIN_NAME}_shared PROPERTIES OUTPUT_NAME ${XRN_BIN_NAME})
endif ()



# =========================================================================
# include dependencies
# =========================================================================
# ${Boost_INCLUDE_DIRS}
# ${Qt5Core_INCLUDE_DIRS}
# ${Qt5Widgets_INCLUDE_DIRS}
# ${Qt5Qml_INCLUDE_DIRS}
# ${Qt5Quick_INCLUDE_DIRS}
# ${Qt5QuickControls2_INCLUDE_DIRS}

# target_include_directories(${XRN_BIN_NAME} PRIVATE "${XRN_BUILD_DIR}/configured_files/include") ?
include_directories(
    ${fmt_INCLUDE_DIRS}
    ${sfml_INCLUDE_DIRS}
)
