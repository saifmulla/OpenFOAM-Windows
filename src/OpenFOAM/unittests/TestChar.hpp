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
     TestChar.cpp
 Description
     This file is a test file for validating class char
 Creator
     Saif Mulla
 Date
     23/12/2015
\*---------------------------------------------------------------------------*/

#include "char/char.H"
using namespace Foam;

TEST(TestChar, checkIsspace){
    ASSERT_TRUE(isspace(' '));
}

TEST(TestChar, checkIsspacenewline){
    ASSERT_TRUE(isspace('\n'));
}

TEST(TestChar, checkIsspaceslash){
    ASSERT_TRUE(isspace('\r'));
}

TEST(TestChar, checkIsspacetab){
    ASSERT_TRUE(isspace('\t'));
}



