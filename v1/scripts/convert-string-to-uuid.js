const convertStringToUuid = require("uuid-by-string");

const stringToConvert = process.argv[2];

console.log(convertStringToUuid(stringToConvert));
