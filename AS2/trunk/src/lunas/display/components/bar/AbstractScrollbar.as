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
  Portions created by the Initial Developer are Copyright (C) 2004-2005
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

/** AbstractScrollbar

	AUTHOR
	
		Name : AbstractScrollbar
		Package : lunas.display.components.bar
		Version : 1.0.0.0
		Date :  2006-02-10
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	PROPERTY SUMMARY
	
		- autoResetPosition:Boolean
	
		- direction:Number [R/W]
		
		- duration:Number
		
		- easing:Function
				
		- isDragging:Boolean [Read Only]
		
		- noEasing:Boolean
		
			Cette propriété permet de définir si la barre utilise une Tween ou pas à chaque changement de la valeur position.
		
		- position:Number [R/W]
	
	METHOD SUMMARY
		
		- dragging():Void
		
		- getBar():MovieClip
		
		- getDirection():Number
		
		- getPosition():Number
		
		- getThumb():MovieClip
		
		- setDirection(n:Number):Void
		
		- setPosition(pos:Number, noEvent:Boolean):Void
		
		- startDragging():Void
		
		- stopDragging():Void
	
	EVENT TYPE SUMMARY
	
		- DRAG:EventType
		
		- CHANGE:EventType
	
	INHERIT
	
		MovieClip → AbstractComponent → AbstractProgressbar → AbstractScrollbar
	
**/

import asgard.display.Direction;
import asgard.events.ButtonEvent;
import asgard.events.ButtonEventType;
import asgard.transitions.easing.Back;
import asgard.transitions.Tween;

import lunas.display.components.bar.AbstractProgressbar;
import lunas.display.components.IScrollbar;

import vegas.util.MathsUtil;

class lunas.display.components.bar.AbstractScrollbar extends AbstractProgressbar implements IScrollbar 
{

	// ----o Constructor
	
	private function AbstractScrollbar() 
	{
		_eDrag = new ButtonEvent(ButtonEventType.DRAG, this) ;
		
		 // Fix bug with MTASC ! I must declare the value with Static Property in the constructor
		_nDirection = Direction.VERTICAL ;
		
	}

	// ----o Constant
	
	static public var DRAG:String = ButtonEventType.DRAG ;
	
	static private var __ASPF__ = _global.ASSetPropFlags(AbstractScrollbar, null, 7, 7) ;
	
	// ----o Public Properties

	public var duration:Number = 24  ;	
	public var easing:Function = null ;
	static public var invertPosField:Object = { _x : "_y" , _y : "_x" } ;
	// public var isDragging:Boolean ; // [Read Only]
	public var noEasing:Boolean = true ;
	
	// ----o Public Methods		

	public function dragging():Void 
	{
		var sizeField:String = getSizeField() ;
		var mouseField:String = getMouseField() ;
		var b:MovieClip = getBar() ;
		var t:MovieClip = getThumb() ;
		var size:Number =  b[sizeField] - t[sizeField] ;
		var pos:Number = this[mouseField] - _mouseOffset ;
		pos = MathsUtil.getPercent( MathsUtil.clamp(pos, 0, size), size ) ;
		setPosition( pos ) ;
		notifyDrag() ;
	}

	public function getBar():MovieClip 
	{
		return null ; // override this method !
	}

	public function getIsDragging():Boolean 
	{
		return _isDragging ;
	}
	
	public function getSizeField():String 
	{
		return (getDirection() == Direction.VERTICAL) ? "_height" : "_width" ;
	}
	
	public function getMouseField():String 
	{
		return (getDirection() == Direction.VERTICAL) ? "_ymouse" : "_xmouse" ;
	}
	
	public function getThumb():MovieClip 
	{
		return null ; // override this method !
	}

	public function notifyDrag():Void 
	{
		dispatchEvent( _eDrag ) ;
	}

	public function startDragging():Void 
	{
		var mouseField:String = (_nDirection == Direction.VERTICAL) ? "_ymouse" : "_xmouse" ;
		_mouseOffset = (getThumb())[mouseField] ;
		dragging() ;
		_isDragging = true ;
		this.onMouseMove = dragging ;
	}

	public function stopDragging():Void 
	{
		_isDragging = false ;
		delete this.onMouseMove ;
	}
	
	public function viewPositionChanged( flag:Boolean ):Void 
	{

		if (_tw.running) 
		{
			_tw.stop() ;
		}

		var posField:String = (_nDirection == Direction.VERTICAL) ? "_y" : "_x" ;
		
		var sizeField:String = (_nDirection == Direction.VERTICAL) ? "_height" : "_width" ;
		
		var b:MovieClip = getBar() ;
		var t:MovieClip = getThumb() ;

		var size:Number =  b[sizeField] - t[sizeField] ;
		var pos:Number = (getPosition() / 100) *  size  ;
		
		if (!isDragging) 
		{
			t[invertPosField[posField]] =  0 ;
		} 
		
		if ( flag || _isDragging || noEasing ) 
		{
			t[posField] = pos ;
		} 
		else 
		{
			_tw = new Tween 
			( 
				t, 
				posField, 
				easing || Back.easeOut ,
				t[posField] ,  
				pos , 
				isNaN(duration) ? 24 : duration
			) ;
			
			_tw.run() ;
			
		}
	}

	// ----o Virtual Properties

	public function get isDragging():Boolean 
	{
		return getIsDragging() ;	
	}

	// ----o Private Properties

	private var _eDrag:ButtonEvent ;
	private var _isDragging:Boolean ;
	private var _mouseOffset:Number = 0 ;
	private var _nDirection:Number ; 
	private var _tw:Tween ;
	
}