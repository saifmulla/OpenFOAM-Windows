CMAKE_MINIMUM_REQUIRED(VERSION 2.8)
# Enable C++11 on Apple machines.
IF( APPLE )
	# SET( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -stdlib=libc++" )
	# SET( CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -stdlib=libc++" )
	# SET( CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -stdlib=libc++" )
	# SET( CMAKE_MODULE_LINKER_FLAGS "${CMAKE_MODULE_LINKER_FLAGS} -stdlib=libc++" )

	SET( CMAKE_XCODE_ATTRIBUTE_CLANG_CXX_LANGUAGE_STANDARD "c++11" )
	SET( CMAKE_XCODE_ATTRIBUTE_CLANG_CXX_LIBRARY "libc++" )
	ADD_DEFINITIONS(-DGTEST_USE_OWN_TR1_TUPLE=1)

ENDIF( APPLE )

# ###############################################
# Start the project.
PROJECT(openfoam-windows C CXX) #project name

# ###############################################
# yes we are building shared libraries
ADD_DEFINITIONS(-DFOAM_BUILD_SHARED_LIB)

# ###############################################
# by default unit tests are disabled
# however to enable them simply supply variable
# BUILD_UNIT_TESTS = ON
OPTION( BUILD_UNIT_TESTS "Build unit tests." ON )

IF (BUILD_UNIT_TESTS)
	SET(BUILD_UNIT_TESTS ${BUILD_UNIT_TESTS})
ENDIF (BUILD_UNIT_TESTS)

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
# Fix Google Mock to work with Clang on OsX.
# This is a big, yet safe, cheat.
IF( APPLE )
	INCLUDE_DIRECTORIES(libraries/CMake/GTest)
ENDIF( APPLE )


#compile gtest framework for unit testing
# ###############################################
# Enable the CMake built in CTest system if unit
# tests are enabled.
IF( BUILD_UNIT_TESTS)
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

