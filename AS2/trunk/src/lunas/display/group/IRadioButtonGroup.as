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
  Portions created by the Initial Developer are Copyright (C) 2004-2005
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

/**	IRadioButtonGroup [Interface]

	AUTHOR
		
		Name : IRadioButtonGroup
		Package : lunas.display.group
		Version : 1.0.0.0
		Date :  2006-02-08
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	METHOD SUMMARY
	
		- addButton(obj):Void
		
		- handleEvent(e:Event)
		
		- removeButton(obj):Void
		
		- selectedItemAt (id:Number, groupName:String, noEvent:Boolean):Void
		
		- setGroupName(name:String, obj):Void

		- unSelect(groupName:String):Void

**/

import vegas.events.EventListener;

interface lunas.display.group.IRadioButtonGroup extends EventListener {
	
	function addButton(obj):Void ;
	
	//function handleEvent(e:Event) ;
	
	function removeButton(obj):Void ;
	
	function selectedItemAt (id:Number, groupName:String, noEvent:Boolean):Void ;
	
	function setGroupName(name:String, obj):Void ;
	
	function unSelect(groupName:String):Void ;
	
}