CMAKE_MINIMUM_REQUIRED(VERSION 2.8)
# Enable C++11 on Apple machines.
IF( APPLE )
	# SET( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -stdlib=libc++" )
	# SET( CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -stdlib=libc++" )
	# SET( CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -stdlib=libc++" )
	# SET( CMAKE_MODULE_LINKER_FLAGS "${CMAKE_MODULE_LINKER_FLAGS} -stdlib=libc++" )
    # set mac os default deployment minimum to 10.7
    IF(NOT CMAKE_OSX_DEPLOYMENT_TARGET)
        SET(CMAKE_OSX_DEPLOYMENT_TARGET "10.7")
    ENDIF(NOT CMAKE_OSX_DEPLOYMENT_TARGET)
    # this code only builds for mac os 64 bit arch
    SET(CMAKE_OSX_ARCHITECURES "x86_64")

    #determine sdk to build on if not explicitly suplied
    IF(NOT CMAKE_OSX_SYSROOT)
	    EXECUTE_PROCESS(COMMAND "xcrun" "--show-sdk-path" OUTPUT_VARIABLE XCRUN_OSX_SYSROOT 
	    	RESULT_VARIABLE XCRUN_OSX_SYSROOT_STATUS OUTPUT_STRIP_TRAILING_WHITESPACE)
	    IF(XCRUN_OSX_SYSROOT_STATUS EQUAL 0)
	    	SET(CMAKE_OSX_SYSROOT ${XCRUN_OSX_SYSROOT})
	    ENDIF(XCRUN_OSX_SYSROOT_STATUS EQUAL 0)	
	    UNSET(XCRUN_OSX_SYSROOT)
	    UNSET(XCRUN_OSX_SYSROOT_STATUS)
    ENDIF(NOT CMAKE_OSX_SYSROOT)

    # set macOs architecture to x86
	SET( CMAKE_XCODE_ATTRIBUTE_CLANG_CXX_LANGUAGE_STANDARD "c++11" )
	SET( CMAKE_XCODE_ATTRIBUTE_CLANG_CXX_LIBRARY "libc++" )
	ADD_DEFINITIONS(-DGTEST_USE_OWN_TR1_TUPLE=1)
	SET(EXTRA_COMPILER_FLAGS "-march=native")

ENDIF( APPLE )

# ###############################################
# global variables for some messages to be displayed
SET(MPI_MESSAGE 
	"It appears MPI compiler is not present or path is not supplied."
	"Despite compilation will continue but the code cannot be run in parallel."
	"if you intent to use parallel processing then reconfigure again by supplying "
	"value to -DMPI_CXX_COMPILER."
	)

# ###############################################
# Start the project.
PROJECT(openfoam-windows C CXX) #project name

# ###############################################
# yes we are building shared libraries
ADD_DEFINITIONS(-DFOAM_BUILD_SHARED_LIB)

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

# ###############################################
# include subdirectories to be added for compilations
INCLUDE(src/CMakeLists.txt)

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
	ADD_SUBDIRECTORY(applications/test/unittests)
	# ADD_SUBDIRECTORY(libraries)
ENDIF( BUILD_UNIT_TESTS)

########## include directories ###############


