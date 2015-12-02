CMAKE_MINIMUM_REQUIRED(VERSION 2.8)
PROJECT(OpenFOAM-Windows CXX) #project name
#determine version of cmake, this project is build with version 2.8 in mind
SET(cmv "${CMAKE_MAJOR_VERSION}.${CMAKE_MINOR_VERSION}")
MESSAGE("Using CMAKE version ${cmv}, anything below 2.8 is not guarenteed to work")


#compile gtest framework for unit testing
MESSAGE("Compiling GTest framework...")
SET(GTEST_DIR ${CMAKE_SOURCE_DIR}/libraries/gtest)
MESSAGE("GTEST directory root " ${GTEST_DIR})
ADD_SUBDIRECTORY(libraries/gtest)

ADD_SUBDIRECTORY(applications/test/unittests)
ENABLE_TESTING()