﻿/*

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
 * This serializer convert a Date object in an EDEN string representation.
 * EDEN Compatibility to serialize ECMAScript data.
 * @author eKameleon
 */
class vegas.util.serialize.DateSerializer 
{

	/**
	 * Returns a Eden representation of the object.
	 * @return a string representing the source code of the object.
	 */	
	public static function toSource(date:Array):String 
	{
		return "new Date(" + date.valueOf() + ")" ;
    }

}
