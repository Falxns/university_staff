#include <stdio.h>
#include <string.h>

#define ctUnknown 0
#define ctDigit 1
#define ctPoint 2

const char transitions[12][3] = {
        {0, 0, 0},
        {0, 2, 0},
        {0, 3, 0},
        {0, 0, 4},
        {0, 5, 0},
        {0, 6, 0},
        {0, 0, 7},
        {0, 8, 0},
        {0, 9, 0},
        {0, 10, 0},
        {0, 11, 0},
        {0, 0, 0}
};

int CheckStr(const char Symbol){
    if (Symbol == '.') {
        return ctPoint;
    }
    else{
        if ((Symbol >= '0')&&(Symbol <= '9'))
            return ctDigit;
        return ctUnknown;
    }
}

int main() {
    printf("Enter date:\n");
    char inp[30];
    gets(inp);
    int state = 1;
    for (int i = 0; i < strlen(inp); i++){
        state = transitions[state][CheckStr(inp[i])];
    }
    if ((state == 9)||(state == 11))
        printf("Yeah baby!");
    else
        printf("There is no date here :c");
    return 0;
}