comment ~
	A small tool to convert Ascii into Hex and Decimal. Don't blame the codes. I am still an
	utter noob. I like to add few features but that may take months for me code.
	Features planning
	-----------------
	1) Add coversion for binary 
	2) Convert any to any
~
.686
.model flat, stdcall
option casemap: none

include Template.inc

.code
start:
	invoke GetModuleHandle, NULL
	mov hInstance, eax
	invoke InitCommonControls
	invoke DialogBoxParam, hInstance, IDD_DLGBOX, NULL, addr DlgProc, NULL
	invoke ExitProcess, NULL
	
DlgProc proc hWnd:HWND, uMsg:UINT, wParam:WPARAM, lParam:LPARAM
	.if uMsg == WM_INITDIALOG
		invoke SetWindowText, hWnd, addr szDialogCaption
		invoke LoadIcon, hInstance, APP_ICON
		invoke SendMessage, hWnd, WM_SETICON, 1, eax
	.elseif uMsg == WM_COMMAND
		mov eax, wParam
		;Calculate as you change Ascii data	
		.if ax==IDC_ASCII
			shr eax,16
		.if ax==EN_CHANGE
			invoke GetDlgItemText, hWnd, IDC_ASCII, addr szAscii, 600
			.if (eax != 0 && eax <= 600)
				invoke HexCalculate
				invoke SetDlgItemText, hWnd, IDC_HEX, addr szBuffer
				invoke hex2bin, addr szBuffer, addr szBinary
				invoke wsprintf, addr szBuffer, addr szForma2, eax
				invoke SetDlgItemText, hWnd, IDC_BIN, addr szBuffer

				invoke DecCalculate
				invoke SetDlgItemText, hWnd, IDC_DEC, addr szBuffer
				
			.else
				ret
			.endif
		.endif	
		
		comment ~
		;Use incase u are using  a button to calculate
		.elseif eax == IDC_CALC
			invoke GetDlgItemText, hWnd, IDC_ASCII, addr szAscii, 600
			.if (eax != 0)
				invoke HexCalculate
				invoke SetDlgItemText, hWnd, IDC_HEX, addr szBuffer
				invoke DecCalculate
				invoke SetDlgItemText, hWnd, IDC_DEC, addr szBuffer
			.else
				ret
			.endif
		~	
		;Copy Decimal	
		.elseif eax == IDC_COPY1
			invoke SendDlgItemMessage,hWnd,IDC_DEC,EM_SETSEL,0,-1 
			invoke SendDlgItemMessage,hWnd,IDC_DEC,WM_COPY,0,0 	
		;Copy Hex	
		.elseif eax == IDC_COPY2
			invoke SendDlgItemMessage,hWnd,IDC_HEX,EM_SETSEL,0,-1 
			invoke SendDlgItemMessage,hWnd,IDC_HEX,WM_COPY,0,0 
		;Copy Ascii		
		.elseif eax == IDC_COPY3
			invoke SendDlgItemMessage,hWnd,IDC_ASCII,EM_SETSEL,0,-1 
			invoke SendDlgItemMessage,hWnd,IDC_ASCII,WM_COPY,0,0 	
		.endif
		
	.elseif uMsg == WM_CLOSE
		invoke EndDialog, hWnd, 0
	.endif
	
	xor eax, eax			
	Ret
DlgProc EndP	

;Hex Calculation
HexCalculate	proc 
	invoke lstrlen, addr szAscii
	push esi
	push ebx
	xor esi, esi
	xor ebx, ebx
	mov esi, eax
	invoke RtlZeroMemory, addr szBuffer, 600
L1:	
	xor eax, eax
	mov al, byte ptr ds:[szAscii+ ebx]
	invoke wsprintf, addr szBuffer1, addr szForma, eax
	invoke lstrcat, addr szBuffer, addr szBuffer1	
	inc ebx
	cmp esi, ebx
	jnz L1 
	xor eax, eax
	pop ebx
	pop esi
	Ret
HexCalculate EndP

;Decimal Calculation
DecCalculate	proc 
	invoke lstrlen, addr szAscii
	push esi
	push ebx
	xor esi, esi
	xor ebx, ebx
	mov esi, eax
	invoke RtlZeroMemory, addr szBuffer, 600
L1:	
	xor eax, eax
	mov al, byte ptr ds:[szAscii+ ebx]
	invoke wsprintf, addr szBuffer1, addr szForma2, eax
	invoke lstrcat, addr szBuffer, addr szBuffer1	
	inc ebx
	cmp esi, ebx
	jnz L1 
	xor eax, eax
	pop ebx
	pop esi
	Ret
DecCalculate EndP
end start
