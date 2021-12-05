import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;
import java.util.function.Predicate;
import java.util.stream.Collectors;
import java.util.stream.IntStream;
import java.util.stream.Stream;

public class Part1 {
  public static void main(String[] args) throws IOException {
    Iterator<String> lines = Files.lines(Paths.get(args[0])).iterator();
    IntStream draws = Arrays
        .stream(lines.next().split(","))
        .mapToInt(Integer::parseInt);

    ArrayList<List<Set<Integer>>> boards = new ArrayList<>();
    while (lines.hasNext()) {
      lines.next();

      int[][] board = IntStream
          .range(0, 5)
          .mapToObj(_i -> Arrays.stream(lines.next().split("\\s+"))
              .filter(Predicate.not(String::isEmpty))
              .mapToInt(Integer::parseInt).toArray())
          .toArray(int[][]::new);

      boards.add(
          Stream.concat(
              Arrays
                  .stream(board)
                  .map(r -> IntStream.of(r).boxed().collect(Collectors.toSet())),
              IntStream.range(0, 5)
                  .mapToObj(c -> Arrays.stream(board).mapToInt(r -> r[c]).boxed().collect(Collectors.toSet())))
              .collect(Collectors.toList()));
    }

    Set<Integer> drawn = new HashSet<Integer>();
    draws.forEach(draw -> {
      drawn.add(draw);

      boards
          .stream()
          .filter(b -> b.stream().anyMatch(r -> drawn.containsAll(r)))
          .findAny()
          .ifPresent(winner -> {
            long sum = winner
                .stream()
                .limit(5)
                .flatMap(Set::stream)
                .filter(n -> !drawn.contains(n))
                .mapToInt(Integer::intValue)
                .sum();
            System.out.println(sum * draw);
            System.exit(0);
          });
    });
  }
}
