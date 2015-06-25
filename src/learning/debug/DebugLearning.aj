package learning.debug;


import java.awt.Font;
import java.awt.GraphicsDevice;
import java.awt.GraphicsEnvironment;
import java.awt.Rectangle;

import javax.swing.JFrame;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;

import serialization.LearnAndApplyData;
import learning.LearnItemCount;

public aspect DebugLearning {
	
	pointcut saveLearning() : execution(private void saveData(LearnAndApplyData)) &&  within(LearnItemCount);

	private static JFrame debugFrame = null;
	private static JTextArea jTextArea = null;
	private static int INT_WIDTH = 800;
	private static int INT_HEIGHT = 1000;
	
	before (LearnAndApplyData data) : saveLearning()&&args(data){
		buildDebugFrame();
		printDebug(data);
		showFrame();
	}
	
	private void showFrame(){
		debugFrame.setVisible(true);
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
			msg.append("[Item Id] : " + i + " clicks=" + data.getTimeOfObject(i) + " | ");
		}
		msg.append(System.getProperty("line.separator"));
		msg.append("#####################################################");
		msg.append(System.getProperty("line.separator"));
		
			jTextArea.append(msg.toString());
	}
	
	private void buildDebugFrame(){
		if (debugFrame == null ) {
			debugFrame = new JFrame("Debug window");
			jTextArea = new JTextArea();
			
			

			JScrollPane scroll = new JScrollPane (jTextArea, 
			   JScrollPane.VERTICAL_SCROLLBAR_ALWAYS, JScrollPane.HORIZONTAL_SCROLLBAR_ALWAYS);

			debugFrame.add(scroll);
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
