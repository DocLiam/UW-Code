#include <stdio.h>
#include <stdlib.h>

struct Node {
    int bigit;
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

void print_num_helper(struct Node *nlst) {
    if (nlst != NULL) {
        print_num_helper(nlst->next);

        if (nlst->next != NULL || nlst->bigit != 0) {
            if (nlst->next == NULL || nlst->bigit >= 1000) printf("%d", nlst->bigit);
            else if (nlst->bigit < 10) printf("000%d", nlst->bigit);
            else if (nlst->bigit < 100) printf("00%d", nlst->bigit);
            else if (nlst->bigit < 1000) printf("0%d", nlst->bigit);
        }
    }
}

int all_zero(struct Node *nlst) {
    if (nlst == NULL) return 1;
    else if (nlst->bigit == 0) return all_zero(nlst->next);
    return 0;
}

int cull_zeroes(struct Node *nlst) {
    if (nlst != NULL) {
        int still_zeroes = cull_zeroes(nlst->next);

        if (still_zeroes) {
            if (nlst->next != NULL) free(nlst->next);
            nlst->next = NULL;

            if (nlst->bigit == 0) return 1;
        }
        return 0;
    }
    else return 1;
}

struct Node *cons_bigit(int bgt, struct Node *nxt) {
    struct Node *first = malloc(sizeof(struct Node));

    first->bigit = bgt;
    first->next = nxt;

    return first;
}

void free_num(struct Node *blst) {
    struct Node *temp;

    while (blst != NULL) {
        temp = blst;
        blst = blst->next;
        free(temp);
    }
}

struct Node *copy_num(struct Node *nlst) {
    struct Node *temp = nlst;
    struct Node *new;

    if (temp == NULL) new = NULL;
    else new = (struct Node *) malloc(sizeof(struct Node));

    struct Node *copy = new;

    while (temp != NULL) {
        if (temp->next == NULL) new->next = NULL;
        else new->next = (struct Node *) malloc(sizeof(struct Node));
        new->bigit = temp->bigit;
        temp = temp->next;
        new = new->next;
    }

    return copy;
}

struct Node *add(struct Node *n1lst, struct Node *n2lst) {
    struct Node *new = NULL;

    if (n1lst == NULL && n2lst == NULL) return NULL;

    int carry = 0;
    int bgt1, bgt2;

    while (n1lst != NULL || n2lst != NULL || carry > 0) {
        if (n1lst == NULL) bgt1 = 0;
        else {
            bgt1 = n1lst->bigit;
            n1lst = n1lst->next;
        }

        if (n2lst == NULL) bgt2 = 0;
        else {
            bgt2 = n2lst->bigit;
            n2lst = n2lst->next;
        }

        new = cons_bigit((bgt1+bgt2+carry)%10000, new);
        
        carry = (bgt1+bgt2+carry)/10000;
    }

    return reverse(new);
}

int length(struct Node *blst) {
    int l = 0;

    while (blst != NULL) {
        l++;
        blst = blst->next;
    }

    return l;
}

struct Node *mult_helper(struct Node *n1lst, struct Node *n2lst) {
    struct Node *temp = n2lst;
    struct Node *new = cons_bigit(0, NULL);
    
    struct Node *copy1 = new;
    struct Node *copy2 = new;

    while (n1lst != NULL) {
        temp = n2lst;
        copy2 = copy1;

        while (temp != NULL && n1lst->bigit != 0) {
            copy2->bigit += temp->bigit*n1lst->bigit;
            if (copy2->next == NULL && temp->next != NULL) copy2->next = cons_bigit(0, NULL);
            copy2 = copy2->next;
            temp = temp->next;
        }

        copy1 = copy1->next;
        n1lst = n1lst->next;
    }

    return new;
}

struct Node *mult(struct Node *n1lst, struct Node *n2lst) {
    if (n1lst == NULL || n2lst == NULL) NULL;

    struct Node *mult_result;

    if (length(n1lst) > length(n2lst)) mult_result = mult_helper(n2lst, n1lst);
    else mult_result = mult_helper(n1lst, n2lst);
    struct Node *carry_result = add(mult_result, NULL);
    
    free_num(mult_result);

    return carry_result;
}

void print_num(struct Node *nlst) {
    struct Node *blst = add(nlst, NULL);
    cull_zeroes(blst);
    if (blst == NULL || all_zero(blst)) printf("0");
    else print_num_helper(blst);
    free_num(blst);
}

int main() {
    struct Node *test1 = cons_bigit(20000, cons_bigit(1, NULL));
    struct Node *test2 = copy_num(test1);

    struct Node *test3 = add(test1, test2);

    struct Node *test4 = mult(test1, test2);
    
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