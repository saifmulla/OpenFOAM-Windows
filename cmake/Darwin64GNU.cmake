# ###############################################
# this is gnug++ and gcc specific confif file 
# for MacOS
MESSAGE(STATUS "Generating configuration for MacOSX g++ compiler")
SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=gnu++11 -Wextra -Wno-unused-parameter -Wold-style-cast -Wnon-virtual-dtor")
SET(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -lc++")
SET(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -dynamiclib -flat_namespace" )
