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

/** Log

	AUTHOR

		Name : Log
		Package : vegas.logging
		Version : 1.0.0.0
		Date : 2006-09-01
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

    This class is inspirate for the moment about mx.loggin.* package...

*/

// TODO refactoring all vegas.logging.* package with vegas tools (see AS2 implementation).

package vegas.logging
{

    import vegas.data.iterator.Iterator;
    import vegas.data.map.HashMap;
    import vegas.logging.errors.InvalidCategoryError;
    import vegas.util.StringUtil ;
    
    public class Log
    {
        
        // ----o Constructor
        
        public function Log()
        {
            // 
        }
        
        // ----o Public Properties
	
	    static public var DEFAULT_CATEGORY:String = "" ;
	    
    	static public var ILLEGALCHARACTERS:String = "[]~$^&/\\(){}<>+=`!#%?,:;'\"@" ;
    	
        static public var INVALID_CHARS:String = "Categories can not contain any of the following characters : []~$^&/\\(){}<>+=`!#%?,:;'\"@" ;
           
        static public var INVALID_LENGTH:String = "Categories must be at least one character in length." ;
        
    	static public var INVALID_TARGET:String = "Log, Invalid target specified." ;
    	
    	// ----o Public Methods
        
        /**
         *  Allows the specified target to begin receiving notification of log events.
         *
         *  @param The specific target that should capture log events.
         */
    	static public function addTarget(target:ITarget):void
        {
            
            if(target != null)
            {
                
                var filters:Array = target.filters ;
                var logger:ILogger ;

                var it:Iterator = _loggers.iterator() ;
                while (it.hasNext())
                {
                    var log:ILogger = it.next() as ILogger ;
                    var cat:String = it.key() ;
                    
                    if( categoryMatchInFilterList( cat, filters ) )
                    {
                        target.addLogger( log ); 
                    }
                    
                }
                
                _targets.push(target);
            
                if ( _targetLevel == NONE )
                {
                    _targetLevel = target.level.valueOf() ;
                }
                else if (target.level.valueOf() < _targetLevel)
                {
                    _targetLevel = target.level.valueOf() ;
                }
                
            }
            else
            {
                    throw new ArgumentError( INVALID_TARGET );
            }

        }
        
        /**
         *  This method removes all of the current loggers from the cache.
         *  Subsquent calls to the <code>getLogger()</code> method return new instances
         *  of loggers rather than any previous instances with the same category.
         *  This method is intended for use in debugging only.
         */
        static public function flush():void
        {
            _loggers.clear() ;
            _targets = [];
            _targetLevel = NONE ;
        }
        
        /**
         *  Returns the logger associated with the specified category.
         *  If the category given doesn't exist a new instance of a logger will be
         *  returned and associated with that category.
         *  Categories must be at least one character in length and may not contain
         *  any blanks or any of the following characters:
         *  []~$^&amp;\/(){}&lt;&gt;+=`!#%?,:;'"&#64;
         *  This method will throw an <code>InvalidCategoryError</code> if the
         *  category specified is malformed.
         *
         *  @param category The category of the logger that should be returned.
         *
         *  @return An instance of a logger object for the specified name.
         *  If the name doesn't exist, a new instance with the specified
         *  name is returned.
         */
        static public function getLogger( category:String ):ILogger
        {
            
            checkCategory(category) ;
            
            var result:ILogger = _loggers.get(category) ;
            
            if(result == null)
            {
                result = new LogLogger(category) ;
               
                _loggers.put(category, result) ;
                
            }
            
            var target:ITarget;
            
            var len:uint = _targets.length ;
            
            for(var i:int=0 ; i<len ; i++)
            {
                
                target = _targets[i] as ITarget ;
                
                if( categoryMatchInFilterList(category, target.filters) )
                {
                    target.addLogger(result);
                }
                
            } 

            return result ;
        
        }

        /**
         *  This method checks the specified string value for illegal characters.
         *
         *  @param value The String to check for illegal characters.
         *            The following characters are not valid:
         *                []~$^&amp;\/(){}&lt;&gt;+=`!#%?,:;'"&#64;
         *  @return   <code>true</code> if there are any illegal characters found,
         *            <code>false</code> otherwise
         */
        static public function hasIllegalCharacters( value:String ):Boolean
        {
            
            var chars:Array = ILLEGALCHARACTERS.split("") ;
            var result:Boolean = StringUtil.indexOfAny( value , chars ) != -1 ;
            return result ;
        
        }
        	
    	/**
    	 *  Indicates whether a debug level log event will be processed by a
    	 *  log target.
    	 *
    	 *  @return true if a debug level log event will be logged; otherwise false.
    	 */
    	static public function isDebug():Boolean
    	{
    	    return (_targetLevel <= LogEventLevel.DEBUG.valueOf()) ? true : false;
    	}
        
     	/**
    	 *  Indicates whether an error level log event will be processed by a
    	 *  log target.
    	 *
    	 *  @return true if an error level log event will be logged; otherwise false.
    	 */
    	static public function isError():Boolean
    	{
    	    return _targetLevel <= LogEventLevel.ERROR.valueOf() ;
    	}
        
     	/**
	     *  Indicates whether a fatal level log event will be processed by a
    	 *  log target.
    	 *
    	 *  @return true if a fatal level log event will be logged; otherwise false.
    	 */
    	static public function isFatal():Boolean
    	{
    	    return _targetLevel <= LogEventLevel.FATAL.valueOf() ;
    	}
        
     	/**
    	 *  Indicates whether an info level log event will be processed by a
    	 *  log target.
    	 *
    	 *  @return true if an info level log event will be logged; otherwise false.
    	 */	
    	static public function isInfo():Boolean
    	{
    	    return _targetLevel <= LogEventLevel.INFO.valueOf() ;
    	}
        	
    	/**
    	 *  Indicates whether a warn level log event will be processed by a
    	 *  log target.
    	 *
    	 *  @return true if a warn level log event will be logged; otherwise false.
    	 */
    	static public function isWarn():Boolean
    	{
    	    return _targetLevel <= LogEventLevel.WARN.valueOf() ;
    	}
        
        /**
         *  Stops the specified target from receiving notification of log events.
         *
         *  @param The specific target that should capture log events.
         */
        static public function removeTarget(target:ITarget):void
        {
            if(target)
            {
                var filters:Array = target.filters;
                var logger:ILogger;
            
                var it:Iterator = _loggers.iterator() ;
                while (it.hasNext())
                {
                   
                    var log:ILogger = it.next() as ILogger ;
                    var cat:String = it.key() ;
                    
                    if( categoryMatchInFilterList( cat, filters ) )
                    {
                    
                        target.removeLogger( log );
                        
                    }
                    
                }
                
                var len:uint = _targets.length ;
                
                for(var j:int = 0 ; j < len ; j++)
                {
                    if(target == _targets[j])
                    {
                        _targets.splice(j, 1);
                        j-- ;
                    }
                }
                
                resetTargetLevel() ;
            }
            else
            {
                throw new ArgumentError( INVALID_TARGET );
            }
        
        }
        
    	// ----o Private Properties
        
        /**
         *  @private
         *  An associative Array of existing loggers keyed by category
         */
    	static private var _loggers:HashMap = new HashMap() ;

        /**
         *  @private
         *  Sentinal value for the target log level to indicate no logging.
         */
    	static private var NONE:int = int.MAX_VALUE;
        
        /**
         *  @private
         *  The most verbose supported log level among registered targets.
         */
    	static private var _targetLevel:int = NONE ;
    	
        /**
         *  @private
         *  Array of targets that should be searched any time
      	 *  a new logger is created.
         */
        static private var _targets:Array = [];
        
        // ----o Private Methods
        
        /**
         *  This method checks that the specified category matches any of the filter
         *  expressions provided in the <code>filters</code> Array.
         *
         *  @param category The category to match against
         *  @param filters A list of Strings to check category against.
         *  @return <code>true</code> if the specified category matches any of the
         *            filter expressions found in the filters list, <code>false</code>
         *            otherwise.
         *  @private
         */
        static private function categoryMatchInFilterList(category:String, filters:Array):Boolean
        {
            
            var filter:String;
            var result:Boolean = false;
            var index:int = -1;
            var len:uint = filters.length ;
            
            for( var i:uint = 0; i<len ; i++)
            {
                filter = filters[i] ;
                
                index = filter.indexOf("*");

                if(index == 0)
                {
                    return true ;
                }

                index = (index < 0) ? index = category.length : index -1 ;

                if( category.substring(0, index) == filter.substring(0, index) )
                {
                    return true;
                }
            }
            return false ;
        }
        
        /**
         *  This method will ensure that a valid category string has been specified.
         *  If the category is not valid an <code>InvalidCategoryError</code> will be thrown.
         *  Categories can not contain any blanks or any of the following characters: []`*~,!#$%^&amp;()]{}+=\|'";?&gt;&lt;./&#64; 
         *  or be less than 1 character in length.
         * 
         *  @private
         */
        static private function checkCategory(category:String):void
        {
            
            if(category == null || category.length == 0)
            {
                throw new InvalidCategoryError( INVALID_LENGTH );
            }
            
            if( hasIllegalCharacters(category) || (category.indexOf("*") != -1))
            {
                throw new InvalidCategoryError( INVALID_CHARS ) ;
            }
            
        }
    
        /**
         *  This method resets the Log's target level to the most verbose log level
         *  for the currently registered targets.
         * 
         * @private
         */
        static private function resetTargetLevel():void
        {
            var minLevel:int = NONE;
            var len:uint = _targets.length ;
            for (var i:int = 0; i < len ; i++)
            {
                if (minLevel == NONE || _targets[i].level.valueOf() < minLevel) ;
                minLevel = _targets[i].level ;
            }
            _targetLevel = minLevel ;
        }
        

    }
    
}