//---------------------------------------------------------------------------
#include <fmx.h>
#pragma hdrstop

#include "Main.h"
#include "Settings.h"
#include "Info.h"
#include <vector>
using namespace std;
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.fmx"
TMainF *MainF;
//---------------------------------------------------------------------------
TImage *Blocks[100];
int counter, Blck, shft, mp;
bool IsUp;
struct position
{
	int X;
	int Y;
};
position pos;
const int SizeY = 6, SizeX = 30;
const int MapCount = 4;
int Map[SizeY][SizeX];
vector<vector<int>> MapSet[MapCount] =
{	{
		{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
		{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
		{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
		{0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
		{0, 0, 0, 1, 0, 0, 1, 1, 1, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
		{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
	},
	{
		{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0},
		{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0},
		{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 1, 3, 0, 0, 0, 0, 0, 0, 0},
		{0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 3, 0, 0, 0, 0, 0, 0, 0},
		{0, 0, 0, 1, 0, 0, 1, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0},
		{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0}
	},
	{
		{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3},
		{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 3},
		{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 3},
		{0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 3},
		{0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 3},
		{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
	}
};
struct Mapa
{
	char bmpLvl[255];
	int WidthMap;
	char bmpBack[255];
	int ShiftMap;
	int IntervalMap;
	vector<vector<int> > MapNew;
};
vector<Mapa> Maps = {
{"Resourse/lvl1.jpg", 700, "Resourse/map1.jpg", -50, 700, MapSet[0]},
{"Resourse/lvl2.jpg", 1250, "Resourse/map2.jpg", -650, 500, MapSet[1]},
{"Resourse/lvl3.jpg", 1600, "Resourse/map3.jpg", -1000, 370, MapSet[2]}
};
//---------------------------------------------------------------------------
__fastcall TMainF::TMainF(TComponent* Owner)
	: TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TMainF::FormCloseQuery(TObject *Sender, bool &CanClose)
{
	BackgrMove->Enabled = false;
	if (MessageDlg("Are you sure you want to exit?", TMsgDlgType::mtConfirmation, mbYesNo, 0) == mrNo)
	{
	  CanClose = false;
	}
}
//---------------------------------------------------------------------------
void __fastcall TMainF::btnPlayClick(TObject *Sender)
{
	btnPlay->Visible = false;
	btnSettings->Visible = false;
	btnLeft->Visible = true;
	btnRight->Visible = true;
	imgLevel->Visible = true;
	btnReturn->Visible = true;
	btnGo->Visible = true;
	imgMenu->Visible = false;
	btnInfo->Visible = false;
}
//---------------------------------------------------------------------------
void __fastcall TMainF::FormCreate(TObject *Sender)
{
	mp = 0;
	shft = -50;
	for (int i = 0; i < SizeY; i++) {
		for (int j = 0; j < SizeX; j++) {
			Map[i][j] = MapSet[0][i][j];
		}
	}
	Music->Volume = 50;
	Music->Play();
}
//---------------------------------------------------------------------------
void __fastcall TMainF::btnReturnClick(TObject *Sender)
{
	btnPlay->Visible = true;
	btnSettings->Visible = true;
	btnLeft->Visible = false;
	btnRight->Visible = false;
	imgLevel->Visible = false;
	btnReturn->Visible = false;
	btnGo->Visible = false;
	imgMenu->Visible = true;
	btnInfo->Visible = true;
}
//---------------------------------------------------------------------------
void __fastcall TMainF::btnGoClick(TObject *Sender)
{
	btnLeft->Visible = false;
	btnRight->Visible = false;
	btnReturn->Visible = false;
	btnGo->Visible = false;
	imgLevel->Visible = false;
	imgBackgr->Visible = true;
	imgPlayer->Visible = true;

	IsUp = false;
	imgBackgr->Position->X = 0;
	pos.X = 0;
	pos.Y = SizeY - 2;
	imgPlayer->Position->Y = 300;
	imgPlayer->Position->X = 100;
	imgPlayer->RotationAngle = 0;

	int count = 0;
	counter = 0;
	Blck = 0;
	for (int i = 0; i < SizeY - 1; i++) {
		for (int j = 0; j < SizeX; j++) {
			if (Map[i][j] == 1) {
				TImage *Block = new TImage(this);
				Block->Parent = MainF;
				Block->Size->Width = 50;
				Block->Size->Height = 50;
				Block->Position->X = 100 + j * 50;
				Block->Position->Y = 300 - (SizeY - 2 - i) * 50;
				Block->Bitmap->LoadFromFile("Resourse/block.jpg");
				Blocks[count] = Block;
				count++;
                Blck++;
			}
		}
	}
	BackgrMove->Enabled = true;
}
//---------------------------------------------------------------------------
void CheckDeath(TObject *Sender)
{
    if (((Map[pos.Y][pos.X + 1] == 1) && !IsUp) ||
		((Map[pos.Y + 1][pos.X + 1] == 1) && (Map[pos.Y + 1][pos.X] == 0))) {
		MainF->BackgrMove->Enabled = false;
		MainF->imgPlayer->Visible = false;
		if (MessageDlg("Retry?", TMsgDlgType::mtConfirmation, mbYesNo, 0) == mrNo) {
			MainF->btnPlayClick(Sender);
			MainF->imgBackgr->Visible = false;
			for (int i = 0; i < Blck; i++) {
				Blocks[i]->Visible = false;
			}
			counter = 0;
		} else {
			IsUp = false;
			pos.X = -1;
			pos.Y = SizeY - 2;
			MainF->imgPlayer->Position->Y = 300;
			MainF->imgPlayer->Position->X = 100;
			MainF->imgPlayer->RotationAngle = 0;
			MainF->imgBackgr->Position->X = 0;
			MainF->imgPlayer->Visible = true;
			for (int i = 0; i < Blck; i++) {
				Blocks[i]->Position->X += counter * 50;
			}
			counter = 0;
			MainF->BackgrMove->Enabled = true;
		}
	}
}
//---------------------------------------------------------------------------
void CheckWin(TObject *Sender)
{
	if (Map[pos.Y][pos.X + 1] == 3) {
		MainF->BackgrMove->Enabled = false;
		ShowMessage("!!!... YOU WON ^-^ ...!!!");
		MainF->btnPlayClick(Sender);
		MainF->imgBackgr->Visible = false;
		MainF->imgPlayer->Visible = false;
		for (int i = 0; i < Blck; i++) {
			Blocks[i]->Visible = false;
		}
		counter = 0;
	}
}
//---------------------------------------------------------------------------
void __fastcall TMainF::BackgrMoveTimer(TObject *Sender)
{
    counter += 1;
	if (imgBackgr->Position->X > shft) {
		imgBackgr->Position->X -= 50;
		for (int i = 0; i < Blck; i++) {
			Blocks[i]->Position->X -= 50;
		}
	} else {
		imgPlayer->Position->X += 50;
		counter -= 1;
	}

	CheckDeath(Sender);

	CheckWin(Sender);

	if (IsUp && (Map[pos.Y - 1][pos.X + 1] == 0) && (Map[pos.Y + 1][pos.X] == 1)) {
		imgPlayer->Position->Y -= 50;
		imgPlayer->RotationAngle += 90;
		pos.Y -= 1;
		IsUp = false;
	} else {
			if ((pos.Y < (SizeY - 2)) && (Map[pos.Y + 1][pos.X + 1] == 0)) {
				imgPlayer->Position->Y += 50;
				imgPlayer->RotationAngle += 90;
				pos.Y += 1;
			}
	}

	pos.X += 1;
}
//---------------------------------------------------------------------------
void __fastcall TMainF::FormKeyDown(TObject *Sender, WORD &Key, System::WideChar &KeyChar,
          TShiftState Shift)
{
	if ((KeyChar == VK_SPACE) && !IsUp) {
		IsUp = true;
	}
	if ((Key == VK_LEFT) && (btnLeft->Visible == true)) {
		btnLeftClick(Sender);
	}
	if ((Key == VK_RIGHT) && (btnRight->Visible == true)) {
		btnRightClick(Sender);
	}
	if ((Key == VK_ESCAPE) && (btnReturn->Visible == true)) {
		btnReturnClick(Sender);
	}
	if ((Key == VK_RETURN) && (btnGo->Visible == true)) {
		btnGoClick(Sender);
	}
}
//---------------------------------------------------------------------------
void ChangeMap(Mapa Change)
{
	MainF->imgLevel->Bitmap->LoadFromFile(Change.bmpLvl);
	MainF->imgBackgr->Width = Change.WidthMap;
	MainF->imgBackgr->Bitmap->LoadFromFile(Change.bmpBack);
	shft = Change.ShiftMap;
	MainF->BackgrMove->Interval = Change.IntervalMap;
	for (int i = 0; i < SizeY; i++) {
		for (int j = 0; j < SizeX; j++) {
			Map[i][j] = Change.MapNew[i][j];
		}
	}
}
//---------------------------------------------------------------------------
void __fastcall TMainF::btnRightClick(TObject *Sender)
{
	if (mp < Maps.size() - 1) {
		mp += 1;
	} else {
		mp = 0;
	}
	ChangeMap(Maps[mp]);
}
//---------------------------------------------------------------------------

void __fastcall TMainF::btnLeftClick(TObject *Sender)
{
	if (mp > 0) {
		mp -= 1;
	} else {
		mp = Maps.size() - 1;
	}
    ChangeMap(Maps[mp]);
}
//---------------------------------------------------------------------------

void __fastcall TMainF::btnSettingsClick(TObject *Sender)
{
    SettingsF->ShowModal();
}
//---------------------------------------------------------------------------

void __fastcall TMainF::CycleMusicTimer(TObject *Sender)
{
	if (Music->CurrentTime == Music->Duration ) {
		Music->CurrentTime = 0;
        Music->Play();
	}
}
//---------------------------------------------------------------------------


void __fastcall TMainF::btnInfoClick(TObject *Sender)
{
	btnPlay->Enabled = true;
    InfoF->ShowModal();
}
//---------------------------------------------------------------------------

