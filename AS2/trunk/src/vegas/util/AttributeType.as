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
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

/**
 * This enumeration static class is based on ECMA-262 property attributes specification. See chapter 8.6.1 - PDF p38/188
 * @author eKameleon
 * @see Attribute
 * @see ASSetPropFlags
 */
class vegas.util.AttributeType 
{

	/**
	 * The NONE value(0).
	 */	
	public static var NONE:Number = 0 ;
	
	/**
	 * The DONT_ENUM value(1).
	 */	
	public static var DONT_ENUM:Number = 1 ;
	
	/**
	 * The DONT_DELETE value(2).
	 */
	public static var DONT_DELETE:Number = 2 ;

	/**
	 * The READ_ONLY value(4).
	 */
	public static var READ_ONLY:Number = 4 ;

	/**
	 * The OVERRIDE_ONLY value(3).
	 */
	public static var OVERRIDE_ONLY:Number = DONT_ENUM | DONT_DELETE ;

	/**
	 * The DELETE_ONLY value(5).
	 */
	public static var DELETE_ONLY:Number = DONT_ENUM | READ_ONLY ;

	/**
	 * The ENUM_ONLY value(6).
	 */
	public static var ENUM_ONLY:Number = READ_ONLY | DONT_DELETE ;

	/**
	 * The LOCKED value(7).
	 */
	public static var LOCKED:Number = DONT_DELETE | DONT_ENUM | READ_ONLY ;


	private static var __ASPF__ = _global["ASSetPropFlags"](AttributeType, null, 7, 7) ;
	
}