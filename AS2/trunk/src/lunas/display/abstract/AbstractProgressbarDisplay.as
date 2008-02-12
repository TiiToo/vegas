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

import lunas.core.IProgressbar;
import lunas.display.abstract.AbstractProgressDisplay;

/**
 * This class provides a skeletal implementation of all the {@code IProgressbar} display components, to minimize the effort required to implement this interface.
 * @author eKameleon
 */
class lunas.display.abstract.AbstractProgressbarDisplay extends AbstractProgressDisplay implements IProgressbar 
{

	/**
	 * Creates a new AbstractProgressbarDisplay instance. 
	 * @param sName the name of the display.
	 * @param target the DisplayObject instance control this target.
	 */
	private function AbstractProgressbarDisplay(sName:String, target:MovieClip ) 
	{ 
		super ( sName, target ) ;
		_nDirection = Direction.HORIZONTAL ;
	}

	/**
	 * (read-write) Determinates the direction value of this component.
	 * @see Direction
	 */
	public function get direction():Number 
	{
		return getDirection() ;
	}

	/**
	 * @private
	 */
	public function set direction(n:Number):Void 
	{
		setDirection(n) ;	
	}
	
	/**
	 * Returns the direction value of this component.
	 * @return the direction value of this component.
	 * @see Direction
	 */
	public function getDirection():Number 
	{ 
		return (_nDirection == Direction.HORIZONTAL) ? Direction.HORIZONTAL : Direction.VERTICAL ;
	}

	/**
	 * Sets the direction value of this component.
	 */
	public function setDirection(n:Number):Void 
	{
		_nDirection = (n == Direction.HORIZONTAL) ? Direction.HORIZONTAL : Direction.VERTICAL ;
		update() ;
	}

	/**
	 * @private
	 */
	private var _nDirection:Number ;
	
}