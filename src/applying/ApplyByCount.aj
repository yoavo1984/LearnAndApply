/*
 * Apply by count aspect will change the return collection called by data source
 * To be sorted by the amount of time the element was previously called by the user.
 * Using the aspect will cause the first element in the collection is 
 * the one which the user clicked on most, etc.. 
 */

package applying;

import java.util.Collection;

import serialization.*;
import core.Choosable;
import core.Item;

public aspect ApplyByCount {

	pointcut gettingDataSource() : execution (public Collection<Item> dataSource())&&within(Choosable+);
	
	Collection<Item> around() : gettingDataSource() {
		Collection<Item> collection = proceed();
		
		try {
			LearnAndApplyData data = (LearnAndApplyData)SerializationUtil.deserialize(LearnAndApplyData.FILE_NAME);
		} catch (Exception e) {
			return collection
		}
		
		
		return collection;
	}

}
//	public Collection<Item> dataSource() {
