CMAKE_MINIMUM_REQUIRED(VERSION 2.8)
# Enable C++11 on Apple machines.
IF( APPLE )
	# SET( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -stdlib=libc++" )
	# SET( CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -stdlib=libc++" )
	# SET( CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -stdlib=libc++" )
	# SET( CMAKE_MODULE_LINKER_FLAGS "${CMAKE_MODULE_LINKER_FLAGS} -stdlib=libc++" )

	SET( CMAKE_XCODE_ATTRIBUTE_CLANG_CXX_LANGUAGE_STANDARD "c++11" )
	SET( CMAKE_XCODE_ATTRIBUTE_CLANG_CXX_LIBRARY "libc++" )
	ADD_DEFINITIONS(-DGTEST_USE_OWN_TR1_TUPLE=1 -DGTEST_HAS_PTHREAD)

ENDIF( APPLE )

# ###############################################
# Start the project.
PROJECT(openfoam-windows CXX) #project name

# ###############################################
# Allow unit tests to be disabled via command
# line or the CMake GUI.
OPTION( BUILD_UNIT_TESTS "Build unit tests." ON )

# ###############################################
# Enable the CMake built in CTest system if unit
# tests are enabled.
IF( BUILD_UNIT_TESTS )
	ENABLE_TESTING()
ENDIF( BUILD_UNIT_TESTS )

# ###############################################
# Make VC happy and group all the binary outputs,
# also make sure GMock headers will compile in
# all targets.
IF( MSVC )
	SET(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/bin)
	SET(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/bin)
	SET(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/bin)
	ADD_DEFINITIONS( -D_VARIADIC_MAX=10 )
ENDIF( MSVC )

# ###############################################
# Find the threading package for this machine.
# FIND_PACKAGE( Threads )

# ###############################################
# Fix Google Mock to work with Clang on OsX.
# This is a big, yet safe, cheat.
IF( APPLE )
	INCLUDE_DIRECTORIES(libraries/CMake/GTest)
ENDIF( APPLE )


#compile gtest framework for unit testing

########## include directories ###############
INCLUDE(libraries/CMakeLists.txt)