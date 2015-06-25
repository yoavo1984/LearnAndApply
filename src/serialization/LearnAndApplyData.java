package serialization;

import java.io.Serializable;

public class LearnAndApplyData implements Serializable{
	public static String FILE_NAME = "data.ser";

	private int [] times;
	private static final long serialVersionUID = 1L;

	public LearnAndApplyData() {
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
