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
 * This static enumeration class defines all net server levels.
 * @author eKameleon
 */
class asgard.net.NetServerLevel 
{
	
	/**
	 * The 'error' level code.
	 */
	public static var ERROR:String = "error" ;

	/**
	 * The 'info' level code.
	 */
	public static var INFO:String = "info" ;
	
	/**
	 * The 'status' level code.
	 */
	public static var STATUS:String = "status" ;	

	/**
	 * The 'warn' level code.
	 */
	public static var WARN:String = "warn" ;	

	/**
	 * @private
	 */
	private static var __ASPF__ = _global.ASSetPropFlags(NetServerLevel, null , 7, 7) ;

}
