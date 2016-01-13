# ###############################################
# build OpenFOAM library
# creates library files for following platforms
# Linux:
#     libOpenFOAM.so
# Mac OSX:
#     libOpenFOAM.dylib
# Windows:
#     OpenFOAM.lib
#     OpenFOAM.dll
#     OpenFOAM.pdb

# ###############################################
# unset SHARED_LIB_NAME if set otherwise set to current one
UNSET(SHARED_LIB_NAME)
SET(SHARED_LIB_NAME OpenFOAM)

# ###############################################
# now point to lnInclude directory for source compilations
INCLUDE_DIRECTORIES(BEFORE
    ${CMAKE_CURRENT_SOURCE_DIR}/include
    ${CMAKE_CURRENT_SOURCE_DIR}/global/clock
    ${CMAKE_CURRENT_SOURCE_DIR}/primitives/pTraits
    ${CMAKE_CURRENT_SOURCE_DIR}/primitives/direction
    ${CMAKE_CURRENT_SOURCE_DIR}/primitives/chars/char    
    ${CMAKE_CURRENT_SOURCE_DIR}/primitives/Scalar
    )

# ###############################################
# add source files to the list to be compiled into shared lib
# this list is intentionally kept manual to avoid cmake 
# file(GLOB_RECURSE) problems also to keep it efficient
# for every file to be compilied must be appended manually
# to SOURCE_FILES variable
SET(SOURCE_FILES 
    ${CMAKE_CURRENT_SOURCE_DIR}/global/clock/clock.C
    ${CMAKE_CURRENT_SOURCE_DIR}/primitives/bool/bool.C
    # ${CMAKE_CURRENT_SOURCE_DIR}/primitives/Scalar/doubleScalar/doubleScalar.C
    # ${CMAKE_CURRENT_SOURCE_DIR}/primitives/Scalar/floatScalar/floatScalar.C
    # ${CMAKE_CURRENT_SOURCE_DIR}/primitives/Scalar/scalar/scalar.C
    )

# ###############################################
# add target to create shared library
ADD_LIBRARY(${SHARED_LIB_NAME} SHARED ${SOURCE_FILES})

IF( BUILD_UNIT_TESTS )
    ADD_SUBDIRECTORY(unittests)
ENDIF( BUILD_UNIT_TESTS )
