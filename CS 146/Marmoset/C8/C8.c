#include <stdio.h>

struct Node {
    int data;
    struct Node *next;
};

struct Node *reverse(struct Node *lst) {
    if (lst == NULL) return NULL;

    struct Node *prev = NULL;
    struct Node *first = lst;
    struct Node rest = *lst;
    
    while (first != NULL) {
        first->next = prev;
        prev = first;
        if (rest.next != NULL) first = rest.next;
        else break;
        rest = *rest.next;
    }

    return first;
}