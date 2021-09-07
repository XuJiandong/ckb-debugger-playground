#include "stdio.h"
#include "stdlib.h"


int fib(int a) {
    __asm__("li a0, 16\r\n"
    "sub sp, sp, a0"
    :
    :
    :"a0"
    );
    return fib(a-1) + fib(a-2);
}

int main() {
  fib(100);
  return 0;
}
