#include "C12.h"
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

struct hash make_table(int s) {
    struct hash hash_table;

    hash_table.size = s;
    hash_table.table = malloc(s*sizeof(struct anode*));

    for (int i = 0; i < s; i++) hash_table.table[i] = NULL;

    return hash_table;
}

char *search(struct hash T, int k) {
    int node_index = k%(T.size);
    struct anode *node = T.table[node_index];

    while (node != NULL) {
        if (node->key == k) return node->value;

        node = node->next;
    }

    return NULL;
}

void copy_string(char *src, char *dest) {
    int i = 0;
    
    for (int j = 0; src[j] != '\0'; j++) {
        dest[j] = src[j];
        
        i = j;
    }

    dest[i+1] = '\0';
}

int strlength(char *src) {
    int k = 1;

    for (int l = 0; src[l] != '\0'; l++) k++;

    return k;
}

void add(struct hash T, int k, char *v) {
    int node_index = k%(T.size);
    struct anode *new_node = malloc(sizeof(struct anode));

    new_node->next = T.table[node_index];
    T.table[node_index] = new_node;
    char *new_value = malloc((strlen(v)+1)*sizeof(char));
    strcpy(new_value, v);

    new_node->value = new_value;
    new_node->key = k;
}

void free_table(struct hash T) {
    for (int i = 0; i < T.size; i++) {
        struct anode *node = T.table[i];

        while (node != NULL) {
            struct anode *temp = node->next;

            free(node->value);
            free(node);

            node = temp;
        }

        T.table[i] = NULL;
    }

    free(T.table);
}

void delete(struct hash T, int k) {
    int node_index = k%(T.size);
    struct anode *node = T.table[node_index];
    struct anode *prev = NULL;
    struct anode *temp;

    while (node != NULL) {
        if (node->key == k) {
            if (prev != NULL) prev->next = node->next;
            else T.table[node_index] = node->next;

            temp = node->next;

            free(node->value);
            free(node);

            node = temp;
        }
        else {
            prev = node;
            node = node->next;
        }
    }
}