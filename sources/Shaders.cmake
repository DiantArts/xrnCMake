macro(compile_shaders interface)
    if (ENABLE_SHADERS)
        find_program(glslc_executable NAMES glslc HINTS Vulkan::glslc)

        foreach(SHADER ${XRN_FRAGMENTS})
            get_filename_component(FILE_NAME ${SHADER} NAME)
            set(SPIRV "${XRN_FRAGMENTS_DIR}/${FILE_NAME}.spv")
            add_custom_command(
                OUTPUT ${SPIRV}
                COMMAND glslc -fshader-stage="fragment" ${SHADER} -o ${SPIRV}
                DEPENDS ${SHADER}
                COMMENT "Compiling fragment shader ${SHADER}"
            )
            list(APPEND SPIRV_BINARY_FILES ${SPIRV})
        endforeach(SHADER)

        foreach(SHADER ${XRN_VERTEXES})
            get_filename_component(FILE_NAME ${SHADER} NAME)
            set(SPIRV "${XRN_VERTEXES_DIR}/${FILE_NAME}.spv")
            add_custom_command(
                OUTPUT ${SPIRV}
                COMMAND glslc -fshader-stage="vertex" ${SHADER} -o ${SPIRV}
                DEPENDS ${SHADER}
                COMMENT "Compiling vertex shader ${SHADER}"
            )
            list(APPEND SPIRV_BINARY_FILES ${SPIRV})
        endforeach(SHADER)

        foreach(SHADER ${XRN_GEOMETRIES})
            get_filename_component(FILE_NAME ${SHADER} NAME)
            set(SPIRV "${XRN_GEOMETRIES_DIR}/${FILE_NAME}.spv")
            add_custom_command(
                OUTPUT ${SPIRV}
                COMMAND glslc -fshader-stage="geometry" ${SHADER} -o ${SPIRV}
                DEPENDS ${SHADER}
                COMMENT "Compiling geometry shader ${SHADER}"
            )
            list(APPEND SPIRV_BINARY_FILES ${SPIRV})
        endforeach(SHADER)

        foreach(SHADER ${XRN_COMPUTES})
            get_filename_component(FILE_NAME ${SHADER} NAME)
            set(SPIRV "${XRN_COMPUTES_DIR}/${FILE_NAME}.spv")
            add_custom_command(
                OUTPUT ${SPIRV}
                COMMAND glslc -fshader-stage="compute" ${SHADER} -o ${SPIRV}
                DEPENDS ${SHADER}
                COMMENT "Compiling compute shader ${SHADER}"
            )
            list(APPEND SPIRV_BINARY_FILES ${SPIRV})
        endforeach(SHADER)

        add_custom_target(${XRN_BIN_NAME}_shaders ALL DEPENDS ${SPIRV_BINARY_FILES})
    endif ()
endmacro()
