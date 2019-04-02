#include <stdio.h>
#include <string.h>
#include "AES.h"
#include "FFArith.h"


int XTime (int input);
int X4Time(int input);

// Global variables
int in1[4][4] = {
        {0x17,0x89,0xe3,0x88},
        {0x29,0x60,0xce,0x9f},
        {0xd6,0x2e,0x5a,0x94},
        {0x2a,0x24,0x64,0x61}
};

int in2[4][4] = {
        {0x87, 0xF2, 0x4D, 0x97},
        {0x6E, 0x4C, 0x90, 0xEC},
        {0x46, 0xE7, 0x4A, 0xC3},
        {0xA6, 0x86, 0xD8, 0x95}
};

int out[4][4] = {};
int OutCol[4][1] = {};

//--------------------------
//--- MAIN FUNCTION --------
//--------------------------
int main (){


    printf("Input message:\n");
    PrintArray(in1);

    ENC_MixColsHT(in1);
    printf("Encrypted message:\n");
    PrintArray(out);

	DEC_MixColsHT(out);
	printf("Decrypted message:\n");
	PrintArray(out);

    return 0;
}

//--------------------------
//------ END MAIN ----------
//--------------------------

