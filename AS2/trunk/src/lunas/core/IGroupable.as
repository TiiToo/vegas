/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is LunAS Library.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

/**
 * This interface defines an object groupable in the application.
 * @author eKameleon
 */
interface lunas.core.IGroupable 
{

	/**
	 * Returns {@code true} if this object is grouped.
	 * @return {@code true} if this object is grouped.
	 */
	function getGroup():Boolean ; 
	
	/**
	 * Returns the name of the group of this object.
	 * @return the name of the group of this object.
	 */
	function getGroupName():String ; 

	/**
	 * Sets if the object is grouped or not.
	 */
	function setGroup(b:Boolean):Void ; 
	
	/**
	 * Sets the name of the group of this component.
	 * @param sName the name of the group or null to unregister the object.
	 */	
	function setGroupName(sName:String):Void ; 

}