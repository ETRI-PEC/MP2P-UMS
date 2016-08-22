#SingleInstance, Off
#Include %A_ScriptDir%\AHKsock_unicode.ahk
 ;#Include %A_ScriptDir%\AHKsock_ansi.ahk
 ;#Include %A_ScriptDir%\AHKsock_tmp.ahk
 
 iPeerSocket := -1
 Gui, Add, Edit, x2 y0 w200 h40 vMessage, 
 Gui, Add, Button, x202 y0 w90 h40 gSend, Button
 ; Generated using SmartGUI Creator 4.0
 Gui, Show, x500 y87 h47 w298, Client
 OnExit, GuiClose


top:


 sName:="127.0.0.1"
 
 If (i := AHKsock_Connect(sName, 27015, "Peer"))
        MsgBox, % "AHKsock_Connect() failed with return value = " i " and ErrorLevel = " ErrorLevel
Return

Peer(sEvent, iSocket = 0, sName = 0, sAddr = 0, sPort = 0, ByRef bData = 0, bDataLength = 0) {
    Global iPeerSocket, bExiting, bSameMachine, bCantListen
    
    If (sEvent = "ACCEPTED") {
        MsgBox, % "A client with IP " sAddr " connected!" iPeerSocket
        
        If (iPeerSocket <> -1) {
            MsgBox, % "We already have a peer! Disconnecting..."
            AHKsock_Close(iSocket) ;Close the socket
            Return
        }
        iPeerSocket := iSocket
        
    } If (sEvent = "CONNECTED") {
        If (iSocket = -1) {
            MsgBox, % "AHKsock_Connect() failed."
         If (i := AHKsock_Connect(sName, 27015, "Peer")) {
           }   
       } Else MsgBox, % "AHKsock_Connect() successfully connected on IP " sAddr "."

        If (iPeerSocket <> -1) 
		{
            MsgBox, % "We already have a peer! Disconnecting..."
            AHKsock_Close(iSocket) ;Close the socket
            Return
        }
        iPeerSocket := iSocket
        
    } Else If (sEvent = "DISCONNECTED") {
		AHKsock_Close()
        iPeerSocket := -1
		if not bexiting{
		If (i := AHKsock_Connect(sName, 27015, "Peer")) {
                MsgBox, % "AHKsock_Connect() failed with return value = " i " and ErrorLevel = " ErrorLevel
            }Else MsgBox, % "The peer disconnected! Going back to connecting..."
			}
		
            
        
    } Else If (sEvent = "RECEIVED") {
		msgbox,%bdata%
		data=%bdata%
		if(bdata="hey"){
			msgbox, HIDE UR WIFE!
			}
    }
}

return
send:
	Gui,Submit,Nohide
	if(IpeerSocket=-1)
		return
	sText=%Message%
    MsgBox, U typed %Message%, and %sText%
    sText := Strget(&sText, "UTF-8")
    iTextLength := StrLen(sText)
    MsgBox, Transformed but..shit.... %sText% with %iTextLength%..
If (i := AHKsock_ForceSend(iPeerSocket, &sText, iTextLength)) {
        MsgBox, % "AHKsock_ForceSend failed with return value = " i " and error code = " ErrorLevel
    }
return
#r::
msgbox,reloading
reload

GuiEscape:
GuiClose:
bexiting :=True
    AHKsock_Close()
ExitApp