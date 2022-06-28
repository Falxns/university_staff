#include <stdio.h>
#define AMOUNT_OTDEL 3
#define AMOUNT_RABOTNIK 5
typedef struct
{
    char fio[31];
    int oklad;
    int otdel;
} sotrudnik;

void input(sotrudnik *base);
void calculation(sotrudnik *base, int *zarplata);
void output(int *zarplata);

int main()
{
    sotrudnik base[AMOUNT_RABOTNIK];
    int zarplata[AMOUNT_OTDEL];
    for (int i = 0; i <= AMOUNT_OTDEL - 1; i++)
    {
        zarplata[i] = 0;
    }

    input(base);

    for (int i = 0; i <= AMOUNT_RABOTNIK - 1; i++)
    {
        printf("%s %d %d\n", base[i].fio, base[i].oklad, base[i].otdel);
    }

    calculation(base, zarplata);

    for (int i = 0; i <= AMOUNT_OTDEL - 1; i++)
    {
        printf("%d otdel = %d\n", i + 1, zarplata[i]);
    }

    output(zarplata);

    return 0;
}

void input(sotrudnik *base)
{
    FILE *f;
    f = fopen("D:\\Programs\\CLion Projects\\lab3\\input.txt","r");
    for (int i = 0; i <= AMOUNT_RABOTNIK - 1; i++)
    {
        fscanf(f,"%s %d %d", base[i].fio, &base[i].oklad, &base[i].otdel);
    }
    fclose(f);
}

void calculation(sotrudnik *base, int *zarplata)
{
    for (int i = 0; i <= AMOUNT_RABOTNIK - 1; i++)
    {
        for (int j = 0; j <= AMOUNT_OTDEL - 1; j++)
        {
            if (base[i].otdel == j + 1) zarplata[j] = zarplata[j] + base[i].oklad;
        }
    }
}

void output(int *zarplata)
{
    FILE *output_file;
    output_file = fopen("D:\\Programs\\CLion Projects\\lab3\\output.txt","w");
    for (int i = 0; i <= AMOUNT_OTDEL - 1; i++)
    {
        fprintf(output_file, "%d otdel = %d\n", i + 1, zarplata[i]);
    }
    fclose(output_file);
}