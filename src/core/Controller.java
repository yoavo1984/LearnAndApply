package core;

import java.util.Collection;

public class Controller implements Choosable<Item>, Renderable<Item>{
	Collection<Item> list;
	public Controller() {
		// TODO Auto-generated constructor stub
	}
	
	public void setDataSource (Collection<Item> list) {
		this.list = list;
	}
	
	@Override
	public void render() {
		// TODO Auto-generated method stub
		
	}
	@Override
	public void choose(Item item) {
		// TODO Auto-generated method stub
		
	}
	@Override
	public Collection<Item> dataSource() {
		// TODO Auto-generated method stub
		return null;
	}
	
	
}
