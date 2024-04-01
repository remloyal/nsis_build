## 1.打包配置
配置 friggaDataCenter.nsi 的版本参数
将需要打包的文件放在 FilesToInstall

修改 index.js 里面的 config 参数，需要与friggaDataCenter.nsi对应
运行 build.bat

## 2完成打包
OutFile 下将会输出 exe blockmap  和 latest.yml 三个文件

对应 用 electron-builder 用 NSIS 生成的，可用于自动更新