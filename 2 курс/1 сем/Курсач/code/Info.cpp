#include <fmx.h>
#pragma hdrstop

#include "Info.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.fmx"
TInfoF *InfoF;
//---------------------------------------------------------------------------
__fastcall TInfoF::TInfoF(TComponent* Owner)
	: TForm(Owner)
{
}
