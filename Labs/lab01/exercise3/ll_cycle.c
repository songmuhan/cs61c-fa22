#include <stddef.h>
#include "ll_cycle.h"

int ll_has_cycle(node *head) {
    /* TODO: Implement ll_has_cycle */
    node *fast =head;
    node *slow =head;
    if( fast==NULL || fast->next == NULL) return 0;
    while(fast && fast->next){
        fast = fast->next->next;
        slow = slow->next;
        if(fast == slow){
            return 1;
        }
    }
    return 0;
}
