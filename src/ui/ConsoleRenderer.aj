package ui;

import java.util.Collection;
import java.util.Iterator;
import java.util.Scanner;


import core.Uniqueness;

public aspect ConsoleRenderer {
	declare precedence : GUIRenderer ,ConsoleRenderer ;
	pointcut rendering() : execution(public void render(..))&&within(Renderable+) ;
	
	before () : rendering (){
		this.clearScreen();
		this.DrawLine();
		
		@SuppressWarnings("unchecked")
		Renderable<Uniqueness> render = (Renderable<Uniqueness>)thisJoinPoint.getThis();
		Collection <? extends Uniqueness> collection = render.dataSource();
		
		for (Iterator<? extends Uniqueness> iterator = collection.iterator(); iterator.hasNext();) {
			
			System.out.println("Item :"  + iterator.next().getId());
		}
		
		input(render, collection);
		
		System.out.println("Rendering from aspect");
	}

	private void input(Renderable<Uniqueness> render,
			Collection<? extends Uniqueness> collection) {
		boolean validInput = false;
		while (!validInput) {
			int userInput = this.waitForUserInput();
			
			for (Iterator<? extends Uniqueness> iterator = collection.iterator(); iterator.hasNext();) {
				
				Uniqueness item = iterator.next();
				if (userInput == item.getId()){
					render.choose(item);
					validInput = true;
				}
			}
		}
	}
	
	private int waitForUserInput  () {
		Scanner reader = new Scanner(System.in);
		return reader.nextInt();
	}
	
	private void DrawLine () {
		for (int i = 0 ; i < 50 ; i++){
			System.out.print("*");
		}
		System.out.println();
	}
	
	private void clearScreen () {
		for (int i = 0 ; i < 50; i++) {
			System.out.println();
		}
	}
}
