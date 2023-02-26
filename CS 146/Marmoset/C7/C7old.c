#include "array.h"
#include <stdio.h>

void shift(int lower, int upper, int direction) {
    if (direction == -1) for (int i = lower; i <= upper; i++) put(i-1, get(i));
    else if (direction == 1) for (int i = upper; i >= lower; i--) put(i+1, get(i));
}

int main() {
    int stack_id, value;

    int s1_top, s2_top, s3_lower, s3_upper, s3_top;

    s1_top = -1;
    s2_top = 21;

    s3_lower = 7;
    s3_upper = 6;

    s3_top = 6;

    int map[3] = {0, 0, 0};

    int previous_mapped = 0;

    for (int action = getchar(); action != EOF; action = getchar()) {
        if (action == 'u') scanf(" %d %d", &stack_id, &value);
        else if (action == 'o') scanf(" %d", &stack_id);

        if (map[stack_id] == 0) {
            map[stack_id] = previous_mapped+1;
            previous_mapped++;
        }
        
        switch (map[stack_id]) {
            case 1:
                if (action == 'o') {
                    printf("%d\n", get(s1_top));
                    scanf("%d\n", NULL);
                    s1_top--;
                }
                else if (action == 'u') {
                    if (s1_top+1 == s3_lower && (s3_upper != s3_lower-1)) {
                        put(s3_upper+1, get(s3_lower));
                        if (s3_top == s3_lower) s3_top = s3_upper+1;
                        s3_lower++;
                        s3_upper++;
                    }
                    
                    s1_top++;
                    put(s1_top, value);
                }

                break;
            case 2:
                if (action == 'o') {
                    printf("%d\n", get(s2_top));
                    scanf("%d\n", NULL);
                    s2_top++;
                }
                else if (action == 'u') {
                    if (s2_top-1 == s3_upper && (s3_upper != s3_lower-1)) {
                        put(s3_lower-1, get(s3_upper));
                        if (s3_top == s3_upper) s3_top = s3_lower-1;
                        s3_upper--;
                        s3_lower--;
                    }
                    
                    s2_top--;
                    put(s2_top, value);
                }

                break;
            case 3:
                if (action == 'o') {
                    printf("%d\n", get(s3_top));
                    scanf("%d\n", NULL);
                    if (s3_lower == s3_top) {
                        s3_top = s3_upper;
                        s3_lower++;
                    }
                    else if (s3_upper == s3_top) {
                        s3_top--;
                        s3_upper--;
                    }
                    else {
                        if ((s3_upper-s3_top) <= (s3_top-s3_lower)) {
                            shift(s3_top+1, s3_upper, -1);
                            s3_upper--;
                            s3_top--;
                        }
                        else if ((s3_upper-s3_top) > (s3_top-s3_lower)) {
                            shift(s3_lower, s3_top-1, 1);
                            s3_lower++;
                        }
                    }
                }
                else if (action == 'u') {
                    if (s3_upper-s3_lower == -1) {
                        s3_lower = s1_top+1+((int) ((s2_top-s1_top)/2));
                        s3_top = s3_lower;
                        s3_upper = s3_top;
                        put(s3_lower, value);
                    }
                    else if (s3_top == s3_lower) {
                        if (s3_lower == s1_top+1) {
                            put(s3_upper+1, get(s3_lower));
                            put(s3_top, value);
                            s3_upper++; 
                        }
                        else {
                            put(s3_lower-1, get(s3_lower));
                            put(s3_top, value);
                            s3_lower--;
                        }
                    }
                    else if (s3_top == s3_upper) {
                        if (s3_upper == s2_top-1) {
                            put(s3_lower-1, value);
                            s3_lower--;
                            s3_top = s3_lower;
                        }
                        else {
                            put(s3_upper+1, value);
                            s3_top++;
                            s3_upper++;
                        }
                    }
                    else if (((s3_upper-s3_top) <= (s3_top-s3_lower) && s3_upper != s2_top-1) || s3_lower == s1_top+1) {
                        s3_top++;
                        shift(s3_top, s3_upper, 1);
                        put(s3_top, value);
                        s3_upper++;
                    }
                    else if (((s3_upper-s3_top) > (s3_top-s3_lower) && s3_lower != s1_top+1) || s3_upper == s2_top-1) {
                        shift(s3_lower, s3_top, -1);
                        put(s3_top, value);
                        s3_lower--;
                    }
                }

                break;
            default:
                break;
        }
    }

    return 0;
}