package ui;

import java.util.Scanner;

public class ConsoleInput extends Thread{

	Scanner reader = new Scanner(System.in);
	Integer input;
	public ConsoleInput() {
		
	}
	
	public Integer getInput(){
		return input;
	}
	
	@Override
	public void run() {
		// TODO Auto-generated method stub
	
		this.input =  reader.nextInt();

		super.run();
	}

}
