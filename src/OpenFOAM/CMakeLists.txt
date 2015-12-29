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
# create a directory lnInclude for all header files to be
# included
EXECUTE_PROCESS(COMMAND mkdir -p src/OpenFOAM/lnInclude RESULT_VARIABLE result
                OUTPUT_VARIABLE statusvar
                ERROR_VARIABLE errorvar)
# check if directory is successfully created if not abort build process
IF(${result} EQUAL "0")
    UNSET(result)
    UNSET(statusvar)
    UNSET(errorvar)
    MESSAGE(STATUS "created directory 'lnInclude' inside ${CMAKE_CURRENT_SOURCE_DIR}/lnInclude")
ELSE (${result} EQUAL "0")
    MESSAGE(FATAL_ERROR "lnInclude directory inside OpenFOAM could not be created, aborting build...")
ENDIF(${result} EQUAL "0")

# ###############################################
# copy all header files from all subdirectories inside OpenFOAM
# directory into a list
# further create symbolic links to these files inside lnInclude
# for source codes to compile, this will help in keeping
# all header files at one places which searching for
# source headers

FILE(GLOB_RECURSE LIST_DIR_H . EXCLUDE lnInclude "*.H")
#loop over all the header files generated in list
FOREACH(LIST_DIR_H ${LIST_DIR_H})
    GET_FILENAME_COMPONENT(FILE_NAME ${LIST_DIR_H} NAME)#generate the real file name
    # check if file already exists, if yes then retain it
    IF(NOT EXISTS src/OpenFOAM/lnInclude/${FILE_NAME})
        #execute command to create symbolic links
        EXECUTE_PROCESS(COMMAND ln -s ${LIST_DIR_H} src/OpenFOAM/lnInclude/${FILE_NAME}
            RESULT_VARIABLE result
            OUTPUT_VARIABLE output
            ERROR_VARIABLE error
        )
        # check if ${error} variable is empty otherwise generate fatal error and abort build
        IF(NOT result EQUAL "0")
            MESSAGE(FATAL_ERROR "failed to create symbolic link on ${FILE_NAME}
            error => ${error}")
        ENDIF(NOT result EQUAL "0")
        # unset all variables
        UNSET(result)
        UNSET(output)
        UNSET(error)
    ENDIF(NOT EXISTS src/OpenFOAM/lnInclude/${FILE_NAME})# endif file exists
ENDFOREACH(LIST_DIR_H ${LIST_DIR_H}) #end foreach list dir

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





