const fs = require("fs").promises;

(async () => {
  const positions = (
    await fs.readFile(process.argv[process.argv.length - 1], {
      encoding: "utf8",
    })
  )
    .split(",")
    .map((x) => parseInt(x));
  positions.sort((a, b) => a - b);

  const align = positions[positions.length / 2];
  const cost = positions
    .map((x) => Math.abs(x - align))
    .reduce((a, b) => a + b);
  console.log(cost);
})();
