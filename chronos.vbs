Option Explicit

Dim wallpaperPath, htmlFilePath, Shell, answer
Dim excludedProcesses
Dim objWMIService, colProcesses, objProcess

excludedProcesses = Array("chrome.exe", "firefox.exe", "iexplore.exe")

On Error Resume Next

Set objWMIService = GetObject("winmgmts:\\.\root\cimv2")
If Err.Number <> 0 Then
    MsgBox "Error getting WMI service: " & Err.Description, vbCritical, "Error"
    WScript.Quit
End If

Set colProcesses = objWMIService.ExecQuery("SELECT * FROM Win32_Process")
If Err.Number <> 0 Then
    MsgBox "Error querying processes: " & Err.Description, vbCritical, "Error"
    Set objWMIService = Nothing
    WScript.Quit
End If

Dim fso, scriptFile, parentFolder
Set fso = CreateObject("Scripting.FileSystemObject")
Set scriptFile = fso.GetFile(WScript.ScriptFullName)
parentFolder = fso.GetParentFolderName(scriptFile)

Set Shell = CreateObject("WScript.Shell")

answer = MsgBox("WARNING: THIS VIRUS CAN HARM TO YOUR COMPUTER, DO YOU WANT TO RUN THIS MALWARE?", vbExclamation + vbYesNo, "WARNING")

Function runVirus()
    wallpaperPath = parentFolder & "\matrix.png"
    htmlFilePath = parentFolder & "\hacked.html"

    Shell.RegWrite "HKCU\Control Panel\Desktop\Wallpaper", wallpaperPath
    If Err.Number <> 0 Then
        MsgBox "Error writing registry: " & Err.Description, vbCritical, "Error"
        WScript.Quit
    End If

    Shell.Run "RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters", 1, True
    If Err.Number <> 0 Then
        MsgBox "Error updating wallpaper: " & Err.Description, vbCritical, "Error"
        WScript.Quit
    End If

    MsgBox "Wallpaper changed successfully!", vbInformation, "Success"
    
    ' Uncomment the following line to run the HTML file
    ' Shell.Run """" & htmlFilePath & """", 1, False
End Function

If answer = vbYes Then
    runVirus()
End If

Set Shell = Nothing
