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
import lunas.core.IProgress;
import lunas.display.abstract.AbstractComponentDisplay;

import pegas.events.UIEvent;
import pegas.maths.Range;

/**
 * This class provides a skeletal implementation of all the {@code IProgress} display components, to minimize the effort required to implement this interface.
 * @author eKameleon
 */
class lunas.display.abstract.AbstractProgressDisplay extends AbstractComponentDisplay implements IProgress
{

	/**
	 * Creates a new AbstractProgressbarDisplay instance. 
	 * @param sName the name of the display.
	 * @param target the DisplayObject instance control this target.
	 * @param bGlobal the flag to use a global event flow or a local event flow.
	 * @param sChannel the name of the global event flow if the {@code bGlobal} argument is {@code true}.
	 */
	private function AbstractProgressDisplay(sName:String, target:MovieClip , bGlobal:Boolean , sChannel:String ) 
	{ 
		super ( sName, target , bGlobal , sChannel ) ;
		_rPercent = Range.PERCENT_RANGE ;
	}

	/**
	 * The name of the event dispatched when the component change.
	 */
	public static var CHANGE:String = UIEvent.CHANGE ;
	
	/**
	 * This flag indicates of the position is auto reset. 
	 */
	public var autoResetPosition:Boolean = false ;

	/**
	 * (read-write) Determinates the position value of this component. A value between 0 and 100 (percentage).
	 */
	public function get position():Number 
	{
		return getPosition() ;
	}
	
	/**
	 * @private
	 */	
	public function set position(n:Number):Void 
	{
		setPosition(n) ;	
	}

	/**
	 * Returns the position value of this component.
	 * @return the position value of this component.
	 */
	public function getPosition():Number 
	{
		return isNaN(_position) ? 0 : _position ;
	}

	/**
	 * Sets the position value of this component.
	 */
	public function setPosition(pos:Number, noEvent:Boolean, flag:Boolean):Void 
	{

		pos = _rPercent.clamp(pos) ;
		
		if (pos != _position) 
		{
			_position = pos ;
			
			viewPositionChanged(flag) ;
			
			if ( noEvent != true ) 
			{
				notifyChanged() ;
			}
			
		}
	}
	
	/**
	 * Invoked when the view of the display is changed.
	 */
	public function viewChanged():Void 
	{
		
		var memPos:Number = getPosition() ;
		
		setPosition(0, true, true) ;
		
		if ( autoResetPosition == false ) 
		{
			setPosition( memPos, true, true) ;
		}
		
	}

	/**
	 * Invoked when the position of the bar is changed.
	 * @param flag (optional) An optional boolean.
	 */
	public function viewPositionChanged(flag:Boolean):Void 
	{
		// overrides this method
	}
	
	/**
	 * @private
	 */
	private var _position:Number = 0 ;

	/**
	 * @private
	 */
	private var _rPercent:Range ;
	
}