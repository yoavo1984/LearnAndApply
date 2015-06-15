package ui;

import java.util.Collection;

import core.Uniqueness;

public interface Renderable<T extends Uniqueness> {
	
	public Collection<T> dataSource();
	
	public void render();
	
	public void choose(T item);
}
