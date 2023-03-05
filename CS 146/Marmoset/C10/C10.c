#include <stdio.h>
#include "C10.h"

int main() {
  int m, n;

  while (scanf("%d %d", &m, &n) == 2) {
    printNums(m, n);
  }
}

void printNums(int m, int n) {
    //Start from i = m-1
    int i = m-1;
    int j = 1;
    int temp_i;
    int reversed_i;

    goto ContinueI;

    //Increment i by 1
    //Go to check if i is a palindrome
    IncrementI:
        i++;
        goto CheckPalindrome;

    //Start from j = 1
    //Go to continue with j
    CheckSquareFree:
        j = 1;
        goto ContinueJ;
    
    //Continue to go to increment as long as (j+1)^2 <= i
    //If the condition is not met then i is square-free so print i
    ContinueJ:
        if ((j+1)*(j+1) <= i) goto IncrementJ;
        goto PrintI;
    
    //Increment j by 1
    IncrementJ:
        j++;
        goto SquareFactor;

    //Check if j^2 is a factor of i
    //If the condition is met then i is not square-free so continue with the next i
    //If the condition is not met then continue with the next j
    SquareFactor:
        if (i%(j*j) == 0) goto ContinueI;
        goto ContinueJ;
    
    //Start from temp_i = i reversed_i = 0 and go to the reverse process of i
    CheckPalindrome:
        temp_i = i;
        reversed_i = 0;
        goto ReverseI;

    //Check if temp_i still has digits left
    //If the condition is met go to add the next digit from the "stack" of digits on temp_i
    //If the condition is not met the reversal is complete so check if reversed_i is the same as i
    //If the condition is met go to check if i is square-free
    //If the condition is not met continue with the next i
    ReverseI:
        if (temp_i > 0) goto AddDigit;
        if (reversed_i == i) goto CheckSquareFree;
        goto ContinueI;
    
    //Use arithmetic to take the leftover end digit from temp_i and add it as a unit to reversed_i effectively shifting the rest of reversed_i to the left
    //Remove the unit of temp_i so that the rest of the digits move right
    //Go to continue the reversal process of i
    AddDigit:
        reversed_i = reversed_i*10 + temp_i%10;
        temp_i /= 10;
        goto ReverseI;

    //Print i once it meets all conditions
    PrintI:
        printf("%d\n", i);
        goto ContinueI;

    //Continue to go to increment as long as i < n
    //This code is put at the end because all other labels have a recourse if the condition is not met so they will not run over to the next label by accident
    //Since continue must end at some point but printNums is a void we should not return a value so instead we make sure it runs to the end of the function body once the condition is not met
    ContinueI:
        if (i < n) goto IncrementI;
}