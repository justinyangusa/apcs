/*
 * Justin Yang and Ken Noh
 * Paley APCS B period
 */

import javax.swing.JApplet;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.Polygon;
import java.awt.Rectangle;
import java.awt.Color;
import java.awt.RenderingHints;

@SuppressWarnings("serial")
public class Flag extends JApplet {
	private final int STRIPES = 13;
	private final double A = 1.0; // Hoist of flag
	private final double B = 1.9; // Fly of flag
	private final double C = 7.0 / STRIPES; // Hoist of Union
	private final double D = .76; // Fly of Union
	private final double E = .054; // y-coordinate of center of first star
	private final double F = .054; // Distance between star rows
	private final double G = .063; // x-coordinate of center of first star
	private final double H = .063; // Distance between star columns
	private final double K = .0616; // Diameter of star
	private final double L = 1.0 / STRIPES; // Height of stripe
	private final int STARS_ACROSS = 11;
	private final int STARS_DOWN = 9;
	private final Color OLD_GLORY_RED = new Color(178, 34, 52);
	private final Color OLD_GLORY_BLUE = new Color(60, 59, 110);
	private int width;
	private int height;

	public Flag() {
	}

	public void init() {
		setSize(760, 400);
	}

	/**
	 * Draws a black border
	 */
	public void drawBox(Graphics2D g) {
		g.setColor(Color.BLACK);
		g.draw(new Rectangle(width, height));
	}

	/**
	 * Draws a red rectangle then white stripes
	 */
	public void drawStripes(Graphics2D g) {
		g.setColor(OLD_GLORY_RED);
		g.fill(new Rectangle(width, height));

		g.setColor(Color.WHITE);
		for (int i = 1; i < STRIPES; i += 2) {
			g.fill(new Rectangle(0, (int) (i * L * height), width,
					(int) (L * height)));
		}
	}

	/**
	 * Draw the Union and stars
	 */
	public void drawUnion(Graphics2D g) {
		// Fills the Union blue
		g.setColor(OLD_GLORY_BLUE);
		g.fill(new Rectangle((int) (D * height), (int) (C * height)));

		// Fills the stars white
		g.setColor(Color.WHITE);

		// Negative the radius to the tips
		double outerRadius = -K * height / 2;
		// Negative the radius to the inside points
		double innerRadius = outerRadius * Math.sin(Math.PI / 10)
				/ Math.sin(3 * Math.PI / 10);

		// Makes a star with given diameter, centered at (0, 0)
		Polygon star = new Polygon();
		for (int i = 0; i < 10; i++) {
			if (i % 2 == 0) {
				star.addPoint((int) (outerRadius * Math.sin(i * Math.PI / 5)),
						(int) (outerRadius * Math.cos(i * Math.PI / 5)));
			} else {
				star.addPoint((int) (innerRadius * Math.sin(i * Math.PI / 5)),
						(int) (innerRadius * Math.cos(i * Math.PI / 5)));
			}
		}

		for (int j = 0; j < STARS_DOWN; j++) {
			for (int i = j % 2; i < STARS_ACROSS; i += 2) {
				// Translates and fills the star.
				g.translate(height * (G + i * H), height * (E + j * F));
				g.fill(star);
				g.translate(-height * (G + i * H), -height * (E + j * F));
			}
		}
	}

	/**
	 * Makes the stars look better.
	 */
	public void antiAlias(Graphics2D g) {
		g.setRenderingHint(RenderingHints.KEY_ANTIALIASING,
				RenderingHints.VALUE_ANTIALIAS_ON);
	}

	public void paint(Graphics graphics) {
		Graphics2D g = (Graphics2D) graphics;
		width = super.getWidth();
		height = super.getHeight();

		antiAlias(g);

		// Keeps the width and height in proportion
		if (width > (int) (height * B / A)) {
			width = (int) (height * B / A);
		} else {
			height = (int) (width * A / B);
		}

		drawBox(g);
		drawStripes(g);
		drawUnion(g);
	}
}
