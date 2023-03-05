#include <stdio.h>

struct Node {
    int data;
    struct Node *next;
};

struct Node *reverse(struct Node *lst) {
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

int main() {
    struct Node node1, node2, node3, node4, current;

    node4.data = 3;
    node4.next = NULL;
    node3.data = 2;
    node3.next = &node4;
    node2.data = 1;
    node2.next = &node3;
    node1.data = 0;
    node1.next = &node2;

    printf("test\n");
    current = node1;

    for (int i = 0; i < 4; i++) {
        printf("%d\n", current.data);
        if (i != 3) current = *current.next;
    }

    current = *reverse(&node1);

    for (int i = 0; i < 4; i++) {
        printf("%d\n", current.data);
        if (i != 3) current = *current.next;
    }

    return 0;
}