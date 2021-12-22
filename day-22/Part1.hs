import System.Environment
import qualified Data.Text as Text
import qualified Data.List as List
import qualified Data.Map as Map

processCubeOverlap (x0, x1, y0, y1, z0, z1) (i0, i1, j0, j1, k0, k1) sign cubes
  = let
      (max_x0, min_x1) = (max x0 i0, min x1 i1)
      (max_y0, min_y1) = (max y0 j0, min y1 j1)
      (max_z0, min_z1) = (max z0 k0, min z1 k1)
    in if max_x0 <= min_x1 && max_y0 <= min_y1 && max_z0 <= min_z1
      then Map.insertWith
        (+)
        (max_x0, min_x1, max_y0, min_y1, max_z0, min_z1)
        (-sign)
        cubes
      else cubes

processLines (line : lines) cubes =
  let
    sign = if List.isPrefixOf "on" line then 1 else 0
    limits@(x0 : x1 : y0 : y1 : z0 : z1 : _) =
      map ((read :: String -> Int) . Text.unpack)
        $ concatMap
            (Text.splitOn (Text.pack "..") . head . tail . Text.splitOn
              (Text.pack "=")
            )
        $ Text.splitOn (Text.pack ",") (Text.pack line)
    keepLine = all (\x -> x >= (-50) && x <= 50) limits
    cube     = (x0, x1 + 1, y0, y1 + 1, z0, z1 + 1)
    cubes'   = if keepLine
      then Map.foldrWithKey (processCubeOverlap cube) cubes cubes
      else cubes
    cubes'' = if keepLine && sign == 1
      then Map.insertWith (+) cube 1 cubes'
      else cubes'
  in processLines lines cubes''
processLines [] cubes = cubes

main = do
  [arg0] <- getArgs
  input  <- readFile arg0
  print
    $ Map.foldrWithKey
        (\(x0, x1, y0, y1, z0, z1) sign acc ->
          acc + (x1 - x0) * (y1 - y0) * (z1 - z0) * sign
        )
        0
    $ processLines (lines input) Map.empty
