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
package vegas.events
{
	import flash.events.Event;
	
	import vegas.core.CoreObject;
	import vegas.util.ClassUtil;
	
	public class AbstractCoreEventDispatcher extends CoreObject implements IEventDispatcher
    {

        public function AbstractCoreEventDispatcher() 
        {
        
            super() ;
    		_dispatcher = initEventDispatcher() ;
    		
        }
        
        public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0.0, useWeakReference:Boolean=false):void
        {
            _dispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference) ;
        }
        
        public function dispatchEvent( event:Event ):Boolean
        {
            return _dispatcher.dispatchEvent(event) ;
        }
 
     	public function getEventBroadcaster():EventDispatcher 
     	{
	    	return _dispatcher ;
	    }
 
        public function hasEventListener(type:String):Boolean
        {
            return _dispatcher.hasEventListener(type) ;
        }
        
       	public function initEventDispatcher():EventDispatcher 
       	{
		    return new EventDispatcher( this ) ;
	    }

        public function registerEventListener(type:String, listener:*, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
        {
            _dispatcher.registerEventListener(type, listener, useCapture, priority, useWeakReference) ;
        }

        public function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void
        {
            _dispatcher.removeEventListener(type, listener, useCapture) ;
        } 


        public function willTrigger(type:String):Boolean
        {
            return _dispatcher.willTrigger(type) ;
        }
        
        override public function toSource( ...arguments:Array ):String
        {
            return "new " + ClassUtil.getPath(this) + "()" ;
        }

        public function unregisterEventListener(type:String, listener:*, useCapture:Boolean=false):void
        {
            _dispatcher.unregisterEventListener(type, listener, useCapture) ;
        }
	
    	private var _dispatcher:EventDispatcher ;  
    	
    }
}