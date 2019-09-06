// $ node example.js
const parser = require("./calc2").parser;

const expr = `36 / (8 - 2)`;

console.log(parser.parse(expr));
