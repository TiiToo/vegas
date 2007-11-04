/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is PEGAS Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

import vegas.core.CoreObject;
import vegas.core.ICloneable;

/**
 * A basic TweenEntry used in the Tween and TweenLite class.
 * @author eKameleon
 */
class pegas.transitions.TweenEntry extends CoreObject implements ICloneable
{
	
	/**
	 * Creates a new TweenEntry instance.
	 * @param p the property string value.
	 * @param e the easing function of the tween entry.
	 * @param b the begin value.
	 * @param f the finish value.
	 */	
	public function TweenEntry(p:String, e:Function, b:Number, f:Number) 
	{
		begin = b ;
		setEasing(e) ;
		finish = f ;
		prop = p ;
	}

	/**
	 * Defines the begin value of the value.
	 */
	public var begin:Number ;

	/**
	 * (read-write) Defines the easing method reference of this entry.
	 */
	public function get easing():Function 
	{
		return getEasing() ;
	}
	
	/**
	 * @private
	 */
	public function set easing( f:Function ):Void 
	{
		setEasing(f) ;
	}

	/**
	 * (read-write) Defines the finish value of the entry.
	 */
	public function get finish():Number 
	{
		return getFinish() ;
	}
	
	/**
	 * @private
	 */
	public function set finish(n:Number):Void 
	{
		setFinish(n) ;
	}

	/**
	 * The previous position of the entry.
	 */
	public var prevPos:Number ;

	/**
	 * The property of the tween entry.
	 */
	public var prop:String ;

	/**
	 * Returns a shallow copy of this entry.
	 * @return a shallow copy of this entry.
	 */
	public function clone() 
	{
		var t:TweenEntry = new TweenEntry (prop, getEasing(), begin, finish);
		return t ;
	}

	/**
	 * Returns the change value of this tween entry.
	 * @return the change value of this tween entry.
	 */
	public function getChange():Number 
	{
		return _change ;	
	}

	public function getEasing():Function 
	{
		return _easing ;	
	}

	public function getFinish():Number 
	{
		return _finish ;
	}
	
	/**
	 * Returns the current position of this entry with the specified time value and with the specified duration.
	 * @param t The time position of the motion.
	 * @param d The duration value of the motion.
	 * @return the current position of this entry with the specified time value and with the specified duration.
	 */
	public function getPosition(t:Number , d:Number):Number 
	{
		return _easing( t, begin, _change , d ) ;
	}
	
	/**
	 * The default static easing used by this tween entry if the easing property is empty.
	 */
	public static function noEasing(t:Number, b:Number, c:Number, d:Number):Number 
	{
		return c*t/d + b;
	}

	/**
	 * Sets the easing function of this entry. Use by default the static TweenEntry.noEasing method. 
	 */	
	public function setEasing( e:Function ):Void 
	{
		_easing	= e || TweenEntry.noEasing ;
	}
	
	/**
	 * Sets the finish value of this entry.
	 */
	public function setFinish(n:Number):Void 
	{
		_finish = n ;
		_setChange(n) ;
	}
	
	/**
	 * Sets the position of the tween entry with the specified value.
	 */
	public function setPosition(value:Number):Number 
	{
		prevPos = _pos ;
		_pos = value ;
		return value ;
	}
	
	/**
	 * Returns the String representation of the object.
	 * @return the String representation of the object.
	 */
	public function toString():String 
	{
		return "[TweenEntry" + (prop ? (":" + prop) : "") + "]" ;
	}

	private var _change:Number ;
	private var _easing:Function = TweenEntry.noEasing ;
	private var _finish:Number ;
	private var _pos ;
	
	/**
	 * Sets the new change value of this entry.
	 */
	private function _setChange(n:Number):Void 
	{
		var c:Number = n - begin ;
		_change = isNaN(c) ? 0 : c ;
	}

}