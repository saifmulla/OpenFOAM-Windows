##############################################
#
# this file is specific compilation setting for Linux systems
# moreover these settings are generic across compilers therefore any
# standard configurations accross multiple compilers on Linux
# must be place in this file

MESSAGE(STATUS "Including file: Linux64.cmake")
MESSAGE(STATUS "Loading Linux specific configuration")

SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -m64 -march=native")

