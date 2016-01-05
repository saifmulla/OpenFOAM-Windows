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
     TestSwap.cpp
 Description
     This file is a test file for validating Swap function
 Creator
     Saif Mulla
 Date
     21/12/2015
\*---------------------------------------------------------------------------*/
     
#include "Swap.H"
using namespace Foam;

TEST(TestSwap, checkSwap){
	int a = 10;
	int b = 20;
    Swap(a,b);
    SUCCEED();
}

TEST(TestSwap, checkInt){
	int a = 10;
	int b = 20;
	Swap(a,b);
	ASSERT_EQ(a,20);
	ASSERT_EQ(b,10);
}

TEST(TestSwap, checkFloat){
	float a = 0.10;
	float b = 0.010;
	Swap<float>(a,b);
	EXPECT_FLOAT_EQ(a,0.010);
	EXPECT_FLOAT_EQ(b,0.10);
}
