#include <stdio.h>
#include <string.h>
#include <stdlib.h>

struct Node {
    struct Node *next;
    char *word;
    int index;
};

void find_print(char temp[], struct Node *current) {
    if (current->index != -1 && strcmp(temp, current->word) == 0) {
        printf("%d", current->index);
    }
    else if (current->next == NULL) {
        struct Node *new = malloc(sizeof(struct Node));
        new->next = NULL;
        new->word = malloc(sizeof(char)*(strlen(temp)+1));
        strcpy(new->word, temp);
        new->index = (current->index)+1;
        current->next = new;

        printf("%s", temp);
    }
    else {
        find_print(temp, current->next);
    }
}

int main() {
    char temp[100];
    struct Node *root = malloc(sizeof(struct Node));
    root->index = -1;
    root->next = NULL;
    
    for (char i = getchar(); i != EOF; i = getchar()) {
        ungetc(i, stdin);
        scanf("%s", temp);

        find_print(temp, root);

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