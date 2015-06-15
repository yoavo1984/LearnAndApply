package core;

import java.util.Collection;
import java.util.List;

import ui.Renderable;

public class Controller  implements Choosable<Item>, Renderable<Item>, Runnable {
	private Collection<Item> list;
	private boolean changed;
	public Controller() {
		// TODO Auto-generated constructor stub
	}
	
	public Controller(List<Item> items) {
		this.setDataSource(items);
		this.changed = true;
	}

	public void setDataSource (Collection<Item> list) {
		this.list = list;
	}
	
	@Override
	public void render() {
		// TODO Auto-generated method stub
		System.out.println("Rendering from controller");
		
	}
	@Override
	public void choose(Item item) {
		// TODO Auto-generated method stub
		this.changed = true;
		
	}
	@Override
	public Collection<Item> dataSource() {
		// TODO Auto-generated method stub
		return this.list;
	}
	
	public void run(){

        while(true) {
                try {
                	if (this.changed){ 
                		this.changed = false;
                		this.render();
                	} 
                	
					Thread.sleep(200);
				} catch (InterruptedException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
        }
	}
	
	
}
