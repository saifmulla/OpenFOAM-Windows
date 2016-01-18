# ###############################################
# this is gnug++ and gcc specific confif file 
# for Linux
MESSAGE(STATUS "Generating configuration for Linux g++ compiler")

# ###############################################
# check for GNU compiler version
EXECUTE_PROCESS(COMMAND ${CMAKE_C_COMPILER} -dumpversion
	RESULT_VARIABLE VAR_RESULT
	OUTPUT_VARIABLE VAR_OUTPUT
	ERROR_VARIABLE VAR_OUTPUT
	)

# if the version could not be determined halt compilation
IF(VAR_RESULT GREATER 0)
	MESSAGE(FATAL_ERROR "There appears to be a problem determining "
		"Version number of ${CMAKE_CXX_COMPILER} compiler\n"
		${VAR_OUTPUT})
ENDIF(VAR_RESULT GREATER 0)

# else if version greater than GCC 4.6 then apply c++11 flag
# c++11 flags tend to break on 4.6 due to lack of support
# therefore apply this flag only for greater versions
IF(VAR_OUTPUT VERSION_GREATER 4.7 OR VAR_OUTPUT VERSION_EQUAL 4.7)
	SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=gnu++11")
ELSE
	SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++0x")
ENDIF(VAR_OUTPUT VERSION_EQUAL 4.6 OR VAR_OUTPUT VERSION_EQUAL 4.7)

# determine the exact major and minor version of compiler 
# to set compiler version variable 

ADD_DEFINITIONS(-DGTEST_USE_OWN_TR1_TUPLE=1)
SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -march=native -Wall -Wextra -Wno-unused-parameter -Wold-style-cast")
SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -frounding-math -fsignaling-nans -ftrapping-math")
SET(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -shared -Xlinker --add-needed")
SET(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -Xlinker --no-as-needed")

# compiler options based on build_type
IF(CMAKE_BUILD_TYPE MATCHES Debug)
	SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -O0 -Og")
ELSEIF(CMAKE_BUILD_TYPE MATCHES Release)
	SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -O3 -ftree-slp-vectorize -ftree-vectorize -funroll-loops")
ENDIF(CMAKE_BUILD_TYPE MATCHES Debug)



