package ui;

import java.util.Collection;
import java.util.Iterator;

import core.Uniqueness;

import java.awt.Frame;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.WindowEvent;

import javax.lang.model.element.VariableElement;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;

public aspect GUIRenderer {
	pointcut rendering2() : execution(public void render(..))&&within(Renderable+) ;
	
	before () : rendering2 (){
		@SuppressWarnings("unchecked")
		Renderable<Uniqueness> render = (Renderable<Uniqueness>)thisJoinPoint.getThis();
		Collection <? extends Uniqueness> collection = render.dataSource();
		
		displayGUI(collection, render);
		
		for (Iterator<? extends Uniqueness> iterator = collection.iterator(); iterator.hasNext();) {
			
			System.out.println("Item :"  + iterator.next().getId());
		}
	}
	
	private void displayGUI (Collection <? extends Uniqueness> collection,Renderable<Uniqueness> render) {
		JFrame frame = new JFrame();
		JLabel jblHelloWorld = new JLabel("");
		
		JButton[] buttons = new JButton[6];
		int i =0;
		for (Iterator<? extends Uniqueness> iterator = collection.iterator(); iterator.hasNext();) {
			
			buttons[i] = new JButton(String.valueOf(iterator.next().getId()));
			buttons[i].setSize(30, 30);
			buttons[i].setLocation(50, 30 + i * 50);
			
			buttons[i].addActionListener(new GUIActionListener(render, collection, frame));
			
			frame.add(buttons[i]);
			i++;
		}
		
		frame.add(jblHelloWorld);
		
		frame.setSize(100, 500);
		frame.setVisible(true);
		
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

