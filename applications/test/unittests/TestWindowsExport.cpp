//TestWindowsExport.cpp
#include <iostream>
#include "gtest/gtest.h"
//#include "gmock/gmock.h"
#include "windowsExport.H"

 TEST(TestWindowsExport,checkValues){
 #ifdef _MSC_VER
 	ASSERT_EQ(1,FEXPORT);
 #elif defined(__linux__) || (__APPLE__)
 	ASSERT_EQ(0,FEXPORT);
 #endif
 }

int main(int argc, char *argv[]){
    ::testing::InitGoogleTest(&argc,argv);
    return RUN_ALL_TESTS();
}