package core;

public class Item implements Uniqueness{

	private static int lastId = 0;
	int id;
	
	public Item() {
		// TODO Auto-generated constructor stub
		this.id = lastId++;
	}
	
	public int getId () {
		return this.id;
	}

}
