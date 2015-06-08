package core;

public interface Choosable <T extends Uniqueness>{

	public void choose (T item);
	
	public Comparable<T> dataSource();
}
