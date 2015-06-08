package core;

public interface renderable<T extends Uniqueness> {
	
	public Comparable<T> dataSource();
	
	public void render();
}
