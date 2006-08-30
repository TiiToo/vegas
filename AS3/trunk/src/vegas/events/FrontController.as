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

/** FrontController

	AUTHOR
	
		Name : FrontController
		Package : vegas.events
		Version : 1.0.0.0
		Date :  2006-07-08
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	CONSTRUCTOR
	
		var oC:FrontController = new FrontController([oE:EventBroadcaster=null, name:String=null) ;

	METHOD SUMMARY
	
		- contains(eventName:String):Boolean
		
		- fireEvent(ev:Event):void

        - fireEventType( type:String ):void 
  		
		- getListener(eventName:String):EventListener 
		
		- insert(eventName:String, listener:EventListener):void
		
		- remove(eventName:String):void
	
	INHERIT
	
		CoreObject → FrontController
	
	IMPLEMENTS 

		IFormattable, IHashable, ISerializable

    EXAMPLE
    
        import flash.events.Event ;
    
        import vegas.events.Delegate ;
        import vegas.events.EventListener ;
        import vegas.events.FrontController ;
    
        public class MyMainClass 
        {
        
            function MyMainClass() 
            {
    
                trace("------- Test FrontController") ;
            
                var listener:EventListener = new Delegate(this, test) ;
            
                var controller:FrontController = new FrontController() ;
                controller.insert(Event.CHANGE, change) ; // with Function
                controller.insert(Event.INIT, listener) ; // with EventListener
            
                controller.fireEvent( new Event(Event.INIT ) ) ;
                controller.fireEventType( Event.CHANGE ) ;
            
                trace("---------") ;
            
            }

            public function change(e:Event):void {
            
                trace("change > " + e) ;
            
            }
        
            public function test( e:Event ):void {
            
                trace("test > " + e) ;
            
            }

        }
    
*/

package vegas.events
{
    
    import flash.events.Event ;
    
    import vegas.core.CoreObject;
    import vegas.data.map.ArrayMap;
    
    public class FrontController extends CoreObject
    {
        
        // ----o Constructor
        
        public function FrontController( oE:EventBroadcaster=null , name:String=null )
        {
		    _map = new ArrayMap() ;
		    if (name == null) 
		    {
			    name = EventBroadcaster.DEFAULT_DISPATCHER_NAME ;
		    }
    		_oE = (oE == null) ? EventBroadcaster.getInstance(name) : oE ; 
    		
    		initialize() ;
    		
        }
        
    	// ----o Public Methods 

    	/**
    	 * Returns 'true' if the eventName is registered in the FrontController.
    	 * @param eventName:String
    	 */
    	public function contains( eventName:String ):Boolean 
    	{
    		return _map.containsKey(eventName) ;	
    	}
    
    	/**
    	 * Dispatch an event into the FrontController
    	 * @param e:Event 
    	 */
    	public function fireEvent(e:Event):void 
    	{
  	        _oE.dispatchEvent(e) ;
    	}

    	/**
    	 * Dispatch a simple event into the FrontController with a specific type.
    	 * @param e:Event 
    	 */
    	public function fireEventType( type:String ):void 
    	{
  	        _oE.dispatchEvent( new Event(type) ) ;
    	}

    	/**
    	 * Returns a EventListener
    	 * @usage  myController.get( myEvent:String ) ;	
    	 * @param  eventName:String
    	 * @return an EventListener or a event callback Function.
    	 */
    	public function getListener(eventName:String):* {
    		return _map.get(eventName) ;
    	}
    
       	/**
    	 * Initialize all Commands - override this method.
    	 */
    	public function initialize():void
    	{
    		
    		// override this method.
    		
    	}
    	
    	/**
    	 * Add a new entry into the FrontController.
    	 * @param eventName:String
    	 * @param listener:EventListener or listener:Function
    	 */
    	public function insert(eventName:String, listener:*):void 
    	{
    		_map.put.apply( this, arguments ) ;
    		_oE.addListener(eventName, listener) ;
    	}
    	
    	/**
    	 * Remove an entry into the FrontController.
    	 * @param eventName:String
    	 * @return nothing
    	 */
    	public function remove(eventName:String):void
    	{
    		var listener:* = _map.remove( eventName ) ;
    		if (listener) 
    		{
    		    _oE.removeListener(eventName, listener);
    		}
    	}
    	
        // ----o Private Properties
        
       	private var _oE:EventBroadcaster ;
        private var _map:ArrayMap ;
        
    }
    
}