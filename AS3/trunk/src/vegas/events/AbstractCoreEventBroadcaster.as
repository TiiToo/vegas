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

/* AbstractCoreEventBroadcaster

	AUTHOR
	
		Name : AbstractCoreEventBroadcaster
		Package : vegas.events
		Version : 1.0.0.0
		Date :  2006-07-08
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	CONSTRUCTOR
	
		new AbstractCoreEventBroadcaster() ;

	METHOD SUMMARY
	
        - addEventListener(type:String, listener:*, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void

        - dispatchEvent(event:Event):Boolean
        
        - getEventBroadcaster():EventBroadcaster
        
        - hasEventListener(type:String):Boolean 
        
        - hashCode():uint
        
        - initEventDispatcher():EventBroadcaster
        
            override this method to change the internal EventBroadcaster !
        
        - removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void
        
        - toSource(...arguments):String
        
        - toString():String
        
        - willTrigger(type:String):Boolean 
        
	INHERIT
	
		CoreObject → AbstractCoreEventBroadcaster

	IMPLEMENTS 
	
		IEventBroadcaster, IEventDispatcher, IFormattable, IHashable, ISerializable

**/


package vegas.events
{
    import flash.events.Event;

    import vegas.core.CoreObject;
    import vegas.util.ClassUtil ;

    public class AbstractCoreEventBroadcaster extends CoreObject implements IEventBroadcaster
    {
        // ----o Constructor
    
        public function AbstractCoreEventBroadcaster() {
        
            super() ;
    		_oED = initEventDispatcher() ;
    		
        }
        
        // ----o Public Methods
        
        public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0.0, useWeakReference:Boolean=false):void
        {
            _oED.addEventListener(type, listener, useCapture, priority, useWeakReference) ;
        }
        
        public function addListener(type:String, listener:*, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
        {
            _oED.addListener(type, listener, useCapture, priority, useWeakReference) ;
        }
 
        public function dispatchEvent( event:Event ):Boolean
        {
            return _oED.dispatchEvent(event) ;
        }
 
     	public function getEventBroadcaster():EventBroadcaster {
	    	return _oED ;
	    }
 
        public function hasEventListener(type:String):Boolean
        {
            return _oED.hasEventListener(type) ;
        }
        
       	public function initEventDispatcher():EventBroadcaster {
		    return new EventBroadcaster( this ) ;
	    }

        public function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void
        {
            _oED.removeEventListener(type, listener, useCapture) ;
        } 

        public function removeListener(type:String, listener:*, useCapture:Boolean=false):void
        {
            _oED.removeListener(type, listener, useCapture) ;
        }

        public function willTrigger(type:String):Boolean
        {
            return _oED.willTrigger(type) ;
        }
        
        override public function toSource( ...arguments:Array ):String
        {
            return "new " + ClassUtil.getPath(this) + "()" ;
        }
	
	    // ----o Private Properties

    	private var _oED:EventBroadcaster ;  
    	
    }
}