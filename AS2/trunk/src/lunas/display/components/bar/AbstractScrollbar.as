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

import lunas.display.components.bar.AbstractProgressbar;
import lunas.display.components.IScrollbar;

import pegas.events.ButtonEvent;
import pegas.events.ButtonEventType;
import pegas.transitions.easing.Back;
import pegas.transitions.Tween;

import vegas.util.MathsUtil;

class lunas.display.components.bar.AbstractScrollbar extends AbstractProgressbar implements IScrollbar 
{

	private function AbstractScrollbar() 
	{
		_eDrag = new ButtonEvent(ButtonEventType.DRAG, this) ;
		_eStartDrag = new ButtonEvent(ButtonEventType.START_DRAG, this) ;
		_eStopDrag = new ButtonEvent(ButtonEventType.STOP_DRAG, this) ;
		
		 // Fix bug with MTASC ! I must declare the value with Static Property in the constructor
		_nDirection = Direction.VERTICAL ;
		
	}

	static public var DRAG:String = ButtonEventType.DRAG ;

	static public var START_DRAG:String = ButtonEventType.START_DRAG ;

	static public var STOP_DRAG:String = ButtonEventType.STOP_DRAG ;

	public var duration:Number = 24  ;	

	public var easing:Function = null ;

	static public var invertPosField:Object = { _x : "_y" , _y : "_x" } ;

	public function get isDragging():Boolean 
	{
		return getIsDragging() ;	
	}

	public var noEasing:Boolean = true ;
	
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

	public function notifyStartDrag():Void
	{
		dispatchEvent( _eStartDrag ) ;	
	}
	
	public function notifyStopDrag():Void
	{
		dispatchEvent( _eStopDrag ) ;	
	}

	public function startDragging():Void 
	{
		notifyStartDrag() ;
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
		notifyStopDrag() ;
	}
	
	public function viewPositionChanged( flag:Boolean ):Void 
	{

		if (_tw.getRunning()) 
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


	private var _eDrag:ButtonEvent ;
	private var _eStartDrag:ButtonEvent ;
	private var _eStopDrag:ButtonEvent ;
	private var _isDragging:Boolean ;
	private var _mouseOffset:Number = 0 ;
	private var _nDirection:Number ; 
	private var _tw:Tween ;
	
}