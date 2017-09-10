/*
 CS 3100 Lab 4 - by Mick Zeller
*/
#include <stdio.h>
#include <stdlib.h>

int main()
{
    int i, *ptr = 0;

    for(i = 0; i < 100; i++)
    {
ptr=(int*)malloc(sizeof(int) * 100);
    }

    ptr[100] = 0;

    return 0;
}
