#include <stdio.h>

int factorise(int n){
    if (n == 1) return 1;

    int n2 = n/2;
    if (n2*2 == n) return factorise(n2);
    else {
        int n3 = n/3;
        if (n3*3 == n) return factorise(n3);
        else {
            int n5 = n/5;
            if (n5*5 == n) return factorise(n5);
            else return 0;
        }
    }
}

void regular(int n){
    for (int i = 1; i <= n; i++) {
        if (factorise(i)) printf("%d\n", i);
    }
}