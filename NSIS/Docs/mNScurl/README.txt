# NScurl ([NSIS](https://github.com/negrutiu/nsis) plugin)
NScurl是一个带有高级HTTP/HTTPS功能的NSIS（Nullsoft Scriptable Install System）插件。它基于[libcurl](https://curl.haxx.se/libcurl/)和[OpenSSL](https://www.openssl.org/)实现了SSL后端。
此插件包含在我的非官方[NSIS构建](https://github.com/negrutiu/nsis)中。



### 功能：
- **现代**：支持现代SSL协议和密码，包括HTTPS/2，TLS1.3等。
- **兼容**：适用于Windows NT4，Windows 11和所有中间版本
- **多线程**：并行下载/上传多个文件
- **异步**：启动多个后台传输，稍后检查它们
- **坚持不懈**：多次尝试连接并恢复失败/丢失的传输
- **NSIS感知**：在任何安装阶段（从`.onInit`，从`Sections`，从自定义页面，静默安装程序等）下载文件
- **详细**：提供大量有用的信息供查询（传输大小，速度，HTTP状态，HTTP头等）
- 支持HTTP和TLS身份验证
- 支持所有相关的HTTP方法（GET，POST，HEAD等）
- 支持DNS-over-HTTPS名称解析
- 支持自定义HTTP标头和数据
- 支持代理服务器（经过身份验证和开放）
- 支持大于4GB的文件
- 可以直接将远程内容下载到内存（NSIS字符串）中而不是文件
- 在**64位**[NSIS构建](https://github.com/negrutiu/nsis)中工作良好
- 更多...请查看包含的[文档]（NScurl.Readme.htm）

基本用法：
快速传输：
NScurl::http GET "https://download.sysinternals.com/files/SysinternalsSuite.zip" "$TEMP\SysinternalsSuite.zip" /INSIST /CANCEL /RESUME /END
Pop $0 ; 状态文本（成功为“OK”）
快速传输（自定义GET参数+自定义请求头）：
NScurl::http GET "https://httpbin.org/get?param1=value1&param2=value2" "$TEMP\httpbin_get.json" /HEADER "Header1: Value1" /HEADER "Header2: Value2" /END
Pop $0
发送 .json 文件：
NScurl::http POST "https://httpbin.org/post" MEMORY /HEADER "Content-Type: application/json" /DATA '{ "number_of_the_beast" : 666 }' /END
Pop $0
发送 .json 文件（作为 MIME 多部分表单）：
NScurl::http POST "https://httpbin.org/post" Memory /POST "User" "My user name" /POST "Password" "My password" /POST FILENAME=maiden.json TYPE=application/json "Details" '{ "number_of_the_beast" : 666 }' /END
Pop $0
更复杂的例子见文档
