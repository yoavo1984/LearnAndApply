package core;

import java.util.Collection;

import ui.Renderable;

public class Controller implements Choosable<Item>, Renderable<Item>{
	private Collection<Item> list;
	public Controller() {
		// TODO Auto-generated constructor stub
	}
	
	public void setDataSource (Collection<Item> list) {
		this.list = list;
	}
	
	@Override
	public void render(Collection <Item> dataSource) {
		// TODO Auto-generated method stub
		System.out.println("Rendering from controller");
		
	}
	@Override
	public void choose(Item item) {
		// TODO Auto-generated method stub
		
	}
	@Override
	public Collection<Item> dataSource() {
		// TODO Auto-generated method stub
		return this.list;
	}
	
	
}
