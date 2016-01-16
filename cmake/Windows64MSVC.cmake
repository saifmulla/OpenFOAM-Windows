# ###############################################
# this is MSVC VC++ compiler specific config file 
# for Windows
MESSAGE(STATUS "Generating configuration for Windows VC++ compiler")
MESSAGE(STATUS "BUILD COMMAND " ${CMAKE_VS_MSBUILD_COMMAND})
MESSAGE(STATUS "PLATFORM TOOLSET " ${CMAKE_VS_PLATFORM_TOOLSET})
# make microsoft compiler to compile 64
SET(CMAKE_CL_64 TRUE)
