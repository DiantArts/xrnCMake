function(conan_config_set)
    # Set a config value.
    # Arguments NAME and VALUE are required
    # Example usage:
    #    conan_config_set(NAME general.revision_enabled
    #                     VALUE 1)
    #
    # See: https://docs.conan.io/en/latest/reference/commands/consumer/config.html

    set(oneValueArgs NAME VALUE)
    cmake_parse_arguments(CONAN "" "${oneValueArgs}" "" ${ARGN})

    if(DEFINED CONAN_COMMAND)
        set(CONAN_CMD ${CONAN_COMMAND})
    else()
        conan_check(REQUIRED)
    endif()

    message(STATUS "Conan: Setting ${CONAN_NAME} to ${CONAN_VALUE}")

    execute_process(COMMAND ${CONAN_CMD} config set ${CONAN_NAME}=${CONAN_VALUE}
                    RESULT_VARIABLE return_code)
    if(NOT "${return_code}" STREQUAL "0")
        message(FATAL_ERROR "Conan config set failed='${return_code}'")
    endif()
endfunction()


macro(conan_config)
    # dependencies directory
    list(APPEND CMAKE_MODULE_PATH ${CMAKE_BINARY_DIR})
    list(APPEND CMAKE_PREFIX_PATH ${CMAKE_BINARY_DIR})

    # download conan.cmake if does not exist
    if (ENABLE_UPDATE_CONAN OR NOT EXISTS "${XRN_TOOLCHAIN_DETAILS_DIR}/conan_provider.cmake")
        message(STATUS "Downloading conan_provider.cmake from https://github.com/conan-io/cmake-conan")
        file(
            DOWNLOAD "https://raw.githubusercontent.com/conan-io/cmake-conan/develop2/conan_provider.cmake"
            "${XRN_TOOLCHAIN_DETAILS_DIR}/conan_provider.cmake"
            TLS_VERIFY ON
        )
    endif()
    # include(${XRN_TOOLCHAIN_DETAILS_DIR}/conan_provider.cmake)

    # add download remotes
    # conan_config_set(NAME general.revisions_enabled VALUE 1)
    # conan_add_remote(NAME bincrafters URL https://bincrafters.jfrog.io/artifactory/api/conan/public-conan)
    # conan_add_remote(NAME conancenter URL https://center.conan.io)

    # run it
    # conan_cmake_configure(REQUIRES ${library_versions} GENERATORS cmake_find_package)
    # conan_cmake_autodetect(settings)
    # conan_cmake_install(
    # PATH_OR_REFERENCE .
    # GENERATOR cmake
    # BUILD missing
    # SETTINGS ${settings}
    # )
endmacro()

macro(download_dependencies interface library_versions)
    conan_config()

    # includes
    include(FetchContent)

    target_include_directories(${interface} INTERFACE ${XRN_SOURCES_DIR})
    if (EXISTS "${XRN_EXTERNALS_DIR}")
        target_include_directories(${interface} INTERFACE ${XRN_EXTERNALS_DIR})
    endif ()

    foreach(library_name IN LISTS XRN_PERSONAL_DEPENDENCIES)
        MESSAGE(STATUS "Dowloading ${library_name}")
        string(TOLOWER ${library_name} library_dirname)

        get_filename_component(${library_name}_LOCAL_FULLPATH "../${library_name}" REALPATH)
        if (EXISTS "${${library_name}_LOCAL_FULLPATH}") # if directory is present locally
            set(library_dir "${${library_name}_LOCAL_FULLPATH}")
        else () # else dowload it
            FetchContent_Declare(
                ${library_dirname}
                GIT_REPOSITORY https://github.com/DiantArts/${library_name}
                GIT_TAG        main
                CONFIGURE_COMMAND ""
                BUILD_COMMAND ""
            )
            FetchContent_GetProperties(${library_dirname})
            if(NOT ${library_dirname}_POPULATED)
                FetchContent_Populate(${library_dirname})
            endif()
            set(library_dir "${${library_dirname}_SOURCE_DIR}")
        endif ()

        target_include_directories(${interface} INTERFACE ${library_dir}/externals/)
        target_include_directories(${interface} INTERFACE ${library_dir}/sources/)

        file(
            GLOB_RECURSE
            XRN_${library_dirname}_SOURCES
            ${${library_name}_LOCAL_FULLPATH}/sources/*.cpp
            ${${library_name}_LOCAL_FULLPATH}/sources/*.cxx
            ${${library_name}_LOCAL_FULLPATH}/sources/*.c
            ${${library_name}_LOCAL_FULLPATH}/sources/*.CC
            PARENT_SCOPE
        )
        file(
            GLOB_RECURSE
            XRN_${library_dirname}_MAINS
            ${${library_name}_LOCAL_FULLPATH}/sources/*main.cpp
            ${${library_name}_LOCAL_FULLPATH}/sources/*main.cxx
            ${${library_name}_LOCAL_FULLPATH}/sources/*main.c
            ${${library_name}_LOCAL_FULLPATH}/sources/*main.CC
            PARENT_SCOPE
        )
        foreach(main_file IN LISTS XRN_${library_dirname}_MAINS)
            list(REMOVE_ITEM XRN_${library_dirname}_SOURCES "${main_file}")
        endforeach()
        list(APPEND XRN_SOURCES ${XRN_${library_dirname}_SOURCES})
    endforeach()

endmacro()
