/*
 * Apply by count aspect will change the return collection called by data source
 * To be sorted by the amount of time the element was previously called by the user.
 * Using the aspect will cause the first element in the collection is 
 * the one which the user clicked on most, etc.. 
 */

package applying;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;

import serialization.*;
import core.Choosable;
import core.Item;
import core.Uniqueness;

public aspect ApplyByCount {
	
	declare precedence : ApplyByCount, UserSecurity;
	pointcut gettingDataSource() : execution (public Collection<Item> dataSource())&&within(Choosable+);
	
	
	Collection<Item> around() : gettingDataSource() {
		Collection<Item> collection = proceed();
		LearnAndApplyData data;
		
		try {
			data = (LearnAndApplyData)SerializationUtil.deserialize(LearnAndApplyData.FILE_NAME);
		} catch (Exception e) {
			return collection;
		}
		
		return this.sortCollectionByTimeData(collection, data);
	}
	
	private Collection<Item> sortCollectionByTimeData(Collection<Item> collection, LearnAndApplyData data) {
		Collection<Item> retval = new ArrayList<Item>();
		
		int dataSize = data.getTimesArraySize();
		int[] tempDataTimeArray = this.createDataTimeArrayCopy(data);
		
		for (int i = 0 ; i < dataSize; i++) {
			int maxIndex = 0;
			for (int j = 0; j < dataSize - 1; j++){
				if (tempDataTimeArray[maxIndex] < tempDataTimeArray[j+1]) {
					maxIndex = j+1;
				}
			}
			retval.add(this.getItemFromCollection(collection, maxIndex));
			tempDataTimeArray[maxIndex] = -1;
		}
		
		
		return retval;
	}
	
	private int[] createDataTimeArrayCopy (LearnAndApplyData data){
		int dataSize = data.getTimesArraySize();
		int []retval = new int[dataSize];
		
		for (int i = 0; i < dataSize; i++) {
			retval[i] = data.getTimeOfObject(i);
		}
		
		return retval;
	}
	
	private Item getItemFromCollection (Collection<Item> collection, int objId) {
		for (Iterator<? extends Uniqueness> iterator = collection.iterator(); iterator.hasNext();) {
			Uniqueness item = iterator.next();
			
			if (objId == item.getId()){
				return (Item)item;
			}
		}

		return null;
	}

}
//	public Collection<Item> dataSource() {
