using System;
using System.Collections.Generic;

#nullable enable

using Vars = System.ValueTuple<int, int, int, int>;
using Instruction = System.ValueTuple<
    string,
    System.Func<
        System.ValueTuple<int, int, int, int>,
        int?,
        System.ValueTuple<int, int, int, int>
    >
>;

Vars setVar(Vars vars, int idx, int val)
{
    if (idx == 0)
        vars.Item1 = val;
    else if (idx == 1)
        vars.Item2 = val;
    else if (idx == 2)
        vars.Item3 = val;
    else if (idx == 3)
        vars.Item4 = val;
    else
        throw new Exception($"Invalid index ${idx}");

    return vars;
}

int getVar(Vars vars, int idx)
{
    switch (idx)
    {
        case 0:
            return vars.Item1;
        case 1:
            return vars.Item2;
        case 2:
            return vars.Item3;
        case 3:
            return vars.Item4;
        default:
            throw new Exception($"Invalid index ${idx}");
    }
}

string? FindModelNumber(Instruction[] instructions, int i, Vars vars, Dictionary<(Vars, int), string?> memo)
{
    string? result;
    if (memo.TryGetValue((vars, i), out result))
    {
        return result;
    }

    for (int input = 1; input <= 9; input++)
    {
        var varsCopy = instructions[i].Item2(vars, input);

        int j;
        for (j = i + 1; j < instructions.Length; j++)
        {
            if (instructions[j].Item1 == "inp")
            {
                var restInput = FindModelNumber(instructions, j, varsCopy, memo);
                if (restInput != null)
                {
                    return memo[(varsCopy, j)] = input + restInput;
                }
                else
                {
                    goto NextInput;
                }
            }
            else
            {
                varsCopy = instructions[j].Item2(varsCopy, null);
            }
        }

        if (varsCopy.Item4 == 0)
        {
            return memo[(varsCopy, j)] = input.ToString();
        }

        NextInput:
        {
        }
    }

    memo[(vars, i)] = null;
    return null;
}

var instructions = new List<Instruction>();
foreach (var instructionString in System.IO.File.ReadLines(args[0]))
{
    string[] instructionParts = instructionString.Split(' ');
    var op = instructionParts[0];
    var lhs = instructionParts[1][0] - 'w';

    if (op == "inp")
    {
        instructions.Add((op, (vars, rhs) => setVar(vars, lhs, (int)rhs!)));
    }
    else
    {
        Func<Vars, int> getRhs = (vars) => (
            instructionParts[2][0] >= 'w'
                ? getVar(vars, instructionParts[2][0] - 'w')
                : int.Parse(instructionParts[2])
        );

        switch (op)
        {
            case "add":
                instructions.Add((op, (vars, _) => setVar(vars, lhs, getVar(vars, lhs) + getRhs(vars))));
                break;
            case "mul":
                instructions.Add((op, (vars, _) => setVar(vars, lhs, getVar(vars, lhs) * getRhs(vars))));
                break;
            case "div":
                instructions.Add((op, (vars, _) => setVar(vars, lhs, getVar(vars, lhs) / getRhs(vars))));
                break;
            case "mod":
                instructions.Add((op, (vars, _) => setVar(vars, lhs, getVar(vars, lhs) % getRhs(vars))));
                break;
            case "eql":
                instructions.Add((op, (vars, _) => setVar(vars, lhs, getVar(vars, lhs) == getRhs(vars) ? 1 : 0)));
                break;
            default: throw new Exception($"Unknown instruction {instructionParts[0]}");
        }
    }
}

Dictionary<(Vars, int), string?> memo = new Dictionary<(Vars, int), string?>();

Console.WriteLine(FindModelNumber(
    instructions.ToArray(),
    0,
    (0, 0, 0, 0),
    memo
));
