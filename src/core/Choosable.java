package core;

import java.util.Collection;

public interface Choosable <T extends Uniqueness>{

	public void choose (T item);
	
	public Collection<? extends T> dataSource();
}
