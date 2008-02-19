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
package lunas.display.button 
{
	import flash.display.DisplayObject;
	
	import lunas.core.AbstractButtonBuilder;	

	/**
	 * The IBuilder class of the AquaButton component.
	 * @author eKameleon
	 */
	public class AquaButtonBuilder extends AbstractButtonBuilder 
	{
		
		/**
		 * Creates a new AquaButtonBuilder instance.
		 * @param target the target of the component reference to build.
		 * @param bGlobal the flag to use a global event flow or a local event flow.
		 * @param sChannel the name of the global event flow if the <code>bGlobal</code> argument is <code>true</code>.
		 */
		public function AquaButtonBuilder(target:DisplayObject, bGlobal:Boolean = false, sChannel:String = null)
		{
			super( target, bGlobal, sChannel );
		}
		
	}
}
