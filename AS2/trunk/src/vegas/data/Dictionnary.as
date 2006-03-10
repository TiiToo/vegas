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

/* ------- 	Dictionnary [Interface]

	AUTHOR

		Name : Dictionnary
		Package : vegas.data
		Version : 1.0.0.0
		Date :  2005-04-24
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	METHODS
	
		- getKeys():Enumeration
		
		- getValueAt(key)
		
		- getValues():Enumeration
		
		- isEmpty():Boolean
		
		- put( key, value)
		
		- remove(key)
		
		- size():Number

----------  */

import vegas.data.Enumeration;

interface vegas.data.Dictionnary {
		
	function getKeys():Enumeration ;

	function get(key) ;

	function getValues():Enumeration ;

	function isEmpty():Boolean ;
	
	function put( key , value ) ;
	
	function remove(key) ;

	function size():Number ;
	
}