#include<windows.h>

LRESULT CALLBACK WndProc(HWND, UINT, WPARAM, LPARAM);

BOOL Line(HDC hdc, int x1, int y1, int x2, int y2);
BOOL DrawTank(HDC hdc);
BOOL DrawSun(HDC hdc);

char szProgName[]="Program";

int WINAPI WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPSTR lpszCmdLine, int nCmdShow)
{
    HWND hWnd;
    MSG lpMsg;
    WNDCLASS w;

    w.lpszClassName=szProgName;
    w.hInstance=hInstance;
    w.lpfnWndProc=WndProc;
    w.hCursor=LoadCursor(NULL, IDC_ARROW);
    w.hIcon=0;
    w.lpszMenuName=0;
    w.hbrBackground=(HBRUSH)GetStockObject(WHITE_BRUSH);
    w.style=CS_HREDRAW|CS_VREDRAW;
    w.cbClsExtra=0;
    w.cbWndExtra=0;

    if(!RegisterClass(&w))
        return 0;

    hWnd=CreateWindow(szProgName,
                      "Test",
                      WS_OVERLAPPEDWINDOW,
                      100,
                      100,
                      420,
                      420,
                      (HWND)NULL,
                      (HMENU)NULL,
                      (HINSTANCE)hInstance,
                      (HINSTANCE)NULL);

    ShowWindow(hWnd, nCmdShow);

    UpdateWindow(hWnd);

    while(GetMessage(&lpMsg, NULL, 0, 0)) {
        TranslateMessage(&lpMsg);
        DispatchMessage(&lpMsg);
    }
    return(lpMsg.wParam);
}

LRESULT CALLBACK WndProc(HWND hWnd, UINT messg,
                         WPARAM wParam, LPARAM lParam)
{
    HDC hdc;
    RECT r;
    HBRUSH hBrush;
    PAINTSTRUCT ps;
    switch(messg)
    {
        case WM_PAINT:
            hdc = BeginPaint(hWnd, &ps);

            DrawTank(hdc);
            DrawSun(hdc);

            ValidateRect(hWnd, NULL);
            EndPaint(hWnd, &ps);
            break;

        case WM_DESTROY:
            PostQuitMessage(0);
            break;

        default:
            return(DefWindowProc(hWnd, messg, wParam, lParam));
    }
    return 0;
}

BOOL Line(HDC hdc, int x1, int y1, int x2, int y2)
{
    MoveToEx(hdc, x1, y1, NULL);
    return LineTo(hdc, x2, y2);
}

BOOL DrawTank(HDC hdc)
{
    RECT r;
    HBRUSH hBrush;

    hBrush = CreateSolidBrush(RGB(50,205,50));
    SelectObject(hdc, hBrush);
    Rectangle(hdc, 160, 160, 320, 260);

    hBrush=CreateSolidBrush(RGB(0,255,0));
    SelectObject(hdc, hBrush);
    Ellipse(hdc, 0,240,400,380);

    hBrush=CreateSolidBrush(RGB(50,205,50));
    SelectObject(hdc, hBrush);
    Ellipse(hdc, 130,300,190,360);
    Ellipse(hdc, 210,300,270,360);
    Ellipse(hdc, 50,280,110,340);
    Ellipse(hdc, 290,280,350,340);

    r.left = 0;
    r.top = 185;
    r.right = 160;
    r.bottom = 215;
    hBrush = CreateSolidBrush(RGB(50,205,50));
    SelectObject(hdc, hBrush);
    Rectangle(hdc, 0, 185, 160, 215);

    Rectangle(hdc, 275, 140, 285, 160);

    r.left = 155;
    r.top = 186;
    r.right = 165;
    r.bottom = 214;
    FillRect(hdc, &r, hBrush);

    r.left = 276;
    r.top = 145;
    r.right = 284;
    r.bottom = 165;
    FillRect(hdc, &r, hBrush);
}

BOOL DrawSun(HDC hdc)
{
    HBRUSH hBrush;

    hBrush = CreateSolidBrush(RGB(255,255,0));
    SelectObject(hdc, hBrush);
    Ellipse(hdc, -50, -50, 50, 50);

    Line(hdc, 50, 50, 100, 100);
    Line(hdc, 25, 70, 40, 120);
    Line(hdc, 75, 25, 125, 40);

    hBrush = CreateSolidBrush(RGB(224,255,255));
    SelectObject(hdc, hBrush);
    Ellipse(hdc, 150, 50, 250, 100);
    Ellipse(hdc, 280, 25, 380, 75);
}