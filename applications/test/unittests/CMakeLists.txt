#cmake file for unit tests using gtest framework
CMAKE_MINIMUM_REQUIRED(VERSION 2.8)
PROJECT(OpenFOAM-Windows-UnitTests CXX) #project name
#include list of directories here
INCLUDE_DIRECTORIES("${CMAKE_SOURCE_DIR}/src/OpenFOAM/include"
	"${GTEST_DIR}/include")
SET(SHARED_LINKS gtest)
MESSAGE(${CMAKE_SOURCE_DIR}/src/OpenFOAM/include)
ENABLE_TESTING()
# ADD_EXECUTABLE(TestWindowsExport TestWindowsExport.cpp)
# TARGET_LINK_LIBRARIES(TestWindowsExport gtest)
# ADD_TEST(TestWindowsExport, ${EXECUTABLE_OUTPUT_PATH}/TestWindowsExport)
#loop over all the cpp files prefixed with Test
FILE(GLOB TEST_PROGS "Test*.cpp")
FOREACH(TEST_PROG ${TEST_PROGS})
	GET_FILENAME_COMPONENT(TEST_FILE ${TEST_PROG} NAME_WE)
	ADD_EXECUTABLE(${TEST_FILE} ${TEST_PROG})
	TARGET_LINK_LIBRARIES(${TEST_FILE} ${SHARED_LINKS})
	ADD_TEST(${TEST_FILE} ${EXECUTABLE_OUTPUT_PATH}/${TEST_FILE})
ENDFOREACH(TEST_PROG ${TEST_PROGS})