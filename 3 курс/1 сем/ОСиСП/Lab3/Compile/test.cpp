#include <iostream>
#include <thread>
#include <windows.h>

int main()
{
    char text[] = "Blank";
    long pid = GetCurrentProcessId();
    printf("%d\n", pid);
    int i = 0;
    while (i < 1) {
        printf("%s ",text);
        std::this_thread::sleep_for(std::chrono::seconds(1));
    }
}