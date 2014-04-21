/**
 * @author Ken Noh
 * @author Justin Yang
 * Paley B Period APCS
 * Hivolts Extra Credit
 */

import java.applet.Applet;
import java.awt.Color;
import java.awt.Graphics;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;

public class MainBoard extends Applet implements KeyListener {
	private static final long serialVersionUID = 1;
	Board grid = new Board();
	public static boolean restart = false;
	public static String endMessage = "";

	public void init() {
		setSize(400, 400);
		addKeyListener(this);
	}

	public void paint(Graphics g) {
		if (endMessage != "") {
			String msg = endMessage;
			endMessage = "";
			repaint();
			if (msg == "Win") {
				grid.showDialog("Game over: you won!");
			} else {
				grid.showDialog("Game over: you lost.");
			}
			restart = true;
			repaint();
		}
		if (restart) {
			restart = false;
			grid = new Board();
		}

		g.setColor(Color.BLACK);
		for (int i = 0; i < GVar.SIDE_LENGTH; i++) {
			g.fillRect(0, i * GVar.GRID_SIZE - 1, GVar.SIDE_LENGTH_PX, 2);
			g.fillRect(i * GVar.GRID_SIZE - 1, 0, 2, GVar.SIDE_LENGTH_PX);
		}

		grid.paint(g);
	}

	public void keyTyped(KeyEvent e) {
		int key = e.getKeyCode();
//		System.out.println(e);
		if (grid.intInArray(key, grid.keyList)) {
			grid.keyAction(key);
			if (key != KeyEvent.VK_J) {
				grid.moveMhos();
			}
			repaint();
		}
	}

	public void keyReleased(KeyEvent e) {
	}

	public void keyPressed(KeyEvent e) {
		int key = e.getKeyCode();
//		System.out.println(e);
		if (grid.intInArray(key, grid.keyList)) {
			grid.keyAction(key);
			grid.moveMhos();
			repaint();
		}
	}
}
