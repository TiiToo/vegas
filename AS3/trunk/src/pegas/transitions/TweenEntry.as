﻿/*

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

package pegas.transitions 
{
	import vegas.core.CoreObject;
	import vegas.core.ICloneable;
	import vegas.core.ICopyable;	

	/**
	 * A basic TweenEntry used in the Tween and TweenLite class.
	 * @author eKameleon
	 */
	public class TweenEntry extends CoreObject implements ICloneable, ICopyable 
	{

		/**
		 * Creates a new TweenEntry instance.
	 	 * @param p the property string value.
		 * @param e the easing function of the tween entry.
		 * @param b the begin value.
		 * @param f the finish value.
	 	 */	
		public function TweenEntry( p:String=null , e:Function=null , b:Number=NaN , f:Number=NaN )
		{
			begin  = b ;
			easing = e ;
			finish = f ;
			prop   = p ;
		}
		
		/**
		 * Defines the begin value of the value.
		 */
		public var begin:Number ;

		/**
		 * (read-only) Indicates the change value of this tween entry.
		 */
		public function get change():Number 
		{
			return _change ;	
		}

		/**
		 * (read-write) Defines the easing method reference of this entry.
		 */
		public function get easing():Function 
		{
			return _easing ;
		}
			
		/**
		 * @private
	 	 */
		public function set easing( f:Function ):void 
		{
			_easing	= f || TweenEntry.noEasing ;
		}

		/**
		 * (read-write) Defines the finish value of the entry.
		 */
		public function get finish():Number 
		{
			return _finish ;
		}
			
		/**
		 * @private
		 */
		public function set finish(n:Number):void 
		{
			_finish = n ;
			setChange(n) ;
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
		public function clone():*
		{
			return new TweenEntry(prop, easing, begin, finish);
		}

		/**
		 * Returns a deep copy of this entry.
		 * @return a deep copy of this entry.
		 */
		public function copy():*
		{
			return new TweenEntry (prop, easing, begin, finish);
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
			return c*t/d + b ;
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
		public override function toString():String 
		{
			return "[TweenEntry" + (prop ? (":" + prop) : "") + "]" ;
		}
		
		/**
		 * @private
		 */
		private var _change:Number ;
		
		/**
		 * @private
		 */
		private var _easing:Function = TweenEntry.noEasing ;
		
		/**
		 * @private
		 */
		private var _finish:Number ;
		
		/**
		 * @private
		 */
		private var _pos:Number ;
	
		/**
		 * Sets the new change value of this entry.
	 	 */
		protected function setChange(n:Number):void 
		{
			var c:Number = n - begin ;
			_change = isNaN(c) ? 0 : c ;
		}

	}

}