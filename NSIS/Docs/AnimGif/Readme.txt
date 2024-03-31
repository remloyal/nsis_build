AnimGif.dll - 这是一个在安装程序页面上显示动画横幅的插件。
基于Juan Soulie的代码。与基于PictureEx的版本相比，它的工作速度更快，但是即使我修复了一些错误（并添加了透明度支持），它仍然不喜欢某些图像（就像Juan Soulie原始程序一样），所以不要忘记使用您的GIF进行测试 :)
PictureEx版本可以在AnimGifPe.zip文件中找到。

使用方法：

1）AnimGif::play /NOUNLOAD [/HALIGN=POSX] [/VALIGN=POSY] [/HWND=xxx] [/BGCOL=xxx] [/FIT=WIDTH|HEIGHT|BOTH] FileName

FileName - 图像文件名。支持Bmp、gif和jpg图像类型。

空的文件名字符串""清除图像，但不停止声音播放。

HALIGN - 对齐（在目标窗口上），宽度的百分比，默认为50（居中）

VALIGN - 对齐，高度的百分比，默认为100（底部）

HWND - 目标窗口句柄，默认为当前页面的#32770子窗口。

BGCOL - 用于图像透明区域的颜色。如果未定义，插件将尝试从目标窗口中提取值，但如果窗口隐藏，则无法实现此目标。
颜色值可以是十六进制（以0x开头）或十进制（第一个字符不为0）。十六进制值将用作RGB颜色，十进制值将用作GetSysColor() API调用中的Windows系统颜色索引，请参阅MSDN。如果未指定值并且目标窗口保持隐藏（例如在自定义的“Show”函数中），将使用默认的COLOR_BTNFACE颜色。

FIT - 图像拉伸以占用窗口的宽度或高度。主要用于屏幕dpi为120的情况。

默认值-不拉伸。

例如：

 AnimGif::play /NOUNLOAD "$PLUGINSDIR\felix_new.gif"
2）AnimGif::stop
停止播放并清除窗口
======================================================
作者：Takhir Bedertdinov
