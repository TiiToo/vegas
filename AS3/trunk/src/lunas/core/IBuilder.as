﻿/*

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
package lunas.core 
{
	import flash.display.DisplayObject;
	
	import vegas.core.IRunnable;	

	/**
	 * The IBuilder interface.
	 * @author eKameleon
	 */
	public interface IBuilder extends IRunnable 
	{
		
		/**
		 * Indicates the target reference of the component.
		 */
		function get target():DisplayObject
		function set target( target:DisplayObject ):void ;		
		
		/**
		 * Clear the view of the component.
	 	 */
		function clear():void ;

		/**
		 * Update the view of the component.
		 */
		function update():void ;
		
	}

}
