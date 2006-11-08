/**
	
	AUTHOR
	
		Name : AbstractVScrollList
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
class lunas.display.components.list.AbstractVScrollList extends AbstractList 
{
	
	/**
	 * Create a new AbstractVScrollList
	 */
	private function AbstractVScrollList() 
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
	
	public function get vMaxPosition():Number 
	{
		return getVMaxPosition() ;	
	}
	
	public function get vPosition():Number 
	{
		return getVPosition() ;
	}
	
	public function set vPosition(n:Number):Void 
	{
		setVPosition(n) ;
	}

	public function getScrollPolicy():ScrollContainerPolicy 
	{
		return _scrollPolicy ;
	}

	public function getVMaxPosition():Number 
	{
		return getContainer().getMaxscroll() ;
	}

	public function getVPosition():Number 
	{ 
		var c:MovieClip = getContainer() ;
		return (c.getDirection() == Direction.VERTICAL) ? c.getScroll() : null ;
	}

	public function setScrollPolicy( policy:ScrollContainerPolicy , noRender:Boolean):Void 
	{
		_scrollPolicy = ScrollContainerPolicy.validate(policy) ? policy : ScrollContainerPolicy.FULL ;
		if (!noRender) 
		{
			update() ;
		}
	}

	public function setVPosition(n:Number, noEvent:Boolean):Void 
	{ 
		var c:MovieClip = getContainer() ;
		if (c.getDirection() == Direction.VERTICAL) 
		{
			c.setScroll(n, noEvent) ;
		}
	}
 	
	private var _scrollPolicy:ScrollContainerPolicy ;
	
}