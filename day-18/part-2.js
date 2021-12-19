#!/usr/bin/env node

const fs = require("fs").promises;

const _split = (number, leftSplit = false) => {
  const newNumber = [];

  number.forEach((element) => {
    if (Number.isInteger(element) && !leftSplit && element >= 10) {
      newNumber.push([Math.floor(element / 2), Math.ceil(element / 2)]);
      leftSplit = true;
    } else if (Array.isArray(element)) {
      [newElement, leftSplit] = _split(element, leftSplit);
      newNumber.push(newElement);
    } else {
      newNumber.push(element);
    }
  });

  return [newNumber, leftSplit];
};

const split = (number) => {
  const [new_number, leftSplit] = _split(number);
  return [leftSplit, new_number];
};

const explode = (number) => {
  let nesting = 0;
  let numberStr = JSON.stringify(number);

  for (let i = 0, c = ""; (c = numberStr.charAt(i)); i++) {
    if (c === "[") {
      nesting++;
    } else if (c === "]") {
      nesting--;
    }

    if (
      nesting == 5 &&
      (match = numberStr.substring(i).match(/^\[(?<left>\d+),(?<right>\d+)\]/))
    ) {
      const { left, right } = match.groups;
      const matchEnd = match.index + 3 + left.length + right.length;

      if (
        (rightMatch = numberStr.substring(i + matchEnd).match(/(?<num>\d+)/))
      ) {
        const { num } = rightMatch.groups;
        numberStr =
          numberStr.substring(0, i + matchEnd + rightMatch.index) +
          (Number.parseInt(num) + Number.parseInt(right)) +
          numberStr.substring(i + matchEnd + rightMatch.index + num.length);
      }

      numberStr = `${numberStr.substring(0, i)}0${numberStr.substring(
        i + matchEnd
      )}`;

      if (
        (leftMatch = numberStr
          .substring(0, i)
          .match(/(?<lead>.*\b)(?<num>\d+)/))
      ) {
        const { lead, num } = leftMatch.groups;
        numberStr =
          numberStr.substring(0, leftMatch.index + lead.length) +
          (Number.parseInt(num) + Number.parseInt(left)) +
          numberStr.substring(leftMatch.index + lead.length + num.length);
      }

      return [true, JSON.parse(numberStr)];
    }
  }

  return [false, number];
};

const reduce = (number) => {
  while (true) {
    [changed, number] = explode(number);
    if (changed) continue;

    [changed, number] = split(number);
    if (changed) continue;

    return number;
  }
};

const magnitude = (number) => {
  if (Number.isInteger(number)) {
    return number;
  } else {
    return 3 * magnitude(number[0]) + 2 * magnitude(number[1]);
  }
};

(async () => {
  const numbers = (
    await fs.readFile(
      process.argv[process.argv.length - 1],
      {
        encoding: "utf8",
      },
      "utf8"
    )
  )
    .split("\n")
    .map((l) => JSON.parse(l));

  console.log(
    Math.max(
      ...numbers.flatMap((a) => numbers.map((b) => magnitude(reduce([a, b]))))
    )
  );
})();
