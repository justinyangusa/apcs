/**
 * @author Ken Noh
 * @author Justin Yang
 * Paley B Period APCS
 * Hivolts Extra Credit
 */

import java.awt.Color;
import java.awt.Graphics;

public class Character extends BasicUnit {

	public Character(int x, int y, Color c) {
		xCoordinate = x;
		yCoordinate = y;
		color = c;
	}

	public void move(int x, int y) {
		setX(x);
		setY(y);
	}

	public void paint(Graphics g) {
		g.setColor(color);
		g.fillRect(xCoordinate * GVar.GRID_SIZE
				+ (GVar.GRID_SIZE - GVar.UNIT_SIZE) / 2, yCoordinate
				* GVar.GRID_SIZE + (GVar.GRID_SIZE - GVar.UNIT_SIZE) / 2,
				GVar.UNIT_SIZE, GVar.UNIT_SIZE);
	}
}
