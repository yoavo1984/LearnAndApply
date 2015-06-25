package ui;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Scanner;

public class ConsoleInput extends Thread {

	private static BufferedReader in = new BufferedReader(new InputStreamReader(System.in));
	   
	private Callback<Integer> callback;

	public ConsoleInput(Callback<Integer> callback) {
		this.callback = callback;
		
	}

	@Override
	public void run() {
		boolean validInput = false;
		while ((!validInput) && (!this.isInterrupted()) ) {
			try {
				if (!in.ready()) {
					sleep(100);
				} else {
					int input = Integer.parseInt(in.readLine());
					validInput = callback.run(input);
					if (!validInput){
						System.out.println("Not a valid input. please choose an item from the list above");
					}
				}
			} catch (NumberFormatException e){
				System.out.println("input should be a number");
				continue;
			} catch (InterruptedException e) {
				System.out.println("input was given. closing reader, new reader will come up..");
		        return;
		    }	catch (IOException e) {
		        return;
			}
			
		}
	}


}
