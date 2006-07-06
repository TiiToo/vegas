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

/** ISerializable [interface]

	AUTHOR
	
		Name : ISerializable
		Package : vegas.util
		Version : 1.0.0.0
		Date : 2005-12-19
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
	
	DESCRIPTION
	
		  Allows an object to control its own serialization.
	
	METHOD SUMMARY
	
		- toSource( [indent:Number], [indentor:String] ):String

			PARAMETERS
			
				- indent : optional the starting of the indenting
				- indentor : the string value used to do the indentation

			RETURN
			
				a string representing the source code of the object.

	NOTE
	
		To add a diffrent syntax formating it should be possible to add a 3rd *formater* argument
		and override the implementation of the method in all core objects.

	THANKS
	
		Zwetan : Core2 framework inspired by Mozilla SpiderMonkey.

**/

interface vegas.core.ISerializable {
	
	function toSource(indent:Number, indentor:String):String ;
	
}