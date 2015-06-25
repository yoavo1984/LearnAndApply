package ui;

import java.util.Collection;
import java.util.Iterator;

import core.Uniqueness;

import java.awt.Insets;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.WindowEvent;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;

public aspect GUIRenderer {
	pointcut rendering() : execution(public void render(..))&&within(Renderable+) ;
	
	private static JFrame  frame = new JFrame();
	before () : rendering(){
		@SuppressWarnings("unchecked")
		Renderable<Uniqueness> render = (Renderable<Uniqueness>)thisJoinPoint.getThis();
		Collection <? extends Uniqueness> collection = render.dataSource();
		displayGUI(collection, render);
	}
	
	private void displayGUI (Collection <? extends Uniqueness> collection,Renderable<Uniqueness> render) {
		frame.getContentPane().removeAll();
		frame.setSize(300 ,  500);
		JLabel jLabel = new JLabel("Learn & Apply: Choose on of the following items");
		
		
		JButton[] buttons = new JButton[collection.size()];
		int i =0;
		for (Iterator<? extends Uniqueness> iterator = collection.iterator(); iterator.hasNext();) {
			
			Uniqueness u = iterator.next();
			buttons[i] = new JButton(String.valueOf(u.getId()));
			buttons[i].setMargin(new Insets(0, 0, 0, 0));
			buttons[i].setSize(200, 30);
			buttons[i].setLocation((300 - 225) /2, 30 + i * 50);
			
			buttons[i].addActionListener(new GUIActionListener(render, collection, frame));
			
			frame.add(buttons[i]);
			i++;
		}
	    jLabel.setHorizontalAlignment(JLabel.CENTER);
	    jLabel.setVerticalAlignment(JLabel.TOP);
		frame.add(jLabel);
		
		frame.setSize(300 ,  500);
		frame.setVisible(true);
		frame.setAlwaysOnTop(true);
		
	}
	
	public class GUIActionListener implements ActionListener {
		Renderable<Uniqueness> render;
		Collection <? extends Uniqueness> collection;
		JFrame frame;
		
		public GUIActionListener(Renderable<Uniqueness> render, Collection <? extends Uniqueness> collection, JFrame frame) {
			this.collection = collection;
			this.render = render;
			this.frame = frame;
			
		}
		
		public void actionPerformed (ActionEvent e) {
			for (Iterator<? extends Uniqueness> iterator = collection.iterator(); iterator.hasNext();) {
				
				Uniqueness item = iterator.next();
				int buttonId = Integer.parseInt(e.getActionCommand());
				if (buttonId == item.getId()){
					render.choose(item);
					frame.dispatchEvent(new WindowEvent(frame, WindowEvent.WINDOW_CLOSING));
				}
			}
			
		}
		}
	}

