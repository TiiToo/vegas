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

package pegas.process
{
		
	import pegas.events.ActionEvent;
	
	import vegas.events.AbstractCoreEventBroadcaster;

    /**
     * @author eKameleon
     */ 
	public class AbstractAction extends AbstractCoreEventBroadcaster implements IAction
	{
		
		/**
		 * Creates a new AbstractAction instance.
		 */
		public function AbstractAction()
		{
			//
		}

		public var looping:Boolean ;
	
		public function get running():Boolean 
		{
			return getRunning() ;	
		}
	
		public function clone():*
		{
			return new AbstractAction() ;
		}

		public function getRunning():Boolean 
		{
			return _isRunning ;	
		}

		public function notifyFinished():void 
		{
			var eFinish:ActionEvent = new ActionEvent(ActionEvent.FINISH) ;
			dispatchEvent(eFinish) ;
		}
	
		public function notifyStarted():void
		{
			var eStart:ActionEvent = new ActionEvent(ActionEvent.START) ;
			dispatchEvent( eStart ) ;
		}
		
		protected function notifyChanged():void 
		{
			var eChange:ActionEvent = new ActionEvent(ActionEvent.CHANGE) ;
			dispatchEvent(eChange) ;
		}

		protected function notifyCleared():void 
		{
			var eClear:ActionEvent = new ActionEvent(ActionEvent.CLEAR) ;
			dispatchEvent(eClear) ;
		}	
	
		protected function notifyInfo( oInfo:* ):void
		{
			var eInfo:ActionEvent = new ActionEvent(ActionEvent.INFO, oInfo) ;
			dispatchEvent(eInfo) ;
		}
	
		protected function notifyLooped():void 
		{
			var eLoop:ActionEvent = new ActionEvent(ActionEvent.LOOP) ;
			dispatchEvent(eLoop) ;
		}

		protected function notifyProgress():void
		{
			var eProgress:ActionEvent = new ActionEvent(ActionEvent.PROGRESS) ;
			dispatchEvent(eProgress) ;
		}
	
		protected function notifyResumed():void
		{
			var eResume:ActionEvent = new ActionEvent(ActionEvent.RESUME) ;
			dispatchEvent(eResume) ;
		}
	
		protected function notifyStopped():void
		{
			var eStop:ActionEvent = new ActionEvent(ActionEvent.STOP) ;
			dispatchEvent(eStop) ;
		}

		protected function notifyTimeOut():void
		{
			var eTimeOut:ActionEvent = new ActionEvent(ActionEvent.TIMEOUT) ;
			dispatchEvent(eTimeOut) ;
		}
		
		public function run(...arguments):void 
		{
		// 
		}

		protected function setRunning(b:Boolean):void
		{
			_isRunning = b ;	
		}

		private var _isRunning:Boolean ;

	}

}