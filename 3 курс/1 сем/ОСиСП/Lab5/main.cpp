#include <iostream>
#include <queue>
#include <vector>
#include <string>
#include <fstream>
#include <thread>
#include "queueElem/QueueElem.h"
#include "queueHandler/ThreadpoolQueueProcessor.h"

#define MAX_STRING_SIZE 1024

using namespace std;

int main() {
    Queue myQueue;
    vector<string> buffer;
    int countThreadsConsole;
    unsigned int maxThreads = thread::hardware_concurrency();
    bool isRight;
    isRight = false;
    do {
        cout << "Number of threads to use:" << endl;
        cin >> countThreadsConsole;
        if (countThreadsConsole > maxThreads){
            cout << "Max number of threads is " << maxThreads << ". Try again."<< endl;
        } else {
            isRight = true;
        }
    } while (!isRight);

    ifstream streamIn("C:\\Users\\maksf\\Desktop\\OSISP\\Lab5\\input.txt");
    long strCount = 0;
    char str[MAX_STRING_SIZE];
    int j = 0;
    while (!streamIn.eof()){
        streamIn.getline(str,MAX_STRING_SIZE);
        strCount++;
        buffer.resize(strCount);
        buffer[j] = str;
        if (buffer[j][buffer[j].size() - 1] != '\n'){
            buffer[j] += '\n';
        }
        j++;
    }
    streamIn.close();
    cout << "File has been read." << endl;

    int countThreads;
    long strCountForThread;
    int countMod;
    if (strCount > countThreadsConsole) {
        countThreads = countThreadsConsole;
        strCountForThread = strCount / countThreadsConsole;
        countMod = strCount % countThreadsConsole;
    } else {
        strCountForThread = 1;
        countMod = 0;
        countThreads = strCount;
    }
    for (int i = 0; i < countThreads; i++) {
        if (i != countThreads - 1) {
            QueueElem queueElem(strCountForThread * i + 1, strCountForThread * (i + 1));
            myQueue.pushInQueue(queueElem);
        } else {
            QueueElem queueElem(strCountForThread * i + 1, strCountForThread * (i + 1) + countMod);
            myQueue.pushInQueue(queueElem);
        }
    }

    ThreadpoolQueueProcessor queueHandle(&myQueue,&buffer);
    queueHandle.Process(countThreads);
    queueHandle.Wait();

    int countSort =  strCount / strCountForThread - 1;
    for (int i = 0; i < countSort; i++){
        if (i == (countSort - 1)) {
            inplace_merge(buffer.begin(), buffer.begin() + strCountForThread * (i + 1),
                               buffer.end());
        } else {
            inplace_merge(buffer.begin(), buffer.begin() + strCountForThread * (i + 1),
                               buffer.begin() + strCountForThread * (i + 2));
        }
    }

    ofstream streamOut("C:\\Users\\maksf\\Desktop\\OSISP\\Lab5\\output.txt");
    for(int i = 0; i < buffer.size(); i++){
        streamOut << buffer[i];
    }
    streamOut.close();

    cout << "Answer has been written." << endl;
    cout << "Done!" << endl;

    return 0;
}