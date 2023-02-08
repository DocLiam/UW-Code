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