#cmake file for unit tests using gtest framework
#PROJECT(OpenFOAM-Windows-UnitTests CXX) #project name
#include list of directories here

INCLUDE_DIRECTORIES(${GMOCK_INCLUDE_DIRS}
${PROJECT_SOURCE_DIR}/src/OpenFOAM/include/
)

ADD_EXECUTABLE(TestWindowsExport TestWindowsExport.cpp)
TARGET_LINK_LIBRARIES(TestWindowsExport GMock)
ADD_TEST(TestWindowsExport ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}TestWindowsExport)
#loop over all the cpp files prefixed with Test
#FILE(GLOB TEST_PROGS "Test*.cpp")
#FOREACH(TEST_PROG ${TEST_PROGS})
#	GET_FILENAME_COMPONENT(TEST_FILE ${TEST_PROG} NAME_WE)
#	ADD_EXECUTABLE(${TEST_FILE} ${TEST_PROG})
#	TARGET_LINK_LIBRARIES(${TEST_FILE} ${SHARED_LINKS})
#	ADD_TEST(${TEST_FILE} ${EXECUTABLE_OUTPUT_PATH}/${TEST_FILE})
#ENDFOREACH(TEST_PROG ${TEST_PROGS})
