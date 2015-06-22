package security;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.Vector;

import core.Uniqueness;
import core.UserDetails;
import core.Item;

public aspect UserSecurity {
	
	private static int[] ITEMS_TO_BLOCK = {0};
	pointcut gettingDataSource() : execution (public Collection<Item> dataSource())&&within(UserDetails+);
	
	Collection<Item> around() : gettingDataSource() {

		Collection<Item> collection = proceed();
		
		UserDetails hasUser = (UserDetails)thisJoinPoint.getThis();
		Vector <Uniqueness> itemsToRemove = new Vector<Uniqueness>();
		
		if (hasUser.getUserID() == -1) {
			return collection;
		} else {
			
			for (Iterator<? extends Uniqueness> iterator = collection.iterator(); iterator.hasNext();) {
				Uniqueness tempItem = iterator.next();
				
				for (int i = 0 ; i < ITEMS_TO_BLOCK.length; i++) {
					if (ITEMS_TO_BLOCK[i] == tempItem.getId()){
						itemsToRemove.add(tempItem);
					}
				}
			}
		}
		
		for (int i = 0; i < itemsToRemove.size();i++) {
			collection.remove(itemsToRemove.elementAt(i));
		}
		
		return collection;
	}

}
