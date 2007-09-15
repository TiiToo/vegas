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

*/

package vegas.string.eden
{
	
	/**
	 * GenericParser
	 */
	public class GenericParser
	{
		
		import vegas.string.Eden ;
		
		/**
		 * Creates a new GenericParser instance.
		 */
		public function GenericParser( source:String, callback:* )
        {
        	
        	if( callback == null )
            {
            	callback = Eden ;
            }
			
	        //delegates
    	    this.log = function( message:* ):void
            {
        	    callback.log( message );
            } ;
			
	        this.onParsed = function( value:* ):*
            {
    	        return callback.onParsed( value );
            } ;
			
        	this.isAuthorized = function( value:* ):*
            {
            	return callback.isAuthorized( value );
            } ;
			
	        this.addAuthorized = function( ...arguments:Array ):void
            {
    	        callback.addAuthorized.apply( callback, arguments );
            } ;
			
	        this.removeAuthorized = function( ...arguments:Array ):void
            {
    	       callback.removeAuthorized.apply( callback, arguments );
            } ;
			
        	this.source = source;
	        this.pos    = 0;
	        this.ch     = "";
	        
        }
		
        public var source:String;

	    public var pos:Number;

	    public var ch:String;
	    
	    public var log:Function;

	    public var onParsed:Function;

	  	public var isAuthorized:Function;

	    public var addAuthorized:Function;

	    public var removeAuthorized:Function;
		
	    /**
		 *Method: getCharAt
		 */
	    public function getCharAt( pos:int ):String
        {
    	    if( isNaN(pos) )
           	{
            	pos = this.pos;
            }
			
	        return source.charAt( pos );
        }
		
	    /**
	      * Method: getChar():String
		 */
    	public function getChar():String
        {
    	    return source.charAt( pos );
        }
		
	    /**
	      * Method: next():String
		 */
	    public function next():String
        {
    	    ch = getChar();
	        pos++;
	        return ch;
        }
		
	    /**
	      * Method: hasMoreChar():Boolean
		 */
	    public function hasMoreChar():Boolean
        {
    	    return( pos <= (source.length-1) );
        }
		
	    /**
	      * eval( ...arguments:Array ):*
	      * override this method.
		 */
    	public function eval( ...arguments:Array ):*
        {
        	return null ;
        }
		
	    /**
		 * @static evaluate( source:String, callback:* ):*
		 * To override.
		 */
	    static public function evaluate( source:String, callback:* ):*
        {
    	    var parser:GenericParser = new GenericParser( source, callback );
	        return parser.eval();
        }
	    
	    /**
		 * isAlpha(c:String):Boolean
		 */
	    public function isAlpha( /*char*/ c:String ):Boolean
        {
    	    return ( (("A" <= c) && (c <= "Z")) || (("a" <= c) && (c <= "z")) ) ;
        }
		
	    /**
		 * isASCII(c:String):Boolean
		 */
	    public function isASCII( /*char*/ c:String ):Boolean
        {
        	return ( c.charCodeAt( 0 ) <= 255 ) ;
    	}
		
	    /**
		 * isDigit(c:String):Boolean
		 */
	    public function isDigit( /*char*/ c:String ):Boolean
        {
	        return ( ("0" <= c) && (c <= "9") ) ;
        }
		
	    /**
		 * isHexDigit(c:String):Boolean
		 */
    	public function isHexDigit( /*char*/ c:String ):Boolean
        {
        	return ( isDigit( c ) || (("A" <= c) && (c <= "F")) || (("a" <= c) && (c <= "f")) ) ;
        }
		
	    /**
		 * isOctalDigit(c:String):Boolean
		 */
    	public function isOctalDigit( /*char*/ c:String ):Boolean
        {
        	return ( ("0" <= c) && (c <= "7") ) ;
        }
		
		/**
		 * isUnicode(c:String):Boolean
		 */
    	public function isUnicode( /*char*/ c:String ):Boolean
        {
	        return ( c.charCodeAt( 0 ) > 255 ) ;
        }
		
	}
	
}