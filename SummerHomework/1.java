/*
 * Justin Yang
 * APCS Summer Homework Q1
 */
public class one {
	
	public static int sumSquares(int start, int end) {
		int sum = 0;
		for (int i = start; i <= end; i++) {
			sum += i * i;
		}
		return sum;
	}

	public static void main(String[] args) {
		System.out.println(sumSquares(1,5));
		System.out.println(sumSquares(-2,2));
	}

}
