#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.


SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.



USERID="tmp"
BSRCDIR=""


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Read Config(ahtrun.cnf) File
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Loop, read, ahtrun.cnf
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
		arg1 := A_LoopField
	}

}


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Set Working Path
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

BINFILE=\PREPPlayer.exe
TARGETFILE := DESTDIR . BINFILE
;MsgBox, %TARGETFILE%


SetWorkingDir %DESTDIR%
RUN %TARGETFILE%


sleep, 1000

IfWinExist, LoginWindow
{
	WinActivate
;	MsgBox % "The active window's ID is " . WinExist("LoginWindow")
	MouseClick, left, 72,63
	Loop, 10
	{
		Send {DEL}
	}
	Send %USERID%
	Send, {Enter}
	sleep, 1000
}
else
{
	MsgBox "Error: No application"
}

; MainWindow를 찾는다.
IfWinExist, PrepPlayer
{
	MouseClick, left, 477, 331
}
sleep, 100
ifWinExist, ChannelWindow
{
	MouseClick, left, 177, 60
	MouseClick, left, 135, 107, 2 ; double click
}
else
{
	MsgBox, No channel window
}



