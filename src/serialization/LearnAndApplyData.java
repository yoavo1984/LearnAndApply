package serialization;

import java.io.Serializable;

import javax.lang.model.element.VariableElement;
import javax.xml.crypto.Data;

public class LearnAndApplyData implements Serializable{
	public static String FILE_NAME = "data.ser";

	private int [] times;
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public LearnAndApplyData() {
		// TODO Auto-generated constructor stub
		times = new int [6];
	}
	
	public int getTimeOfObject (int objIndex) {
		return times[objIndex];
	}
	
	public void setTimeOfObject (int objIndex, int value) {
		times[objIndex] = value;
	}
	
	public int getTimesArraySize () {
		return times.length;
	}
	
	public void cleanData () {
		for (int i = 0; i < this.times.length; i++) {
			times[i] = 0;
		}
	}

}
