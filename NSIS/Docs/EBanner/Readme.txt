ebanner.dll - 显示安装程序页面底部横幅的插件
支持的格式：所有当前IE可以显示的格式。

用法：

1）ebanner :: show / NOUNLOAD [/ HALIGN = LEFT | RIGHT | CENTER] [/ VALIGN = TOP | BOTTOM | CENTER] [/ HWND = xxx] [/ FIT = WIDTH | HEIGHT | BOTH] FileName

HALIGN - 对齐（在目标窗口上），左、右或居中（默认）

VALIGN - 对齐方式，顶部、居中或底部（默认）

HWND - 目标窗口句柄，默认为当前页面＃32770子窗口。

FIT - 图像拉伸以占据窗口宽度或高度或完整窗口。主要适用于屏幕dpi 120。默认情况下不拉伸。

FileName - 图像文件名。支持Bmp、gif和jpg图像类型。空的文件名字符串“”清除图像，但不停止播放声音。

例如，默认底部中心位置和原始大小：

     ebanner::show /NOUNLOAD "$PLUGINSDIR\catch.gif"

2)   ebanner::stop

     销毁图像，清除窗口，停止声音（如果有）。 可选的，在页面关闭时应自动停止（我猜的）。


3）ebanner :: play / NOUNLOAD [/ LOOP] FileName

FileName - 要播放的声音文件名（带扩展名，如wav、mp3…）。 空的文件名字符串“”停止声音。

例如：

     ebanner::play /NOUNLOAD /LOOP "$PLUGINSDIR\snd.mp3"


Takhir Bedertdinov
