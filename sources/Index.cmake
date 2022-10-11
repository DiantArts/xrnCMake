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
