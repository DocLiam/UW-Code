#include "array.h"
#include <stdio.h>

void shift(int lower, int upper, int direction) {
    if (direction == -1) for (int i = lower; i <= upper; i++) put(i-1, get(i));
    else if (direction == 1) for (int i = upper; i >= lower; i--) put(i+1, get(i));
}

int main() {
    int stack_id, value;

    int s1_top, s2_top, s3_lower, s3_upper;

    s1_top = -1;
    s2_top = 21;

    s3_lower = 7;
    s3_upper = 6;

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
                        shift(s3_lower, s3_upper, 1);
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
                        shift(s3_lower, s3_upper, -1);
                        s3_upper--;
                        s3_lower--;
                    }
                    
                    s2_top--;
                    put(s2_top, value);
                }

                break;
            case 3:
                if (action == 'o') {
                    printf("%d\n", get(s3_upper));
                    scanf("%d\n", NULL);

                    s3_upper--;
                }
                else if (action == 'u') {
                    if (s3_upper == s3_lower-1) {
                        s3_lower = (int) ((s1_top+s2_top)/2);
                        s3_upper = s3_lower;
                    }
                    else if (s3_upper == s2_top-1) {
                        shift(s3_lower, s3_upper, -1);
                        s3_lower--;
                    }
                    else {
                        s3_upper++;
                    }

                    put(s3_upper, value);
                }

                break;
            default:
                break;
        }
    }

    return 0;
}