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

import lunas.display.components.AbstractComponent;
import lunas.display.components.IProgressbar;

import pegas.events.UIEventType;
import pegas.maths.Range;

class lunas.display.components.bar.AbstractProgressbar extends AbstractComponent implements IProgressbar 
{

	// ----o Constructor
	
	private function AbstractProgressbar() 
	{
		_rPercent = Range.PERCENT_RANGE ;
		_nDirection = Direction.HORIZONTAL ;
	}

	// ----o Constant
	
	static public var CHANGE:String = UIEventType.CHANGE ;
	
	static private var __ASPF__ = _global.ASSetPropFlags(AbstractProgressbar, null, 7, 7) ;
	
	// ----o Public Properties
	
	public var autoResetPosition:Boolean = false ;

	// ----o Virtual Properties

	public function get direction():Number 
	{
		return getDirection() ;
	}
	
	public function set direction(n:Number):Void 
	{
		setDirection(n) ;	
	}

	public function get position():Number 
	{
		return getPosition() ;
	}
	
	public function set position(n:Number):Void 
	{
		setPosition(n) ;	
	}

	// ----o Public Methods		

	public function getDirection():Number 
	{ 
		return (_nDirection == Direction.HORIZONTAL) ? Direction.HORIZONTAL : Direction.VERTICAL ;
	}
	
	public function getPosition():Number 
	{
		return isNaN(_position) ? 0 : _position ;
	}

	public function setDirection(n:Number):Void 
	{
		_nDirection = (n == Direction.HORIZONTAL) ? Direction.HORIZONTAL : Direction.VERTICAL ;
		update() ;
	}

	public function setPosition(pos:Number, noEvent:Boolean, flag:Boolean):Void 
	{
		pos = _rPercent.clamp(pos) ;
		
		if (pos != _position) 
		{
			_position = pos ;
			
			viewPositionChanged(flag) ;
			
			if (!noEvent) notifyChanged() ;
		}
	}
	
	public function viewChanged():Void 
	{
		var memPos:Number = getPosition() ;
		setPosition(0, true, true) ;
		if (!autoResetPosition) 
		{
			setPosition( memPos, true, true) ;
		}
	}

	public function viewPositionChanged(flag:Boolean):Void 
	{
		// override this method
	}

	// ----o Private Properties

	private var _nDirection:Number ;
	private var _position:Number = 0 ;
	private var _rPercent:Range ;
	
}