/**
 * all test cases for testing Hashes functionality
 * such as SHA1Digest, SHA1 and Hasher classes
 */
 #include "SHA1/SHA1Digest.H"

// test SHADigest constructor
TEST(TestHasher,construct){
    Foam::SHA1Digest sh1d();
}

TEST(TestHasher,str){
	Foam::SHA1Digest sh1d;
	sh1d.str();
}

TEST(TestHasher,equality){
	Foam::SHA1Digest sh1d;
	Foam::SHA1Digest sh2d;

	if(sh1d == sh2d)
		SUCCEED();
	else
		FAIL();

	const std::string hexdigest = "_0123456789abcdef";

	if(sh1d == hexdigest)
		FAIL();
}