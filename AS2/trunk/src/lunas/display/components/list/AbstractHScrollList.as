/**
	
	AUTHOR
	
		Name : AbstractHScrollList
		Package : lunas.display.components.list
		Version : 1.0.0.0
		Date :  8 nov. 06
		Author : eKameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

*/

import asgard.display.Direction;
import asgard.display.ScrollContainerPolicy;

import lunas.display.components.list.AbstractList;

/**
 * @author eKameleon
 */
class lunas.display.components.list.AbstractHScrollList extends AbstractList 
{
	
	/**
	 * Create a new AbstractHScrollList
	 */
	private function AbstractHScrollList() 
	{
		super();
		setScrollPolicy(ScrollContainerPolicy.FULL) ;
	}

	
	public function get scrollPolicy():ScrollContainerPolicy 
	{
		return getScrollPolicy() ;
	}
	
	public function set scrollPolicy(policy:ScrollContainerPolicy):Void 
	{
		setScrollPolicy(policy) ;
	}
	
	public function get hMaxPosition():Number 
	{
		return getHMaxPosition() ;	
	}
	
	public function get hPosition():Number 
	{
		return getHPosition() ;
	}
	
	public function set hPosition(n:Number):Void 
	{
		setHPosition(n) ;
	}

	public function getScrollPolicy():ScrollContainerPolicy 
	{
		return _scrollPolicy ;
	}

	public function getHMaxPosition():Number 
	{
		return getContainer().getMaxscroll() ;
	}

	public function getHPosition():Number 
	{ 
		var c:MovieClip = getContainer() ;
		return (c.getDirection() == Direction.HORIZONTAL) ? c.getScroll() : null ;
	}

	public function setScrollPolicy( policy:ScrollContainerPolicy , noRender:Boolean):Void 
	{
		_scrollPolicy = ScrollContainerPolicy.validate(policy) ? policy : ScrollContainerPolicy.FULL ;
		if (!noRender) 
		{
			update() ;
		}
	}

	public function setHPosition(n:Number, noEvent:Boolean):Void 
	{ 
		var c:MovieClip = getContainer() ;
		if (c.getDirection() == Direction.HORIZONTAL) 
		{
			c.setScroll(n, noEvent) ;
		}
	}
 	
	private var _scrollPolicy:ScrollContainerPolicy ;
	
}