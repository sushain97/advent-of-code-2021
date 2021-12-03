import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.Arrays;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

public class Part1 {
    public static void main(String[] args) throws IOException {
        char[][] numbers = Files
                .lines(Paths.get(args[0]))
                .map(l -> l.toCharArray())
                .toArray(char[][]::new);
        int len = numbers[0].length;

        String gamma = IntStream
                .range(0, len)
                .mapToObj(digit -> Arrays.stream(numbers).filter(n -> n[digit] == '0').count() > numbers.length / 2
                        ? "0"
                        : "1")
                .collect(Collectors.joining(""));

        String epsilon = gamma
                .chars()
                .mapToObj(c -> c == '0' ? "1" : "0")
                .collect(Collectors.joining());

        System.out.println(Integer.parseInt(gamma, 2) * Integer.parseInt(epsilon, 2));
    }
}
