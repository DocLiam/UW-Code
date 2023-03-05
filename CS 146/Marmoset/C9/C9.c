#include <stdio.h>
#include <stdlib.h>

struct Node {
    int bigit;
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

void print_num(struct Node *nlst) {
    if (nlst == NULL) printf("0");
    else if (nlst->next != NULL) {
        print_num(nlst->next);

        if (nlst->bigit < 10) printf("000%d", nlst->bigit);
        else if (nlst->bigit < 100) printf("00%d", nlst->bigit);
        else if (nlst->bigit < 1000) printf("0%d", nlst->bigit);
        else printf("%d", nlst->bigit);
    }
    else printf("%d", nlst->bigit);
}

struct Node *cons_bigit(int bgt, struct Node *nxt) {
    if (bgt == 0 && nxt == NULL) return NULL;

    struct Node *new = malloc(sizeof(struct Node));

    new->bigit = bgt;
    new->next = nxt;

    return new;
}

void free_num(struct Node *blst) {
    struct Node *temp1 = blst;
    struct Node *temp2;

    while (temp1 != NULL) {
        temp2 = temp1->next;
        free(temp1);
        temp1 = temp2;
    }
}

struct Node *copy_num(struct Node *nlst) {
    struct Node *temp = nlst;
    struct Node *new = NULL;

    while (temp != NULL) {
        new = cons_bigit(temp->bigit, new);
        temp = temp->next;
    }

    return reverse(new);
}

struct Node *add(struct Node *n1lst, struct Node *n2lst) {
    struct Node *temp1 = n1lst;
    struct Node *temp2 = n2lst;

    struct Node *new = NULL;

    int bgt1, bgt2;
    int carry = 0;

    while (temp1 != NULL || temp2 != NULL || carry > 0) {
        if (temp1 != NULL) {
            bgt1 = temp1->bigit;
            temp1 = temp1->next;
        }
        else bgt1 = 0;
        if (temp2 != NULL) {
            bgt2 = temp2->bigit;
            temp2 = temp2->next;
        }
        else bgt2 = 0;

        new = cons_bigit((bgt1+bgt2+carry)%10000, new);

        carry = (bgt1+bgt2+carry)/10000;
    }

    return reverse(new);
}


struct Node *mult(struct Node *n1lst, struct Node *n2lst) {
    struct Node *temp1 = n1lst;
    struct Node *temp2 = n2lst;
    struct Node *temp2_copy = temp2;

    if (temp1 == NULL || temp2 == NULL) return NULL;

    struct Node *new = NULL;
    struct Node *new_copy = new;
    struct Node *new_temp = new;

    int carry, bgt1, bgt2;
    
    while (temp1 != NULL) {
        temp2 = n2lst;

        if (new_copy == NULL) {
            carry = 0;

            while (temp2 != NULL || carry > 0) {
                if (temp2 == NULL) bgt2 = 0;
                else {
                    bgt2 = temp2->bigit;
                    temp2 = temp2->next;
                }

                new = cons_bigit((bgt2*temp1->bigit+carry)%10000, new);

                carry = (bgt2*temp1->bigit+carry)/10000;
            }

            new_copy = reverse(new);
            new = new_copy;
        }
        else {
            carry = 0;

            while (temp2 != NULL || carry > 0) {
                if (temp2 == NULL) bgt2 = 0;
                else bgt2 = temp2->bigit;

                new_temp->bigit += bgt2*temp1->bigit+carry;
                carry = new_temp->bigit/10000;
                new_temp->bigit = new_temp->bigit%10000;

                if (new_temp->next == NULL && (carry > 0 || (temp2 != NULL && temp2->next != NULL))) {
                    new_temp->next = cons_bigit(-1, NULL);
                    new_temp->next->bigit = 0;
                }

                if (temp2 != NULL) temp2 = temp2->next;
                new_temp = new_temp->next;
            }
        }
        
        temp1 = temp1->next;
        if (new->next == NULL && temp1 != NULL) {
            new->next = cons_bigit(-1, NULL);
            new->next->bigit = 0;
        }
        new = new->next;
        new_temp = new;
    }

    return new_copy;
}

int main() {
    struct Node *test1 = NULL;
    for (int i = 0; i < 2800; i++) test1 = cons_bigit(9999, test1);
    struct Node *test2 = cons_bigit(9999, NULL);

    struct Node *test3 = add(test1, test2);

    struct Node *test4 = mult(test1, test3);
    
    print_num(test1);

    printf("\n");

    free_num(test1);

    print_num(test2);

    printf("\n");

    free_num(test2);

    print_num(test3);

    printf("\n");

    free_num(test3);

    print_num(test4);

    printf("\n");

    free_num(test4);

    return 0;
}