# ###############################################
# this is gnug++ and gcc specific confif file 
# for MacOS
MESSAGE(STATUS "Generating configuration for MacOSX g++ compiler")
SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=gnu++11 -Wextra -Wno-unused-parameter -Wold-style-cast -Wnon-virtual-dtor")
SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -frounding-math -fsignaling-nans -ftrapping-math")

SET(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -lc++")
SET(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -dynamiclib -flat_namespace" )

IF(CMAKE_BUILD_TYPE MATCHES Debug)
	SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -O0 -Og")
ELSEIF(CMAKE_BUILD_TYPE MATCHES Release)
	SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -O3 -ftree-slp-vectorize -ftree-vectorize -ftree-loop-vectorize -funroll-loops")
ENDIF(CMAKE_BUILD_TYPE MATCHES Debug)
