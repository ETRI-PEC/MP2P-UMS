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
;;; Set Working Path
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

BINFILE=\PREPPlayer.exe
TARGETFILE := DESTDIR . BINFILE
;MsgBox, %TARGETFILE%


SetWorkingDir %DESTDIR%


ifWinNotExist, PrepPlayer 
{
	RUN %TARGETFILE%
	sleep, 1000

	IfWinExist, LoginWindow
	{
		WinActivate
	;	MsgBox % "The active window's ID is " . WinExist("LoginWindow")
		Xcord :=72
		Ycord :=63

		
		ifEqual, RESOLUTION, UHD
		{
			Xcord := Xcord * 1.5
			Ycord := Ycord * 1.5
			;MsgBox, %Xcord% and %Ycord%
		}
		
		MouseClick, left, Xcord, Ycord
		; MouseClick, left, 72, 63
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
}

; MainWindow를 찾는다.
IfWinExist, PrepPlayer
{
	Xcord :=477
	Ycord :=331

	ifEqual, RESOLUTION, UHD
	{
		Xcord := Xcord * 1.5
		Ycord := Ycord * 1.5
	}	

	ifWinNotExist, ChannelWindow
	{
		
		MouseClick, left, Xcord, Ycord
	}
	;MouseClick, left, 477, 331
}
sleep, 1000
ifWinExist, ChannelWindow
{
	WinActivate
	Xcord :=177
	Ycord :=60

	ifEqual, RESOLUTION, UHD
	{
		Xcord := Xcord * 1.5
		Ycord := Ycord * 1.5
	}		
	MouseClick, left, Xcord, Ycord
	;MouseClick, left, 177, 60


	Xcord :=135
	Ycord :=107

	ifEqual, RESOLUTION, UHD
	{
		Xcord := Xcord * 1.5
		Ycord := Ycord * 1.5
	}	

	MouseClick, left, Xcord, Ycord, 2 ; double click
	;MouseClick, left, 135, 107, 2 ; double click

	Xcord :=88
	Ycord :=118
	ifEqual, RESOLUTION, UHD
	{
		Xcord := Xcord * 1.5
		Ycord := Ycord * 1.5
	}		
	MouseClick, left, Xcord, Ycord

}
else
{
	;MsgBox, No channel window
}


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Open debug window
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
sleep, 2000

ifWinExist, ChannelStatusWindow
{
	WinActivate
	Xcord :=273
	Ycord :=39
	ifEqual, RESOLUTION, UHD
	{
		Xcord := Xcord * 1.5
		Ycord := Ycord * 1.5
	}		
	MouseClick, left, Xcord, Ycord

	WinGetPos, Xcord, Ycord
	ifEqual, RESOLUTION, UHD
	{
		Xcord := Xcord - 900
	}
	else
	{
		Xcord := Xcord - 600
	}
	WinMove, Xcord, Ycord 


}


