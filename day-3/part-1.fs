module Part1

[<EntryPoint>]
let main argv =
  let numbers = System.IO.File.ReadLines(argv.[0]) |> Array.ofSeq

  let gamma = (
    (seq {0..(numbers.[0].Length - 1)})
      |> Seq.map (fun i ->
        let count = numbers |> Array.filter (fun n -> n.[i] = '0') |> Array.length
        if count > numbers.Length / 2 then '0' else '1'
      )
      |> Array.ofSeq
      |> System.String
  )

  let epsilon = (
    gamma
      |> Seq.map (fun n -> if n = '0' then '1' else '0')
      |> Array.ofSeq
      |> System.String
  )

  ((System.Convert.ToInt32 (gamma, 2)) * (System.Convert.ToInt32 (epsilon, 2)))
    |> printfn "%A"

  0
