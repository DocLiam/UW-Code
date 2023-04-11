#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <ctype.h>

struct Node {
    struct Node *next;
    char *word;
    int index;
};

void find_print(int index, struct Node *current) {
    if (current->index == index) printf("%s", current->word);
    else find_print(index, current->next);
}

int main() {
    char temp[100];
    struct Node *root = NULL;

    for (int i = getchar(); i != EOF; i = getchar()) {
        ungetc(i, stdin);
        scanf("%s", temp);

        int isint = 1;

        for (int j = 0; temp[j] != '\0'; ++j) if (!isdigit(temp[j])) isint = 0;

        if (isint == 0) {
            struct Node *new = malloc(sizeof(struct Node));
            if (root == NULL) new->index = 0;
            else new->index = (root->index)+1;

            new->word = malloc(sizeof(char)*(strlen(temp)+1));
            strcpy(new->word, temp);
            new->next = root;
            root = new;

            printf("%s", temp);
        }
        else {
            find_print(atoi(temp), root);
        }

        char whitespace = getchar();

        for (whitespace = whitespace; whitespace == ' ' || whitespace == '\n'; whitespace = getchar()) {
            if (whitespace != EOF) printf("%c", whitespace);
            else {
                ungetc(whitespace, stdin);
                break;
            }
        }
        if (whitespace != EOF) ungetc(whitespace, stdin);
    }

    return 0;
}