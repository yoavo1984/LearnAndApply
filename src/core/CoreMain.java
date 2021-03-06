package core;

import java.util.ArrayList;
import java.util.List;

public class CoreMain {
	private static int NUMBER_OF_ITEMS = 6;
	private static boolean ADD_USER = true;
	

	public static void main(String[] args) throws InterruptedException {
		
		List<Item> items = new ArrayList<Item>(); 
		
		for (int i = 0 ; i < NUMBER_OF_ITEMS ; i++) {
			items.add(new Item());
		}
		CoreUser user = new CoreUser("John");
		
		Controller controller = new Controller(items);
		if (ADD_USER) {
			controller.addUser(user);
		}
		new Thread(controller).start();
		Thread.sleep(400);
	}

}
