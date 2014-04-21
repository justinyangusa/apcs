import java.util.Scanner;

/**
 * 
 * @author Justin Yang
 * @author Ken Noh Paley B Period APCS Homework for 12/9-12/13 Scheme Exercise
 *         1.16
 * 
 */

public class LoopInvariant {

	static int fastExpt(int b, int n) {
		int a = 1;

		while (n != 0) {
			if (n % 2 == 0) {
				b *= b;
				n /= 2;
			} else {
				a *= b;
				n -= 1;
			}
		}
		return a;
	}

	public static void main(String[] args) {
		Scanner in = new Scanner(System.in);
		System.out.print("Enter b: ");
		int b = in.nextInt();
		System.out.print("Enter n: ");
		int n = in.nextInt();
		System.out.println(fastExpt(b, n));
	}
}
