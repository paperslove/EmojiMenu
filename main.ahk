#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%
#SingleInstance Force
SetBatchLines -1
CoordMode, Mouse, Screen
SetMouseDelay, 0

FileInstall emoji_happy, %A_WorkingDir%/emoji_happy
FileInstall emoji_neutral, %A_WorkingDir%/emoji_neutral
FileInstall emoji_negative, %A_WorkingDir%/emoji_negative

Gui, Add, TreeView, vMyTree r16 gMyTree
TV1 := TV_Add("Positive")
TV2 := TV_Add("Neutral")
TV3 := TV_Add("Negative")
GuiControl, -Redraw, MyTreeView 
Loop
{
	FileReadLine, tempEmojiVar, emoji_happy, %A_Index%
	if ErrorLevel
        break
	TV1C%A_Index% := TV_Add(tempEmojiVar, TV1)
}

Loop
{
	FileReadLine, tempEmojiVar, emoji_neutral, %A_Index%
	if ErrorLevel
        break
	TV2C%A_Index% := TV_Add(tempEmojiVar, TV2)
}

Loop
{
	FileReadLine, tempEmojiVar, emoji_negative, %A_Index%
	if ErrorLevel
        break
	TV3C%A_Index% := TV_Add(tempEmojiVar, TV3)
}
Sleep 21
GuiControl, +Redraw, MyTreeView 
Sleep 21
Gui, Show
return

MyTree:
if (A_GuiEvent = "DoubleClick")
{
    TV_GetText(RowText, A_EventInfo)
    clipboard = %RowText%
	SoundPlay, *-1
}
Return
	
GuiClose:
ExitApp
