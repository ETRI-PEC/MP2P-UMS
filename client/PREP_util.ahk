
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Util
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

memory=%clipboard%
clipboard=

cnt=1
f1::
mousegetpos,xp,yp
clipboard=%clipboard%`n%cnt%:%xp%,%yp%
check=%clipboard%
cnt++
msgbox,%check%
return

f2::reload
f3::
msgbox,%memory%
return

f4::
exitapp

return
