                            ZipDLL v1.2.2a
版权所有 2002-2004
Tim Kosse
tim.kosse@gmx.de

这是什么？
-----
ZipDLL 是 NSIS 的一个扩展 DLL。它可以从 zip 文件中解压文件。在与 NSISdl 结合使用时尤其有用，这样您就不必下载未压缩的大文件。

用法
-----

  要从 zip 文件中提取文件，请使用以下宏：

  !insertmacro ZIPDLL_EXTRACT SOURCE DESTINATION FILE

    参数：Zip 文件，目标目录，要提取的文件
    描述：将存档中的指定文件提取到目标目录。
    如果文件是 <ALL>，则将提取存档中的所有文件。

  示例：
    !insertmacro MUI_ZIPDLL_EXTRACTALL "c:\test.zip" "c:\output"

  
  导出的函数：
  - 参数：Zip 文件，目标目录
        描述：将存档中的所有文件提取到目标目录。.

  - 参数：Zip 文件，目标目录，要提取的文件
        描述：将存档中的指定文件提取到目标目录。

  示例:
    ZipDLL::extractall "c:\test.zip" "c:\output"

支持的语言
-------------------

ZipDLL.nsh contains the following additional languages:
- 阿拉伯语
- 巴西葡萄牙语
- 简体中文
- 繁体中文
- 克罗地亚语
- 丹麦语
- 法语
- 德语
- 匈牙利语
- 韩语
- 立陶宛语
- 波兰语
- 俄语
- 西班牙语

要添加您的语言，只需修改 ZipDLL.nsh，这应该非常简单。
请将修改后的 ZipDLL.nsh 发送至 tim.kosse@gmx.de，以便其他人也能受益。

法律事项
-----------

  此 NSIS 插件在 GPL 下获得许可，请阅读文件 ZipArchive\gpl.txt 获取详细信息。
  ZipDLL 使用来自 http://www.artpol-software.com/index_zip.html 的 ZipArchive 库。
   请阅读文件 ZipArchive\license.txt 获取详细信息

  用于专有软件的替代许可证:
  ------------------------------------------------------

  由于 ZipArchive 受 GPL 许可，因此它只能与具有 GPL 兼容许可证的程序一起使用，这也适用于此 DLL。
   但是，您可以获得 ZipArchive 的商业许可证（对于免费软件和大多数共享软件程序是免费的）。请阅读 ZipArchive\license.txt 获取详     
   细信息。在获得 ZipArchive 许可证时，允许将 ZipDLL 与专有软件一起使用。

---------------
文档翻译：水晶石
---------------

Version History
---------------

1.2.2a
------

- added Croatian and Hungarian language

1.2.2
-----

- Added a lot of languages
- Some improvements for ZipDll.nsh made by deguix

1.2.1
-----

- Made compatible with NSIS 2b3

1.2
---

- Added macros for automatic language selection
- Translation possible, works like /translate switch for NsisDL plugin

1.1
---

- made compatible with latest NSIS (parameters on stack swapped)
- cleaned up code

1.0
---

- initial release
   