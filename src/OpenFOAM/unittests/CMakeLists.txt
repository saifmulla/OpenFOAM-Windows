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
${PROJECT_SOURCE_DIR}/src/OpenFOAM/primitives/bools/bool
${PROJECT_SOURCE_DIR}/src/OpenFOAM/primitives/Scalar
)

ADD_EXECUTABLE(All_Tests All_Tests.cpp)
TARGET_LINK_LIBRARIES(All_Tests gtest OpenFOAM ${CMAKE_THREAD_LIBS_INIT})
ADD_TEST(All_Tests ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/All_Tests)

SET_PROPERTY(TARGET All_Tests PROPERTY FOLDER "ALL_TESTS")
