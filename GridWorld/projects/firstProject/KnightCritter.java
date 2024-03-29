/*
 * Justin Yang & Ken Noh
 * Paley B Period APCS
 * GridWorld Homework for 12/9-12/13
 */

/* 
 * AP(r) Computer Science GridWorld Case Study:
 * Copyright(c) 2005-2006 Cay S. Horstmann (http://horstmann.com)
 *
 * This code is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation.
 *
 * This code is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * @author Chris Nevison
 * @author Barbara Cloud Wells
 * @author Cay Horstmann
 */

import info.gridworld.actor.Critter;
import info.gridworld.actor.Flower;
import info.gridworld.grid.Location;

import java.awt.Color;
import java.util.ArrayList;

/**
 * A KnightCritter moves like a Knight in chess. It moves two squares vertically
 * and one horizontally or two horizontally and one vertically. Objects adjacent
 * to it do not impede its path. In GridWorld, a KnightCritter will NOT move
 * onto a location that is occupied by another object.
 */
public class KnightCritter extends Critter {
	private boolean crusher;

	public KnightCritter() {
		setColor(Color.BLACK);
		crusher = false;
	}

	/**
	 * @param crush
	 *            if the KnightCritter will crush Flowers
	 */
	public KnightCritter(boolean crush) {
		setColor(Color.RED);
		crusher = crush;
	}

	/**
	 * @return list of empty locations where the KnightCritter can move
	 */
	public ArrayList<Location> getMoveLocations() {
		Location curr = getLocation();
		ArrayList<Location> possible = new ArrayList<Location>();
		ArrayList<Location> locs = new ArrayList<Location>();

		// Adds all eight locations for the KnightCritter
		possible.add(new Location(curr.getRow() - 2, curr.getCol() - 1));
		possible.add(new Location(curr.getRow() - 2, curr.getCol() + 1));
		possible.add(new Location(curr.getRow() - 1, curr.getCol() - 2));
		possible.add(new Location(curr.getRow() - 1, curr.getCol() + 2));
		possible.add(new Location(curr.getRow() + 1, curr.getCol() - 2));
		possible.add(new Location(curr.getRow() + 1, curr.getCol() + 2));
		possible.add(new Location(curr.getRow() + 2, curr.getCol() - 1));
		possible.add(new Location(curr.getRow() + 2, curr.getCol() + 1));

		for (int i = 0; i < possible.size(); i++)
			if (getGrid().isValid(possible.get(i)))
				if (getGrid().get(possible.get(i)) == null || crusher
						&& getGrid().get(possible.get(i)) instanceof Flower)
					locs.add(possible.get(i));
		return locs;
	}
}