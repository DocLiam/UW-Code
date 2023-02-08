#include <stdio.h>

int isqrt(int n){
    int i_lower = 1;
    int i_upper = n;
    
    int i_mid, mid_div;

    while (i_lower <= i_upper){
        i_mid = (i_lower+i_upper)/2;
        mid_div = n/i_mid;

        if (mid_div == i_mid) return i_mid;

        if (i_mid < mid_div) i_lower = i_mid+1;
        else if (i_mid > mid_div) i_upper = i_mid-1;
    }
    
    if (i_mid > mid_div) return i_mid-1;
    
    return i_mid;
}

void sumsqr(int n){
    int j, j_sqr;

    for (int i = isqrt(n/2)+1; i >= 0; i--){
        j_sqr = n-(i*i);
        j = isqrt(j_sqr);
        
        if (j*j == j_sqr){
            if (j > i) printf("%d %d\n", j, i);
            else printf("%d %d\n", i, j);
        }
    }
}