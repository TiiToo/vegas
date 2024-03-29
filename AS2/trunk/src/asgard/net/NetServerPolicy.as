﻿ /*

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
 * The static enumeration class with all NetServer policy constants.
 * @author eKameleon
 */	
class asgard.net.NetServerPolicy extends Number 
{
	
	/**
	 * Creates a new NetServerPolicy instance.
	 */
	function NetServerPolicy( value:Number )
	{
		super( value ) ;
	}	
	
	/**
	 * Determinates if the NetServerConnection use an INFINITY policy.
	 */
	public static var INFINITY:NetServerPolicy = new NetServerPolicy(0) ;
	
	/**
	 * Determinates if the NetServerConnection use a LIMIT policy.
	 */
	public static var LIMIT:NetServerPolicy = new NetServerPolicy(1) ;

}