package learning;

//import core.Uniqueness;
import core.Choosable;
import core.Item;
import serialization.*;

public aspect LearnItemCount {
	
	pointcut choosing() : execution(public void choose(Item))&&
	within(Choosable+) ;

	before (Item it) : choosing()&&args(it){
		
		LearnAndApplyData data;
		try {
			data = (LearnAndApplyData)SerializationUtil.deserialize(LearnAndApplyData.FILE_NAME);
		} catch (Exception e) {
			data = new LearnAndApplyData();
			
		}
		
		int objOldCount = data.getTimeOfObject(it.getId());
		data.setTimeOfObject(it.getId(), objOldCount + 1 );
		
		for (int i = 0; i < 6; i++) {
			System.out.print("Item Id : " + data.getTimeOfObject(i) + " * ");
		}
		System.out.println();
		
		try {
			SerializationUtil.serialize(data,LearnAndApplyData.FILE_NAME);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
