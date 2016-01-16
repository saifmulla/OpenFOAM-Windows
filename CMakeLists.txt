CMAKE_MINIMUM_REQUIRED(VERSION 2.8)

# ###############################################
# global variables for some messages to be displayed
SET(MPI_MESSAGE 
	"It appears MPI compiler is not present or path is not supplied."
	"Despite compilation will continue but the code cannot be run in parallel."
	"if you intent to use parallel processing then reconfigure again by supplying "
	"value to -DMPI_CXX_COMPILER."
	)

# Start the project.
PROJECT(openfoam-windows CXX C) #project name

# ###############################################
# check if CMAKE_BUILD_TYPE variable is set 
# if set then configure based on that type 
# otherwise make it Release
OPTION(CMAKE_BUILD_TYPE "Release Build." Release )
IF(NOT CMAKE_BUILD_TYPE)
	SET(CMAKE_BUILD_TYPE Release)
ENDIF(NOT CMAKE_BUILD_TYPE)

IF($ENV{BUILD_ENV} MATCHES "development")
	SET(CMAKE_BUILD_TYPE Debug)
ENDIF($ENV{BUILD_ENV} MATCHES "development")
# ###############################################
# include cmake config files based on OS and compiler
MESSAGE(STATUS "Configuring for ${CMAKE_SYSTEM_NAME} and using ${CMAKE_CXX_COMPILER_ID} compiler")
INCLUDE(cmake/${CMAKE_SYSTEM_NAME}64.cmake)
INCLUDE(cmake/${CMAKE_SYSTEM_NAME}64${CMAKE_CXX_COMPILER_ID}.cmake)

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

# ###############################################
# yes we are building shared libraries
ADD_DEFINITIONS(-DFOAM_BUILD_SHARED_LIB)
ADD_DEFINITIONS(-DUSE_STL)

# ###############################################
# by default unit tests are disabled
# however to enable them simply supply variable
# BUILD_UNIT_TESTS = ON
OPTION( BUILD_UNIT_TESTS "Build unit tests." ON )

IF (BUILD_UNIT_TESTS)
	SET(BUILD_UNIT_TESTS ${BUILD_UNIT_TESTS})
ENDIF (BUILD_UNIT_TESTS)

# ###############################################
# start finding required packages such as MPI, Flex, bison etc
# ###########
# find MPI
FIND_PACKAGE(MPI)
IF(NOT MPI_CXX_FOUND)
    MESSAGE(WARNING ${MPI_MESSAGE})
ELSE(MPI_CXX_FOUND)
	EXECUTE_PROCESS(COMMAND mpirun --version RESULT_VARIABLE VERSION_RESULT 
		OUTPUT_VARIABLE VERSION_OUTPUT OUTPUT_STRIP_TRAILING_WHITESPACE ERROR_VARIABLE VERSION_ERROR)
	MESSAGE("${VERSION_OUTPUT}")
	MESSAGE("${VERSION_ERROR}")
	# STRING(REPLACE " " ";" OP_LIST ${VERSION_OUTPUT})
	# STRING(REPLACE "/" ";" EXEC_LIST ${MPIEXEC})
	# LIST(GET OP_LIST 2 IDX2)
	# LIST(GET EXEC_LIST 4 MPIEXEC_COMMAND)
	# MESSAGE(STATUS "Using ${MPIEXEC} Version ${IDX2}")
ENDIF(NOT MPI_CXX_FOUND)


#compile gtest framework for unit testing
# ###############################################
# Enable the CMake built in CTest system if unit
# tests are enabled.
IF( BUILD_UNIT_TESTS)
	# ###############################################
	# Fix Google Mock to work with Clang on OsX.
	# This is a big, yet safe, cheat.
	IF( APPLE )
		INCLUDE_DIRECTORIES(libraries/CMake/GTest)
	ENDIF( APPLE )

	ENABLE_TESTING()
	# ###############################################
	# find package pthreads this is required when 
	# unit testing with gtest 
	FIND_PACKAGE(Threads)
	INCLUDE(libraries/CMakeLists.txt)
	# ADD_SUBDIRECTORY(applications/test/unittests)
	# ADD_SUBDIRECTORY(libraries)
ENDIF( BUILD_UNIT_TESTS)

########## include directories ###############
# ###############################################
# include subdirectories to be added for compilations
INCLUDE(src/CMakeLists.txt)


