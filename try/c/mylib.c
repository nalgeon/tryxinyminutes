#include <stdio.h>

// is accessible from other .c files
void public_hello() {
    printf("hello in public");
}

// is NOT accessible from other .c files
static void private_hello() {
    printf("hello in private");
}
