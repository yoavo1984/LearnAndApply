package core;

public class Item implements Uniqueness{

	private static int lastId = 0;
	int id;
	
	public Item() {
		this.id = lastId++;
	}
	
	public int getId () {
		return this.id;
	}

}
