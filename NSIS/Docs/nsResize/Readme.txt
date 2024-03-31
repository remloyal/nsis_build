nsResize NSIS插件

作者：Stuart 'Afrow UK' Welch
公司：Afrow Soft Ltd
日期：2013年4月13日
版本：1.0.0.0

一个小型的NSIS插件，用于移动或调整窗口/控件的大小。

请参阅Examples\nsResize*。

宏
nsResize.nsh包括LargeWindow示例脚本使用的宏。

函数
nsResize::SetRTL $(^RTL)

开启或关闭从右到左模式。只有在使用nsResize::Set函数时才需要此功能。

nsResize::Set control_HWND x y width height

设置控件的新X和Y坐标以及新的宽度和高度。您可以使用与nsDialogs相同的单位值。 x或y的空字符串将确保控件不被移动。宽度或高度的空字符串将确保控件不被调整大小。

nsResize::Add control_HWND x y width height

添加给定的X，Y，宽度和高度值。您可以使用与nsDialogs相同的单位值。请注意，必须对从右到左的语言进行特殊处理。

nsResize::Top control_HWND

将控件移动到Z顺序的顶部。

nsResize::GetPos control_HWND
Pop $X
Pop $Y

获取控件相对于其父窗口的对话框单位中的位置。

nsResize::GetPosPx control_HWND
Pop $X
Pop $Y

获取控件相对于其父窗口的像素位置。

nsResize::GetSize control_HWND
Pop $Width
Pop $Height

获取控件在对话框单位中的大小。

nsResize::GetSizePx control_HWND
Pop $Width
Pop $Height

获取控件在像素中的大小。

更新日志
1.0.0.0 - 2013年4月13日

第一个版本。
许可证
该插件按“原样”提供，不提供任何明示或暗示的保证。作者不对使用该插件所产生的任何损害负责。

任何人都可以将此插件用于任何目的，包括商业应用程序，并且可以自由更改和重新分发，但受以下限制：

插件的来源不能被歪曲；您不能声称自己编写了原始插件。如果您在产品中使用此插件，则应在产品文档中提供确认，但不是必需的。
修改后的版本必须明确标记，并且不能被误传为原始插件。
任何分发中都不得删除或更改。