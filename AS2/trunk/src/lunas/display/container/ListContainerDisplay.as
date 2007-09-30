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
  Portions created by the Initial Developer are Copyright (C) 2004-2007
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

import asgard.display.Direction;

import flash.geom.Rectangle;

import lunas.core.IDirectionable;
import lunas.display.container.SimpleContainerDisplay;
import lunas.model.ContainerModel;

import pegas.draw.RectanglePen;

/**
 * This container display all childs in a list representation. 
 * This list is {@code IDirectionable}
 * @author eKameleon
 * @see Direction
 */
class lunas.display.container.ListContainerDisplay extends SimpleContainerDisplay implements IDirectionable
{

	/**
	 * Creates a new ListContainerDisplay instance
	 * @param sName:String the name of the display.
	 * @param target:MovieClip the DisplayObject instance control this target.
	 * @param id (optional) the id of the model.
	 * @param bGlobal (optional) the flag to use a global event flow or a local event flow.
	 * @param sChannel (optional) the name of the global event flow if the {@code bGlobal} argument is {@code true}.
	 * @param childs (optional) An Array of items to insert in the model.
	 */
	function ListContainerDisplay( sName:String, target:MovieClip , id , bGlobal:Boolean , sChannel:String , childs:Array ) 
	{ 
		super( sName, target, id, bGlobal, sChannel, childs ) ;
		_nDirection = Direction.VERTICAL ;
		createMask() ;
		update() ;
	}
	
	/**
	 * The height property name use in the container to layout all items.
	 */
	public var propH:String = "_height" ;

	/**
	 * The x property name use in the container to layout all items.
	 */
	public var propX:String = "_x" ;
	
	/**
	 * The y property name use in the container to layout all items.
	 */
	public var propY:String = "_y" ;

	/**
	 * The width property name use in the container to layout all items.
	 */
	public var propW:String = "_width" ;
	
	/**
	 * Returns the direction value of this object.
	 * @return the direction value of this object.
	 */
	public function get direction():Number 
	{
		return getDirection() ;
	}

	/**
	 * Sets the direction value of this object.
	 */
	public function set direction(n:Number):Void 
	{
		setDirection( n ) ;
	}
	
	/**
	 * Returns the number of childs in this container.
	 * @return the number of childs in this container.
	 */
	public function get childCount():Number 
	{
		return getChildCount() ;
	}
	
	/**
	 * Sets the number of childs in this container.
	 */
	public function set childCount(n:Number):Void 
	{
		setChildCount( n ) ;
	}
	
	/**
	 * (read-write) Indicates if the mask is active or not over this container.
	 */
	public function get maskIsActive():Boolean 
	{
		return getMaskIsActive() ;
	}

	/**
	 * @private
	 */
	public function set maskIsActive( b:Boolean ):Void 
	{
		setMaskIsActive( b ) ;
	}

	/**
	 * (read-write) Indicates the space value between to elements in the container.
	 */
	public function get space():Number 
	{
		return getSpace() ;
	}
	
	/**
	 * @private
	 */
	public function set space(n:Number):Void 
	{
		setSpace( n ) ;
	}	

	/**
	 * The thickness value to defines a padding border in the container.
	 */
	public var thickness:Number = 1 ;
	
	/**
	 * (read-write) Indicates if this container use a scrollRect reference to mask the content.
	 */
	public function get useScrollRect():Boolean
	{
		return _useScrollRect ;
	}

	/**
	 * @private
	 */
	public function set useScrollRect( b :Boolean ):Void
	{
		_useScrollRect = b ;
		update() ;
	}
	
	/**
	 * Refreshs and changes the child position of all childs in the container.
	 */
	public function changeChildsPosition():Void 
	{

		var child, prev ;
		var model:ContainerModel = getModel() ;
		
		var pro:String = getCoordinateProperty() ;
		var inv:String = (pro == propY) ? propX : propY ;
		
		var s:String = getSizeProperty() ;
		var a:Array  = model.toArray() ;
		var l:Number = a.length ;
		
		for (var i:Number = 0 ; i<l ; i++) 
		{
			child      = a[i] ;
			prev       = a[i-1] ;
			child[pro] = (i == 0) ? 0 : ( prev[pro] + prev[s] + getSpace() ) ;
			child[inv] = 0 ;
		}
	}

	/**
	 * Creates the mask reference of this display.
	 * @param sName the name reference of the mask target of this container.
	 * @param nDepth the depth value of the mask target of this container.
	 */
	/*protected*/ function createMask( sName:String, nDepth:Number ):Void 
	{
		if (_mcMask == null) 
		{
			_mcMask = view.createEmptyMovieClip( "_mcMask", 1000 ) ;
			_maskPen = new RectanglePen( _mcMask ) ;
		}
	}

	/**
	 * Draw the component display.
	 */
	public function draw():Void 
	{
		if ( getModel().size() > 0 ) 
		{
			changeChildsPosition() ;
		}
		resize() ;
		refreshMask() ;
	}

	/**
	 * Get the internal bound object of this display.
	 */	
	public function getBound():Object 
	{ 
		return _bound ;
	}

	/**
	 * Returns the direction value of this component.
	 * @return the direction value of this component.
	 * @see Direction
	 */
	public function getDirection():Number 
	{ 
		return (_nDirection == Direction.VERTICAL) ? Direction.VERTICAL : Direction.HORIZONTAL ;
	}
	
	/**
	 * Returns the number of childs visible in this container.
	 * @return the number of childs visible in this container.
	 */
	public function getChildCount():Number 
	{ 
		return (_nChildCount >getModel().size()) ? getModel().size() : _nChildCount ; 
	}
	
	/**
	 * Returns the string representation of the coordinate attribute used in this display with the current direction value.
	 * @return the string representation of the coordinate attribute used in this display with the current direction value.
	 */
	public function getCoordinateProperty():String 
	{
		return (_nDirection == Direction.VERTICAL) ? propY : propX ;
	}

	/**
	 * Returns the child position with the specified index and the current direction of this display.
	 * @return the child position with the specified index and the current direction of this display.
	 */
	public function getChildPositionAt(n:Number):Number 
	{
		var o = getModel().getChildAt(n-1) ;
		var p:String = getCoordinateProperty() ;
		var s:String = getSizeProperty() ;
		return (o != undefined) ? (o[p] + o[s] + _nSpace) : 0 ;
	}
	
	/**
	 * Returns the mask reference of this display.
	 * @return the mask reference of this display.
	 */
	public function getMask():MovieClip 
	{
		return _mcMask ;
	}
	
	/**
	 * Returns {@code true} if the mask is active.
	 * @return {@code true} if the mask is active.
	 */
	public function getMaskIsActive():Boolean 
	{ 
		return _bMaskIsActive ;
	}

	/**
	 * Returns the string representation of the size attribute with the current direction.
	 * @return the string representation of the size attribute with the current direction.
	 */
	public function getSizeProperty():String 
	{
		return (_nDirection == Direction.VERTICAL) ? propH : propW ;
	}
	
	/**
	 * Returns the space between 2 childs in the list.
	 * @return the space between 2 childs in the list.
	 */
	public function getSpace():Number 
	{ 
		return isNaN(_nSpace) ? 0 : _nSpace ;
	}
	
	/**
	 * Use the mask protection.
	 */
	public function lockMask():Void
	{
		_bLockMask = true;	
	}
	
	/**
	 * Refresh the mask view of the display.
	 */
	/*protected*/ function refreshMask():Void 
	{
		
		_maskPen.clear() ;

		if ( _bMaskIsActive && _bLockMask == false ) 
		{
			if ( _useScrollRect )
			{
				view.scrollRect = new Rectangle(0, 0, _bound.w , _bound.h ) ;	
			}
			else
			{
				_maskPen.beginFill( 0xFF0000 , 60 ) ;
				_maskPen.draw( _bound.w , _bound.h ) ;
				_maskPen.endFill() ;
				container.setMask(_mcMask) ;	
			}
		}
		else 
		{
			view.scrollRect = null ;
			container.setMask(null) ;
		}
		
	}

	/**
	 * Removes the mask reference of this display.
	 */
	/*protected*/ function removeMask():Void 
	{
		if (_mcMask != undefined) 
		{
			_mcMask.removeMovieClip () ;
			_maskPen = null ;
		}
	}

	/**
	 * Invoqued when the container size change.
	 */
	public function resize():Void 
	{
		if (_nChildCount > 0) 
		{
			var isHorizontal:Boolean = (_nDirection == Direction.HORIZONTAL) ;
			var n:Number = getChildCount() ;
			var n1:Number = 0 ;
			var n2:Number = 0 ;
			var p:String = isHorizontal ? propW : propH ;
			var f:String = isHorizontal ? propH : propW ;
			for (var i:Number = 0 ; i<n ; i++) 
			{
				var c = getModel().getChildAt(i) ;
				n1 += _nSpace + c[p];
				n2 = Math.max(c[f], n2) ;
			}
			n1 -= _nSpace || 0 ;
			var s1:Number = (_nDirection == 1) ? _nSpace : 0 ;
			var s2:Number = (_nDirection == 1) ? 0 : _nSpace ;
			_bound = 
			{
				w : (isHorizontal ? n1 : n2) + thickness , 
				h : (isHorizontal ? n2 : n1) + thickness 
			} ;
			break ;
		}
		else if (_bMaskIsActive) 
		{
			_bound = {
				w : _w  ,
				h : _h 
			};
		}
		else 
		{
			_bound = 
			{
				w : container._width  ,
				h : container._height 
			};
		}
		_w = _bound.w ; 
		_h = _bound.h ;
	}
	
	/**
	 * Sets the direction value of this object.
	 */
	public function setDirection(n:Number):Void 
	{
		_nDirection = (n == Direction.HORIZONTAL) ? Direction.HORIZONTAL : Direction.VERTICAL ;
		container._x = container._y = 0 ;
		update() ;
	}
	
	/**
	 * Sets the numbers of childs visible in the list.
	 */
	public function setChildCount(n:Number):Void 
	{
		if (n == null) _nChildCount = null ;
		else _nChildCount = (n>1) ? n : 1 ;
		_bMaskIsActive = (_nChildCount>0) ;
		update() ;
	}
	
	/**
	 * Sets the mask activity of the display.
	 */
	public function setMaskIsActive ( b:Boolean ):Void 
	{
		_bMaskIsActive = b ;
		update() ;
	}
	
	/**
	 * Sets the space value (in pixel) between 2 childs in the list.
	 */
	public function setSpace(n:Number):Void 
	{
		_nSpace = isNaN(n) ? 0 : n ; 
		if (getModel().size() > 0) update() ;
	}
	
	/**
	 * Unlock the mask protection.
	 */
	public function unlockMask():Void
	{
		_bLockMask = false;	
	}
	
	/**
	 * Invoqued if the enabled property of this container is changed.
	 */
	public function viewEnabled():Void 
	{
		var l:Number = getModel().size() ;
		while (--l > -1) 
		{
			getModel().getChildAt(l).enabled = enabled ;
		}
	}

	/**
	 * @private
	 */
	private var _bMaskIsActive:Boolean ;

	/**
	 * @private
	 */
	private var _bLockMask:Boolean = false ;

	/**
	 * @private
	 */
	private var _bound:Object ;

	/**
	 * @private
	 */
	private var _maskPen:RectanglePen ;

	/**
	 * @private
	 */
	private var _nDirection:Number ; 

	/**
	 * @private
	 */
	private var _nChildCount:Number = null ;
	
	/**
	 * @private
	 */
	private var _nSpace:Number = 0 ;

	/**
	 * @private
	 */
	private var _mcMask:MovieClip ;

	/**
	 * @private
	 */
	private var _useScrollRect:Boolean = false ;

}