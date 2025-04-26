#Persistent
#SingleInstance Force
DetectHiddenWindows, On

OnMessage(0x02B1, "SessionChange")

; Global Variables
SecretSignRecognized := false
CheckActive := false
MaxTime := 2 * 60 * 1000 ; 2 minutes

; Window Tracking
FirstStepOK := false
SecondStepOK := false
ThirdStepOK := false

; Mouse Gesture Tracking
MouseShakePhase := 0
ShakeStart := 0
LastMoveTime := 0
LastX := 0
LastY := 0

return

SessionChange(wParam, lParam)
{
    global CheckActive, SecretSignRecognized, StartTime, MaxTime
    global FirstStepOK, SecondStepOK, ThirdStepOK
    global MouseShakePhase, ShakeStart, LastMoveTime, LastX, LastY

    if (lParam = 8) ; 8 = WTS_SESSION_UNLOCK
    {
        SecretSignRecognized := false
        FirstStepOK := false
        SecondStepOK := false
        ThirdStepOK := false
        MouseShakePhase := 0
        ShakeStart := 0
        LastMoveTime := 0
        LastX := 0
        LastY := 0
        CheckActive := true
        StartTime := A_TickCount
        SetTimer, MonitorAction, 1000
        SetTimer, MonitorWindow, 500
        SetTimer, MonitorMouse, 100
        TrayTip,, Welcome back! Please Authenticate., 5
    }
}

; Hotkey: CTRL + WIN + K
^#k::
    global SecretSignRecognized, CheckActive
    if (CheckActive)
    {
        SecretSignRecognized := true
        EndAll("Hotkey recognized.")
    }
return

MonitorAction:
    global CheckActive, SecretSignRecognized, StartTime, MaxTime

    if (!CheckActive)
        return

    TimeElapsed := A_TickCount - StartTime
    if (TimeElapsed > MaxTime and !SecretSignRecognized)
    {
        TrayTip,, Incorrect behavior! Locking now..., 2
        Sleep, 1000
        DllCall("LockWorkStation") ; Lock Windows
        ExitApp
    }
return

MonitorWindow:
    global SecretSignRecognized, CheckActive
    global FirstStepOK, SecondStepOK, ThirdStepOK

    if (!CheckActive)
        return

    WinGetActiveTitle, ActiveWindow

    if (!FirstStepOK && (InStr(ActiveWindow, "Calculator")))
    {
        FirstStepOK := true
        TrayTip,, 1st step OK (Calculator), 2
    }
    else if (FirstStepOK && !SecondStepOK && InStr(ActiveWindow, "Settings"))
    {
        SecondStepOK := true
        TrayTip,, 2nd step OK (Settings), 2
    }
    else if (FirstStepOK && SecondStepOK && !ThirdStepOK && InStr(ActiveWindow, "Explorer"))
    {
        ThirdStepOK := true
        SecretSignRecognized := true
        EndAll("Window sequence recognized.")
    }
return

MonitorMouse:
    global SecretSignRecognized, CheckActive
    global MouseShakePhase, ShakeStart, LastMoveTime, LastX, LastY

    if (!CheckActive)
        return

    MouseGetPos, CurrentX, CurrentY
    Movement := Abs(CurrentX - LastX) + Abs(CurrentY - LastY)

    if (MouseShakePhase = 0 and Movement > 50)
    {
        ShakeStart := A_TickCount
        MouseShakePhase := 1
        TrayTip,, Shake detected - Phase 1 started, 2
    }
    else if (MouseShakePhase = 1)
    {
        if (A_TickCount - ShakeStart > 5000) ; Shake for 5 seconds
        {
            MouseShakePhase := 2
            LastMoveTime := A_TickCount
            TrayTip,, Stop now for 2 seconds, 2
        }
    }
    else if (MouseShakePhase = 2)
    {
        if (Movement < 5)
        {
            if (A_TickCount - LastMoveTime > 2000) ; Still for 2 seconds
            {
                MouseShakePhase := 3
                TrayTip,, Start 2nd shake round!, 2
            }
        }
        else
        {
            LastMoveTime := A_TickCount ; Reset if moving
        }
    }
    else if (MouseShakePhase = 3 and Movement > 50)
    {
        SecretSignRecognized := true
        EndAll("Mouse gesture recognized.")
    }

    LastX := CurrentX
    LastY := CurrentY
return

EndAll(Message)
{
    global CheckActive
    SetTimer, MonitorAction, Off
    SetTimer, MonitorWindow, Off
    SetTimer, MonitorMouse, Off
    CheckActive := false
    TrayTip,, Access granted: %Message%, 3
}
