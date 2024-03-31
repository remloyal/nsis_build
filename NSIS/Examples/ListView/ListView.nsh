!verbose push
!verbose 3

!include "nsDialogs.nsh"

!ifndef define
    !define define '!insertmacro USER_DEFINE'
    !macro USER_DEFINE CONSTANT VALUE
        !ifndef ${CONSTANT}
            !define ${CONSTANT} ${VALUE}
        !endif
    !macroend
!endif

${define} WS_CAPTION                    0x00C00000

${define} WS_TABSTOP                    0x00010000
${define} WS_GROUP                      0x00020000
${define} WS_SIZEBOX                    0x00040000
${define} WS_SYSMENU                    0x00080000
${define} WS_HSCROLL                    0x00100000
${define} WS_VSCROLL                    0x00200000
${define} WS_DLGFRAME                   0x00400000
${define} WS_BORDER                     0x00800000
${define} WS_MAXIMIZE                   0x01000000
${define} WS_CLIPCHILDREN               0x02000000
${define} WS_CLIPSIBLINGS               0x04000000
${define} WS_DISABLED                   0x08000000
${define} WS_VISIBLE                    0x10000000
${define} WS_ICONIC                     0x20000000
${define} WS_CHILD                      0x40000000
${define} WS_POPUP                      0x80000000

${define} WS_EX_DLGMODALFRAME           0x00000001
${define} WS_EX_NOPARENTNOTIFY          0x00000004
${define} WS_EX_TOPMOST                 0x00000008
${define} WS_EX_ACCEPTFILES             0x00000010
${define} WS_EX_TRANSPARENT             0x00000020
${define} WS_EX_MDICHILD                0x00000040
${define} WS_EX_TOOLWINDOW              0x00000080
${define} WS_EX_WINDOWEDGE              0x00000100
${define} WS_EX_CLIENTEDGE              0x00000200
${define} WS_EX_CONTEXTHELP             0x00000400
${define} WS_EX_RIGHT                   0x00001000
${define} WS_EX_RTLREADING              0x00002000
${define} WS_EX_LEFTSCROLLBAR           0x00004000
${define} WS_EX_CONTROLPARENT           0x00010000
${define} WS_EX_STATICEDGE              0x00020000
${define} WS_EX_APPWINDOW               0x00040000

${define} MAX_PATH                          260

${define} FW_DONTCARE                       0
${define} FW_THIN                           100
${define} FW_EXTRALIGHT                     200
${define} FW_ULTRALIGHT                     200
${define} FW_LIGHT                          300
${define} FW_NORMAL                         400
${define} FW_REGULAR                        400
${define} FW_MEDIUM                         500
${define} FW_SEMIBOLD                       600
${define} FW_DEMIBOLD                       600
${define} FW_BOLD                           700
${define} FW_EXTRABOLD                      800
${define} FW_ULTRABOLD                      800
${define} FW_HEAVY                          900
${define} FW_BLACK                          900

${define} SM_CXSCREEN                       0
${define} SM_CYSCREEN                       1
${define} SM_CXVSCROLL                      2
${define} SM_CYHSCROLL                      3
${define} SM_CYCAPTION                      4
${define} SM_CXBORDER                       5
${define} SM_CYBORDER                       6
${define} SM_CXDLGFRAME                     7
${define} SM_CXFIXEDFRAME                   7
${define} SM_CYDLGFRAME                     8
${define} SM_CYFIXEDFRAME                   8
${define} SM_CYVTHUMB                       9
${define} SM_CXHTHUMB                       10
${define} SM_CXICON                         11
${define} SM_CYICON                         12
${define} SM_CXCURSOR                       13
${define} SM_CYCURSOR                       14
${define} SM_CYMENU                         15
${define} SM_CXFULLSCREEN                   16
${define} SM_CYFULLSCREEN                   17
${define} SM_CYKANJIWINDOW                  18
${define} SM_MOUSEPRESENT                   19
${define} SM_CYVSCROLL                      20
${define} SM_CXHSCROLL                      21
${define} SM_DEBUG                          22
${define} SM_SWAPBUTTON                     23
${define} SM_CXMIN                          28
${define} SM_CYMIN                          29
${define} SM_CXSIZE                         30
${define} SM_CYSIZE                         31
${define} SM_CXFRAME                        32
${define} SM_CXSIZEFRAME                    32
${define} SM_CYFRAME                        33
${define} SM_CYSIZEFRAME                    33
${define} SM_CXMINTRACK                     34
${define} SM_CYMINTRACK                     35
${define} SM_CXDOUBLECLK                    36
${define} SM_CYDOUBLECLK                    37
${define} SM_CXICONSPACING                  38
${define} SM_CYICONSPACING                  39
${define} SM_MENUDROPALIGNMENT              40
${define} SM_PENWINDOWS                     41
${define} SM_DBCSENABLED                    42
${define} SM_CMOUSEBUTTONS                  43
${define} SM_SECURE                         44
${define} SM_CXEDGE                         45
${define} SM_CYEDGE                         46
${define} SM_CXMINSPACING                   47
${define} SM_CYMINSPACING                   48
${define} SM_CXSMICON                       49
${define} SM_CYSMICON                       50
${define} SM_CYSMCAPTION                    51
${define} SM_CXSMSIZE                       52
${define} SM_CYSMSIZE                       53
${define} SM_CXMENUSIZE                     54
${define} SM_CYMENUSIZE                     55
${define} SM_ARRANGE                        56
${define} SM_CXMINIMIZED                    57
${define} SM_CYMINIMIZED                    58
${define} SM_CXMAXTRACK                     59
${define} SM_CYMAXTRACK                     60
${define} SM_CXMAXIMIZED                    61
${define} SM_CYMAXIMIZED                    62
${define} SM_NETWORK                        63
${define} SM_CLEANBOOT                      67
${define} SM_CXDRAG                         68
${define} SM_CYDRAG                         69
${define} SM_SHOWSOUNDS                     70
${define} SM_CXMENUCHECK                    71
${define} SM_CYMENUCHECK                    72
${define} SM_SLOWMACHINE                    73
${define} SM_MIDEASTENABLED                 74
${define} SM_MOUSEWHEELPRESENT              75
${define} SM_XVIRTUALSCREEN                 76
${define} SM_YVIRTUALSCREEN                 77
${define} SM_CXVIRTUALSCREEN                78
${define} SM_CYVIRTUALSCREEN                79
${define} SM_CMONITORS                      80
${define} SM_SAMEDISPLAYFORMAT              81
${define} SM_IMMENABLED                     82
${define} SM_CXFOCUSBORDER                  83
${define} SM_CYFOCUSBORDER                  84
${define} SM_TABLETPC                       86
${define} SM_MEDIACENTER                    87
${define} SM_STARTER                        88
${define} SM_SERVERR2                       89
${define} SM_MOUSEHORIZONTALWHEELPRESENT    91
${define} SM_CXPADDEDBORDER                 92
${define} SM_DIGITIZER                      94
${define} SM_MAXIMUMTOUCHES                 95
${define} SM_REMOTESESSION              0x00001000
${define} SM_SHUTTINGDOWN               0x00002000
${define} SM_REMOTECONTROL              0x00002001

${define} DRIVE_UNKNOWN                     0
${define} DRIVE_NO_ROOT_DIR                 1
${define} DRIVE_REMOVABLE                   2
${define} DRIVE_FIXED                       3
${define} DRIVE_REMOTE                      4
${define} DRIVE_CDROM                       5
${define} DRIVE_RAMDISK                     6

${define} LVS_ICON                      0x00000000
${define} LVS_REPORT                    0x00000001
${define} LVS_SMALLICON                 0x00000002
${define} LVS_LIST                      0x00000003
${define} LVS_SINGLESEL                 0x00000004
${define} LVS_SHOWSELALWAYS             0x00000008
${define} LVS_SORTASCENDING             0x00000010
${define} LVS_SORTDESCENDING            0x00000020
${define} LVS_SHAREIMAGELISTS           0x00000040
${define} LVS_NOLABELWRAP               0x00000080
${define} LVS_ALIGNTOP                  0x00000000
${define} LVS_AUTOARRANGE               0x00000100
${define} LVS_EDITLABELS                0x00000200
${define} LVS_OWNERDRAWFIXED            0x00000400
${define} LVS_ALIGNLEFT                 0x00000800
${define} LVS_OWNERDATA                 0x00001000
${define} LVS_NOSCROLL                  0x00002000
${define} LVS_NOCOLUMNHEADER            0x00004000
${define} LVS_NOSORTHEADER              0x00008000

${define} LVS_EX_GRIDLINES              0x00000001
${define} LVS_EX_SUBITEMIMAGES          0x00000002
${define} LVS_EX_CHECKBOXES             0x00000004
${define} LVS_EX_TRACKSELECT            0x00000008
${define} LVS_EX_HEADERDRAGDROP         0x00000010
${define} LVS_EX_FULLROWSELECT          0x00000020
${define} LVS_EX_ONECLICKACTIVATE       0x00000040
${define} LVS_EX_TWOCLICKACTIVATE       0x00000080
${define} LVS_EX_FLATSB                 0x00000100
${define} LVS_EX_REGIONAL               0x00000200
${define} LVS_EX_INFOTIP                0x00000400
${define} LVS_EX_UNDERLINEHOT           0x00000800
${define} LVS_EX_UNDERLINECOLD          0x00001000
${define} LVS_EX_MULTIWORKAREAS         0x00002000
${define} LVS_EX_LABELTIP               0x00004000
${define} LVS_EX_BORDERSELECT           0x00008000
${define} LVS_EX_DOUBLEBUFFER           0x00010000

${define} LVM_FIRST                     0x00001000
${define} LVM_GETBKCOLOR                0x00001000
${define} LVM_SETBKCOLOR                0x00001001
${define} LVM_GETIMAGELIST              0x00001002
${define} LVM_SETIMAGELIST              0x00001003
${define} LVM_GETITEMCOUNT              0x00001004
${define} LVM_GETITEM                   0x00001005
${define} LVM_SETITEM                   0x00001006
${define} LVM_INSERTITEM                0x00001007
${define} LVM_DELETEITEM                0x00001008
${define} LVM_DELETEALLITEMS            0x00001009
${define} LVM_GETCALLBACKMASK           0x0000100A
${define} LVM_SETCALLBACKMASK           0x0000100B
${define} LVM_GETNEXTITEM               0x0000100C
${define} LVM_FINDITEM                  0x0000100D
${define} LVM_GETITEMRECT               0x0000100E
${define} LVM_SETITEMPOSITION           0x0000100F
${define} LVM_GETITEMPOSITION           0x00001010
${define} LVM_GETSTRINGWIDTH            0x00001011
${define} LVM_HITTEST                   0x00001012
${define} LVM_ENSUREVISIBLE             0x00001013
${define} LVM_SCROLL                    0x00001014
${define} LVM_REDRAWITEMS               0x00001015
${define} LVM_ARRANGE                   0x00001016
${define} LVM_EDITLABEL                 0x00001017
${define} LVM_GETEDITCONTROL            0x00001018
${define} LVM_GETCOLUMN                 0x00001019
${define} LVM_SETCOLUMN                 0x0000101A
${define} LVM_INSERTCOLUMN              0x0000101B
${define} LVM_DELETECOLUMN              0x0000101C
${define} LVM_GETCOLUMNWIDTH            0x0000101D
${define} LVM_SETCOLUMNWIDTH            0x0000101E
${define} LVM_GETHEADER                 0x0000101F
${define} LVM_CREATEDRAGIMAGE           0x00001021
${define} LVM_GETVIEWRECT               0x00001022
${define} LVM_GETTEXTCOLOR              0x00001023
${define} LVM_SETTEXTCOLOR              0x00001024
${define} LVM_GETTEXTBKCOLOR            0x00001025
${define} LVM_SETTEXTBKCOLOR            0x00001026
${define} LVM_GETTOPINDEX               0x00001027
${define} LVM_GETCOUNTPERPAGE           0x00001028
${define} LVM_GETORIGIN                 0x00001029
${define} LVM_UPDATE                    0x0000102A
${define} LVM_SETITEMSTATE              0x0000102B
${define} LVM_GETITEMSTATE              0x0000102C
${define} LVM_GETITEMTEXT               0x0000102D
${define} LVM_SETITEMTEXT               0x0000102E
${define} LVM_SETITEMCOUNT              0x0000102F
${define} LVM_SORTITEMS                 0x00001030
${define} LVM_SETITEMPOSITION32         0x00001031
${define} LVM_GETSELECTEDCOUNT          0x00001032
${define} LVM_GETITEMSPACING            0x00001033
${define} LVM_GETISEARCHSTRING          0x00001034
${define} LVM_SETICONSPACING            0x00001035
${define} LVM_SETEXTENDEDLISTVIEWSTYLE  0x00001036
${define} LVM_GETEXTENDEDLISTVIEWSTYLE  0x00001037
${define} LVM_GETSUBITEMRECT            0x00001038
${define} LVM_SUBITEMHITTEST            0x00001039
${define} LVM_SETCOLUMNORDERARRAY       0x0000103A
${define} LVM_GETCOLUMNORDERARRAY       0x0000103B
${define} LVM_SETHOTITEM                0x0000103C
${define} LVM_GETHOTITEM                0x0000103D
${define} LVM_SETHOTCURSOR              0x0000103E
${define} LVM_GETHOTCURSOR              0x0000103F
${define} LVM_APPROXIMATEVIEWRECT       0x00001040
${define} LVM_SETWORKAREAS              0x00001041
${define} LVM_GETSELECTIONMARK          0x00001042
${define} LVM_SETSELECTIONMARK          0x00001043
${define} LVM_SETBKIMAGE                0x00001044
${define} LVM_GETBKIMAGE                0x00001045
${define} LVM_GETWORKAREAS              0x00001046
${define} LVM_SETHOVERTIME              0x00001047
${define} LVM_GETHOVERTIME              0x00001048
${define} LVM_GETNUMBEROFWORKAREAS      0x00001049
${define} LVM_SETTOOLTIPS               0x0000104A
${define} LVM_GETTOOLTIPS               0x0000104E

${define} LVM_SORTITEMSEX               0x00001051
${define} LVM_GETGROUPSTATE             0x0000105C
${define} LVM_GETFOCUSEDGROUP           0x0000105D
${define} LVM_GETGROUPRECT              0x00001062
${define} LVM_SETSELECTEDCOLUMN         0x0000108C
${define} LVM_SETVIEW                   0x0000108E
${define} LVM_GETVIEW                   0x0000108F
${define} LVM_INSERTGROUP               0x00001091
${define} LVM_SETGROUPINFO              0x00001093
${define} LVM_GETGROUPINFO              0x00001095
${define} LVM_REMOVEGROUP               0x00001096
${define} LVM_MOVEGROUP                 0x00001097
${define} LVM_GETGROUPCOUNT             0x00001098
${define} LVM_GETGROUPINFOBYINDEX       0x00001099
${define} LVM_MOVEITEMTOGROUP           0x0000109A
${define} LVM_SETGROUPMETRICS           0x0000109B
${define} LVM_GETGROUPMETRICS           0x0000109C
${define} LVM_ENABLEGROUPVIEW           0x0000109D
${define} LVM_SORTGROUPS                0x0000109E
${define} LVM_INSERTGROUPSORTED         0x0000109F
${define} LVM_REMOVEALLGROUPS           0x000010A0
${define} LVM_HASGROUP                  0x000010A1
${define} LVM_SETTILEVIEWINFO           0x000010A2
${define} LVM_GETTILEVIEWINFO           0x000010A3
${define} LVM_SETTILEINFO               0x000010A4
${define} LVM_GETTILEINFO               0x000010A5
${define} LVM_SETINSERTMARK             0x000010A6
${define} LVM_GETINSERTMARK             0x000010A7
${define} LVM_INSERTMARKHITTEST         0x000010A8
${define} LVM_GETINSERTMARKRECT         0x000010A9
${define} LVM_SETINSERTMARKCOLOR        0x000010AA
${define} LVM_GETINSERTMARKCOLOR        0x000010AB
${define} LVM_SETINFOTIP                0x000010AD
${define} LVM_GETSELECTEDCOLUMN         0x000010AE
${define} LVM_ISGROUPVIEWENABLED        0x000010AF
${define} LVM_GETOUTLINECOLOR           0x000010B0
${define} LVM_SETOUTLINECOLOR           0x000010B1
${define} LVM_CANCELEDITLABEL           0x000010B3
${define} LVM_MAPINDEXTOID              0x000010B4
${define} LVM_MAPIDTOINDEX              0x000010B5
${define} LVM_ISITEMVISIBLE             0x000010B6
${define} LVM_GETEMPTYTEXT              0x000010CC
${define} LVM_GETFOOTERRECT             0x000010CD
${define} LVM_GETFOOTERINFO             0x000010CE
${define} LVM_GETFOOTERITEMRECT         0x000010CF
${define} LVM_GETFOOTERITEM             0x000010D0
${define} LVM_GETITEMINDEXRECT          0x000010D1
${define} LVM_SETITEMINDEXSTATE         0x000010D2
${define} LVM_GETNEXTITEMINDEX          0x000010D3

${define} LVA_DEFAULT                       0
${define} LVA_ALIGNLEFT	                    1
${define} LVA_ALIGNTOP                      2
${define} LVA_SNAPTOGRID                    5

${define} LV_VIEW_ICON                  0x00000000
${define} LV_VIEW_DETAILS               0x00000001
${define} LV_VIEW_SMALLICON             0x00000002
${define} LV_VIEW_LIST                  0x00000003
${define} LV_VIEW_TILE                  0x00000004

${define} LVIS_FOCUSED                  0x00000001
${define} LVIS_SELECTED                 0x00000002
${define} LVIS_CUT                      0x00000004
${define} LVIS_DROPHILITED              0x00000008
${define} LVIS_OVERLAYMASK              0x00000F00
${define} LVIS_STATEIMAGEMASK           0x0000F000
${define} LVIS_UNCHECKED                0x00001000
${define} LVIS_CHECKED                  0x00002000

${define} LVSIL_NORMAL                      0
${define} LVSIL_SMALL                       1
${define} LVSIL_STATE                       2
${define} LVSIL_HEADER                      3

${define} LVCF_FMT                      0x00000001
${define} LVCF_WIDTH                    0x00000002
${define} LVCF_TEXT                     0x00000004
${define} LVCF_SUBITEM                  0x00000008
${define} LVCF_IMAGE                    0x00000010
${define} LVCF_ORDER                    0x00000020

${define} LVCFMT_LEFT                   0x00000000
${define} LVCFMT_RIGHT                  0x00000001
${define} LVCFMT_CENTER                 0x00000002
${define} LVCFMT_JUSTIFYMASK            0x00000003
${define} LVCFMT_IMAGE                  0x00000800
${define} LVCFMT_BITMAP_ON_RIGHT        0x00001000
${define} LVCFMT_COL_HAS_IMAGES         0x00008000

${define} LVFI_PARAM                        1
${define} LVFI_STRING                       2
${define} LVFI_SUBSTRING                    4       # Vista or later
${define} LVFI_PARTIAL                      8
${define} LVFI_WRAP                         32
${define} LVFI_NEARESTXY                    64

${define} LVIF_TEXT                     0x00000001
${define} LVIF_IMAGE                    0x00000002
${define} LVIF_PARAM                    0x00000004
${define} LVIF_STATE                    0x00000008
${define} LVIF_INDENT                   0x00000010
${define} LVIF_GROUPID                  0x00000100
${define} LVIF_COLUMNS                  0x00000200
${define} LVIF_NORECOMPUTE              0x00000800

${define} LR_DEFAULTCOLOR               0x00000000
${define} LR_MONOCHROME                 0x00000001
${define} LR_LOADFROMFILE               0x00000010
${define} LR_LOADTRANSPARENT            0x00000020
${define} LR_DEFAULTSIZE                0x00000040
${define} LR_VGACOLOR                   0x00000080
${define} LR_LOADMAP3DCOLORS            0x00001000
${define} LR_CREATEDIBSECTION           0x00002000
${define} LR_SHARED                     0x00008000

${define} ILC_COLOR                         0
${define} ILC_MASK                          1
${define} ILC_COLOR4                        4
${define} ILC_COLOR8                        8
${define} ILC_COLOR16                       16
${define} ILC_COLOR24                       24
${define} ILC_COLOR32                       32
${define} ILC_COLORDDB                      254

${define} CLR_NONE                      0xFFFFFFFF
${define} CLR_DEFAULT                   0xFF000000

!define __NSD_ListView_CLASS SysListView32
!define __NSD_ListView_STYLE ${DEFAULT_STYLES}|${LVS_REPORT}|${LVS_SINGLESEL}|${LVS_SHAREIMAGELISTS}|${LVS_NOSORTHEADER}
!define __NSD_ListView_EXSTYLE ${WS_EX_WINDOWEDGE}|${WS_EX_CLIENTEDGE}

!insertmacro __NSD_DefineControl ListView

!macro __NSD_ImageList_Create TYPE XSIZE YSIZE HIML

    !if ${TYPE} == Icon
        !define IMG_UNIT ${ILC_COLOR32}
    !else
        !define IMG_UNIT ${ILC_COLORDDB}
    !endif
    System::Call 'comctl32::ImageList_Create(i ${XSIZE}, i ${YSIZE}, i ${ILC_MASK}|${IMG_UNIT}, i 0, i 0) i.s'
    Pop ${HIML}
    !undef IMG_UNIT

!macroend

!define NSD_ImageList_Create '!insertmacro __NSD_ImageList_Create Bitmap'
!define NSD_ImageList_Create2 '!insertmacro __NSD_ImageList_Create Icon'

!macro __NSD_ImageList_AddBitmap HIML IMAGEFILE

    Push $0
    System::Call 'user32::LoadImage(i 0, t "${IMAGEFILE}", i ${IMAGE_BITMAP}, i 0, i 0, i ${LR_LOADFROMFILE}|${LR_DEFAULTSIZE}) i.r0'
    System::Call 'comctl32::ImageList_AddMasked(i ${HIML}, i r0, i ${CLR_DEFAULT})'
    System::Call 'gdi32::DeleteObject(ir0)'
    Pop $0

!macroend

!define NSD_ImageList_AddBitmap '!insertmacro __NSD_ImageList_AddBitmap'


!macro __NSD_ImageList_AddIcon HIML XSIZE YSIZE ICONFILE

    Push $0
    System::Call 'user32::LoadImage(i 0, t "${ICONFILE}", i ${IMAGE_ICON}, i ${XSIZE}, i ${YSIZE}, i ${LR_LOADFROMFILE}|${LR_SHARED}) i.r0'
    System::Call 'comctl32::ImageList_AddIcon(i ${HIML}, i r0)'
    System::Call 'gdi32::DeleteObject(ir0)'
    Pop $0

!macroend

!define NSD_ImageList_AddIcon '!insertmacro __NSD_ImageList_AddIcon'


!macro __NSD_ImageList_AddIcon2 HIML XSIZE YSIZE RESFILE ICONINDEX

    Push $0
    Push $1
    System::Call 'kernel32::GetModuleHandle(t "${RESFILE}") i.r0'
    System::Call 'user32::LoadImage(i r0, i ${ICONINDEX}, i ${IMAGE_ICON}, i ${XSIZE}, i ${YSIZE}, i ${LR_SHARED}) i.r1'
    System::Call 'comctl32::ImageList_AddIcon(i ${HIML}, i r1)'
    System::Call 'gdi32::DeleteObject(i r1)'
    System::Call 'user32::FreeLibrary(i r0)'
    Pop $1
    Pop $0

!macroend

!define NSD_ImageList_AddIcon2 '!insertmacro __NSD_ImageList_AddIcon2'


!macro __NSD_ImageList_Destroy HIML

    Push ${HIML}
    System::Call 'comctl32::ImageList_Destroy(i s)'

!macroend

!define NSD_ImageList_Destroy '!insertmacro __NSD_ImageList_Destroy'



!macro __NSD_LV_InsertColumn HWNDCTL INDEX WIDTH TEXT

    System::Call "*(i,i,i,t,i,i)i(${LVCF_FMT}|${LVCF_WIDTH}|${LVCF_TEXT},${LVCFMT_CENTER},${WIDTH},'${TEXT}',${MAX_PATH},).s"
    Exch $0
    SendMessage ${HWNDCTL} ${LVM_INSERTCOLUMN} ${INDEX} $0
    System::Free $0
    Pop $0

!macroend

!define NSD_LV_InsertColumn '!insertmacro __NSD_LV_InsertColumn'


!macro __NSD_LV_GetColumnWidth HWNDCTL INDEX VAR

    SendMessage ${HWNDCTL} ${LVM_GETCOLUMNWIDTH} ${INDEX} 0 ${VAR}

!macroend


!define NSD_LV_GetColumnWidth '!insertmacro __NSD_LV_GetColumnWidth'

!macro __NSD_LV_SetColumnWidth HWNDCTL INDEX WIDTH

    SendMessage ${HWNDCTL} ${LVM_SETCOLUMNWIDTH} ${INDEX} ${WIDTH}

!macroend


!define NSD_LV_SetColumnWidth '!insertmacro __NSD_LV_SetColumnWidth'

!macro __NSD_LV_InsertItem HWNDCTL ITEM TEXT

    System::Call "*(i,i,i,i,i,t,i,i,i)i(${LVIF_TEXT}|${LVIF_IMAGE},${ITEM},,,,'${TEXT}',${MAX_PATH},,).s"
    Exch $0
    SendMessage ${HWNDCTL} ${LVM_INSERTITEM} 0 $0
    System::Free $0
    Pop $0

!macroend

!define NSD_LV_InsertItem '!insertmacro __NSD_LV_InsertItem'


!macro __NSD_LV_SetItemIcon HWNDCTL ITEM ICONINDEX

    System::Call "*(i,i,i,i,i,t,i,i,i)i(${LVIF_IMAGE},${ITEM},,,,,${MAX_PATH},${ICONINDEX},).s"
    Exch $0
    SendMessage ${HWNDCTL} ${LVM_SETITEM} 0 $0
    System::Free $0
    Pop $0

!macroend

!define NSD_LV_SetItemIcon '!insertmacro __NSD_LV_SetItemIcon'


!macro __NSD_LV_SetSubItem HWNDCTL ITEM SUBITEM TEXT

    System::Call "*(i,i,i,i,i,t,i,i,i)i(${LVIF_TEXT},${ITEM},${SUBITEM},,,'${TEXT}',${MAX_PATH},,).s"
    Exch $0
    SendMessage ${HWNDCTL} ${LVM_SETITEM} 0 $0
    System::Free $0
    Pop $0

!macroend

!define NSD_LV_SetSubItem '!insertmacro __NSD_LV_SetSubItem'


!macro __NSD_LV_CheckItem HWNDCTL ITEM

    System::Call "*(i,i,i,i,i,t,i,i,i)i(${LVIF_STATE},${ITEM},,${LVIS_CHECKED},${LVIS_STATEIMAGEMASK},,,,).s"
    Exch $0
    SendMessage ${HWNDCTL} ${LVM_SETITEMSTATE} ${ITEM} $0
    System::Free $0
    Pop $0

!macroend

!define NSD_LV_CheckItem '!insertmacro __NSD_LV_CheckItem'


!macro __NSD_LV_GetItemText HWNDCTL ITEM SUBITEM VAR

    Push $0
    System::Alloc ${NSIS_MAX_STRLEN}
    Pop $0
    Push ${SUBITEM}
    Push ${ITEM}
    System::Call '*(i,i,i,i,i,t,i,i,i)i(${LVIF_TEXT},s,s,,,ir0,${MAX_PATH},,).s'
    Exch $0
    SendMessage ${HWNDCTL} ${LVM_GETITEMTEXT} ${ITEM} $0
    System::Free $0
    Pop $0
    System::Call '*$0(&t${NSIS_MAX_STRLEN}.s)'
    System::Free $0
    Exch
    Pop $0
    Pop ${VAR}

!macroend

!define NSD_LV_GetItemText '!insertmacro __NSD_LV_GetItemText'


!verbose pop