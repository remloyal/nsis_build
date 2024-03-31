WimImage plugin for NSIS

Coded by Jason Ross aka JasonFriday13 on the forums.

Copyright (C) 2014 MouseHelmet Software

except for:
wimgapi.h
wimgapi.lib 32bit and 64 bit
Copyright (c) Microsoft Corporation.

Introduction
------------

This plugin is designed to remove the current 2GB limit in NSIS by creating
and extracting images contained in .wim files that are separate to the
installer. Thanks to the Wim API being unicode only, this plugin is unicode
only. This plugin requires Admin privileges to run correctly (blame the API
for that one too). Also requires Windows 7 or later. 32 bit and 64 bit
plugins are included.

Functions
---------

There are five functions in this plugin. All must be called in a section.
This plugin does not make directories on it's own, you must create them
yourself before calling these functions (I intentionally made it this way
to help minimize bugs in the code). The options are processed in this
order, the ones out of order will be skipped and left on the stack. Returns
an error code on the stack, see below for the codes.

Also, Extract overwrites any files with matching filenames, and by the looks of
the WIMApplyImage flags, it doesn't support "off", "try", "ifnewer", and "ifdiff".


WimImage::AddDir       Creates .wim files and overwrites existing .wim files.
WimImage::AppendDir    Adds another directory as a new image in the .wim file.

 /O C:\path\to\file.wim /S C:\path\to\dir [/T C:\path\to\temp\dir] [/C number] [/V]

 /O   The output file to write.
 /S   The source directory to make an image from.
 /T   Optional. The temporary directory for the plugins temporary files.
      The default uses GetTempPath from windows as it's temp dir.
      A great option is $PLUGINSDIR\temp.
 /C   Optional. Sets the compression level. Valid numbers are:
      0, no compression, 1, XPRESS (fast), 2, LZX (smallest size).
      The default is 0 (no compression).
 /V   Optional. This turns on file verification.

WimImage::Split        Splits the .wim file into optical disc sized chunks.

 /O C:\path\to\file.swm /S C:\path\to\file.wim /SS size [/R bytes] [/V]

 /O   The output file to write. The extension must be '.swm'.
      Files are automatically numbered when written.
 /S   The source .wim file to split.
 /SS  The split size to use. Valid values are:
      CD650   Splits to 650MB CD sized files.
      CD700   Splits to 700MB CD sized files.
      DVD4GB  Splits to 4GB DVD ISO9660 sized files.
      DVD5    Splits to 4.35GB DVD sized files.
      DVD9    Splits to 7.95GB DVD sized files.
 /R   Optional. Reserves space in bytes on the first disc for the installer and
      other files. The default is 1MB (1048576 bytes).
      The minimum is 1MB (1048576 bytes). Anything smaller will be set to 1MB.
      The maximum is 4GB - 100MB, for CDs it's: CD size - 100MB.
 /V   Optional. This turns on file verification if the source was created with it.

WimImage::Copy         Copies a .wim/.swm file to a temp folder.
                       Required for split media as all files must exist
                       at the same time for Extract to work properly.
                       Automatically prompts for the next disc.

 /O C:\path\to\file(.wim/.swm) /S C:\path\to\file(.wim/.swm) [/M text]

 /O   The output file(s) to write. The extension must be the same as the
      source file. Split files keep their numbering when copied.
 /S   The source file(s) to copy.
 /M   Optional. Displays a custom text for the 'next disc' prompt.
      When there is only one file per disc, you can use %d in the
      string to specify a disc number. The default is (English only):
      "Please insert disc %d to continue."

WimImage::Extract      Reads a wim file and extracts a single image.
                       If the source file is a split file, Extract
                       automatically uses the subsequent files. Extract
                       fails if any of the split files don't exist.

 /O C:\path\to\dir /S C:\path\to\file(.wim/.swm) [/T C:\path\to\tempdir] [/I number] [/RS] [/V]

 /O   The output directory to write to.
 /S   The source .wim/.swm file to extract an image from.
 /T   Optional. The temporary directory for the plugins temporary files.
      The default uses GetTempPath from windows as it's temp dir.
      A great option is $PLUGINSDIR\temp.
 /I   Optional. The image number to extract. Defaults to 1. Due to the way I've setup
      the error handling, it's impossible to return the image count on the stack.
 /RS  Optional. Turns on sequential reading for better speed, especially on cd's and dvd's.
 /V   Optional. This turns on file verification if the source was created with it.

Error codes:

 0   ERR_SUCCESS                          Function finished successfully.
 1   ERR_POPSTACK_FAIL                    Pop failed (is stack empty?)
 2   ERR_INVALID_SWITCH                   Invalid switch used.
 3   ERR_STR_TOOLONG                      String length exceeds MAX_PATH (260 chars).
 4   ERR_INVALID_SRCDIR                   Invalid source directory.
 5   ERR_INVALID_SRCFILE                  Invalid source file.
 6   ERR_INVALID_OUTDIR                   Invalid out directory.
 7   ERR_INVALID_OUTFILE                  Invalid out file.
 8   ERR_INVALID_TEMPDIR                  Invalid temp directory.
 9   ERR_INVALID_COMPRESSION              Invalid compression type.
 10  ERR_INVALID_SPLITSIZE                Invalid split size.
 11  ERR_INVALID_RESERVESIZE              Invalid reserve size.
 12  ERR_GETTEMPPATH_FAIL                 GetTempPath failed.
 13  ERR_WIMREGISTERMESSAGECALLBACK_FAIL  WIMRegisterMessageCallback failed.
 14  ERR_WIMCREATEFILE_FAIL               WIMCreateFile failed.
 15  ERR_WIMSETTEMPORARYPATH_FAIL         WIMSetTemporaryPath failed.
 16  ERR_WIMCAPTUREIMAGE_FAIL             WIMCaptureImage failed.
 17  ERR_WIMALREADY_SPLIT                 The source file is already split.
 18  ERR_WIMSPLITFILE_FAIL                WIMSplitFile failed.
 19  ERR_WIMSPLITFILE_MOREDATA            Not enough data to split.
 20  ERR_WIMGETATTRIBUTES_FAIL            WIMGetAttributes failed.
 21  ERR_WIMCOPYFILE_FAIL                 WIMCopyFile failed.
 22  ERR_WIMCOPYFILEPART_ABORT            WIMCopyFile file part aborted.
 23  ERR_WIMCOPYFILEPART_FAIL             WIMCopyFile file part failed.
 24  ERR_WIMSETREFERENCEFILE_FAIL         WIMSetReferenceFile failed.
 25  ERR_INVALID_IMAGEINDEX               Invalid image number for extraction.
 26  ERR_WIMLOADIMAGE_FAIL                WIMLoadImage failed.
 27  ERR_WIMAPPLYIMAGE_FAIL               WIMApplyImage failed.