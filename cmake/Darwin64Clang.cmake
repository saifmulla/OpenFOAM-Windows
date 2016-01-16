#this is a platform specific file for darwin
MESSAGE(STATUS "Generating configuration for MacOSX clang compiler")
SET( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -stdlib=libc++ -ftemplate-depth=100" )
# SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -traditional-cpp")
SET( CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -std=c++11 -stdlib=libc++ -lc++ -Wl" )
SET( CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -stdlib=libc++ -dynamiclib -flat_namespace" )
# set macOs architecture to x86
SET(CMAKE_XCODE_ATTRIBUTE_CLANG_CXX_LANGUAGE_STANDARD "c++11")
SET(CMAKE_XCODE_ATTRIBUTE_CLANG_CXX_LIBRARY "libc++")
IF(CMAKE_BUILD_TYPE MATCHES Debug)
	SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -g -O0 --verify-debug-info")
ELSEIF(CMAKE_BUILD_TYPE MATCHES Release)
	SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -O3 -fslp-vectorize -fvectorize -funroll-loops")
ENDIF(CMAKE_BUILD_TYPE MATCHES Debug)
