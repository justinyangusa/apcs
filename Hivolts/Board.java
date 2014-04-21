/**
 * @author Ken Noh
 * @author Justin Yang
 * Paley B Period APCS
 * Hivolts Extra Credit
 */

import java.awt.Graphics;
import java.awt.event.KeyEvent;
import java.util.Random;

import javax.swing.JOptionPane;

public class Board {
	GridUnit[][] GridUnits = new GridUnit[GVar.SIDE_LENGTH][GVar.SIDE_LENGTH];

	int[][] border = new int[GVar.BORDER_COUNT][2];
	int[][] inner = new int[GVar.INNER_SIZE][2];
	int[][] all = new int[GVar.ALL_SIZE][2];

	int[][] mhoList = new int[GVar.MHO_COUNT][2];

	int[] you = new int[2];
	int[] keyList = new int[] { KeyEvent.VK_S, KeyEvent.VK_J, KeyEvent.VK_W,
			KeyEvent.VK_X, KeyEvent.VK_D, KeyEvent.VK_A, KeyEvent.VK_E,
			KeyEvent.VK_Q, KeyEvent.VK_C, KeyEvent.VK_Z, KeyEvent.VK_LEFT,
			KeyEvent.VK_UP, KeyEvent.VK_RIGHT, KeyEvent.VK_DOWN }; // ascii
																	// conversion

	Random random = new Random();

	public Board() {
		int bcount = 0;
		int icount = 0;
		int acount = 0;
		for (int y = 0; y < GVar.SIDE_LENGTH; y++) {
			for (int x = 0; x < GVar.SIDE_LENGTH; x++) {
				all[acount] = new int[] { x, y };
				acount++;
				if (x == GVar.SIDE_LENGTH - 1 || x == 0
						|| y == GVar.SIDE_LENGTH - 1 || y == 0) {
					border[bcount] = new int[] { x, y };
					bcount++;
				} else {
					inner[icount] = new int[] { x, y };
					icount++;
				}
			}
		}

		for (int i = 0; i < all.length; i++) {
			GridUnits[all[i][0]][all[i][1]] = new GridUnit(all[i][0], all[i][1]);
		}

		for (int i = 0; i < border.length; i++) {
			GridUnits[border[i][0]][border[i][1]].setValue(GVar.FENCE_VALUE);
		}

		generateBlocks(GVar.FENCE_VALUE, GVar.FENCE_COUNT);
		generateBlocks(GVar.MHO_VALUE, GVar.MHO_COUNT);
		generateBlocks(GVar.YOU_VALUE, GVar.YOU_COUNT);
	}

	public void paint(Graphics g) {
		for (int i = 0; i < all.length; i++) {
			GridUnits[all[i][0]][all[i][1]].paint(g);
		}
	}

	public void generateBlocks(int blockValue, int count) {
		for (int i = 0; i < count; i++) {
			while (true) {
				int x = random.nextInt(GVar.INNER_LENGTH) + 1;
				int y = random.nextInt(GVar.INNER_LENGTH) + 1;
				if (blockValue == GVar.MHO_VALUE) {
					mhoList[i] = new int[] { x, y };
				}
				if (blockValue == GVar.YOU_VALUE) {
					you = new int[] { x, y };
				}
				if (GridUnits[x][y].getValue() == GVar.BLANK_VALUE) {
					GridUnits[x][y].setValue(blockValue);
					break;
				}
			}
		}
	}

	public boolean intInArray(int n, int[] arr) {
		for (int i = 0; i < arr.length; i++) {
			if (arr[i] == n)
				return true;
		}
		return false;
	}

	public int abs(int n) {
		if (n > 0)
			return n;
		else
			return -n;
	}

	public int getSign(int n) {// test for n == 0
		if (n != 0) {
			return n / abs(n);
		} else {
			return 0;
		}
	}

	public void forcedMoveMho(int x, int y, int n) {
		if (GridUnits[x][y].getValue() == GVar.BLANK_VALUE) {
			GridUnits[x][y].setValue(GVar.MHO_VALUE);
			mhoList[n][0] = x;
			mhoList[n][1] = y;
		} else if (GridUnits[x][y].getValue() == GVar.YOU_VALUE) {
			GridUnits[x][y].setValue(GVar.MHO_VALUE);
			mhoList[n][0] = x;
			mhoList[n][1] = y;
			endGame("Loss");
		} else {
			mhoList[n][0] = -1;
		}
	}

	public boolean unforcedMoveMho(int x, int y, int n,
			boolean isFenceGridUnitValid) {
		if (GridUnits[x][y].getValue() == GVar.BLANK_VALUE) {
			GridUnits[x][y].setValue(GVar.MHO_VALUE);
			mhoList[n][0] = x;
			mhoList[n][1] = y;
			return true;
		} else if (GridUnits[x][y].getValue() == GVar.YOU_VALUE) {
			GridUnits[x][y].setValue(GVar.MHO_VALUE);
			mhoList[n][0] = x;
			mhoList[n][1] = y;
			endGame("Loss");
			return true;
		} else if (isFenceGridUnitValid
				&& GridUnits[x][y].getValue() == GVar.FENCE_VALUE) {
			mhoList[n][0] = -1;
			return true;
		} else {
			return false;
		}

	}

	public void moveMho(int x, int y, int n) {
		boolean toContinue = true;
		GridUnits[x][y].setValue(GVar.BLANK_VALUE);
		if (x == you[0]) {
			if (getSign(y - you[1]) == 1) {
				forcedMoveMho(x, y - 1, n);
			} else {
				forcedMoveMho(x, y + 1, n);
			}
		} else if (y == you[1]) {
			if (getSign(x - you[0]) == 1) {
				forcedMoveMho(x - 1, y, n);
			} else {
				forcedMoveMho(x + 1, y, n);
			}
		} else {
			if (unforcedMoveMho(x - getSign(x - you[0]), y
					- getSign(y - you[1]), n, false)) {
				toContinue = false;
			} else if (abs(x - you[0]) > abs(y - you[1])) {
				if (unforcedMoveMho(x - getSign(x - you[0]), y, n, false)) {
					toContinue = false;
				} else if (unforcedMoveMho(x, y - getSign(y - you[1]), n, false)) {
					toContinue = false;
				}
			} else {
				if (unforcedMoveMho(x, y - getSign(y - you[1]), n, false)) {
					toContinue = false;
				} else if (unforcedMoveMho(x - getSign(x - you[0]), y, n, false)) {
					toContinue = false;
				}
			}

			if (toContinue) {
				if (unforcedMoveMho(x - getSign(x - you[0]), y
						- getSign(y - you[1]), n, true))
					;
				else if (abs(x - you[0]) > abs(y - you[1])) {
					if (unforcedMoveMho(x - getSign(x - you[0]), y, n, true))
						;
					else if (unforcedMoveMho(x, y - getSign(y - you[1]), n,
							true))
						;
				} else {
					if (unforcedMoveMho(x, y - getSign(y - you[1]), n, true))
						;
					else if (unforcedMoveMho(x - getSign(x - you[0]), y, n,
							true))
						;
				}
			}
		}
	}

	public void moveMhos() {
		int totalMhoCount = mhoList.length;
		for (int i = 0; i < mhoList.length; i++) {
			int x = mhoList[i][0];
			int y = mhoList[i][1];
			if (x >= 0) {
				moveMho(x, y, i);
			}
			if (mhoList[i][0] < 0) {
				totalMhoCount--;
			}
		}

		if (totalMhoCount == 0) {
			endGame("Win");
		}
	}

	public void moveYou(int x2, int y2) {
		int x = you[0] + x2;
		int y = you[1] + y2;
		GridUnits[you[0]][you[1]].setValue(GVar.BLANK_VALUE);
		if (GridUnits[x][y].getValue() == GVar.BLANK_VALUE) {
			GridUnits[x][y].setValue(GVar.YOU_VALUE);
			you[0] = x;
			you[1] = y;
		} else {
			endGame("Loss");
		}
	}

	public void endGame(String msg) {
		MainBoard.endMessage = msg;
	}

	public void showDialog(String msg) {
		JOptionPane.showMessageDialog(null, msg);
	}

	public void keyAction(int n) {
		switch (n) {
		case KeyEvent.VK_S: {
			// stay
			break;
		}
		case KeyEvent.VK_J: {
			// jump
			int x;
			int y;
			while (true) {
				x = random.nextInt(GVar.SIDE_LENGTH);
				y = random.nextInt(GVar.SIDE_LENGTH);
				if (GridUnits[x][y].getValue() != GVar.FENCE_VALUE) {
					moveYou(x - you[0], y - you[1]);
					break;
				}
			}
			break;
		}
		case KeyEvent.VK_W: {
			// up
			moveYou(0, -1);
			break;
		}
		case KeyEvent.VK_X: {
			// down
			moveYou(0, 1);
			break;
		}
		case KeyEvent.VK_D: {
			// right
			moveYou(1, 0);
			break;
		}
		case KeyEvent.VK_A: {
			// left
			moveYou(-1, 0);
			break;
		}
		case KeyEvent.VK_E: {
			// up and right
			moveYou(1, -1);
			break;
		}
		case KeyEvent.VK_Q: {
			// up and left
			moveYou(-1, -1);
			break;
		}
		case KeyEvent.VK_C: {
			// down and right
			moveYou(1, 1);
			break;
		}
		case KeyEvent.VK_Z: {
			// down and left
			moveYou(-1, 1);
			break;
		}
		case KeyEvent.VK_LEFT: {
			// left
			moveYou(-1, 0);
			break;
		}
		case KeyEvent.VK_UP: {
			moveYou(0, -1);
			break;
		}
		case KeyEvent.VK_RIGHT: {
			moveYou(1, 0);
			break;
		}
		case KeyEvent.VK_DOWN: {
			moveYou(0, 1);
			break;
		}
		case KeyEvent.VK_KP_LEFT: {
			// left
			moveYou(-1, 0);
			break;
		}
		case KeyEvent.VK_KP_UP: {
			moveYou(0, -1);
			break;
		}
		case KeyEvent.VK_KP_RIGHT: {
			moveYou(1, 0);
			break;
		}
		case KeyEvent.VK_KP_DOWN: {
			moveYou(0, 1);
			break;
		}
		default: {
			break;
		}
		}
	}
}