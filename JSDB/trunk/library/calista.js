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

try 
{

	var dummy = calista ;

} 
catch(e) 
{

	/**
	 * Defined NameSpaces.
	 */
	getNamespace("calista") ;
	getNamespace("calista.hash") ;
	getNamespace("calista.util") ;
	
	/**
	 * calista.hash
	 */
	require("calista.hash.MD5") ;
	require("calista.hash.SHA1") ;
	// require("calista.hash.TEA") ; // TODO TEA implementation.
	
	/**
	 * calista.util
	 */
	require("calista.util.Base64") ;
	require("calista.util.Base8") ;
	require("calista.util.LZW") ;

}