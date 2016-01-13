TEST(TestWindowsExport,checkValues){
 #ifdef _MSC_VER
 	ASSERT_EQ(1,FEXPORT);
 #elif defined(__linux__) || (__APPLE__)
 	ASSERT_EQ(0,FEXPORT);
 #endif
 }