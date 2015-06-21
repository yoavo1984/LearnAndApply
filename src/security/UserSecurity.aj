package security;

import java.util.Collection;
import java.util.Iterator;

import core.Uniqueness;
import core.UserDetails;
import core.Item;

public aspect UserSecurity {
	pointcut gettingDataSource() : execution (public Collection<Item> dataSource())&&within(UserDetails+);
	
	Collection<Item> around() : gettingDataSource() {

		Collection<Item> collection = proceed();
		
		UserDetails hasUser = (UserDetails)thisJoinPoint.getThis();
		Uniqueness itemToRemove = null;
		
		if (hasUser.getUserID() == -1) {
			return collection;
		} else {
			
			for (Iterator<? extends Uniqueness> iterator = collection.iterator(); iterator.hasNext();) {
				Uniqueness tempItem = iterator.next();
				
				if(tempItem.getId() == 2) {
					itemToRemove = tempItem;
				}
			}
		}
		
		collection.remove(itemToRemove);
		return collection;
	}

}
