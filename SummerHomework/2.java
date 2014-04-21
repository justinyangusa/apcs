/*
 * Justin Yang
 * APCS Summer Homework Q2
 */

import java.util.ArrayList;
public class two {
	
	public static double sumList(ArrayList<Double> list) {
		double sum = 0;
		for (double num : list) {
			sum += num;
		}
		return sum;
	}

	public static void main(String[] args) {
		ArrayList<Double> theList = new ArrayList<Double>();
		theList.add(1.5);
		theList.add(2.0);
		theList.add(3.2);
		theList.add(4.8);
		System.out.println(sumList(theList));   // prints 11.5 (1.5 + 2.0 + 3.2 + 4.8)
	}

}
