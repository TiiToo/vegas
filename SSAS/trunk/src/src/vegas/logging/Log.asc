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

/**
 * Provides pseudo-hierarchical logging capabilities with multiple format and output options.
 * @author eKameleon
 */
if (vegas.logging._Log == undefined) 
{

	/**
	 * @requires vegas.logging.LogLogger
	 */	
	require("vegas.logging.LogLogger") ;

	/**
	 * Creates a new Log singleton.
	 */
	vegas.logging.Log = {}

	/**
	 * const The default categoty of the {@code ILogger} instances returns with the {@code getLogger} method.
	 */		
	vegas.logging.Log.DEFAULT_CATEGORY /*String*/ = "" ;

	/**
	 * const The string representation of all the illegal characters.
	 */
	vegas.logging.Log.ILLEGALCHARACTERS /*String*/ = "[]~$^&/\\(){}<>+=`!#%?,:;'\"@" ;

	/**
	 * The static field used when throws an Error when a character is invalid.
	 */     
	vegas.logging.Log.INVALID_CHARS /*String*/ = "Categories can not contain any of the following characters : []~$^&/\\(){}<>+=`!#%?,:;'\"@" ;
      
	/**
	 * The static field used when throws an Error when the length of one character is invalid.
	 */     
    vegas.logging.Log.INVALID_LENGTH /*String*/ = "Categories must be at least one character in length." ;

    /**
	 * The static field used when throws an Error when the specified target is invalid.
	 */     
    vegas.logging.Log.INVALID_TARGET /*String*/ = "Log, Invalid target specified." ;

	/**
	 * The static field used when throws a Warning when the specified target is invalid.
	 */
	vegas.logging.Log.REMOVE_TARGET_FAILED /*String*/ = "The target is invalid, isn't register for the moment, you can't remove it" ;	

	/**
	 * Allows the specified target to begin receiving notification of log events.
	 * @param target specific target that should capture log events.
	 */
	vegas.logging.Log.addTarget = function ( target ) /*void*/
	{
		if ( target != null || target instanceof vegas.logging.ITarget ) 
		{
			target.addLogger( vegas.logging.Log._logger ) ;
		}
		else
		{
			throw new vegas.errors.ArgumentsError( vegas.logging.Log.INVALID_TARGET ) ;
		}
	}
	
	/**
	 * This method will ensure that a valid category string has been specified.
	 * If the category is not valid an <code>InvalidCategoryError</code> will be thrown.
	 * Categories can not contain any blanks or any of the following characters: []`*~,!#$%^&amp;()]{}+=\|'";?&gt;&lt;./&#64; 
	 * or be less than 1 character in length.
	 */
    vegas.logging.Log.checkCategory = function (category /*String*/ ) /*void*/
	{
		if( category == null || category.length == 0)
		{
			throw new vegas.logging.errors.InvalidCategoryError( vegas.logging.Log.INVALID_LENGTH ) ;
		}
		if( vegas.logging.Log.hasIllegalCharacters(category) || (category.indexOf("*") != -1))
        {
        	throw new vegas.logging.errors.InvalidCategoryError( vegas.logging.Log.INVALID_CHARS ) ;
		}
	}
	
	/**
	 * This method removes all of the current loggers from the cache.
	 */
	vegas.logging.Log.flush = function () 
	{
		vegas.logging.Log._categories.clear() ;
	}

	/**
	 * Returns the logger associated with the specified category.
	 * If the category given doesn't exist a new instance of a logger will be returned and associated with that category. Categories must be at least one character in length and may not contain any blanks or any of the following characters: []~$^&\/(){}<>+=`!#%?,:;'"@
	 * @param The String to check for illegal characters. The following characters are not valid: []~$^&\/(){}<>+=`!#%?,:;'"@ 
	 * @return An instance of a logger object for the specified name. If the name doesn't exist, a new instance with the specified name is returned.
	 * @throws InvalidCategoryError if the category specified is malformed.
	 */
	vegas.logging.Log.getLogger = function( category /*String*/ , isQueue /*Boolean*/ ) 
	{
		vegas.logging.Log.checkCategory( category ) ;
		
		var categories /*HashMap*/ = vegas.logging.Log._categories ;
		
		if ( ! categories.containsKey(category) ) 
		{
			var logger /*LogLogger*/ = new vegas.logging.LogLogger( category ) ;
			logger.isQueue = isQueue || false ;
			logger.parent  = vegas.logging.Log._logger ; // Bubbling Event
			categories.put(category, logger) ;
			
		}
		return categories.get(category) ;
	}
	
	/**
	 * This method checks the specified string value for illegal characters.
	 * @param value The String to check for illegal characters. The following characters are not valid: []~$^&\/(){}<>+=`!#%?,:;'"@
	 * @return {@code true} if there are any illegal characters found, false otherwise.
	 */
	vegas.logging.Log.hasIllegalCharacters = function ( value /*String*/ ) /*Boolean*/  
	{
		if ( value == null ) 
		{
			return false ;
		}
		return value.indexOfAny( vegas.logging.Log.ILLEGALCHARACTERS.split("") ) != -1 ;
	}

	/**
	 * Stops the specified target from receiving notification of log events.
	 * @param specific target that should capture log events.
	 */
	vegas.logging.Log.removeTarget = function ( target )  
	{
		if( target != null )
		{
			target.removeLogger( vegas.logging.Log._logger ) ;
		}
		else
		{
			throw new vegas.errors.Warning( vegas.logging.Log.REMOVE_TARGET_FAILED ) ;						
		}
	}

	/**
	 * Returns the string representation of this instance.
	 * @return the string representation of this instance
	 */
	vegas.logging.Log.toString = function() 
	{
		return "[Log]" ;
	}

	/**
	 * The internal categories HashMap.
	 */
	vegas.logging.Log._categories /*HashMap*/ = new vegas.data.map.HashMap() ;

	/**
	 * The internal logger.
	 */
	vegas.logging.Log._logger /*LogLogger*/ = new vegas.logging.LogLogger() ;

	/**
	 * The most verbose supported log level among registered targets.
	 */
    vegas.logging.Log._targetLevel /*Number */= Number.MAX_VALUE ;

}