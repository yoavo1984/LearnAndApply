package ui;

import java.util.Collection;

import core.Uniqueness;

public aspect ConsoleRenderer {
	pointcut rendering() : execution(public void render(..))&&within(Renderable+) ;
	
	before (Collection<? extends Uniqueness> r) : rendering () && args(r) {
		System.out.println("Rendering");
	}
}
