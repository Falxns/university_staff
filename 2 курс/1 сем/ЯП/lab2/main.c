#include <stdio.h>

int main() {
    char x[21];
    gets(x);
    int l = strlen(x);
    if (l > 15)
    {
        for (int i = 0; i <= l; i++)
            if (x[i] >= 'A' && x[i] <= 'Z')
            {
                for (int k = i; k <= l; k++)
                {
                    x[k] = x[k+1];
                    i--;
                }
            }
        puts(x);
    }
    else puts(x);
    return 0;
}