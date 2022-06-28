#include <stdio.h>

int main()
{
    float x;
    scanf("%f", &x);
    if (x <= 0) printf("0");
    else
        {
        if (x <= 1) printf("%f\n", x);
        else
            {
            printf("%f\n", x * x * x * x);
            }
        }
    return 0;
}