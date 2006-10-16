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

/** LuminicTarget

	AUTHOR
	
		Name : LuminicTarget
		Package : vegas.logging.targets
		Version : 1.0.0.0
		Date :  2006-09-01
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
	
*/

// TODO : corriger les types de la sérialization (le problème reste que cette console est prévue à la base pour AS1/AS2)
// FIXME : Problème avec le logger ... boucle infinie dans l'événement StatusEvent !!!!

package vegas.logging.targets
{

    import flash.events.AsyncErrorEvent;
    import flash.events.SecurityErrorEvent;
    import flash.events.StatusEvent;
    import flash.net.LocalConnection;
	import flash.xml.XMLNode ;
	
    import vegas.logging.ILogger;
    import vegas.logging.Log;
    import vegas.logging.LogEvent;    
    import vegas.logging.LogEventLevel;
  
    import vegas.maths.Range;
    import vegas.util.ClassUtil ;

    public class LuminicTarget extends LineFormattedTarget
    {
        public function LuminicTarget( collapse:Boolean=true , depth:uint=4 )
        {
            super();
            
            _logger = Log.getLogger( ClassUtil.getPath(this) ) ;
            
            _lc = new LocalConnection() ;
    	    _lc.addEventListener ( AsyncErrorEvent.ASYNC_ERROR, _onAsyncError ) ;
    	    _lc.addEventListener ( StatusEvent.STATUS, _onStatus ) ;
    		_lc.addEventListener ( SecurityErrorEvent.SECURITY_ERROR , _onSecurityError ) ;    		

            isCollapse = collapse ;

    		_maxDepth = depth ;
	    	
        }

    	// ----o Public Properties
        
        static public const CONNECTION_ID:String = "_luminicbox_log_console" ;
        static public const DISPATCH_MESSAGE:String = "log" ;
        
	    public var isCollapse:Boolean ;
   
        // ----o Public Methods

        /**
         *  This method handles a <code>LogEvent</code> from an associated logger.
         *  A target uses this method to translate the event into the appropriate
         *  format for transmission, storage, or display.
         *  This method will be called only if the event's level is in range of the target's level.
         */		
		override public function logEvent(event:LogEvent):void
        {
           
            var message:* = event.message ;
            var level:String = LogEvent.getLevelString(event.level) ;
            var category:String = event.currentTarget.category ;
            var time:Date = new Date() ;

            var context:Object = {
			    loggerId     : null ,
    			levelName    : level ,
    			time : time
	    	} ;
	    	
		    if (isCollapse) 
		    {
			    context.argument = _serializeObj( message , 1) ;
		    } 
		    else 
		    {
			    var data:Object = {
                    type  : "string" ,
        	   		value : formatMessage( message, level, category, time)
                } ;
			    context.argument = data ;
		    }
		
		   _lc.send( CONNECTION_ID , DISPATCH_MESSAGE, context ) ;
        
        }

	    // ----o Virtual Properties
	    
	    public function get maxDepth():uint
	    {
	        return _maxDepth ;
	    }
	
        public function set maxDepth( value:uint ):void
        {
		    var r:Range = new Range(1, 255) ;
    		_maxDepth = r.clamp(value) ;
    	}
    	
        // ----o Private Properties
	
        private var _lc:LocalConnection ;
        private var _logger:ILogger ;
        private var _maxDepth:uint ;

    	// ----o Private Methods
    	
    	private function _getType(o:*):Object 
    	{
    		
    		var tof:String = typeof(o);

    		var type:* = new Object();

    		type.inspectable = true ;

    		type.name = tof ;

    		switch( tof ) 
    		{
    			case "string" :
    			case "boolean" :
    			case "number" :
    			case "undefined" :
    			case "null" :
    				type.inspectable = false ;
    				break ;
    			default :	
    				if(o is Date) 
    				{
	    				type.inspectable = false ;
        				type.name = "date" ;
    				}
    				else if(o is Array) 
    				{
    					type.name = "array" ;
    				}
    				else if(o is XML) 
    				{
    					type.name = "xml" ;
	    				type.stringify = true ;
    				}
    				else if(o is XMLNode) 
    				{
    					type.name = "xmlnode" ;
    					type.stringify = true ;
    				}

    		}
    		
    		return type ;
    	}
    	
    	private function _onAsyncError(e:AsyncErrorEvent):void
    	{
    	    _logger.info( "> " + this + " : " + e ) ;
    	}
    	
    	private function _onStatus( e:StatusEvent ):void
		{
			_logger.info( "> " + this + " : " + e ) ;
		}

		private function _onSecurityError( e:SecurityErrorEvent ):void
		{
		    
		    _logger.info( "> " + this + " : " + e ) ;
		    
		}

    	private function _serializeObj ( o:*, depth:Number) : Object 
    	{
		    
    		var type:* = _getType(o) ;

    		var serial:Object = {} ;
    		
       		if (!type.inspectable) 
    		{
    			
    			serial.value = o ;
    			
        	}
        	else if(type.stringify) 
        	{
    			
    			serial.value = o + "" ;
    			
    		}
    		else 
    		{
    			
    			if (depth <= _maxDepth) 	{
    				
    				if(type.name == "movieclip" || type.name == "button") 
    				{
    				    serial.id = o + "" ;
    				}
    				
    				var items:Array = [] ;

    				if(o is Array) 
    				{
    					var len:uint = o.length ;
    					for(var i:uint=0; i<len ; i++) 
    					{
    						items[i] = 
    						{
    							property : i ,
    							value : _serializeObj( o[i], (depth+1) )
    						} ;
    					}
    					
    				}
    				else 
    				{
    					for (var prop:String in o) 
    					{
    						items.push
    						( 
    						    {
    							    property : prop ,
        							value : _serializeObj( o[prop], (depth+1) )
    						    }
    						);
    					} 
    				}
    				
    				serial.value = items ;
    				
    			}
    			else 
    			{
    				
    				serial.reachLimit = true ;
    				
    			}
    		}
    		
    		serial.type = type.name ;
    		
    		return serial ;
    		
    	}
    	

        
    }
}