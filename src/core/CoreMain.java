package core;

import java.util.ArrayList;
import java.util.List;

public class CoreMain {
	private static int NUMBER_OF_ITEMS = 6;
	

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Controller controller = new Controller();
		List<Item> items = new ArrayList<Item>(); 
		
		for (int i = 0 ; i < NUMBER_OF_ITEMS ; i++) {
			items.add(new Item());
		}
		
		controller.setDataSource(items);
		controller.render(controller.dataSource());
	}

}
