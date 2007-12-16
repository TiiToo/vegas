/*
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is eden: ECMAScript data exchange notation AS2. 
  
  The Initial Developer of the Original Code is
  Zwetan Kjukov <zwetan@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2006
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):
  
  	- Alcaraz Marc (aka eKameleon) <vegas@ekameleon.net> (2006)
	  Use this version only with Vegas AS3 Framework Please.

        PS : original code in buRRRn.eden.Application class.

*/

package vegas.string
{

    import vegas.string.eden.ECMAScript ;
    import vegas.string.eden.Config ;

	import vegas.util.ArrayUtil ;
	import vegas.util.Serializer ;
	import vegas.util.StringUtil ;	
    
	dynamic public class Eden
	{
		
		/**
		 * logs property.
		 */
		public static var logs:Array = [];
		
    	/**
		 * Allows to display messages in the console.
		 */
	    public static function _trace( message:String ):void
    	{
			trace( message );
        }
		
	    /**
		 * Add a message to the logs queue.
	      */
  		public static function log( message:String ):void
        {
        	logs.push( message );
			
	        if( Config.verbose )
            {
	            _trace( message );
            }
        }
    
	    /** 
	     * Display all the logs in the console.
	     */
	    public static function showLogs():void
    	{
    		var l:uint = logs.length ;
        	for( var i:uint=0; i<l ; i++ )
            {
	            _trace( logs[i] );
            }
        }
		
		/**
		 * StaticEvent: onParsed
		 * To override.
		 */
	    public static function onParsed( value:* ):*
        {
    	    return value;
        }
		
    	/**
		 * Dynamically interpret a source string.
		 * That's it, a small and fast ECMAScript parser.
		 */
		public static function deserialize( source:String="hello", scope:* = null, callback:* = null ):*
        {
	        return ECMAScript.evaluate( source, scope, callback ) ;
        }
		
    	/**
		 * Takes an object reference and serialize it as an ECMAScript string.
		 */
		public static function serialize( ...arguments:Array ):String
		{
			
            var indent:* ;
			
            var reference:* = arguments[0] ;
			
        	if( !Config.compress  )
            {
	            if( isNaN(arguments[1]) )
    	        {
        	        indent = 0;
                }
            }
			
         	/* global ??
			if( reference === _global )
			{
				return Serializer.globalToSource( indent );
			}
			*/
            
	        if( reference === undefined )
            {
    	        return Config.undefineable;
            }
			
        	if( reference === null )
            {
            	return "null";
            }
			
	        return Serializer.toSource( reference , indent ) ;
        }
		
    	/**
		 * addAuthorized
		 */
	    public static function addAuthorized( ...arguments:Array ):void
        {
			
    	    var l:uint = arguments.length ;
			
        	for( var i:Number = 0 ; i<l; i++ )
            {
            	if( ! ArrayUtil.contains( Config.authorized, arguments[i] ) )
                {
	                Config.authorized.push( arguments[i] );
                }
            }
        }
		
    	/**
		 * removeAuthorized
		 */
	    public static function removeAuthorized( ...arguments:Array ):void
        {
    	    var paths:* ;
    	    var i:uint ;
    	    var found:* ;
    	    
	        paths = [].concat(arguments) ;
			
        	var l:uint = paths.length ;
        	for( i=0; i < l ; i++ )
            {
	            found = Config.authorized.indexOf( paths[i] );
	            if( found > -1 )
                {
    	            Config.authorized.splice( found, 1 );
                }
            }
        }
		
        /**
		 * isAuthorized
		 */
	    public static function isAuthorized( path:String ):Boolean
        {
			
			
        	var strictMode:Boolean  = Config.strictMode ;
	        var pathMode:Boolean    = false ;
			
    	    var firstLetter:String = path.charAt( 0 ) ;
			
        	if( path.indexOf( "." ) > -1 )
            {
	            pathMode = true;
            }
			
	        if( !strictMode )
    		{
            	firstLetter = firstLetter.toLowerCase();
            }
			
	        var filterFirstLetter:Function = function( value:*, index:int, arrObj:* ):Boolean
            {
            
            	if( !strictMode )
                {
                	value = value.toLowerCase();
                }
           
	            return StringUtil.startsWith( value, firstLetter ) ;
            
            } ;
			
        	var whiteList:Array = Config.authorized.filter( filterFirstLetter ) ;
			
        	if( whiteList.length == 0 ) 
        	{
        		return false ;
        	}
			
	        var whiteListPath:String ;
        	var len:uint = whiteList.length ;
			
        	for( var i:uint = 0 ; i<len; i++ )
        	{
	            whiteListPath = whiteList[i];
            	
           		if( pathMode && StringUtil.endsWith( whiteListPath, "*" ) && StringUtil.startsWith( path, StringUtil.replace( whiteListPath, "*", "" ) ) )
	  		    {
                	return true;
	            }
    	        else if( path == StringUtil.replace( whiteListPath, ".*", "" ) )
            	{
                	return true;
	           	}
    	    }
			
        	return false ;
        	
        }
		
	}
	
}
