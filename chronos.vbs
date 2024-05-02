Option Explicit

Dim wallpaperPath, htmlFilePath, Shell, answer
Dim excludedProcesses
Dim objWMIService, colProcesses, objProcess

excludedProcesses = Array("chrome.exe", "firefox.exe", "iexplore.exe")

Set objWMIService = GetObject("winmgmts:\\.\root\cimv2")
Set colProcesses = objWMIService.ExecQuery("SELECT * FROM Win32_Process")

Dim fso, scriptFile, parentFolder
Set fso = CreateObject("Scripting.FileSystemObject")
Set scriptFile = fso.GetFile(WScript.ScriptFullName)
parentFolder = fso.GetParentFolderName(scriptFile)

wallpaperPath = parentFolder & "\matrix.png"
htmlFilePath = parentFolder & "\hacked.html"

Set Shell = CreateObject("WScript.Shell")

answer = MsgBox("WARNING: THIS VIRUS CAN HARM TO YOUR COMPUTER, DO YOU WANT TO RUN THIS MALWARE?", vbExclamation + vbYesNo, "WARNING")

Function runVirus()
    wallpaperPath = parentFolder & "\Wallpaper.jpg"
    htmlFilePath = parentFolder & "\File.html"

    Shell.RegWrite "HKCU\Control Panel\Desktop\Wallpaper", wallpaperPath
    Shell.Run "RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters", 1, True

    Shell.Run """" & htmlFilePath & """", 1, False
End Function

If answer = vbYes Then
    runVirus()
End If

Set Shell = Nothing
