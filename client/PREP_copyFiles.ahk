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
;;; Copy to Local Folder
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

FileCopyDir, %BSRCDIR%, %DESTDIR%, 1
MsgBox Copy completed (from %BSRCDIR% to %DESTDIR%)



