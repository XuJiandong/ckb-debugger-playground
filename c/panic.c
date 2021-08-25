#include "stdio.h"
#include "stdlib.h"


int main() {
    int* p = (int*)0xFFFFFFFFFFFF;
    *p = 100;
    return 0;
}
