*****************************************************************
***             TextReplace NSIS plugin v1.5                  ***
*****************************************************************

2006 Shengalts Aleksander aka Instructor (Shengalts@mail.ru)


特点：
- 在文本文件中进行快速搜索/替换
- 区分大小写/不区分大小写替换
- 支持字符串和指向缓冲区的指针
- 如果没有更改可能，输出文件将保持不变
- 检查输入文件是否是二进制文件


**** 在文件中搜索 ****

${textreplace::FindInFile} "[InputFile]" "[FindIt]" "[Options]" $var

"[InputFile]"   - 输入文件

"[FindIt]"      - 要查找的字符串或缓冲区的指针，如果使用了选项 /PI=1

"[Options]"     - 搜索选项

	/S=[0|1]
		/S=0   -  不区分大小写（默认）
		/S=1   - 区分大小写（更快）
	/PI=[0|1]
		/PI=0  - FindIt是一个字符串（默认）
		/PI=1  - FindIt是指向文本缓冲区的指针

$var   找到的字符串数量
       -3   ReplaceIt字符串为空
       -4   无法打开输入文件进行读取
       -5   无法获取输入文件的文件大小
       -6   无法为输入文件文本分配缓冲区
       -7   无法读取输入文件
       -8   输入文件是二进制或宽字符Unicode文件


**** 在文件中替换 ****

${textreplace::ReplaceInFile} "[InputFile]" "[OuputFile]" "[ReplaceIt]" "[ReplaceWith]" "[Options]" $var

"[InputFile]"   - Input file

"[OutputFile]"  - Output file, can be equal to InputFile

"[ReplaceIt]"   - String to replace or pointer to the buffer if used option /PI=1

"[ReplaceWith]" - Replace with this string or pointer to the buffer if used option /PO=1

"[Options]"     - Replace options

	/S=[0|1]
		/S=0   - Case insensitive (default)
		/S=1   - Case sensitive (faster)
	/C=[1|0]
		/C=1   - Copy the file if no changes made (default)
		/C=0   - Don't copy the file if no changes made
	/AI=[1|0]
		/AI=1  - Copy attributes from the InputFile to OutputFile (default)
		/AI=0  - Don't copy attributes
	/AO=[0|1]
		/AO=0  - Don't change OutputFile attributes (error "-9" possible) (default)
		/AO=1  - Change OutputFile attributes to normal before writting
	/PI=[0|1]
		/PI=0  - ReplaceIt is a string (default)
		/PI=1  - ReplaceIt is a pointer to the text buffer
	/PO=[0|1]
		/PO=0  - ReplaceWith is a string (default)
		/PO=1  - ReplaceWith is a pointer to the text buffer

$var   number of replacements
       -1   ReplaceIt pointer is incorrect
       -2   ReplaceWith pointer is incorrect
       -3   ReplaceIt string is empty
       -4   can't open input file for reading
       -5   can't get file size of the input file
       -6   can't allocate buffer for input file text
       -7   can't read input file
       -8   input file is binary or wide character Unicode file 
       -9   can't open output file for writting
       -10  can't allocate buffer for output file text
       -11  can't write to the output file


**** Put text file contents to the buffer ****

${textreplace::FillReadBuffer} "[File]" $var

"[File]"   - Input file

$var   pointer to the buffer
       -4   can't open input file for reading
       -5   can't get file size of the input file
       -6   can't allocate buffer for input file text
       -7   can't read input file
       -8   input file is binary or wide character Unicode file 


**** Free buffer ****

${textreplace::FreeReadBuffer} "[Pointer]"

"[Pointer]"  - Pointer to the buffer


**** Unload plugin ****

${textreplace::Unload}
