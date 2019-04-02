//
// Created by Connor Jones on 2019-04-02.
//

// Print the block
void PrintArray (int out[4][4]){
    const int MES_SIZE = 4;
    int i, j;

    for(i = 0; i < MES_SIZE; i++){
        for(j = 0; j < MES_SIZE; j++){
            printf("%X, ", out[i][j]);
        }
        printf("\n");
    }
    printf("\n");
}

// Mixed columns using FF multiplication
void MixColumns(int in [4][4]){
    int i, n;
    // columns 0-3
    for (i = 0; i <= 3; i++) {
        // Rows 0-3
        for (n = 0; n <= 3; n++) {
            out[n][i] =
                    FF_mul(in[0][i], Rij[n][0], 2) ^ FF_mul(in[1][i], Rij[n][1], 2) ^ FF_mul(in[2][i], Rij[n][2], 2) ^
                    FF_mul(in[3][i], Rij[n][3], 2);
        }
    }
}
void MixColsHT2 (int in [4][4]){
    for (int i = 0; i < 4; i++){

        out[3][i] = (XTime(in[i][3] ^ in[i][0])) ^ (in[i][1] ^ in[i][2]) ^ in[i][0];
        out[0][i] = (XTime(in[i][0] ^ in[i][1])) ^ (in[i][2] ^ in[i][3]) ^ in[i][1];
        out[1][i] = (XTime(in[i][1] ^ in[i][2])) ^ (in[i][3] ^ in[i][0]) ^ in[i][2];
        out[2][i] = (XTime(in[i][2] ^ in[i][3])) ^ (in[i][0] ^ in[i][1]) ^ in[i][3];


    }
}
// Mixed columns using xor only
// Using FF addition
void ENC_MixColsHT(int in [4][4]){
    int xor[12];
    for (int i = 0; i < 4; i++) {
        // Top row of xor gates.
        xor[0] = in[3][i] ^ in[0][i];
        xor[1] = in[0][i] ^ in[1][i];
        xor[2] = in[1][i] ^ in[2][i];
        xor[3] = in[2][i] ^ in[3][i];

        // Second row of xor gates
        xor[4] = in[0][i] ^ xor[2];
        xor[5] = in[1][i] ^ xor[3];
        xor[6] = in[2][i] ^ xor[0];
        xor[7] = in[3][i] ^ xor[1];

        // Third row of xor gates
        xor[8] = XTime(xor[0]) ^ xor[4];
        xor[9] = XTime(xor[1]) ^ xor[5];
        xor[10] = XTime(xor[2]) ^ xor[6];
        xor[11] = XTime(xor[3]) ^ xor[7];

        //Assign to the output matrix
        //out[0][i] = xor[9];
        //out[1][i] = xor[10];
        //out[2][i] = xor[11];
        //out[3][i] = xor[8];

        out[0][i] = XTime(in[0][i] ^ in[1][i]) ^ (in[1][i] ^ (in[2][i] ^ in[3][i]));
        out[1][i] = XTime(in[1][i] ^ in[2][i]) ^ (in[2][i] ^ (in[3][i] ^ in[0][i]));
        out[2][i] = XTime(in[2][i] ^ in[3][i]) ^ (in[3][i] ^ (in[0][i] ^ in[1][i]));
        out[3][i] = XTime(in[3][i] ^ in[0][i]) ^ (in[0][i] ^ (in[1][i] ^ in[2][i]));
    }
}

// UnMix columns
void DEC_MixColsHT(int in[4][4]) {
    int xor[21], tmp[5];
    for (int i = 0; i < 4; i++) {
        // Top row of xor gates.
        xor[0] = in[3][i] ^ in[0][i];
        xor[1] = in[0][i] ^ in[1][i];
        xor[2] = in[1][i] ^ in[2][i];
        xor[3] = in[2][i] ^ in[3][i];

        // Second row of xor gates
        xor[4] = in[0][i] ^ xor[2];
        xor[5] = in[1][i] ^ xor[3];
        xor[6] = in[2][i] ^ xor[0];
        xor[7] = in[3][i] ^ xor[1];

        // Third row of xor gates
        xor[8] = XTime(xor[0]) ^ xor[4];
        xor[9] = XTime(xor[1]) ^ xor[5];
        xor[10] = XTime(xor[2]) ^ xor[6];
        xor[11] = XTime(xor[3]) ^ xor[7];

        // End of part 1
        xor[12] = in[0][i] ^ in[2][i];
        xor[13] = in[1][i] ^ in[3][i];

        tmp[0] = X4Time(xor[12]);
        tmp[1] = X4Time(xor[13]);

        xor[14] = tmp[0] ^ tmp[1];
        tmp[3] = XTime(xor[14]);
        xor[14] = tmp[3];

        // -----------------------------------------------
        // -------------- Part 2 -------------------------
        // -----------------------------------------------

        xor[15] = tmp[0] ^ xor[14];  // first left xor
        xor[16] = tmp[1] ^ xor[14];	 // first right xor

        xor[17] = xor[9] ^ xor[15];  // second left xor OUTPUT 0
        xor[18] = xor[11] ^ xor[15]; // second right xor OUTPUT 2

        xor[19] = xor[10] ^ xor[16]; // thrid right xor OUTPUT 1
        xor[20] = xor[8] ^ xor[16];  // third left xor OUTPUT 3

        //Assign to the output matrix
        out[0][i] = xor[17];
        out[1][i] = xor[19];
        out[2][i] = xor[18];
        out[3][i] = xor[20];


    }

}
void MixColENCorDEC(int in[4][4], int encode) {
    switch (encode) {
        case 0:
            // Encrypt
            ENC_MixColsHT(in[4][4]);
            break;
        case 1:
            // Decrypt
            DEC_MixColsHT(in[4][4]);
            break;
    }
}
// function to multiply by 2 constantly
int XTime (int input){
    const int rijn_poly = 0x11B;
    int output = input << 1;

    if (output > 0b100000000){
        // overflowed!
        output ^= rijn_poly;
    }
    else {
        output = output;
    }
    return output;
}

int X4Time(int input) {
    int output = XTime(input);
    int tmp = XTime(output);
    output = tmp;
    return output;
}

