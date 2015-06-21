package core;

import java.util.ArrayList;
import java.util.List;

public class CoreMain {
	private static int NUMBER_OF_ITEMS = 6;
	

	public static void main(String[] args) throws InterruptedException {
		// TODO Auto-generated method stub
		
		List<Item> items = new ArrayList<Item>(); 
		
		for (int i = 0 ; i < NUMBER_OF_ITEMS ; i++) {
			items.add(new Item());
		}
		CoreUser user = new CoreUser("John");
		
		Controller controller = new Controller(items);
		controller.addUser(user);
		new Thread(controller).start();
//		controller.run();
		Thread.sleep(400);
	}

}
