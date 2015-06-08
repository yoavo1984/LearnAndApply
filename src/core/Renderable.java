package core;

import java.util.Collection;

public interface Renderable<T extends Uniqueness> {
	
	public Collection<T> dataSource();
	
	public void render();
}
