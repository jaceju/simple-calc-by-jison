// $ node example.js
const parser = require("./calc").parser;

const expr = `36 / (8 - 2)`;

console.log(parser.parse(expr));
