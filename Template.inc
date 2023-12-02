
include windows.inc
include kernel32.inc
include user32.inc
include comctl32.inc
include masm32.inc

includelib kernel32.lib
includelib user32.lib
includelib comctl32.lib
includelib masm32.lib

DlgProc	proto	:HWND, :UINT, :WPARAM, :LPARAM
HexCalculate	proto	
DecCalculate	proto	

.data
szDialogCaption	db	"Ascii-Hex-Decimal Converter 0.1",0
szForma		db "%X",32,0
szForma2	db "%d",32,0

.data?
hInstance	HINSTANCE ?
szAscii		db	300	dup (?)
szBuffer	db	60	dup (?)
szBuffer1	db	600	dup (?)
szBinary	db	600	dup (?)
nLen	dd	?


.const
IDD_DLGBOX	equ	1001
IDC_ASCII	equ	1003
IDC_CALC	equ	1004
IDC_HEX		equ	1005
IDC_DEC		equ	1006
IDC_BIN		equ	1015
IDC_COPY1	equ	1014
IDC_COPY2	equ	1013
IDC_COPY3	equ	1012
IDC_COPY4	equ	1016

APP_ICON	equ	2000

