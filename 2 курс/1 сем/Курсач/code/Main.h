//---------------------------------------------------------------------------
#ifndef MainH
#define MainH
//---------------------------------------------------------------------------
#include <System.Classes.hpp>
#include <FMX.Controls.hpp>
#include <FMX.Forms.hpp>
#include <FMX.Controls.Presentation.hpp>
#include <FMX.Menus.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMX.Types.hpp>
#include <FMX.Dialogs.hpp>
#include <FMX.Objects.hpp>
#include <FMX.Ani.hpp>
#include <FMX.Media.hpp>
#include <vector>
//---------------------------------------------------------------------------
class TMainF : public TForm
{
__published:	// IDE-managed Components
	TButton *btnPlay;
	TPopupMenu *BlankPop;
	TButton *btnSettings;
	TButton *btnRight;
	TButton *btnLeft;
	TImage *imgLevel;
	TButton *btnReturn;
	TButton *btnGo;
	TTimer *BackgrMove;
	TImage *imgBackgr;
	TImage *imgPlayer;
	TImage *imgMenu;
    TMediaPlayer *Music;
	TTimer *CycleMusic;
	TButton *btnInfo;
	void __fastcall FormCloseQuery(TObject *Sender, bool &CanClose);
	void __fastcall btnPlayClick(TObject *Sender);
	void __fastcall FormCreate(TObject *Sender);
	void __fastcall btnReturnClick(TObject *Sender);
	void __fastcall btnGoClick(TObject *Sender);
	void __fastcall BackgrMoveTimer(TObject *Sender);
	void __fastcall FormKeyDown(TObject *Sender, WORD &Key, System::WideChar &KeyChar,
		  TShiftState Shift);
	void __fastcall btnRightClick(TObject *Sender);
	void __fastcall btnLeftClick(TObject *Sender);
	void __fastcall btnSettingsClick(TObject *Sender);
	void __fastcall CycleMusicTimer(TObject *Sender);
	void __fastcall btnInfoClick(TObject *Sender);
private:	// User declarations
public:		// User declarations
	__fastcall TMainF(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TMainF *MainF;
//---------------------------------------------------------------------------
#endif
