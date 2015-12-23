/*---------------------------------------------------------------------------*\
  =========                 |
  \\      /  F ield         | OpenFOAM: The Open Source CFD Toolbox
   \\    /   O peration     |
    \\  /    A nd           | Copyright (C) 2011 OpenFOAM Foundation
     \\/     M anipulation  |
-------------------------------------------------------------------------------
License
    This file is part of OpenFOAM.

    OpenFOAM is free software: you can redistribute it and/or modify it
    under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    OpenFOAM is distributed in the hope that it will be useful, but WITHOUT
    ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
    FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
    for more details.

    You should have received a copy of the GNU General Public License
    along with OpenFOAM.  If not, see <http://www.gnu.org/licenses/>.
 file
     TestContiguous.cpp
 Description
     This file is a test file for validating class contiguous
 Creator
     Saif Mulla
 Date
     21/12/2015
\*---------------------------------------------------------------------------*/

#include <iostream>
#include "gtest/gtest.h"
#include "windowsExport.H"
#include "contiguous.H"
using namespace Foam;

TEST(TestContiguous, checkint){
    int a = 1;
	bool check = contiguous<int>();
    ASSERT_TRUE(check);
}

TEST(TestContiguous, checkbool){
    ASSERT_TRUE(contiguous<bool>());
}

TEST(TestContiguous, checkchar){
    ASSERT_TRUE(contiguous<char>());
}

TEST(TestContiguous, checklong){
    ASSERT_TRUE(contiguous<long>());
}

TEST(TestContiguous, checkLongDouble){
    ASSERT_TRUE(contiguous<long double>());
}

TEST(TestContiguous, checkfloat){
    ASSERT_TRUE(contiguous<float>());
}

TEST(TestContiguous, checkdouble){
    ASSERT_TRUE(contiguous<double>());
}

int main(int argc, char *argv[]){
    ::testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}

