package core;

import java.util.Collection;
import java.util.List;
import ui.Renderable;

public class Controller  implements Choosable<Item>, Renderable<Item>,UserDetails, Runnable {
	private Collection<Item> list;
	private boolean changed;
	private CoreUser user;
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
//		System.out.println("Rendering from controller");
		
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
	
	@Override
	public int getUserID() {
		// TODO Auto-generated method stub
		if (this.user != null) {
			return user.getId();
		} else {
			return -1;
		}
	}

	@Override
	public String getUserName() {
		// TODO Auto-generated method stub
		return this.user.getName();
	}
	
	public void addUser(CoreUser user) {
		this.user = user;
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
