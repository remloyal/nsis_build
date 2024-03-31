InetBgDL::Get [/RESET] <URL1> <local_file1> [<URLN> <local_fileN>] /END
如果状态 $0 > 299，则必须使用 /RESET，也可以用于中止所有活动下载。

InetBgDL::GetStats
$0 = HTTP 状态码，0 = 完成
$1 = 完成的文件数
$2 = 剩余文件数
$3 = 当前文件的已下载字节数
$4 = 当前文件的大小（如果大小未知，则为空字符串）

历史记录
=======
20130326 - AndersK
+添加了构建标志，用于硬编码较长的 INTERNET_OPTION_RECEIVE_TIMEOUT
+调试版本会打印 WinInet 信息。

20130324 - AndersK
*/RESET 应该更快地中止
+在 HTTPS URL 上使用 INTERNET_FLAG_SECURE

20110922 - AndersK
*初始公开发行