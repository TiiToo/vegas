/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is Vegas Library.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2007
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

import asgard.display.Direction;

import lunas.display.components.container.ListContainer;

import pegas.events.UIEvent;
import pegas.events.UIEventType;
import pegas.transitions.easing.Back;
import pegas.transitions.Tween;

import vegas.util.MathsUtil;

/**
 * @author eKameleon
 */
class lunas.display.components.container.ScrollContainer extends ListContainer 
{
	
	/**
	 * Creates a new ScrollContainer instance.
	 */
	public function ScrollContainer () 
	{
		super() ;
	}

	static public var SCROLL:String = UIEventType.SCROLL ;

	public function get bottomScroll():Number 
	{
		return getBottomScroll() ;	
	}

	public function get maxscroll():Number 
	{
		return getMaxscroll() ;	
	}

	public function get scroll():Number 
	{
		return getScroll() ;	
	}

	public function set scroll(n:Number):Void 
	{
		setScroll( n ) ;	
	}

	public var fixScroll:Boolean = true ;	

	public var noScrollEasing:Boolean ;

	public var scrollEasing:Function = undefined ;

	public var scrollDuration:Number = 12  ;

	public function clearScroll():Void 
	{ 
		speedScroll(1) ; 
		updateScroll() ;
	}

	public function getBottomScroll():Number 
	{ 
		return (getMaxscroll() > 1) ? (getScroll() + (_nChildCount -1)) : _nChildCount ;
	}
	
	public function getContainerPos():Number 
	{
		var index:Number = getScroll() - 1 ;
		var prop:String = (_nDirection == Direction.HORIZONTAL) ? "_x" : "_y" ;
		return - _oModel.getChildAt(index)[prop] ;
	}

	public function getMaxscroll():Number 
	{
		var m:Number = (_oModel.size() - _nChildCount) ;
		if (isNaN(m)) m = 1 ;
		return ( m >= 1 ) ? m+1 : 1 ;
	}
	
	public function getScroll():Number 
	{ 
		return MathsUtil.clamp(_scroll, 1, maxscroll) ;
	}

	public function viewDestroyed():Void 
	{
		_removeTween() ;
	}

	public function setScroll(n:Number, noEvent:Boolean):Void  
	{
		if (n == _scroll) return ;
		if (getMaxscroll() > 0) 
		{
			_scroll = n ;
			_changeScroll() ;
			if (!noEvent) updateScroll() ;
		}
		else 
		{
			_scroll = 1 ;
		}
	}

	public function speedScroll(n:Number):Void 
	{
		_removeTween() ;
		_scroll = (getMaxscroll() > 0) ? n : 1 ;
		_mcContainer[_getPosProperty()] = getContainerPos() ;
	}

	public function viewChanged():Void 
	{
		super.viewChanged() ; 
		_removeTween() ;
		if (fixScroll) speedScroll(1) ;
	}
	
	public function viewEnabled():Void 
	{
		super.viewEnabled() ; 
		_removeTween() ;
		if (fixScroll) speedScroll(1) ;
	}

	public function updateScroll():Void 
	{
		dispatchEvent(new UIEvent( UIEventType.SCROLL, this)) ;
	}

	private var _scroll:Number = 0 ;

	private var _tw:Tween ;
	
	private function _getPosProperty(Void):String 
	{
		return (_nDirection == Direction.HORIZONTAL) ? "_x" : "_y" ;
	}
		
	private function _removeTween() :Void 
	{
		_tw.stop() ; 
		_tw = null ;
	}
	
	private function _changeScroll() : Void 
	{
		_tw.stop() ;
		var prop:String = _getPosProperty() ;
		var pos:Number = getContainerPos () ;
		if (noScrollEasing) 
		{
			_mcContainer[prop] = pos ; 
		} 
		else 
		{
			_tw = new Tween 
			( 
				_mcContainer, 
				prop, 
				scrollEasing || Back.easeOut, 
				_mcContainer[prop], 
				pos ,
				isNaN(scrollDuration) ? 24 : scrollDuration		 
			) ;
			_tw.run() ;
		}
	}
	
}