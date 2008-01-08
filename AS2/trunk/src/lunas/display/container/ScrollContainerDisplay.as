/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is LunAS Library.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

import asgard.display.Direction;

import lunas.display.container.ListContainerDisplay;

import pegas.events.ActionEvent;
import pegas.events.UIEvent;
import pegas.transitions.Tween;
import pegas.transitions.TweenEntry;
import pegas.transitions.easing.Back;

import vegas.events.Delegate;
import vegas.events.EventListener;
import vegas.util.MathsUtil;

/**
 * This container is a list and can be scrolled.
 * @author eKameleon
 */
class lunas.display.container.ScrollContainerDisplay extends ListContainerDisplay 
{
	
	/**
	 * Creates a new ScrollContainer instance.
	 * @param sName:String the name of the display.
	 * @param target:MovieClip the DisplayObject instance control this target.
	 * @param id (optional) the id of the model.
	 * @param bGlobal (optional) the flag to use a global event flow or a local event flow.
	 * @param sChannel (optional) the name of the global event flow if the {@code bGlobal} argument is {@code true}.
	 * @param childs (optional) An Array of items to insert in the model.
	 */
	public function ScrollContainerDisplay( sName:String, target:MovieClip , id , bGlobal:Boolean , sChannel:String , childs:Array ) 
	{ 
		super( sName, target, id, bGlobal, sChannel, childs ) ;
	}

	/**
	 * The name of the event dispatched when the scroll change.
	 */
	public static var SCROLL:String = UIEvent.SCROLL ;

	/**
	 * Returns the bottom scroll value.
	 * @return the bottom scroll value.
	 */
	public function get bottomScroll():Number 
	{
		return getBottomScroll() ;	
	}

	/**
	 * Returns the maxscroll value.
	 * @return the maxscroll value.
	 */
	public function get maxscroll():Number 
	{
		return getMaxscroll() ;	
	}

	/**
	 * Returns the scroll value of this container.
	 * @return the scroll value of this container.
	 */
	public function get scroll():Number 
	{
		return getScroll() ;	
	}
	
	/**
	 * Sets the scroll value of this container.
	 */
	public function set scroll(n:Number):Void 
	{
		setScroll( n ) ;	
	}

	/**
	 * Indicates if the scroll is fixed.
	 */
	public var fixScroll:Boolean = true ;	

	/**
	 * Indicates if the scroll use an easing effect.
	 */
	public var noScrollEasing:Boolean ;
	
	/**
	 * Indicates the scroll easing method.
	 */
	public var scrollEasing:Function = undefined ;

	/**
	 * Indicates the scroll duration.
	 */
	public var scrollDuration:Number = 12  ;

	/**
	 * Insert a child object at the specified index position.
	 * @param o child object
	 * @param index The position to insert the child
	 * @param oInit (optional) the init object use to initialize the new child.
	 */
	public function addChildAt(o, index:Number, oInit) 
	{
		var c:MovieClip = super.addChildAt(o, index, oInit) ;
		_refreshChilds() ;
		return c ;
	}

	/**
	 * Reset the scroll effect and refresh the view.
	 */
	public function clearScroll():Void 
	{ 
		speedScroll(1) ; 
		updateScroll() ;
	}
	
	/**
	 * Returns the bottom scroll value.
	 * @return the bottom scroll value.
	 */
	public function getBottomScroll():Number 
	{ 
		return (getMaxscroll() > 1) ? (getScroll() + (_nChildCount -1)) : _nChildCount ;
	}
	
	/**
	 * Returns the current container position.
	 * @return the current container position.
	 */
	public function getContainerPos():Number 
	{
		var index:Number = getScroll() - 1 ;
		var prop:String = _getPosProperty() ;
		return - getModel().getChildAt(index)[prop] ;
	}
	
	/**
	 * Returns the maxscroll value of the display container.
	 * @return the maxscroll value of the display container.
	 */
	public function getMaxscroll():Number 
	{
		var m:Number = (getModel().size() - _nChildCount) ;
		if (isNaN(m)) m = 1 ;
		return ( m >= 1 ) ? m+1 : 1 ;
	}
	
	public function getScroll():Number 
	{ 
		return MathsUtil.clamp(_scroll, 1, maxscroll) ;
	}

	/**
	 * Initialize the container of this display.
	 */
	/*override*/public function initContainer():Void
	{

		super.initContainer() ;
		
		_changeListener = new Delegate(this, _refreshChilds ) ;
		_finishListener = new Delegate(this, notifyFinish ) ;

		_tw = new Tween( container ) ;
		_tw.addEventListener( ActionEvent.CHANGE , _changeListener ) ;
		_tw.addEventListener( ActionEvent.FINISH , _finishListener  ) ;
		
		_entry = new TweenEntry() ;

	}
	
	/**
	 * Invoked when the scroll is finished.
	 */
	public function notifyFinish() : Void 
	{
		dispatchEvent( new ActionEvent( ActionEvent.FINISH , this ) ) ;
	}
	
	/**
	 * Invoked when the scroll is started.
	 */
	public function notifyStart() : Void 
	{
		dispatchEvent( new ActionEvent( ActionEvent.START , this ) ) ;
	}
	
	/**
	 * Sets the scroll value of the container.
	 * @param n the scroll value.
	 * @param noEvent This optional flag disabled the scroll event notify in this method if it's {@code true}.
	 */
	public function setScroll(n:Number, noEvent:Boolean):Void  
	{
		if (n == _scroll) return ;
		if (getMaxscroll() > 0) 
		{
			_scroll = n ;
			_changeScroll() ;
			if ( noEvent != true ) 
			{
				updateScroll() ;
			}
		}
		else 
		{
			_scroll = 1 ;
		}
	}
	
	/**
	 * Scroll the container without scroll and without notify an event.
	 */
	public function speedScroll(n:Number):Void 
	{
		_clearTween() ;
		_scroll = (getMaxscroll() > 0) ? n : 1 ;
		container[_getPosProperty()] = getContainerPos() ;
	}

	/**
	 * Invoked when the view of the display is changed.
	 */
	public function viewChanged():Void 
	{
		super.viewChanged() ; 
		_clearTween() ;
		if (fixScroll) speedScroll(1) ;
	}

	/**
	 * Invoked when the view of the display is destroyed.
	 */
	public function viewDestroyed():Void 
	{
		_clearTween() ;
	}

	/**
	 * Invoked when the enabled property of the display is changed.
	 */
	public function viewEnabled():Void 
	{
		super.viewEnabled() ; 
		_clearTween() ;
		if (fixScroll) 
		{
			speedScroll(1) ;
		}
	}
	
	/**
	 * Update the scroll event.
	 */
	public function updateScroll():Void 
	{
		dispatchEvent( new UIEvent( UIEvent.SCROLL, this) ) ;
	}

	/**
	 * @private
	 */
	private var _entry:TweenEntry ;

	/**
	 * @private
	 */
	private var _scroll:Number = 0 ;

	/**
	 * @private
	 */
	private var _changeListener:EventListener ;

	/**
	 * @private
	 */
	private var _finishListener:EventListener ;
	
	/**
	 * @private
	 */
	private var _tw:Tween ;

	/**
	 * @private
	 */
	private function _changeScroll():Void 
	{
		if (_tw.running)
		{
			_tw.stop() ;
		}

		var prop:String = _getPosProperty() ;
		var pos:Number  = getContainerPos () ;
		
		notifyStart() ;
		
		if ( noScrollEasing ) 
		{
			container[prop] = pos ;
			_refreshChilds() ;
			notifyFinish() ;
		} 
		else 
		{
		
			_tw.clear() ;
			
			_entry.prop   = prop ;
			_entry.easing = scrollEasing || Back.easeOut ;
			_entry.begin  = container[prop] ;
			_entry.finish = pos ;
			
			_tw.insert( _entry ) ;
			_tw.duration = isNaN( scrollDuration ) ? 24 : scrollDuration ;
			_tw.run() ;
			
		}
	}
	
	/**
	 * @private
	 */
	private function _clearTween() :Void 
	{
		_tw.stop() ; 
	}

	/**
	 * Returns the position property with the current direction property.
	 * @private
	 * @return the position property with the current direction property.
	 */
	private function _getPosProperty():String 
	{
		return (_nDirection == Direction.HORIZONTAL) ? "_x" : "_y" ;
	}
	
	/**
	 * Invoked to refreshChilds during the scroll of this container.
	 */
	/*protected*/ private function _refreshChilds() : Void 
	{
		// overrides this method.
	}



}