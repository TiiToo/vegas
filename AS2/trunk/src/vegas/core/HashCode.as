/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is Vegas Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2005
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

/**
 * Collected methods which allow easy implementation of {@code hashCode}.
 * @author eKameleon
 */
class vegas.core.HashCode 
{

	/**
	 * Compare two IHashable objects.
	 * @usage   var isEquals:Boolean = HashCode.equals(o1, o2) ;
	 * @param   o1 the first value to compare.
	 * @param   o2 the second value to compare.
	 * @return {@code true} of the two object are equals.  
	 */
	static public function equals(o1, o2):Boolean 
	{
		return HashCode.identify(o1) == HashCode.identify(o2) ;
	}

	/**
	 * Indenfity the hashcode value of an object.
	 */
	static public function identify(o):Number 
	{
		return o["hashCode"]() ;
	}
	
	/**
	 * Returns the next hashcode value.
	 * @return the next hashcode value.
	 */
	static public function next():Number 
	{
		return HashCode._nHash++ ;
	}

	/**
	 * Returns the string representation of the next hashcode value.
	 * @return the string representation of the next hashcode value.
	 */
	static public function nextName():String 
	{
		return String( HashCode._nHash + 1 ) ;
	}
	
	
	/**
	 * Initialize the hashcode value of an object.
	 * @return {@code true}
	 */
	static public function initialize(o):Boolean 
	{
		o.hashCode = function () 
		{
			if (isNaN(this.__hashcode__)) 
			{
				this.__hashcode__ = HashCode.next() ;
				_global.ASSetPropFlags(this, ["__hashcode__"], 7, 7) ;
			}
			return this.__hashcode__ ;
		} ;
		_global.ASSetPropFlags(o, ["__hashcode__", "hashCode"], 7, 7) ;
		return true ;
	}
	
	/**
	 * The internal hashcode counter.
	 */
	static private var _nHash:Number = 0 ;
	
	/**
	 * Launch the initialize of the Object.prototype object.
	 */
	static private var _init:Boolean = HashCode.initialize( Object.prototype ) ;
	
}