#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.


SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.



USERID="tmp"
BSRCDIR=""


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Read Config(ahtrun.cnf) File
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Loop, read, C:\MP2P\ahtrun.cnf
{
	ArrayCount := 0
	Loop, parse, A_LoopReadLine, %A_Tab%
	{

		ifEqual, arg1, USERID
		{
			USERID := A_LoopField
		}
		ifEqual, arg1, DESTDIR
		{
			DESTDIR	:= A_LoopField
		}
		ifEqual, arg1, BSRCDIR
		{
			BSRCDIR := A_LoopField
		}
		ifEqual, arg1, RESOLUTION
		{
			RESOLUTION := A_LoopField
		}
		arg1 := A_LoopField
	}

}


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Stop
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


; MainWindow를 찾는다.
IfWinExist, PrepPlayer
{
	WinActivate

	Xcord :=290
	Ycord :=123

	ifEqual, RESOLUTION, UHD
	{
		Xcord := Xcord * 1.5
		Ycord := Ycord * 1.5
	}	
	MouseClick, left, Xcord, Ycord
	Send, {Enter}

}
else
{
	MsgBox, No windows found
}



