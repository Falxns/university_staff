//---------------------------------------------------------------------------
#include <fmx.h>
#pragma hdrstop

#include "Settings.h"
#include "Main.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.fmx"
TSettingsF *SettingsF;
//---------------------------------------------------------------------------
__fastcall TSettingsF::TSettingsF(TComponent* Owner)
	: TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TSettingsF::btnMuteClick(TObject *Sender)
{
	if (MainF->Music->Volume != 0) {
		MainF->Music->Volume = 0;
		btnMute->Text = "UNMUTE";
	} else {
		MainF->Music->Volume = 50;
        btnMute->Text = "MUTE";
	}
}
//---------------------------------------------------------------------------
void __fastcall TSettingsF::btnPlayer2Click(TObject *Sender)
{
	MainF->imgPlayer->Bitmap->LoadFromFile("Resourse/player2.png");
}
//---------------------------------------------------------------------------

void __fastcall TSettingsF::btnPlayer1Click(TObject *Sender)
{
    MainF->imgPlayer->Bitmap->LoadFromFile("Resourse/player1.jpg");
}
