//
// Created by Connor Jones on 2019-01-14.
//

#include <stdio.h>
#include "FFArith.h"
#ifndef AES_H
#define AES_H

//  Define the Rijdael matrix
const int Rij[4][4] = {
        {0x02,0x03,0x01,0x01},
        {0x01,0x02,0x03,0x01},
        {0x01,0x01,0x02,0x03},
        {0x03,0x01,0x01,0x02},
};

const int InvRij [4][4] = {
        {0x0e,0x09,0x0d,0x0b},
        {0x0b,0x0e,0x09,0x0d},
        {0x0d,0x0b,0x0e,0x09},
        {0x0d,0x0b,0x0b,0x0e}
};

// Function protoypes
void PrintArray(int out[4][4]);
void MixColumns(int in[4][4]);
void ENC_MixColsHT(int in[4][4]);
void DEC_MixColsHT(int in[4][4]);
void MixColsHT2(int in[4][4]);


#endif
