public class Main {
	static Deck deck = new Deck();
	static Hand[] hands = new Hand[2];
	

	public static void deal() {
		hands[0] = new Hand();
		hands[1] = new Hand();
		while (deck.size() > 1) {
			hands[0].put(deck.getCard());
			hands[1].put(deck.getCard());
		}
	}

	public static boolean playRound() {
		System.out.println(((Card) hands[0].peek()).getSymbol() + " versus "
				+ ((Card) hands[1].peek()).getSymbol());
		System.out.println("Player 0 has " + hands[0].size()
				+ ", Player 1 has " + hands[1].size());
		if (((Card) hands[0].peek()).compareTo(((Card) hands[1].peek())) < 0) {
			hands[1].put(hands[0].get());
			hands[1].put(hands[1].get());
			return true; // Player 1 win
		} else if (((Card) hands[0].peek()).compareTo(((Card) hands[1].peek())) > 0) {
			hands[0].put(hands[0].get());
			hands[0].put(hands[1].get());
			return false; // Player 0 win
		} else {
			System.out.println("WAR!");
			boolean winner = playRound();
			if (winner) {
				hands[1].put(hands[0].get());
				hands[1].put(hands[1].get());
			} else {
				hands[0].put(hands[0].get());
				hands[0].put(hands[1].get());
			}
			return winner;
		}
	}

	public static void playWar() {
		deal();
		while (!(hands[0].isEmpty() || hands[1].isEmpty())) {
			playRound();
		}
		System.out.print("The winner of the game is... Player ");
		if (hands[0].isEmpty()) {
			System.out.println(1);
		} else {
			System.out.println(0);
		}
	}

	public static void main(String args[]) {
		playWar();
	}
}
