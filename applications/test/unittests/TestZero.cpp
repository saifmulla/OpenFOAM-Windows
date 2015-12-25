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
     Testzero.cpp
 Description
     This file is a test file for validating zero class
 Creator
     Saif Mulla
 Date
     21/12/2015
\*---------------------------------------------------------------------------*/

#include <iostream>
#include "gtest/gtest.h"
#include "windowsExport.H"
#include "zero.H"
using namespace Foam;

TEST(TestZero, checkZero){
	zero z;
    SUCCEED();
}

TEST(TestZero, divide){
    zero z;
    z/0;
    SUCCEED();
}

int main(int argc, char *argv[]){
    ::testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}
