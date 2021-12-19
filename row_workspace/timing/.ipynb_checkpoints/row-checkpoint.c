#include <stdio.h>

#define W1 2841
#define W2 2676
#define W3 2408
#define W5 1609
#define W6 1108
#define W7 565

void njRowIDCT(int*);

void main()
{
    int A[8] = {1,3,4,0,2,1,3,2};
    njRowIDCT(A);
    for (int i=0;i<8;i++){
        printf("%d\n",A[i]);
    }
}

void njRowIDCT(int* blk) {
    int x0, x1, x2, x3, x4, x5, x6, x7, x8;
    int lol,rofl;
    lol = !((x1 = blk[4] << 11)
        | (x2 = blk[6])
        | (x3 = blk[2])
        | (x4 = blk[1])
        | (x5 = blk[7])
        | (x6 = blk[5])
        | (x7 = blk[3]));
    //printf("Flag check:%d\n",lol);
    if (lol)
    {
        printf("yes the rare case");
        blk[0] = blk[1] = blk[2] = blk[3] = blk[4] = blk[5] = blk[6] = blk[7] = blk[0] << 3;
        return;
    }
    x0 = (blk[0] << 11) + 128;
    x8 = W7 * (x4 + x5);
    x4 = x8 + (W1 - W7) * x4;
    x5 = x8 - (W1 + W7) * x5;
    x8 = W3 * (x6 + x7);
    x6 = x8 - (W3 - W5) * x6;
    x7 = x8 - (W3 + W5) * x7;
    x8 = x0 + x1; //sum01
    x0 -= x1;  //diff01
    x1 = W6 * (x3 + x2);
    x2 = x1 - (W2 + W6) * x2;
    x3 = x1 + (W2 - W6) * x3;
    x1 = x4 + x6; //sum46
    x4 -= x6;   //diff46
    x6 = x5 + x7;  //sum57
    x5 -= x7;  //diff57
    x7 = x8 + x3; // sum013 = sum01 + x3
    x8 -= x3;  //diff013 = sum01 - x3
    x3 = x0 + x2;  //sum012 = diff01 +x2
    x0 -= x2;   //diff012 = diff01 -x2
    x2 = (181 * (x4 + x5) + 128) >> 8;
    x4 = (181 * (x4 - x5) + 128) >> 8;
    printf("Value of diff012,sum46,x22,sum012,x44,diff57,sum57,sum013 %d,%d,%d,%d,%d,%d,%d,%d\n",x0,x1,x2,x3,x4,x5,x6,x7);
    blk[0] = (x7 + x1) >> 8;
    blk[1] = (x3 + x2) >> 8;
    blk[2] = (x0 + x4) >> 8;
    blk[3] = (x8 + x6) >> 8;
    blk[4] = (x8 - x6) >> 8;
    blk[5] = (x0 - x4) >> 8;
    blk[6] = (x3 - x2) >> 8;
    blk[7] = (x7 - x1) >> 8;
}