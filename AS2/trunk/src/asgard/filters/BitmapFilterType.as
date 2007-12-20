/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is ASGard Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

/**
 * The BitmapFilterType class contains values to set the type of a BitmapFilter.
 * @author eKameleon
 */
class asgard.filters.BitmapFilterType 
{
	
	/**
	 * Defines the setting that applies a filter to the entire area of an object.
	 */
	public static var FULL:String = "full" ;

	/**
	 * Defines the setting that applies a filter to the inner area of an object.
	 */
	public static var INNER:String = "inner" ;
	
	/**
	 * Defines the setting that applies a filter to the outer area of an object.
	 */
	public static var OUTER:String = "outer" ;
	
	/**
	 * @private
	 */
	private static var __ASPF__ = _global.ASSetPropFlags(BitmapFilterType, null , 7, 7) ;

}
