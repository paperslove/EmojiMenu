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
P1 := TV_Add("Positive")
;P1C1 := TV_Add("Parent 1's first child", P1)
P2 := TV_Add("Neutral")
;P2C1 := TV_Add("Parent 2's first child", P2)
P3 := TV_Add("Negative")
;P2C1 := TV_Add("Parent 3's second child", P3)
GuiControl, -Redraw, MyTreeView 
Loop
{
	FileReadLine, tempEmojiVar, emoji_happy, %A_Index%
	if ErrorLevel
        break
	P1C%A_Index% := TV_Add(tempEmojiVar, P1)
}

Loop
{
	FileReadLine, tempEmojiVar, emoji_neutral, %A_Index%
	if ErrorLevel
        break
	P2C%A_Index% := TV_Add(tempEmojiVar, P2)
}

Loop
{
	FileReadLine, tempEmojiVar, emoji_negative, %A_Index%
	if ErrorLevel
        break
	P3C%A_Index% := TV_Add(tempEmojiVar, P3)
}
Sleep 21
GuiControl, +Redraw, MyTreeView 
Sleep 21
Gui, Show
return

; ---------------------------------------------------------------------------
MyTree:
if (A_GuiEvent = "DoubleClick")
{
    TV_GetText(RowText, A_EventInfo)  ; Get the text from the row's first field and store it in the var RowText.
    clipboard = %RowText%
	SoundPlay, *-1
}
Return
	
GuiClose:
ExitApp
