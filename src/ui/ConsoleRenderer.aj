package ui;

import java.util.Collection;
import java.util.Iterator;

import core.Uniqueness;

public aspect ConsoleRenderer {
	declare precedence : GUIRenderer ,ConsoleRenderer ;

	pointcut rendering() : execution(public void render(..))&&within(Renderable+) ;

	before() : rendering (){
		this.clearScreen();
		this.DrawLine();

		@SuppressWarnings("unchecked")
		Renderable<Uniqueness> render = (Renderable<Uniqueness>) thisJoinPoint
				.getThis();
		Collection<? extends Uniqueness> collection = render.dataSource();

		for (Iterator<? extends Uniqueness> iterator = collection.iterator(); iterator
				.hasNext();) {

			System.out.println("Item :" + iterator.next().getId());
		}

		input(render, collection);

		System.out.println("Rendering from aspect");
	}
	private static Thread inputThread = null;
	private static class Input implements Callback<Integer> {

		private Collection<? extends Uniqueness> collection;
		private Renderable<Uniqueness> render;

		public Input(Collection<? extends Uniqueness> c,
				Renderable<Uniqueness> r) {
			this.collection = c;
			this.render = r;
		}

		@Override
		public Boolean run(Integer userInput) {
			for (Iterator<? extends Uniqueness> iterator = collection
					.iterator(); iterator.hasNext();) {
				Uniqueness item = iterator.next();
				if (userInput == item.getId()) {
					render.choose(item);
					return true;
				}
			}
			return false;
		}
	}

	private void input(Renderable<Uniqueness> render,
			Collection<? extends Uniqueness> collection) {
		//TODO break old input thread;
		if (inputThread != null){
			inputThread.interrupt();
		}
		inputThread = this.waitForUserInput(render, collection);
		inputThread.start();

	}

	private ConsoleInput waitForUserInput(Renderable<Uniqueness> render,
			Collection<? extends Uniqueness> collection) {
		ConsoleInput reader = new ConsoleInput(new Input(collection,render));
		return reader;
	}


	private void DrawLine() {
		for (int i = 0; i < 50; i++) {
			System.out.print("*");
		}
		System.out.println();
	}

	private void clearScreen() {
		for (int i = 0; i < 50; i++) {
			System.out.println();
		}
	}

}
