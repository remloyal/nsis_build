const fs = require("fs");
const path = require("path");
const yaml = require("./js-yaml");
// @ts-ignore
const { exec, execSync } = require("child_process");

const app = {
  // 安装后的应用名称
  appName: "Frigga Renew Tool",
  name: "Frigga_Renew_Tool",
  guid: "friggaDataCenter",
  zipName: "Tools_renew",
  fileName: "./FilesToInstall",
  // 文件版本
  version: "1.1.0",
  // 产品版本
  pkgVersion: "1.1.0",
  // 是否签名
  sign: false,
  // 是否复制卸载的exe ,签名过后的
  copyUninst: false,
};

const config = {
  version: app.version,
  files: {
    url: "",
    sha512: "",
    size: "",
  },
  path: `${app.name}_${app.version}.exe`,
  sha512: "",
  releaseDate: "",
};

const filePath = `./OutFile/${app.version}/${config.path}`;
const outPath = `./OutFile/${app.version}/${config.path}.blockmap`;
const ymlPath = `./OutFile/${app.version}/latest.yml`;
const run_build = async () => {
  await remove();
  // 复制、解压文件到 FilesToInstall
  await copyFilesToInstall();

  const buildNsisCmd = `"./build.bat" ${app.version}  ${app.pkgVersion}  ${app.sign} ${app.guid}`;
  console.log("buildNsisCmd: ", buildNsisCmd);

  await execSync(buildNsisCmd, { stdio: "inherit" });

  await buildEnd();
};

const remove = async () => {
  if (fs.existsSync(app.fileName)) {
    const cmd = `rd /s /Q "${app.fileName}"`;
    await execSync(cmd, { stdio: "inherit" });
  }
};

const copyFilesToInstall = async () => {
  //  设置要解压的压缩包路径
  const zipFile = `./package/${app.pkgVersion}/${app.zipName}_${app.version}.7z`;
  // 设置要解压到的目标文件夹路径
  const extractTo = "./FilesToInstall";

  // 使用 7-Zip 命令行工具解压压缩包到目标文件夹
  const cmd = `"./crutch/7z.exe" x "${zipFile}" -o"${extractTo}" `;
  await execSync(cmd, { stdio: "inherit" });
  // await fs.copyFileSync("./crutch/update.exe", `./${app.fileName}/update.exe`);

  if (app.copyUninst) {
    await fs.copyFileSync(
      "./crutch/uninst.exe",
      `./${app.fileName}/uninst.exe`
    );
  }
};

const buildEnd = () => {
  const buildBlockmapCmd = `${path.join(
    process.cwd(),
    "./crutch/app-builder.exe"
  )}  blockmap -i ${path.join(process.cwd(), filePath)} -o  ${path.join(
    process.cwd(),
    outPath
  )} `;
  console.log("cmd: ", buildBlockmapCmd);
  exec(buildBlockmapCmd, (error, stdout, stderr) => {
    if (error) {
      console.error(`执行命令时出错： ${error}`);
      return;
    }
    // @ts-ignore
    config.releaseDate = new Date();
    const data = JSON.parse(stdout);
    config.files = {
      url: config.path,
      sha512: data.sha512,
      size: data.size,
    };
    config.sha512 = data.sha512;

    console.log(config);
    try {
      // 将数据转换为YAML格式的字符串
      const yamlData = yaml.dump(config, { lineWidth: -1 });
      console.log(yamlData);
      // 将数据写入YAML文件
      fs.writeFileSync(ymlPath, yamlData, "utf8");
      console.log("YAML文件已创建并写入数据。");
    } catch (e) {
      console.log(e);
    }
  });
};

run_build();
