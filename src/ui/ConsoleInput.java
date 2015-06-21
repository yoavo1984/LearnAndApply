package ui;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Scanner;

public class ConsoleInput extends Thread {

//	Scanner reader = new Scanner(System.in);;
	private static BufferedReader in = new BufferedReader(new InputStreamReader(System.in));
	   
	private Callback<Integer> callback;

	public ConsoleInput(Callback<Integer> callback) {
		this.callback = callback;
		
	}

	@Override
	public void run() {
		boolean validInput = false;
		while ((!validInput) && (!this.isInterrupted()) && (in != null)) {
//				try {
//					if  (System.in.available() == 0) {
//					    // [variant 1
//					        sleep(100);
//					        continue;
//					}   
//				} catch (IOException e) {
//					e.printStackTrace();
//				} catch (InterruptedException e) {
//			        System.out.println("input was given. closing reader, new reader will come up..");
//			        continue;
//			    }
				
//			if (!reader.hasNextInt()){
//				try {
//					sleep(100);
//				} catch (InterruptedException e) {
//					// TODO Auto-generated catch block
//					e.printStackTrace();
//				}
//				continue;
//			}
//		
			try {
				if (in == null){
					return;
				}
				if (!in.ready()) {
					sleep(100);
				} else {
					int input = Integer.parseInt(in.readLine());
					validInput = callback.run(input);		
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

	@Override
	public void interrupt() {
		try {
//			in.reset();
//			in.close();
//			in = null;
			// this.reader.close();
			// this.reader = null;
		} finally {
			super.interrupt();
		}
	}

}
