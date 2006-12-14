/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is Vegas Library.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2007
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

/** Builder [Interface]

	AUTHOR

		Name : Builder
		Package : lunas.display.components
		Version : 1.0.0.0
		Date :  2006-01-04
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net


	METHOD SUMMARY
	
		- clear():Void
		
		- getTarget():MovieClip
		
		- run():Void
		
		- setTarget(t:MovieClip):Void
		
		- update():Void

	INHERIT
	
		IRunnable

**/

import vegas.core.IRunnable;

interface lunas.display.components.IBuilder extends IRunnable {

	function clear():Void ;
	
	function getTarget():MovieClip ;
	
	function setTarget(t:MovieClip):Void ;
	
	function update():Void ;
	
}