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

MAKE_DIRECTORY(${CMAKE_CURRENT_BINARY_DIR}/lnInclude)
# check if directory is successfully created if not abort build process
IF(NOT EXISTS ${CMAKE_CURRENT_BINARY_DIR}/lnInclude)
    MESSAGE(FATAL_ERROR 
        "lnInclude directory inside ${CMAKE_CURRENT_BINARY_DIR} could not be created, aborting build...")
ELSE(NOT EXISTS ${CMAKE_CURRENT_BINARY_DIR}/lnInclude)
    MESSAGE(STATUS
        "created directory 'lnInclude' inside ${CMAKE_CURRENT_BINARY_DIR}/lnInclude")
ENDIF(NOT EXISTS ${CMAKE_CURRENT_BINARY_DIR}/lnInclude)

# ###############################################
# copy all header files from all subdirectories inside OpenFOAM
# directory into a list
# further create symbolic links to these files inside lnInclude
# for source codes to compile, this will help in keeping
# all header files at one places which searching for
# source headers

SET(USER_PLATFORM_NAME ${CMAKE_SYSTEM_NAME})
FILE(GLOB_RECURSE LIST_HEADERS . EXCLUDE lnInclude "*.H")
# ##############################################
#         *****TODO*****                       #
# This process of symbolic linking requires    #
# more refined and efficient approach presently#
# it is very inefficient on windows by doing 
# hard copying due to lack of success in 
# add_custom_command using cmake -e copy
# EXECUTE_PROCESS
# However it will be lot better to have common #
# command working on all platforms 
# This submitted as issue on github page, 
# tagged with #4 issue
# ##############################################
#loop over all the header files generated in list
FOREACH(HEADER ${LIST_HEADERS})
    GET_FILENAME_COMPONENT(FILE_NAME ${HEADER} NAME)#generate the real file name
    # check if file already exists, if yes then retain it
    IF(NOT EXISTS ${CMAKE_CURRENT_BINARY_DIR}/lnInclude/${FILE_NAME})
        IF(USER_PLATFORM_NAME MATCHES "Windows")
            # if windows then make hard copy of each file to lnInclude
            FILE(COPY ${HEADER} DESTINATION ${CMAKE_CURRENT_BINARY_DIR}/lnInclude/)
        ELSEIF(USER_PLATFORM_NAME MATCHES "Linux" OR USER_PLATFORM_NAME MATCHES "Darwin")
            # if linux or mac, execute command to create symbolic links
            EXECUTE_PROCESS(COMMAND ln -s ${HEADER} src/OpenFOAM/lnInclude/${FILE_NAME}
                RESULT_VARIABLE result
                OUTPUT_VARIABLE output
                ERROR_VARIABLE error
            )
            #check if ${error} variable is empty otherwise generate fatal error and abort build
            IF(NOT result EQUAL "0")
                MESSAGE(FATAL_ERROR "failed to create symbolic link on ${FILE_NAME}
                error => ${error}")
            ENDIF(NOT result EQUAL "0")
            # unset all variables
            UNSET(result)
            UNSET(output)
            UNSET(error)    
        ENDIF(USER_PLATFORM_NAME MATCHES "Windows")
    ENDIF(NOT EXISTS ${CMAKE_CURRENT_BINARY_DIR}/lnInclude/${FILE_NAME})# endif file exists
ENDFOREACH(HEADER ${LIST_HEADERS}) #end foreach list dir

# ###############################################
# now point to lnInclude directory for source compilations
INCLUDE_DIRECTORIES(
    ${CMAKE_CURRENT_BINARY_DIR}/lnInclude
    )

# ###############################################
# add source files to the list to be compiled into shared lib
# this list is intentionally kept manual to avoid cmake 
# file(GLOB_RECURSE) problems also to keep it efficient
# for every file to be compilied must be appended manually
# to SOURCE_FILES variable
SET(SOURCE_FILES 
    ${CMAKE_CURRENT_SOURCE_DIR}/primitives/bool/bool.C
    )

# ###############################################
# add target to create shared library
ADD_LIBRARY(${SHARED_LIB_NAME} SHARED ${SOURCE_FILES})
