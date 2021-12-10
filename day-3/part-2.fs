module Part1

[<EntryPoint>]
let main argv =
  let numbers = System.IO.File.ReadLines(argv.[0]) |> Array.ofSeq

  let mutable cursor = 0
  let mutable oxygenNumbers = Array.copy numbers
  while oxygenNumbers.Length > 1 do
    let count = oxygenNumbers |> Array.filter (fun n -> n.[cursor] = '0') |> Array.length
    let keep = if count > oxygenNumbers.Length / 2 then '0' else '1'
    oxygenNumbers <- oxygenNumbers |> Array.filter (fun n -> n.[cursor] = keep)
    cursor <- cursor + 1
  let oxygen = oxygenNumbers.[0]

  cursor <- 0
  let mutable co2Numbers = Array.copy numbers
  while co2Numbers.Length > 1 do
    let count = co2Numbers |> Array.filter (fun n -> n.[cursor] = '0') |> Array.length
    let keep = if count > co2Numbers.Length / 2 then '1' else '0'
    co2Numbers <- co2Numbers |> Array.filter (fun n -> n.[cursor] = keep)
    cursor <- cursor + 1
  let co2 = co2Numbers.[0]

  ((System.Convert.ToInt32 (oxygen, 2)) * (System.Convert.ToInt32 (co2, 2)))
    |> printfn "%A"

  0
