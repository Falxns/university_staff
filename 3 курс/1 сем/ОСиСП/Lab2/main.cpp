#ifndef UNICODE
#define UNICODE
#endif

#include <windows.h>
#include <string>
#include <vector>
#define ROWS 3
#define COLUMNS 3
using namespace std;

LRESULT CALLBACK WindowProc(HWND hwnd, UINT uMsg, WPARAM wParam, LPARAM lParam);

int windowWidth;
int windowHeight;
int columnWidth, rowHeight;
int columnCount, rowCount;

const wchar_t* buf[ROWS][COLUMNS] = { {L"abbb",L"coochieman",L"абфгд"},
                                      {L"d",L"ea",L"bababoy"},
                                      {L"55555",L"4444",L"333"} };

int WinMain(HINSTANCE hInstance, HINSTANCE, LPSTR pCmdLine, int nCmdShow)
{
    const wchar_t CLASS_NAME[] = L"Window Class";
    WNDCLASS windowClass = { };
    windowClass.lpfnWndProc = WindowProc;
    windowClass.lpszClassName = CLASS_NAME;
    windowClass.hInstance = hInstance;
    rowCount = ROWS;
    columnCount = COLUMNS;

    RegisterClass(&windowClass);

    HWND hwnd = CreateWindowEx(
        0,
        CLASS_NAME,
        L"Lab2", WS_OVERLAPPEDWINDOW,
        CW_USEDEFAULT, CW_USEDEFAULT, CW_USEDEFAULT, CW_USEDEFAULT,
        NULL, NULL,
        hInstance, NULL
    );

    if (hwnd == NULL)
    {
        return 1;
    }

    ShowWindow(hwnd, nCmdShow);

    RECT clientRect;
    GetClientRect(hwnd, &clientRect);
    windowWidth = clientRect.right;
    windowHeight = clientRect.bottom;
    columnWidth = windowWidth / columnCount;
    rowHeight = windowHeight / rowCount;

    MSG msg = { };
    while (GetMessage(&msg, NULL, 0, 0))
    {
        TranslateMessage(&msg);
        DispatchMessage(&msg);
    }
    return 0;
}

void fillWindow(HWND hwnd, UINT uMsg, WPARAM wParam, LPARAM lParam)
{
    PAINTSTRUCT ps;
    HDC hdc = BeginPaint(hwnd, &ps);

    FillRect(hdc, &ps.rcPaint, (HBRUSH)(COLOR_WINDOW + 1));
    rowHeight = windowHeight / rowCount;
    columnWidth = windowWidth / columnCount;
    HPEN pen = CreatePen(PS_SOLID, 1, RGB(0, 0, 0));
    SelectObject(hdc, pen);
    for (int i = 0; i < columnCount; i++) {
        for (int j = 0; j < rowCount; j++) {
            HFONT font = CreateFont(rowHeight / 1.5,
                                    columnWidth / (1.6 * wcslen(buf[i][j]) + 1), 0, 0, FW_DONTCARE, FALSE, FALSE, FALSE, DEFAULT_CHARSET,
                                    OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS, CLEARTYPE_QUALITY, VARIABLE_PITCH, NULL);
            SelectObject(hdc, font);
            RECT cell;
            SetRect(&cell, columnWidth * j, rowHeight * i, columnWidth * (j + 1), rowHeight * (i + 1));
            SetBkMode(hdc, TRANSPARENT);
            Rectangle(hdc, columnWidth * j, rowHeight * i, columnWidth * (j + 1), rowHeight * (i + 1));
            DrawText(hdc, buf[i][j], -1, &cell, DT_CENTER | DT_SINGLELINE | DT_VCENTER);
            SetBkMode(hdc, OPAQUE);
            DeleteObject(font);
        }
    }
    DeleteObject(pen);
    EndPaint(hwnd, &ps);
}


LRESULT CALLBACK WindowProc(HWND hwnd, UINT uMsg, WPARAM wParam, LPARAM lParam)
{
    switch (uMsg)
    {
    case WM_DESTROY:
    {
        PostQuitMessage(0);
        return 0;
    }
    case WM_PAINT:
    {
        fillWindow(hwnd, uMsg, wParam, lParam);
        return 0;
    }
    case WM_SIZE:
    {
        windowHeight = HIWORD(lParam);
        windowWidth = LOWORD(lParam);
        InvalidateRect(hwnd, NULL, FALSE);
        return 0;
    }
    }
    return DefWindowProc(hwnd, uMsg, wParam, lParam);
}