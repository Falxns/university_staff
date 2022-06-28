#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct Stack_tag
{
    char data;
    struct Stack_tag *next;
} Stack_t;

#define MAX 10

void push(Stack_t **head, char i);
char pop(Stack_t **head);

int main()
{
    Stack_t* mainSt = NULL;
    char s[MAX];

    printf("Enter your string:\n");
    gets(s);
    int len = strlen(s);

    for (int i = 0; i < len; i++)
    {
        push(&mainSt, s[i]);
    }
    for (int i = 0; i < len ; i++)
    {
        char buff = pop(&mainSt);
        printf("%c", buff);
    }
    return 0;
}

void push(Stack_t **head, char i)
{
    Stack_t *temp;
    temp = (Stack_t*)malloc(sizeof(Stack_t));
    temp->data = i;
    temp->next = *head;
    *head = temp;
}

char pop(Stack_t **head)
{
    char result = '0';
    if (*head == NULL)
        return result;

    Stack_t *temp = *head;
    result = temp->data;
    *head = temp->next;
    free(temp);
    return result;
}