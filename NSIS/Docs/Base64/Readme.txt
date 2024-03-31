==============================================================
Base64.dll v001 (3KB) 由意大利的Angelo Dureghello制作

最后构建日期：2007年1月9日

执行重新启动、关闭或注销工作站的任务

===============================================================
函数：

Base64::Encrypt
Base64数据加密。

参数：字符串、长度
结果：编码后的字符串位于堆栈上

Base64::Decrypt
Base64数据解密。

参数：字符串、长度
结果：解码后的字符串位于堆栈上

===============================================================
示例：

Base64::Encrypt STRINGTOCRYPTB64 16

pop $R7

MessageBox MB_OK|MB_ICONINFORMATION "您加密的内容：$R7"

StrLen $5 $R7
Base64::Decrypt $R7 $5

pop $R7

MessageBox MB_OK|MB_ICONINFORMATION "您解密的内容：$R7"