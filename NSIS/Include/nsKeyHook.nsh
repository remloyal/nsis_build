!ifndef __NsKeyHook_NSH__
!define __NsKeyHook_NSH__

!define VK_BACK        0x08 ; Backspace key
!define VK_TAB         0x09 ; Tab key
!define VK_RETURN      0x0C ; Enter key
!define VK_SHIFT       0x10 ; Shift key
!define VK_CONTROL     0x11 ; Ctrl key
!define VK_MENU        0x12 ; Alt key
!define VK_PAUSE       0x13 ; Pause key
!define VK_CAPITAL     0x14 ; Caps Lock key
!define VK_ESCAPE      0x1B ; Esc key
!define VK_SPACE       0x20 ; Spacebar key
!define VK_PRIOR       0x21 ; Page Up key
!define VK_NEXT        0x22 ; Page Down key
!define VK_END         0x23 ; End key
!define VK_HOME        0x24 ; Home key
!define VK_LEFT        0x25 ; Left Arrow key
!define VK_UP          0x26 ; Up Arrow key
!define VK_RIGHT       0x27 ; Right Arrow key
!define VK_DOWN        0x28 ; Down Arrow key
!define VK_SNAPSHOT    0x2C ; Print Screen key
!define VK_INSERT      0x2D ; Insert key
!define VK_DELETE      0x2E ; Delete key
!define KEY_0          0x30 ; 0 key
!define KEY_1          0x31 ; 1 key
!define KEY_2          0x32 ; 2 key
!define KEY_3          0x33 ; 3 key
!define KEY_4          0x34 ; 4 key
!define KEY_5          0x35 ; 5 key
!define KEY_6          0x36 ; 6 key
!define KEY_7          0x37 ; 7 key
!define KEY_8          0x38 ; 8 key
!define KEY_9          0x39 ; 9 key
!define KEY_A          0x41 ; A key
!define KEY_B          0x42 ; B key
!define KEY_C          0x43 ; C key
!define KEY_D          0x44 ; D key
!define KEY_E          0x45 ; E key
!define KEY_F          0x46 ; F key
!define KEY_G          0x47 ; G key
!define KEY_H          0x48 ; H key
!define KEY_I          0x49 ; I key
!define KEY_J          0x4A ; J key
!define KEY_K          0x4B ; K key
!define KEY_L          0x4C ; L key
!define KEY_M          0x4D ; M key
!define KEY_N          0x4E ; N key
!define KEY_O          0x4F ; O key
!define KEY_P          0x50 ; P key
!define KEY_Q          0x51 ; Q key
!define KEY_R          0x52 ; R key
!define KEY_S          0x53 ; S key
!define KEY_T          0x54 ; T key
!define KEY_U          0x55 ; U key
!define KEY_V          0x56 ; V key
!define KEY_W          0x57 ; W key
!define KEY_X          0x58 ; X key
!define KEY_Y          0x59 ; Y key
!define KEY_Z          0x5A ; Z key
!define VK_LWIN        0x5B ; Left Windows key
!define VK_RWIN        0x5C ; Right Windows key
!define VK_NUMPAD0     0x60 ; Numeric keypad 0 key
!define VK_NUMPAD1     0x61 ; Numeric keypad 1 key
!define VK_NUMPAD2     0x62 ; Numeric keypad 2 key
!define VK_NUMPAD3     0x63 ; Numeric keypad 3 key
!define VK_NUMPAD4     0x64 ; Numeric keypad 4 key
!define VK_NUMPAD5     0x65 ; Numeric keypad 5 key
!define VK_NUMPAD6     0x66 ; Numeric keypad 6 key
!define VK_NUMPAD7     0x67 ; Numeric keypad 7 key
!define VK_NUMPAD8     0x68 ; Numeric keypad 8 key
!define VK_NUMPAD9     0x69 ; Numeric keypad 9 key
!define VK_MULTIPLY    0x6A ; Multiply key
!define VK_ADD         0x6B ; Add key
!define VK_SEPARATOR   0x6C ; Seperator key
!define VK_SUBTRACT    0x6D ; Subtract key
!define VK_DECIMAL     0x6E ; Decimal key
!define VK_DIVIDE      0x6F ; Divide key
!define VK_F1          0x70 ; F1 key
!define VK_F2          0x71 ; F2 key
!define VK_F3          0x72 ; F3 key
!define VK_F4          0x73 ; F4 key
!define VK_F5          0x74 ; F5 key
!define VK_F6          0x75 ; F6 key
!define VK_F7          0x76 ; F7 key
!define VK_F8          0x77 ; F8 key
!define VK_F9          0x78 ; F9 key
!define VK_F10         0x79 ; F10 key
!define VK_F11         0x7A ; F11 key
!define VK_F12         0x7B ; F12 key
!define VK_NUMLOCK     0x90 ; Num Lock key
!define VK_SCROLL      0x91 ; Scroll Lock key
!define VK_LSHIFT      0xA0 ; Left Shift key
!define VK_RSHIFT      0xA1 ; Right Shift key
!define VK_LCONTROL    0xA2 ; Left Ctrl key
!define VK_RCONTROL    0xA3 ; Right Ctrl key
!define VK_LMENU       0xA4 ; Left Alt key
!define VK_RMENU       0xA5 ; Right aLT key

; Asynchronous keys (modifiers).
!define LEFT_CTRL      1
!define LEFT_ALT       2
!define LEFT_SHIFT     4
!define RIGHT_CTRL     8
!define RIGHT_ALT      16
!define RIGHT_SHIFT    32
!define ANY_CTRL       64
!define ANY_ALT        128
!define ANY_SHIFT      256

; Messages to hook.
!define HOOK_WM_CHAR    1
!define HOOK_WM_KEYUP   2
!define HOOK_WM_KEYDOWN 4
!define HOOK_WM_PASTE   8

; Call the hook handler after processing the message.
!define HOOK_POST       1024

!macro __NSKH_Add Msg HWnd Key AsyncKeys Handler

  Push $R0
  Push $R1

  StrCpy $R1 ${Hwnd}

  GetFunctionAddress $R0 ${Handler}
  nsKeyHook::Add $R1 ${Msg} ${Key} ${AsyncKeys} $R0

  Pop $R1
  Pop $R0

!macroend

!define NSKH_OnChar `!insertmacro __NSKH_Add ${HOOK_WM_CHAR}`
!define NSKH_OnPostChar `!insertmacro __NSKH_Add ${HOOK_WM_CHAR}|${HOOK_POST}`
!define NSKH_OnKeyUp `!insertmacro __NSKH_Add ${HOOK_WM_KEYUP}`
!define NSKH_OnPostKeyUp `!insertmacro __NSKH_Add ${HOOK_WM_KEYUP}|${HOOK_POST}`
!define NSKH_OnKeyDown `!insertmacro __NSKH_Add ${HOOK_WM_KEYDOWN}`
!define NSKH_OnPostKeyDown `!insertmacro __NSKH_Add ${HOOK_WM_KEYDOWN}|${HOOK_POST}`
!define NSKH_OnPaste `!insertmacro __NSKH_Add ${HOOK_WM_PASTE}`
!define NSKH_OnPostPaste `!insertmacro __NSKH_Add ${HOOK_WM_PASTE}|${HOOK_POST}`

!endif