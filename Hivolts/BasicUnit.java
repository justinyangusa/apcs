/**
 * @author Ken Noh
 * @author Justin Yang
 * Paley B Period APCS
 * Hivolts Extra Credit
 */

import java.awt.Color;

public abstract class BasicUnit {
	protected static Color color;
	protected static int xCoordinate, yCoordinate;

	public void setX(int x) {
		xCoordinate = x;
	}

	public void setY(int y) {
		yCoordinate = y;
	}

	public int getX() {
		return xCoordinate;
	}

	public int getY() {
		return yCoordinate;
	}
}
