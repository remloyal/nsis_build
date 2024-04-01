const fs = require("fs");
const path = require("path");
const yaml = require("./js-yaml");
// @ts-ignore
const { exec } = require("child_process");

const config = {
  version: "1.3.0-9",
  files: {
    url: "",
    sha512: "",
    size: "",
  },
  path: "Frigga_Data_Center_1.3.0-9_.exe",
  sha512: "",
  releaseDate: "",
};

const filePath = `./OutFile/${config.path}`;
const outPath = `./OutFile/${config.path}.blockmap`;
const ymlPath = `./OutFile/${config.path}.latest.yml`;
const buildBlockmapCmd = `${path.join(
  process.cwd(),
  "app-builder.exe"
)}  blockmap -i ${path.join(process.cwd(), filePath)} -o  ${path.join(
  process.cwd(),
  outPath
)} `;

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
