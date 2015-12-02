#ifndef windowsExport_H
#define windowsExport_H

#ifdef _MSC_VER
    // disable sprintf warnings
    #pragma warning(disable:4996)
    // disable private members in dll export warnings
    #pragma warning(disable:4251)
    #if defined(FOAM_BUILD_SHARED_LIB)
        #define FOAMEXPORT __declspec(dllexport)
        #define FEXPORT 1
    #else
		#define FOAMEXPORT __declspec(dllimport)
        #define FEXPORT 2
    #endif
#else
    #define FOAMEXPORT // Unix like systems including Mac
    #define FEXPORT 0
#endif

#endif
// ************************************************************************* //