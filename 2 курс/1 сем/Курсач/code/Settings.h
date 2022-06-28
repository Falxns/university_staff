//---------------------------------------------------------------------------
#ifndef SettingsH
#define SettingsH
//---------------------------------------------------------------------------
#include <System.Classes.hpp>
#include <FMX.Controls.hpp>
#include <FMX.Forms.hpp>
#include <FMX.Controls.Presentation.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMX.Types.hpp>
#include <FMX.Objects.hpp>
//---------------------------------------------------------------------------
class TSettingsF : public TForm
{
__published:	// IDE-managed Components
	TButton *btnMute;
	TImage *imgSettingsBack;
	TImage *imgPlayer1;
	TImage *imgPlayer2;
	TRadioButton *btnPlayer1;
	TRadioButton *btnPlayer2;
	void __fastcall btnMuteClick(TObject *Sender);
	void __fastcall btnPlayer2Click(TObject *Sender);
	void __fastcall btnPlayer1Click(TObject *Sender);
private:	// User declarations
public:		// User declarations
	__fastcall TSettingsF(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TSettingsF *SettingsF;
//---------------------------------------------------------------------------
#endif
