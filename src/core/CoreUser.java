package core;

public class CoreUser implements Uniqueness {

	private static int lastId = 0;
	private int id;
	private String name;
	
	public CoreUser(String name) {
		this.id = lastId++;
		this.name = name;
	}
	
	public int getId() {
		return this.id;
	}
	
	public String getName() {
		return this.name;
	}

}
