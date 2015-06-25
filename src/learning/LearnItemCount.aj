package learning;

//import core.Uniqueness;

import java.awt.Font;
import java.awt.GraphicsDevice;
import java.awt.GraphicsEnvironment;
import java.awt.Rectangle;

import javax.swing.JFrame;
import javax.swing.JTextArea;
import javax.swing.text.BadLocationException;

import core.Choosable;
import core.Item;
import serialization.*;

public aspect LearnItemCount {
	
	pointcut choosing() : execution(public void choose(Item))&&
	within(Choosable+) ;

	
	before (Item it) : choosing()&&args(it){
		
	 LearnAndApplyData data = updateData(this.getData(), it);
	 saveData(data);
		
	}
	
	private void saveData(LearnAndApplyData data){
		try {
			SerializationUtil.serialize(data,LearnAndApplyData.FILE_NAME);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	private LearnAndApplyData updateData(LearnAndApplyData data, Item it){
		int objOldCount = data.getTimeOfObject(it.getId());
		data.setTimeOfObject(it.getId(), objOldCount + 1 );
		return data;
	}
	private LearnAndApplyData getData(){
		LearnAndApplyData data;
		try {
			data = (LearnAndApplyData)SerializationUtil.deserialize(LearnAndApplyData.FILE_NAME);
		} catch (Exception e) {
			data = new LearnAndApplyData();
			
		}
		return data;
	}

}
