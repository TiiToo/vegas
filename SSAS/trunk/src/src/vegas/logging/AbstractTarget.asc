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
 * This class provides the basic functionality required by the logging framework for a target implementation. 
 * It handles the validation of filter expressions and provides a default level property. 
 * No implementation of the logEvent() method is provided.
 * @author eKameleon
 */
if (vegas.logging.AbstractTarget == undefined) 
{

	/**
	 * @requires vegas.logging.ITarget
	 */
	require("vegas.logging.ITarget") ;
	
	/**
	 * Creates a new AbstractTarget instance.
	 */
	vegas.logging.AbstractTarget = function () 
	{ 
		this._level   = vegas.logging.LogEventLevel.ALL ;
		this._filters = [ "*" ] ;
		this._set     = new vegas.data.set.HashSet() ;
	}

	/**
	 * @extends vegas.logging.ITarget
	 */
	proto = vegas.logging.AbstractTarget.extend( vegas.logging.ITarget ) ;

	// constants

	/**
	 * The static field used when throws an Error when a character is invalid.
	 */        
	vegas.logging.AbstractTarget.CHARS_INVALID /*String*/ = "The following characters are not valid : []~$^&/\\(){}<>+=`!#%?,:;'\"@" ;

	/**
	 * The static field used when throws an Error when filter failed.
	 */        
	vegas.logging.AbstractTarget.ERROR_FILTER /*String*/ = "Error for filter \''{0}'" ;
        
	/**
	 * The static field used when throws an Error when the character placement failed.
	 */        
	vegas.logging.AbstractTarget.CHAR_PLACEMENT /*String*/ = "'*' must be the right most character." ;

	// public

	/**
	 * Inserts a category in the fllters if this category don't exist.
	 * Returns a boolean if the category is add in the list.
	 */
	proto.addCategory = function( category /*String*/ ) /*Boolean*/ 
	{
		if ( this._filters.indexOf( category ) == -1 ) 
		{
			return false ;
		}
		this._filters.push( category ) ;
		return true ;
	}

	/**
	 * Sets up this target with the specified logger.
	 * Note : this method is called by the framework and should not be called by the developer.
	 */
	proto.addLogger = function ( logger /*ILogger*/ ) /*void*/ 
	{
		if ( ! this._set.contains(logger) )
		{
			this._set.insert( logger ) ;
			logger.addEventListener( vegas.logging.LogEvent.LOG , this) ;
		}
	}

	/**
	 * Add a new namespace in the filters array.
	 */
	proto.addNamespace = function ( namespace/*String*/) /*Boolean*/ 
	{
		if ( this.getFilters() == undefined ) 
		{
			this.getFilters() = [] ;
		}
		if ( this.filters.contains(namespace) ) 
		{
			return false ;
		}
		else
		{
			this.filters.push( namespace ) ;
			return true ;
		}
	}

	/**
	 * In addition to the level setting, filters are used to provide a pseudo hierarchical mapping for processing only those events for a given category.
	 */
	proto.getFilters = function() /*Array*/ 
	{
		return this._filters ;	
	}

	/**
	 * This method is called whenever an event occurs of the type for which the EventListener interface was registered.
	 */
	proto.handleEvent = function ( e /*Event*/ )
	{
		var LogEvent = vegas.logging.LogEvent ;
		var LogEventLevel = vegas.logging.LogEventLevel ;
		if ( e.level > this.level )
		{
			var category /*String*/ = e.getTarget().category ;
			if ( this._isValidCategory( category ) ) 
			{
				this.logEvent( e ) ;
			}
		}
	}
	
    /**
     *  This method handles a <code>LogEvent</code> from an associated logger.
     *  <p>A target uses this method to translate the event into the appropriate format for transmission, storage, or display.</p>
     *  <p>This method will be called only if the event's level is in range of the target's level.</p>
     *  <p><b><i>Descendants need to override this method to make it useful.</i></b></p>
     */		
	proto.logEvent = function (e /*LogEvent*/ )/*void*/ 
	{
		// overrides this method
	}


	/**
	 * Removes a category in the fllters if this category exist.
	 * Returns a boolean if the category is remove.
	 */
	proto.removeCategory = function( category /*String*/ ) /*Boolean*/
	{
		var pos /*Number*/ = this._filters.indexOf( category ) ;
		if ( pos > -1) 
		{
			this._filters.splice(pos, 1) ;
			return true ;
		}
		else 
		{
			return false ;
		}
	}

	/**
	 * Stops this target from receiving events from the specified logger.
	 * Note : this method is called by the framework and should not be called by the developer.
	 */
	proto.removeLogger = function ( logger /*ILogger*/ ) /*void*/ 
	{
		if ( this._set.contains(logger) )
		{
			this._set.remove( logger ) ;
			logger.removeEventListener( vegas.logging.LogEvent.LOG , this ) ;
		}
	}

	/**
	 * Removes an existing namespace in the filters array.
	 */
	proto.removeNamespace = function (namespace/*String*/)/*Boolean*/ 
	{
		var pos/*Number*/ = this.filters.indexOf(namespace) ;
		if ( pos > -1) 
		{
			this.filters.splice(pos, 1) ;
			return true ;
		}
		else 
		{
			return false ;
		}
	}

	/**
	 * Sets the filters array of this target.
	 * If you use this virtual property the target is register in the {@code Log} singleton automatically.
	 */
	proto.setFilters = function( value /*Array*/ ) /*void*/
	{
		
		var CHARS_INVALID      = vegas.logging.AbstractTarget.CHARS_INVALID ;
		var CHAR_PLACEMENT     = vegas.logging.AbstractTarget.CHAR_PLACEMENT ;
		var ERROR_FILTER       = vegas.logging.AbstractTarget.ERROR_FILTER ;
		var InvalidFilterError = vegas.logging.errors.InvalidFilterError ;
		var Log                = vegas.logging.Log ;
		
		if ( ! (value instanceof Array) || value == null ) 
		{
			value = ["*"] ; // if null was specified then default to all
		}
		else if ( value.length > 0 )
		{
			
			var filter /*String*/ ;
			var index  /*Number*/ ;
			var len    /*Number*/ = value.length ;
			
			for (var i /*Number*/= 0; i<len ; i++ )
			{
				
				filter = value[i] ;
				
				if ( Log.hasIllegalCharacters( filter ) ) // check for invalid characters
				{
					throw new InvalidFilterError( ERROR_FILTER.format(filter) + " " + CHARS_INVALID ) ;
				}
				
				index = filter.indexOf("*") ;
 				
 				if ((index >= 0) && (index != (filter.length -1)))
                {                        
					throw new InvalidFilterError( ERROR_FILTER.format( filter ) + " " + CHAR_PLACEMENT ) ;
				}
				
			}
		}
		else
		{
			value = ["*"] ; // if null was specified then default to all
		}

		if ( this._set.size() > 0 )
		{
			Log.removeTarget(this);
			this._filters = value;
			Log.addTarget(this);
		}
		else
		{
			this._filters = value;
		}
		
	}
	
	/**
	 * (read-write) In addition to the level setting, filters are used to provide a pseudo hierarchical mapping for processing only those events for a given category.
	 */
	proto.__defineGetter__("filters", proto.getFilters) ;
	proto.__defineSetter__("filters", proto.setFilters) ;

	// private

	/**
	 * Returns {@code true} is the passed argument is a valid category.
	 * @return {@code true} is the passed argument is a valid category.
	 */
	proto._isValidCategory = function (category /*String*/ ) /*Boolean*/ 
	{
		if ( category == vegas.logging.Log.DEFAULT_CATEGORY ) 
		{
			return true ;
		}
		var l /*Number*/ = this.filters.length ;
		var WildExp = vegas.string.WildExp ;
		if (l > 0) 
		{
			for (var i/*Number*/ = 0 ; i<l ; i++) 
			{
				var pattern/*String*/ = this.filters[i] ;
				var we /*WildExp*/ = new WildExp( pattern, WildExp.IGNORECASE | WildExp.MULTIWORD );
				var result = we.test( category ) ;
				if (result == true || pattern == category) 
				{
					return true ;
				}
			}
			return false ;
		} 
		else 
		{
			return true ;
		}
	}
	
	delete proto ;
	
}