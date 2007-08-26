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
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package pegas.events
{
	
	import flash.events.Event;

    /**
     * @author eKameleon
     */
	public class ActionEvent extends Event
	{
		
		/**
		 * Creates a new ActionEvent instance.
		 */
		public function ActionEvent( type:String , info:* = null , bubbles:Boolean = false , cancelable:Boolean = false )
		{
			super(type, bubbles, cancelable);
			_oInfo = info ;
		}

		static public const CHANGE:String = "onChanged" ;
		
		static public const CLEAR:String = "onCleared" ;
		
		static public const FINISH:String = "onFinished" ;
		
		static public const INFO:String = "onInfo" ;
		
		static public const LOOP:String = "onLooped" ;
		
		static public const PROGRESS:String = "onProgress" ;
		
		static public const RESUME:String = "onResumed" ;
		
		static public const START:String = "onStarted" ;
		
		static public const STOP:String = "onStopped" ;	
		
		static public const TIMEOUT:String = "onTimeOut" ;
		
		override public function clone():Event 
		{
			return new ActionEvent(type, getInfo()) ;
		}
		
		public function getInfo():* 
		{
			return _oInfo ;
		}
		
		public function setInfo( oInfo:* ):void 
		{
			_oInfo = oInfo ;	
		}
		
		private var _oInfo:* ;
		
	}
}