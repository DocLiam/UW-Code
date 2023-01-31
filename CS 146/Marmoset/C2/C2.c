#include <stdio.h>
#include <ctype.h>

int peekchar(){
    int c = getchar();

    return c == EOF? EOF : ungetc(c, stdin);
}

int getIntHelper(int acc){
    int c = getchar();

    if(isalpha(c)){
        return getIntHelper(16*acc+tolower(c)-'a'+10);
    }
    else{
        if(isdigit(c)){
            return getIntHelper(16*acc+c-'0');
        }
        else{
            return (ungetc(c, stdin), acc);
        }
    }
}

int skipws(){
    int c = getchar();

    if(isspace(c)){
        return skipws();
    }
    else {
        if (c != EOF){
            ungetc(c, stdin);

            return 0;
        }
        else{
            return -1;
        }
    }
}

int getInt(){
    int state = skipws();

    if (state == 0){
        return getIntHelper(0);
    }
    else{
        return -1;
    }
}

int sumInt(int acc){
    int currentInt = getInt();

    if (currentInt == -1){
        return acc;
    }
    else{
        return sumInt(acc + currentInt);
    }
}

int main(){
    printf("%x\n", sumInt(0));

    return 0;
}