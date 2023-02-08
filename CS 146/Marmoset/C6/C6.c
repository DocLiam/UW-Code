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

int prime(int n){
    int n_sqrt = isqrt(n);
    int n_div;

    if (n == 1) return 0;

    for (int i = 2; i <= n_sqrt; i++){
        n_div = n/i;

        if (n_div*i == n) return 0;
    }
    
    return 1;
}

void prime_factors(int n){
    int n_sqrt = isqrt(n);
    int n_div;

    for (int i = 1; i <= n_sqrt; i++){
        n_div = n/i;

        if (n_div*i == n){
            if (prime(i)){
                printf("%d\n", i);

                prime_factors(n_div);

                break;
            }
            else if (prime(n_div)){
                printf("%d\n", n_div);

                break;
            }
        }
    }
}
