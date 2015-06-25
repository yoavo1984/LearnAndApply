package core;

import java.util.Collection;
import java.util.List;
import ui.Renderable;

/**
 * Simple example of core implementation.
 * 
 * Data source can be any data fits to a collection. 
 * This can be: contacts on cell phone; List of programs or even questions for the user 
 */
public class Controller  implements Choosable<Item>, Renderable<Item>,UserDetails, Runnable {
	private Collection<Item> list;
	private boolean changed;
	private CoreUser user;
	public Controller() {
	}
	
	public Controller(List<Item> items) {
		this.setDataSource(items);
		this.changed = true;
	}

	public void setDataSource (Collection<Item> list) {
		this.list = list;
	}
	
	/**
	 * the function is been used by the two u.i aspect  + it can be implemented by the core itself.
	 */
	@Override
	public void render() {
		
	}
	@Override
	public void choose(Item item) {
		this.changed = true;
		
	}
	@Override
	public Collection<Item> dataSource() {
		return this.list;
	}
	
	@Override
	public int getUserID() {
		if (this.user != null) {
			return user.getId();
		} else {
			return -1;
		}
	}

	@Override
	public String getUserName() {
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
					e.printStackTrace();
				}
        }
	}

	
	
	
}
