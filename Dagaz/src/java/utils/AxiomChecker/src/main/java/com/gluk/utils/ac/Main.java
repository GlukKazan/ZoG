package com.gluk.utils.ac;

public class Main {
	
	public static void main(String[] args) {
		FileLoader loader = FileLoader.getInstance();
		try {
			if (args.length > 0) {
				for (String name: args) {
					loader.load(name);
				}
			} else {
				loader.load("C:/in/games/my/Rithmomachy/Axiom/Rithmomachy/Rithmomachy.4th");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
