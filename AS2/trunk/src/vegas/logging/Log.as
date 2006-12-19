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
  Portions created by the Initial Developer are Copyright (C) 2004-2007
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

import vegas.data.iterator.Iterator;
import vegas.data.map.HashMap;
import vegas.data.set.HashSet;
import vegas.errors.ArgumentsError;
import vegas.errors.Warning;
import vegas.logging.AbstractTarget;
import vegas.logging.errors.InvalidCategoryError;
import vegas.logging.ILogger;
import vegas.logging.ITarget;
import vegas.logging.LogEventLevel;
import vegas.logging.LogLogger;
import vegas.util.StringUtil;

// FIXME when the getLogger method is used after the declaration of the targets... the log event flow is failed.
// TODO Refactoring all the vegas.logging.* package !!!!  

/**
 * Provides psuedo-hierarchical logging capabilities with multiple format and output options.
 * @author eKameleon
 */
class vegas.logging.Log 
{

	/**
	 * const The default categoty of the {@code ILogger} instances returns with the {@code getLogger} method.
	 */
	static public var DEFAULT_CATEGORY:String = "" ;
	
	/**
	 * const The string representation of all the illegal characters.
	 */
	static public var ILLEGALCHARACTERS:String = "[]~$^&/\\(){}<>+=`!#%?,:;'\"@" ;

	/**
	 * The static field used when throws an Error when a character is invalid.
	 */     
	static public var INVALID_CHARS:String = "Categories can not contain any of the following characters : []~$^&/\\(){}<>+=`!#%?,:;'\"@" ;
      
	/**
	 * The static field used when throws an Error when the length of one character is invalid.
	 */     
    static public var INVALID_LENGTH:String = "Categories must be at least one character in length." ;

    /**
	 * The static field used when throws an Error when the specified target is invalid.
	 */     
    static public var INVALID_TARGET:String = "Log, Invalid target specified." ;

	/**
	 * The static field used when throws a Warning when the specified target is invalid.
	 */
	static public var REMOVE_TARGET_FAILED:String = "The target is invalid, isn't register for the moment, you can't remove it" ;

	/**
	 * Allows the specified target to begin receiving notification of log events.
	 * @param target specific target that should capture log events.
	 */
	static public function addTarget( target:ITarget ):Void 
	{
		
		if (target)
		{
			if (_targets.contains(target)) 
			{
				//throw new ArgumentsError( INVALID_TARGET );
			}
			else
			{
			
				var filters:Array = target["filters"] ;
				
				var logger:ILogger ;
				
				if (_loggers.size() > 0)
				{
				
					var it:Iterator = _loggers.iterator() ;
	           		
           			while ( it.hasNext() )
            		{
						
						var log:ILogger = ILogger( it.next() ) ;
						var cat:String = it.key() ;
						if( categoryMatchInFilterList( cat, filters ) )
						{
		                	target.addLogger( log ); 
						}
						
					}
				}
				
				return ;
				
				_targets.insert(target);
				
				if ( _targetLevel == NONE )
				{
					_targetLevel = AbstractTarget(target).level ;
				}	
				else if (AbstractTarget(target).level.valueOf() < _targetLevel)
				{
					_targetLevel = AbstractTarget(target).level ;
				}
			}
		}
		else
		{
			throw new ArgumentsError( INVALID_TARGET );
		}
	}

	/**
	 * This method removes all of the current loggers from the cache.
	 */
	static public function flush():Void 
	{
		_loggers.clear() ;
		_targets.clear() ;
		_targetLevel = NONE ;
	}
	
	/**
	 * Returns the logger associated with the specified category.
	 * If the category given doesn't exist a new instance of a logger will be returned and associated with that category. Categories must be at least one character in length and may not contain any blanks or any of the following characters: []~$^&\/(){}<>+=`!#%?,:;'"@
	 * @param The String to check for illegal characters. The following characters are not valid: []~$^&\/(){}<>+=`!#%?,:;'"@ 
	 * @return An instance of a logger object for the specified name. If the name doesn't exist, a new instance with the specified name is returned.
	 * @throws InvalidCategoryError if the category specified is malformed.
	 */
	static public function getLogger(category:String, isQueue:Boolean):ILogger 
	{
		
		checkCategory( category ) ;
		
		var logger:ILogger = _loggers.get( category ) ;
		
		if(logger == null)
		{
			logger = new LogLogger( category ) ;

			_loggers.put(category, logger) ;
		
			var target:ITarget;
			
			var it:Iterator = _targets.iterator() ;
			while(it.hasNext())
			{
				target = ITarget(it.next()) ;
				if( categoryMatchInFilterList( category, target["filters"] ) )
				{
					target.addLogger(logger);
				}
			} 
		}
		return logger ;
		
	}
		
	/**
	 * This method checks the specified string value for illegal characters.
	 * @param value The String to check for illegal characters. The following characters are not valid: []~$^&\/(){}<>+=`!#%?,:;'"@
	 * @return {code true} if there are any illegal characters found, false otherwise.
	 */
	static public function hasIllegalCharacters(value:String):Boolean 
	{
		return (new StringUtil(value)).indexOfAny( ILLEGALCHARACTERS.split("") ) != -1 ;
	}

  	/**
	 * Indicates whether a debug level log event will be processed by a log target.
	 * @return true if a debug level log event will be logged; otherwise false.
	 */
    static public function isDebug():Boolean
    {
        return _targetLevel <= LogEventLevel.DEBUG ;
    }
        
	/**
	 * Indicates whether an error level log event will be processed by a log target.
	 * @return true if an error level log event will be logged; otherwise false.
	 */
   	static public function isError():Boolean
   	{
   	    return _targetLevel <= LogEventLevel.ERROR ;
   	}
       
	/**
	 *  Indicates whether a fatal level log event will be processed by a log target.
	 *  @return true if a fatal level log event will be logged; otherwise false.
	 */
   	static public function isFatal():Boolean
   	{
   	    return _targetLevel <= LogEventLevel.FATAL ;
   	}
       
    	/**
	 * Indicates whether an info level log event will be processed by a log target.
	 * @return true if an info level log event will be logged; otherwise false.
	 */	
   	static public function isInfo():Boolean
   	{
   	    return _targetLevel <= LogEventLevel.INFO ;
   	}
       	
  	/**
	 * Indicates whether a warn level log event will be processed by a log target.
	 * @return true if a warn level log event will be logged; otherwise false.
	 */
    static public function isWarn():Boolean
    {
        return _targetLevel <= LogEventLevel.WARN ;
    }
	
	/**
	 * Stops the specified target from receiving notification of log events.
	 * @param specific target that should capture log events.
	 */
	static public function removeTarget(target:ITarget):Void 
	{
		if( target )
		{
			if ( _targets.contains(target) )
			{
			
				var filters:Array = AbstractTarget(target).filters ;
        		var logger:ILogger ;
				
				var it:Iterator = _loggers.iterator() ;
				while (it.hasNext())
				{
					
					var log:ILogger = ILogger( it.next() ) ;
					
					var cat:String = it.key() ;
					if( categoryMatchInFilterList( cat, filters ) )
					{
						target.removeLogger( log );
					}
				}
				_targets.remove(target) ;
        		
        		resetTargetLevel() ;
        		
			}
			else
			{
				throw new Warning( REMOVE_TARGET_FAILED ) ;	
			}
		}
		else
		{
			throw new ArgumentsError( INVALID_TARGET );
		}
	}
	
	/**
	 * Returns the number of ITargets in the internal Set of the Log singleton.
	 */
	static public function size():Number
	{
		return _targets.size() ;	
	}

	/**
	 * Returns the string representation of this instance.
	 * @return the string representation of this instance
	 */
	static public function toString():String 
	{
		return "[Log]" ;
	}

	/**
	 * The internal categories HashMap.
	 */
	static private var _categories:HashMap = new HashMap() ;

	/**
	 * The internal logger.
	 */
	static private var _loggers:HashMap = new HashMap() ;

	/**
	 * Sentinal value for the target log level to indicate no logging.
	 */
	static private var NONE:Number = Number.MAX_VALUE;
        
	/**
	 * The most verbose supported log level among registered targets.
	 */
    static private var _targetLevel:Number = Number.MAX_VALUE ;

	/**
	 *  Array of targets that should be searched any time a new logger is created.
	 */
	static private var _targets:HashSet = new HashSet() ;

	/**
	 * This method checks that the specified category matches any of the filter expressions provided in the <code>filters</code> Array.
	 * @param category The category to match against
	 * @param filters A list of Strings to check category against.
	 * @return <code>true</code> if the specified category matches any of the filter expressions found in the filters list, <code>false</code> otherwise.
	 */
	static private function categoryMatchInFilterList(category:String, filters:Array):Boolean
	{
		var filter:String;
		var result:Boolean = false;
		var index:Number = -1;
		var len:Number = filters.length ;
		for( var i:Number = 0; i<len ; i++)
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
	 */
    static private function checkCategory(category:String):Void
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
	 * This method resets the Log's target level to the most verbose log level for the currently registered targets.
 	 */
	static private function resetTargetLevel():Void
	{
		var minLevel:Number = NONE ;
		var it:Iterator = _targets.iterator() ;
		while(it.hasNext())
		{
			var next = it.next() ;
			if ( minLevel == NONE || next.level < minLevel ) 
			{
				minLevel = next.level ;
			}
		}
		_targetLevel = minLevel ;
	}

}