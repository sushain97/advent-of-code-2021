import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.Arrays;

public class Part2 {
    public static void main(String[] args) throws IOException {
        char[][] numbers = Files
                .lines(Paths.get(args[0]))
                .map(l -> l.toCharArray())
                .toArray(char[][]::new);

        int cursor = 0;
        char[][] oxygenNumbers = Arrays.copyOf(numbers, numbers.length);
        while (oxygenNumbers.length > 1) {
            final int cursor_ = cursor;
            long zeroCount = Arrays.stream(oxygenNumbers).filter(n -> n[cursor_] == '0').count();
            char keep = (zeroCount > oxygenNumbers.length / 2) ? '0' : '1';
            oxygenNumbers = Arrays.stream(oxygenNumbers).filter(n -> n[cursor_] == keep).toArray(char[][]::new);
            cursor++;
        }
        String oxygen = new String(oxygenNumbers[0]);

        cursor = 0;
        char[][] co2Numbers = Arrays.copyOf(numbers, numbers.length);
        while (co2Numbers.length > 1) {
            final int cursor_ = cursor;
            long zeroCount = Arrays.stream(co2Numbers).filter(n -> n[cursor_] == '0').count();
            char keep = zeroCount > co2Numbers.length / 2 ? '1' : '0';
            co2Numbers = Arrays.stream(co2Numbers).filter(n -> n[cursor_] == keep).toArray(char[][]::new);
            cursor++;
        }
        String co2 = new String(co2Numbers[0]);

        System.out.println(Integer.parseInt(oxygen, 2) * Integer.parseInt(co2, 2));
    }
}
