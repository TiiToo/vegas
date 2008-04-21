/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is Andromeda Framework based on VEGAS.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package andromeda.process.mocks 
{
	import andromeda.process.SimpleAction;				

	/**
	 * This mock simulate an IAction object who increments a static counter "COUNT" when the run method of all instance of this class are called.
	 * @author eKameleon
	 */
	public class MockSimpleAction extends SimpleAction 
	{
		
		/**
		 * Creates a new MockAction instance.
		 */
		public function MockSimpleAction()
		{
			super() ;
		}
		
		/**
		 * The counter of this class.
		 */
		public static var COUNT:uint = 0 ;
		
		/**
		 * Reset the static counter.
		 */
		public static function reset():void
		{
			COUNT = 0 ;	
		}
		
		/**
		 * Run the process.
		 */
		public override function run(...arguments:Array):void
		{
			notifyStarted() ;
			setRunning(true) ;
			COUNT ++ ;	
			setRunning(false) ;
			notifyFinished() ;
		}
		
	}
}
