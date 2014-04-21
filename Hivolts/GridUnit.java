/**
 * @author Ken Noh
 * @author Justin Yang
 * Paley B Period APCS
 * Hivolts Extra Credit
 */

import java.awt.Graphics;

public class GridUnit {
	private int xcoord, ycoord, value;

	public GridUnit(int x, int y) {
		xcoord = x;
		ycoord = y;
		value = 0;
	}

	public void setValue(int v) {
		value = v;
	}

	public int getValue() {
		return value;
	}

	public int getX() {
		return xcoord;
	}

	public int getY() {
		return ycoord;
	}

	public void paint(Graphics g) {
		if (value == 0) {
		} else if (value == 1) {
			Player ken = new Player(xcoord, ycoord);
			ken.paint(g);
		} else if (value == 2) {
			Enemy justin = new Enemy(xcoord, ycoord);
			justin.paint(g);
		} else if (value == 3) {
			Wall big = new Wall(xcoord, ycoord);
			big.paint(g);
		}
	}
}
