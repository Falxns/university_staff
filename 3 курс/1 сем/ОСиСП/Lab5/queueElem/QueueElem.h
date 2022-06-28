#ifndef LAB4_QUEUEELEM_H
#define LAB4_QUEUEELEM_H

class QueueElem {
public:
    long startOffset{ 0 };
    long finishOffset{ 0 };
    QueueElem(long start, long finish);
};

#endif