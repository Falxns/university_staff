//---------------------------------------------------------------------------
#ifndef InfoH
#define InfoH
//---------------------------------------------------------------------------
#include <System.Classes.hpp>
#include <FMX.Controls.hpp>
#include <FMX.Forms.hpp>
#include <FMX.Controls.Presentation.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMX.Types.hpp>
#include <FMX.Objects.hpp>
//---------------------------------------------------------------------------
class TInfoF : public TForm
{
__published:	// IDE-managed Components
	TLabel *lInfo;
	TLabel *lLevel;
	TLabel *lJump;
	TLabel *lStart;
	TLabel *lReturn;
	TLabel *lMusic;
	TLabel *lSkins;
	TLabel *lFun;
	TImage *imgBack;
private:	// User declarations
public:		// User declarations
	__fastcall TInfoF(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TInfoF *InfoF;
//---------------------------------------------------------------------------
#endif
