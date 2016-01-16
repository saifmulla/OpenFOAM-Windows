# ###############################################
# this is MSVC VC++ compiler specific config file 
# for Windows
MESSAGE(STATUS "Generating configuration for Windows VC++ compiler")
MESSAGE(STATUS "BUILD COMMAND " ${CMAKE_VS_MSBUILD_COMMAND})
MESSAGE(STATUS "PLATFORM TOOLSET " ${CMAKE_VS_PLATFORM_TOOLSET})
# make microsoft compiler to compile 64
SET(CMAKE_CL_64 TRUE)

# ###############################################
# Make VC happy and group all the binary outputs,
# also make sure GMock headers will compile in
# all targets.
IF( MSVC )
	SET(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/bin/)
	SET(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/bin/)
	SET(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/lib/)
	ADD_DEFINITIONS( -D_VARIADIC_MAX=10)
ENDIF( MSVC )
