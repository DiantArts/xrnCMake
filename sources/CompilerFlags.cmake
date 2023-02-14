function(set_compiler_flags interface)

    # =========================================================================
    # -f flags
    # =========================================================================

    # coroutines
    if (20_COROUTINES)
        add_compile_definitions(${interface} INTERFACE -fcoroutines)
    endif ()

    # ftrace
    if (ENABLE_BUILD_WITH_TIME_TRACE)
        if (CMAKE_CXX_COMPILER_ID MATCHES ".*Clang")
            add_compile_definitions(${interface} INTERFACE -ftime-trace)
        else ()
            message(WARNING "ftrace option enabled but not using Clang compiler. Option ignored")
        endif ()
    endif ()

    if (NOT DEFINED XRN_ERROR_LIMIT)
        SET(XRN_ERROR_LIMIT 1)
    endif ()

    # color
    if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
        add_compile_options(-fdiagnostics-color=always -fmax-errors=${XRN_ERROR_LIMIT})
    elseif ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
        add_compile_options(-fcolor-diagnostics -ferror-limit=${XRN_ERROR_LIMIT})
    endif ()

    #debug
    if ()
    endif ()
    if (CMAKE_BUILD_TYPE STREQUAL "Debug")
    elseif (CMAKE_BUILD_TYPE STREQUAL "RelWithDebInfo")
    else ()
        add_compile_definitions(${interface} INTERFACE NO_DEBUG)
    endif ()

endfunction()
