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

/** AbstractTarget

	AUTHOR
	
		Name : AbstractTarget
		Package : vegas.logging
		Version : 1.0.0.0
		Date :  2006-08-31
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
	
*/

package vegas.logging
{

    import vegas.logging.errors.InvalidFilterError ;

    import vegas.events.AbstractCoreEventBroadcaster ;
    import vegas.util.StringUtil ;
    
    public class AbstractTarget extends AbstractCoreEventBroadcaster implements ITarget
    {
        
        // ----o Constructor
        
        public function AbstractTarget()
        {
            super();
        }
        
        // ----o Public Properties
        
        // FIXME : localization with error messages.
        
        static public var charsInvalid:String = "The following characters are not valid\: []~$^&\/(){}<>+\=_-`!@#%?,\:;'\\" ;
        static public var errorFilter:String = "Error for filter \''{0}'" ;
        static public var charPlacement:String = "'*' must be the right most character." ;
        
       	// ----o Public Methods
	    
	    /**
         * Insert a category in the fllters if this category don't exist.
         * Returns a boolean if the category is add in the list.
         */
        public function addCategory( category:String ):Boolean 
        {
	    	
		    if ( _filters.indexOf( category ) == -1 ) 
		    {
		        return false ;
		    }
    		
    		_filters.push( category ) ;
    		
    		return true ;
    		
	    }
	    
	    /**
	     * Sets up this target with the specified logger.
	     */
    	public function addLogger(logger:ILogger):void 
        {
            if ( logger != null )
            {
                _loggerCount++;
                
                logger.addEventListener(LogEvent.LOG, _logHandler);
            }
        }

        /**
         *  This method handles a <code>LogEvent</code> from an associated logger.
         *  A target uses this method to translate the event into the appropriate
         *  format for transmission, storage, or display.
         *  This method will be called only if the event's level is in range of the
         *  target's level.
         *
         *  <b><i>Descendants need to override this method to make it useful.</i></b>
         */		
		public function logEvent(event:LogEvent):void
        {
            // override please.
        }

        /**
         * Remove a category in the fllters if this category exist.
         * Returns a boolean if the category is remove.
         */
	    public function removeCategory( category:String ):Boolean
	    {
	        
	        var pos:Number = _filters.indexOf( category ) ;
    		if ( pos > -1) 
    		{
	    		_filters.splice(pos, 1) ;
		    	return true ;
    		}
    		else 
    		{
			    return false ;
    		}
	        
	    }

		/**
	     * Stops this target from receiving events from the specified logger.
	     */
    	public function removeLogger(logger:ILogger):void {
    	    
    	    if (logger != null)
            {
                _loggerCount--;
                logger.removeEventListener(LogEvent.LOG, _logHandler);
            }
            
    	}

        // ----o Virtual Properties
        
        public function get filters():Array
        {
            return _filters ;
        }

        public function set filters( value:Array ):void
        {
            if (value && value.length > 0)
            {
                var filter:String ;
                var index:int ;
                
                var len:uint = value.length ;
                for (var i:uint = 0; i<len; i++)
                {
                    filter = value[i] ;
                    // check for invalid characters
                    if ( Log.hasIllegalCharacters(filter) )
                    {
                         throw new InvalidFilterError( StringUtil.format(errorFilter, filter ) + charsInvalid );
                    }

                    index = filter.indexOf("*") ;
                    if ((index >= 0) && (index != (filter.length -1)))
                    {                        
                        throw new InvalidFilterError(StringUtil.format( errorFilter, filter) + charPlacement);
                    }
                }
            }
            else
            {
                // if null was specified then default to all
                value = ["*"];
            }

            if (_loggerCount > 0)
            {
                Log.removeTarget(this);
                _filters = value;
                Log.addTarget(this);
            }
            else
		    {
                _filters = value;
		    }
		    
        }
        
        public function get level():LogEventLevel
        {
            return _level ;
        }

        public function set level( value:LogEventLevel ):void
        {
            Log.removeTarget(this);
            _level = value;
            Log.addTarget(this);     
        }
        // ----o Private Properties
       
        /**
         * @private
         * Storage for the filters property.
         */
        private var _filters:Array = ["*"] ;

        /**
         * @private
         * Storage for the filters property.
         */
        private var _level:LogEventLevel = LogEventLevel.ALL ;

        /**
         * @private
         * Count of the number of loggers this target is listening to. 
         * When this value is zero changes to the filters property shouldn't do anything.
         */
        private var _loggerCount:uint = 0 ;
        
        // ----o Private Methods

        /**
         * @private
         * This method will call the <code>logEvent</code> method if the level of the
         * event is appropriate for the current level.
         */
        private function _logHandler( event:LogEvent ):void
        {
            if ( event.level.valueOf() >= level.valueOf() )
            {
                logEvent(event) ;
            }
        }
        
    }
}