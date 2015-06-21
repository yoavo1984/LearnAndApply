package learning;

import core.Uniqueness;
import core.Choosable;
import core.Item;

public aspect LearnByAmountAspect {
	
	pointcut choosing() : execution(public void choose(Item))&&
	within(Choosable+) ;

	before () : choosing(){

	}
}
