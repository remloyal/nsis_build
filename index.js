const fs = require("fs");
const crypto = require("crypto");

function calculateFileHash(filePath) {
  return new Promise((resolve, reject) => {
    const hash = crypto.createHash("sha512");
    const input = fs.createReadStream(filePath);

    input.on("error", reject);

    input.on("data", (chunk) => {
      hash.update(chunk);
    });

    input.on("end", () => {
      const hashValue = hash.digest("hex");
      resolve(hashValue);
    });
  });
}

// 示例用法
const filePath = "./OutFile/Frigga_Data_Center_1.3.0-9_.exe";
calculateFileHash(filePath)
  .then((hash) => {
    console.log("File SHA-512 hash:", hash);
    // 将十六进制哈希值转换为Buffer对象
    const hashBuffer = Buffer.from(hash, "hex");

    // 使用Base64编码将Buffer对象转换为字符串
    const base64Hash = hashBuffer.toString("base64");
    console.log("Base64编码的哈希值:", base64Hash);
    console.log("时间:", new Date());
  })
  .catch((error) => {
    console.error("Error calculating file hash:", error);
  });
