@echo off
Rem : add your path of ResHacker and UPX:
path %PATH%;%CD%;E:\NSIS\Bin
ResHacker -add exehead.dat, exehead.dat, ImageList.bmp, BITMAP, 101, 1033
upx --best -q exehead.dat
