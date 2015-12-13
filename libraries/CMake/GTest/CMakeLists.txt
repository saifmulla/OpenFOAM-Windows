##################################
#set GTEST_ROOT variable to call googletest folder in previous 
# directory
SET(GTEST_ROOT "${CMAKE_CURRENT_SOURCE_DIR}/../../gmock-1.6.0")
# Use a variable to point to the root of googlemock within
# the External directory.  This makes it easier to update
# to new releases as desired.

INCLUDE_DIRECTORIES( ${GTEST_ROOT}/fused-src )

# Make the file lists.
SET( INCLUDE_FILES
	${GTEST_ROOT}/fused-src/gtest/gtest.h
    ${GTEST_ROOT}/fused-src/gmock/gmock.h
)

SET( SOURCE_FILES
    ${GTEST_ROOT}/fused-src/gmock-gtest-all.cc
)

# Add as a static library target.
ADD_LIBRARY( GMock
	STATIC
	${INCLUDE_FILES}
	${SOURCE_FILES}
)

SET(GMOCK_INCLUDE_DIRS ${GTEST_ROOT}/fused-src PARENT_SCOPE)