#cmake file for unit tests using gtest framework
#PROJECT(OpenFOAM-Windows-UnitTests CXX) #project name
#include list of directories here

INCLUDE_DIRECTORIES(${GTEST_INCLUDE_DIRS}
${PROJECT_SOURCE_DIR}/src/OpenFOAM/include
${PROJECT_SOURCE_DIR}/src/OpenFOAM/primitives/Swap
${PROJECT_SOURCE_DIR}/src/OpenFOAM/primitives/zero
${PROJECT_SOURCE_DIR}/src/OpenFOAM/primitives/contiguous
${PROJECT_SOURCE_DIR}/src/OpenFOAM/primitives/pTraits
${PROJECT_SOURCE_DIR}/src/OpenFOAM/primitives/chars
${PROJECT_SOURCE_DIR}/src/OpenFOAM/primitives/one
${PROJECT_SOURCE_DIR}/src/OpenFOAM/primitives/bool
)

#loop over all the cpp files prefixed with Test
FILE(GLOB TEST_PROGS "Test*.cpp")
FOREACH(TEST_PROG ${TEST_PROGS})
	GET_FILENAME_COMPONENT(TEST_FILE ${TEST_PROG} NAME_WE)
	ADD_EXECUTABLE(${TEST_FILE} ${TEST_PROG})
	TARGET_LINK_LIBRARIES(${TEST_FILE} gtest OpenFOAM ${CMAKE_THREAD_LIBS_INIT})
	ADD_TEST(${TEST_FILE} ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/${TEST_FILE})
ENDFOREACH(TEST_PROG ${TEST_PROGS})
