/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is AndromedAS Framework based on VEGAS.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package andromeda.process.mocks 
{
	import andromeda.process.Action;										

	/**
	 * This mock simulate a conctrete Action object who increments a static counter "COUNT" when the run method of all instance of this class are called.
	 * @author eKameleon
	 */
	public class MockAction extends Action 
	{
		
		/**
		 * Creates a new MockAction instance.
		 */
		public function MockAction()
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
		 * Notify all events to simulate the event flow of the object.
		 */
		public function notifyAll():void
		{
			notifyChanged() ;
			notifyCleared() ;
			notifyFinished() ;
			notifyInfo("hello world") ;
			notifyLooped() ;
			notifyProgress() ;
			notifyResumed() ;
			notifyStarted() ;
			notifyStopped() ;
			notifyTimeOut() ;
		}
		
		/**
		 * Run the process.
		 */
		public override function run(...arguments:Array):void
		{
			setRunning(true) ;
			notifyStarted() ;
			COUNT ++ ;	
			setRunning(false) ;
			notifyFinished() ;
		}
		
	}
}
