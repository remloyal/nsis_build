nsis插件animate.dll - 使得在NSIS安装程序中可以显示一个闪屏/幻灯片/滚动屏幕的插件。

使用方法：

1）animate::show /NOUNLOAD [/ATIME=xx] [/FLAGS=XX] [/X=xx] [/Y=xx] [/SFG] [/COLOR=0xRRGGBB] [/NOCANCEL] [/BORDER] FileName

退出字符串：OK，error（无法加载图像）

ATIME - 动画时间（毫秒），默认为1秒
FLAGS - 动画模式，默认为混合，有关可能值的 *.nsi 样本，请参阅。默认为 AW_BLEND
X - 从桌面工作区边框的间隙。如果 <0，则从右边界开始，否则从左边界开始。默认值为工作区中心。
Y - 与 X 相同，用于垂直放置
SFG - 尝试在退出时设置父窗口前景
NOCANCEL - 不要在左键单击时关闭窗口
BORDER - 创建窗口边框
COLOR - 透明 gif 的窗口背景颜色
FileName - 图像文件名（带扩展名），支持 bmp、gif 和 jpg。

2）animate::wait [/ATIME=xx] [/FLAGS=XX] [/SFG] [/NOCANCEL | /IFNC] TIME_MS

IFNC - 如果在此之前单击了横幅（清除 NOCANCEL 标志），则将 ATIME 设置为 0

某些选项可以在此调用中重新定义
退出原因：单击，等待，错误（线程不存在），终止

即使“show”返回“error”，也是安全的。

3）animate::hwnd

返回横幅窗口句柄，以便与其他插件（marquee、animgif）一起使用。

备注：
在“show”动画完成并将控制返回到安装程序后，如果未设置 /NOCANCEL 选项，则用户可以使用左键单击关闭窗口。
在“wait”调用中，如果 TIME_MS 为 0 或 /IFNC 设置，用户已单击横幅（但在此之前未关闭横幅，因为如果 /NOCANCEL 选项），插件将立即开始动画。
如果没有发生这些情况，则插件将继续在任何“show”或“wait”调用中的 /NOCANCEL 选项决定的时间或更短时间显示横幅。在任何情况下，横幅都将在“wait”时间过期后关闭。

例如：

桌面中心1秒淡入（混合）和1秒淡出（默认 ATIMEs）
animate::show /NOUNLOAD /NOCANCEL animate.gif
Pop $0
;在这里，您可以添加安装程序初始化代码 - baner带有NOCANCEL选项锁定。
; 现在插件可以立即使用IFNC选项处理用户单击（如果有）或等待1秒。
	animate::wait /IFNC 1000
	Pop $1

底部右侧上升滑动2秒，显示1秒，再滑出2秒。
用户可以在1秒内（左键单击）不带动画地关闭窗口。
	IntOp $R0 ${AW_VER_NEGATIVE} | ${AW_SLIDE}
	animate::show /NOUNLOAD /ATIME=2000 /FLAGS=$R0 /X=-10 /Y=-10 animate.gif
	Pop $0
	animate::wait 1000
	Pop $1


来自zeeh3的2维滑动/滚动的预定义标志：

!define ROLL_LEFT_TO_RIGHT    0x20001
!define ROLL_RIGHT_TO_LEFT    0x20002
!define ROLL_TOP_TO_BOTTOM    0x20004
!define ROLL_BOTTOM_TO_TOP    0x20008
!define ROLL_DIAG_TL_TO_BR    0x20005
!define ROLL_DIAG_TR_TO_BL    0x20006
!define ROLL_DIAG_BL_TO_TR    0x20009
!define ROLL_DIAG_BR_TO_TL    0x2000a
!define SLIDE_LEFT_TO_RIGHT   0x40001
!define SLIDE_RIGHT_TO_LEFT   0x40002
!define SLIDE_TOP_TO_BOTTOM   0x40004
!define SLIDE_BOTTOM_TO_TOP   0x40008
!define SLIDE_DIAG_TL_TO_BR   0x40005
!define SLIDE_DIAG_TR_TO_BL   0x40006
!define SLIDE_DIAG_BL_TO_TR   0x40009
!define SLIDE_DIAG_BR_TO_TL   0x4000a

兼容性：Win98+，Win2k+，NT 4.0的补丁 - 没有动画，但可以显示窗口。

文档翻译：水晶石
Takhir Bedertdinov
