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
 * The DataFormat class provides values that specify how downloaded data is received.
 * @author eKameleon
 */
class asgard.net.DataFormat 
{

	/**
	 * Specifies that downloaded data is received as raw binary data.
	 */
	public static var BINARY:String = "binary" ;
	
	/**
	 * Specifies that downloaded data is received as text.
	 */
	public static var TEXT:String = "text" ;
	
	/**
	 * Specifies that downloaded data is received as URL-encoded variables.
	 */
	public static var VARIABLES:String = "variables" ;
	
	/**
	 * Returns {@code true} if the passed argument is valid.
	 * @return {@code true} if the passed argument is valid.
	 */
	public static function validate(sFormat:String):Boolean 
	{
		return (sFormat == DataFormat.BINARY) || (sFormat == DataFormat.TEXT) || (sFormat == DataFormat.VARIABLES) ;
	}

}