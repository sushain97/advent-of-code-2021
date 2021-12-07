const fs = require("fs").promises;

(async () => {
  const positions = (
    await fs.readFile(process.argv[process.argv.length - 1], {
      encoding: "utf8",
    })
  )
    .split(",")
    .map((x) => parseInt(x));

  const moveCost = (n) => (n * (n + 1)) / 2;

  let bestCost = Infinity;
  for (let i = Math.min(...positions); i <= Math.max(...positions); i++) {
    const cost = positions.reduce(
      (acc, x) => acc + moveCost(Math.abs(x - i)),
      0
    );
    bestCost = Math.min(bestCost, cost);
  }

  console.log(bestCost);
})();
