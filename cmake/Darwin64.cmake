##############################################
#
# this file is specific compilation setting for MacOSX Darwin
# more these settings are generic across compilers therefore any
# config which is compatible accross multiple compilers on Mac
# must be place in this file
MESSAGE(STATUS "Including file: Darwin64.cmake")
MESSAGE(STATUS "Loading MaxOSX specific configuration")

# set mac os default deployment minimum to 10.7
IF(NOT CMAKE_OSX_DEPLOYMENT_TARGET)
    SET(CMAKE_OSX_DEPLOYMENT_TARGET "10.8")
ENDIF(NOT CMAKE_OSX_DEPLOYMENT_TARGET)

#############################################
#determine sdk to build on if not explicitly suplied
IF(NOT CMAKE_OSX_SYSROOT)
    EXECUTE_PROCESS(COMMAND "xcrun" "--show-sdk-path" OUTPUT_VARIABLE XCRUN_OSX_SYSROOT 
    	RESULT_VARIABLE XCRUN_OSX_SYSROOT_STATUS OUTPUT_STRIP_TRAILING_WHITESPACE)
    IF(XCRUN_OSX_SYSROOT_STATUS EQUAL 0)
    	SET(CMAKE_OSX_SYSROOT ${XCRUN_OSX_SYSROOT})
    ENDIF(XCRUN_OSX_SYSROOT_STATUS EQUAL 0)	
    UNSET(XCRUN_OSX_SYSROOT)
    UNSET(XCRUN_OSX_SYSROOT_STATUS)
ENDIF(NOT CMAKE_OSX_SYSROOT)

# this code only builds for mac os 64 bit arch
SET(CMAKE_OSX_ARCHITECURES "x86_64")
SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -isysroot")
SET(EXTRA_COMPILER_FLAGS ${EXTRA_COMPILER_FLAGS} "-m64 -march=native")

ADD_DEFINITIONS(-DGTEST_USE_OWN_TR1_TUPLE=1)
