# ###############################################
# this is gnug++ and gcc specific confif file 
# for Linux
MESSAGE(STATUS "Generating configuration for Linux g++ compiler")
ADD_DEFINITIONS(-DGTEST_USE_OWN_TR1_TUPLE=1)
SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -march=native -Wall -Wextra -Wno-unused-parameter -Wold-style-cast -std=gnu++11")
SET(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -shared -Xlinker --add-needed")
SET(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -Xlinker --no-as-needed")
