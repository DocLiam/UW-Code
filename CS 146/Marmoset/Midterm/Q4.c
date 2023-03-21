//Using this given struct as the basis for Q4:

struct Node {
    char *mem; // pointer to some memory
    size_t size; // its size
    struct Node *next;
};

struct Node *theHeap; // global variable; head of the linked list

// Here I am assuming that the surrounding code (above) would also include stdlib.h, but here's the include just to make the code whole, especially since size_t and NULL come from this header file - and it doesn't hurt to add in

#include <stdlib.h>


//Solution: Q4.a.

char *findMemory(size_t n) {
    struct Node *previousNode = theHeap;
    struct Node *currentNode = theHeap;

    while (currentNode->size < n) { // Keep progressing currentNode while the size is less than n
        previousNode = currentNode;
        currentNode = currentNode->next;
    }

    char *oldMem = currentNode->mem; // Keep the memory we want to return handy in another variable

    if (currentNode->size == n) {
        if (currentNode == theHeap) theHeap = theHeap->next; // Handle the case that the first node (pointed to by theHeap) has size equal than n
        else previousNode->next = currentNode->next; // Otherwise we redirect the preceding node to the node succeeding the current node
        
        releaseNode(currentNode); // Release the current node entirely
    }
    else {
        currentNode->size = (currentNode->size)-n; // Reduce the size by n
        currentNode->mem = (currentNode->mem)+n; // Increase mem by n bytes
    }

    return oldMem;
}

//Solution: Q4.b.

void replaceMemory(char *p, size_t n) {
    struct Node *newNode = getNode();
    newNode->mem = p;
    newNode->size = n;

    struct Node *previousNode = theHeap;
    struct Node *currentNode = theHeap;

    while (currentNode != NULL && (newNode->mem < currentNode->mem)) { // Crucially, we check if currentNode is still a node and not NULL, otherwise the second condition would fail - we use shortcircuiting of conditions here
        previousNode = currentNode;
        currentNode = currentNode->next;
    }

    newNode->next = currentNode; // This will still work if currentNode is in fact NULL (i.e. the new memory comes after all other memory)

    if (currentNode == theHeap) theHeap = newNode; // If the new node's mem comes before theHeap's, then make newNode the new head of the linked list (this takes care of theHeap being NULL, too)
    else previousNode->next = newNode; // If not, then point the preceding node to the new node
}

//Solution: Q4.c.

void coalesce() {
    if (theHeap != NULL) { // Check that theHeap is not NULL
        struct Node *previousNode = theHeap;
        struct Node *currentNode = theHeap->next;

        while (currentNode != NULL) { // Check that we have not reached the end of the linked list
            if (((previousNode->mem)+(previousNode->size)) == currentNode->mem) { // Check if for node n, n.mem+n.size is equal to the next node's mem
                previousNode->size = (previousNode->size)+(currentNode->size); // Increase the size of the preceding node to absorb to the size of the next node
                previousNode->next = currentNode->next; // Point the preceding node to the node that the current node points to

                releaseNode(currentNode); // Release the current node, since we have coalesced it into the preceding one

                currentNode = previousNode->next; // Progress currentNode to be the node it previously pointed to

                // We do not progress previousNode yet, since the newly coalesced node may also need to be coalesced with the next following node
            }
            else {
                previousNode = currentNode; // If the two nodes are not coalesced, we keep progressing previousNode
                currentNode = currentNode->next; // Likewise here we progress currentNode
            }
        }  
    }
}