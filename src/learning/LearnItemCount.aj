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

	private static JFrame debugFrame = null;
	private static JTextArea jTextArea = null;
	private static int INT_WIDTH = 800;
	private static int INT_HEIGHT = 1000;
	
	before (Item it) : choosing()&&args(it){
		
		LearnAndApplyData data;
		try {
			data = (LearnAndApplyData)SerializationUtil.deserialize(LearnAndApplyData.FILE_NAME);
		} catch (Exception e) {
			data = new LearnAndApplyData();
			
		}
		
		
		
		int objOldCount = data.getTimeOfObject(it.getId());
		data.setTimeOfObject(it.getId(), objOldCount + 1 );
		buildDebugFrame();
		printDebug(data);
		debugFrame.setVisible(true);
		try {
			SerializationUtil.serialize(data,LearnAndApplyData.FILE_NAME);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	private void printDebug(LearnAndApplyData data){
		StringBuilder msg = new StringBuilder();
		msg.append("#####################################################");
		msg.append(System.getProperty("line.separator"));
		msg.append("#                       DEBUG                        ");
		msg.append(System.getProperty("line.separator"));
		msg.append("#####################################################");
		msg.append(System.getProperty("line.separator"));
		
		for (int i = 0; i < data.getTimesArraySize(); i++) {
			msg.append("[Item Id] : " + data.getTimeOfObject(i) + " | ");
		}
		msg.append(System.getProperty("line.separator"));
		msg.append("#####################################################");
		msg.append(System.getProperty("line.separator"));
		
		try {
			jTextArea.getDocument().insertString(0,msg.toString(),null);
		}
		catch (BadLocationException e){
			e.printStackTrace();
		}
	}
	private void buildDebugFrame(){
		if (debugFrame == null ) {
			debugFrame = new JFrame("Debug window");
			jTextArea = new JTextArea();
			debugFrame.add(jTextArea);
			jTextArea.setFont(new Font("Serif",Font.PLAIN,18));
			debugFrame.setAlwaysOnTop(true);
		}
		
		debugFrame.setSize(INT_WIDTH, INT_HEIGHT);
		GraphicsEnvironment ge = GraphicsEnvironment.getLocalGraphicsEnvironment();
        GraphicsDevice defaultScreen = ge.getDefaultScreenDevice();
        Rectangle rect = defaultScreen.getDefaultConfiguration().getBounds();
        int x = (int) rect.getMaxX() - debugFrame.getWidth();
        int y = 0;
        debugFrame.setLocation(x, y);	
		
	}
}
