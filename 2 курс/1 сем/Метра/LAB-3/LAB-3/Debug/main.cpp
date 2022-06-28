#include<iostream>


using namespace std;

class Temp
{
	
};

struct Node
{
	int b;
};

struct Fall
{
	
};
int i, j, k, t;
int n;
int *mas;
int size;
int *arr; 
int left = 43;
int right = 43;
const ui test = 34;
int test1;
typedef unsigned int ui;
int honor;

typedef int INT;

void quickSort()
{
      int tmp;
      int pivot;
	  pivot = arr[(i + j) / 2] + test + test1;
      while (i < j) 
	  {
            while (arr[i] < pivot)
			{
                  i++;
			}
            while (arr[j] > pivot)
			{
                  j--;
			}
            if (i < j) 
			{
                  tmp = arr[i];
                  arr[i] = arr[j];
                  arr[j] = tmp;
                  i++;
                  j--;
			}
      };

      if (i < j)
	  {
            quickSort();
	  }
      if (i < j)
	  {
            quickSort();
	  }
	  return;
}

void SortByRevers()
{
	int maximum = 1000;
	int position = -1;
	for(; i < size; i++)
	{
		maximum = mas[0];
		position = 0;
		j = 1;
		for(; j < size - i; j++)
		{
			if(maximum < mas[j])
			{
				maximum = mas[j];
				position = j;
			}
		}
		int buf;
		buf = mas[position];
		mas[position] = mas[size - i - 1];
		mas[size - i - 1] = buf;	
	}
}

void SortByInsert()
{
	int *count = new int [100];
	for(; i < 100; i++)
		count[i] = 0;
	i = 0;
	for(; i < size; i++)
		count[mas[i]]++;
	i = 0;
	j = 0;
	for(; i < 100; i++)
		while(count[i])
		{
			count[i]--;
			mas[j] = i;
			j++;
		}
}

int Ercsept(int a, char b, int hmd, int l, double d)
{
	int *counter = new int [100];
	for(; i < 100; i++)
		counter[i] = 0;
	i = 0;
	for(; i < size; i++)
		counter[mas[i]]++;
	i = 0;
	j = 0;
	for(; i < 100; i++)
		while(counter[i])
		{
			counter[i]--;
			mas[j] = i;
			j++;
		}
	return 11;
}

void ShellSort()
{
cin >> i;
	for(k = size/2; k > 0; k /=2)
	{
        for(i = k; i < size; i++)
        {
            t = mas[i];
            for(j = i; j>=k; j-=k)
            {
                if(t < mas[j-k])
                    mas[j] = mas[j-k];
                else
                    break;
            }
            mas[j] = t;
        }
	}
}

void function()
{
	int iter;
	while(iter){}
	cin >> hilfe;
	cin >> n;
	cin >> test1;
}