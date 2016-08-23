#SingleInstance, Off
#Include %A_ScriptDir%\AHKsock_unicode.ahk
 ;#Include %A_ScriptDir%\AHKsock_ansi.ahk
 ;#Include %A_ScriptDir%\AHKsock_tmp.ahk
 bExiting:=false
 iPeerSocket := -1
 Gui, Add, Edit, x2 y0 w200 h40 vMessage, 
Gui, Add, Button, x202 y0 w90 h40 gSend, Button
; Generated using SmartGUI Creator 4.0
Gui, Show, x127 y87 h47 w298, Server
OnExit, GuiClose

If (i := AHKsock_Listen(7777, "Peer")) {
	Msgbox, % "AHKsock_Listen() failed with return value = " i " and ErrorLevel = " ErrorLevel
	bCantListen := True ;So that if the connect() attempt fails, we exit.
}

Return

Peer(sEvent, iSocket = 0, sName = 0, sAddr = 0, sPort = 0, ByRef bData = 0, bDataLength = 0) {
    Global iPeerSocket, bExiting, bSameMachine, bCantListen
    Static iIgnoreDisconnect
    
    If (sEvent = "ACCEPTED") {
;		Msgbox In Accepted
       
        
        If (iPeerSocket <> -1) {
            ;Msgbox, % "We already have a peer! Disconnecting..."
            AHKsock_Close(iSocket) ;Close the socket
            Return
        }
        ;Remember the socket
        iPeerSocket := iSocket

        ;Stop listening (see comment block in CONNECTED event)
        AHKsock_Listen(7777)
        
    } If (sEvent = "CONNECTED") {
;		Msgbox In Connected
        
        ;Check if the connection attempt was successful
        If (iSocket = -1) {
;            Msgbox, % "AHKsock_Connect() failed."
            
            ;Check if we are not currently listening, and if we already tried to listen and failed.
            If bCantListen
                ExitApp
            
            Msgbox, % "Listening for a peer..."
            GuiControl,, lblStatus, Waiting for a peer... 

                If (i := AHKsock_Listen(7777, "Peer")) {
                    MsgBox, % "AHKsock_Listen() failed with return value = " i " and ErrorLevel = " ErrorLevel
                    ExitApp
                }
            
        } Else Msgbox, % "AHKsock_Connect() successfully connected on IP " sAddr "."

        If (iPeerSocket <> -1) {
            Msgbox, % "We already have a peer! Disconnecting..."
            AHKsock_Close(iSocket) ;Close the socket
            Return
        }
        
        ;Remember the socket
        iPeerSocket := iSocket

      ;  AHKsock_Listen(27015)
                
    } Else If (sEvent = "DISCONNECTED") {
;	Msgbox In DisConnected
        AHKsock_Listen(7777)
        AHKsock_Close()
        iPeerSocket := -1
		if not bExiting {
            If (i := AHKsock_Listen(7777, "Peer")) {
                Msgbox, % "AHKsock_Listen() failed with return value = " i " and ErrorLevel = " ErrorLevel
            } ;Else Msgbox, % "The peer disconnected! Exiting..."
        }
    } Else If (sEvent = "RECEIVED") {
;	Msgbox In Received

        ;StreamProcessor(bData, bDataLength)
        bData := Strget(&bData, "UTF-8") ; THIS IS HOLY IMPORTANT!!!! 
		;msgbox,%bData% with %bDataLength% length
		data=%bdata%
		if(bdata="hey"){
			msgbox, HIDE UR WIFE!
			}
        if(bdata="FCOPY") {
            Run "PREP_copyFiles.ahk"
            }
        if(bdata="START") {
            Run "PREP_runPlayer.ahk"
            }
        if(bdata="STOP") {
            Run "PREP_stopPlayer.ahk"
            }    
        if(bdata="KILL") {
            Run "PREP_killPlayer.ahk"
            }
        if(bdata="FULL") {
            Run "PREP_setfullPlayer.ahk"
            }
                   
    }
}
return
send:
	Gui,Submit,Nohide
	if(IpeerSocket=-1)
		return
	sText=%Message%
    iTextLength := StrLen(sText)
If (i := AHKsock_ForceSend(iPeerSocket, &sText, iTextLength)) {
        MsgBox, % "AHKsock_ForceSend failed with return value = " i " and error code = " ErrorLevel
        ExitApp
    }
return
#r::
msgbox,reloading
reload

GuiEscape:
GuiClose:
bExiting := True
    AHKsock_Close()
ExitApp


