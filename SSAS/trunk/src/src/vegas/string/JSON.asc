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
 * JSON (JavaScript object Notation) is a lightweight data-interchange format.
 * <p>Serializer & deserializer in AS2.</p>
 * <p>More information in the official site : <a href="http://www.JSON.org/">http://www.JSON.org</a></p>
 * <p>Add Hexa Digits tool in deserialize method - <a href="http://www.burrrn.com/projects/eden.html">EDEN inspiration</a></p>
 * <p><b>Example :</b></p>
 * {@code
 * JSON = vegas.string.JSON ;
 * 
 * // --- Init
 * 
 * var a = [2, true, "hello"] ;
 * var o = { prop1 : 1 , prop2 : 2 } ;
 * var s = "hello world" ;
 * var n = 4 ;
 * var b = true ;
 * 
 * trace("-> Serialize") ;
 * trace("- a : " + JSON.serialize( a ) )  ;
 * trace("- o : " + JSON.serialize( o ) )  ;
 * trace("- s : " + JSON.serialize( s ) )  ;
 * trace("- n : " + JSON.serialize( n ) )  ;
 * trace("- b : " + JSON.serialize( b ) )  ;
 * 
 * trace (" Deserialize") ;
 * 
 * var source = '[ {"prop1":0xFF0000, prop2:2, \'prop3\':"hello", prop4:true} , 2, true,3, [3, 2] ]' ;
 * 
 * var a = JSON.deserialize(source) ;
 * 
 * var o = a[0] ;
 * 
 * trace("a[0] : ") ;
 * trace(" - prop1 : " + o.prop1 + " -> typeof :: " + typeof(o.prop1)) ;
 * trace(" - prop2 : " + o.prop2 + " -> typeof :: " + typeof(o.prop2)) ;
 * trace(" - prop3 : " + o.prop3 + " -> typeof :: " + typeof(o.prop3)) ;
 * trace(" - prop4 : " + o.prop4 + " -> typeof :: " + typeof(o.prop4)) ;
 * 
 * trace("a[1] : " + a[1] ) ;
 * trace("a[2] : " + a[2] ) ;
 * trace("a[3] : " + a[3] ) ;
 * trace("a[4] : " + a[4] + " -> is Array :: " + (a[4] instanceof Array))   ;
 *  
 * trace ("*** JSONError") ;
 * 
 * var source = "[3, 2," ;
 * try
 * {
 *     var o = JSON.deserialize(source) ;
 * }
 * catch( e )
 * {
 *     trace(e.toString()) ; // ## JSONError : Bad Array, at:6 in "[3, 2," ##
 * }
 * }
 * @author eKameleon
 */
if (vegas.string.JSON == undefined) 
{
	
	/**
	 * @requires vegas.string.errors.JSONError
	 */
	require("vegas.string.errors.JSONError") ;
	
	/**
	 * Creates the JSON singleton reference.
	 */
	vegas.string.JSON = {}

	/**
	 * Deserialize the string source representation and return the result object.
	 */
	vegas.string.JSON.deserialize = function ( source ) 
	{
		
		source = new String(source) ; // Speed ;
		var at /*Number*/ = 0 ;
		var ch /*String*/ = ' ' ;
		
		var _isDigit, _isHexDigit, _white, _string, _next ;
		var _array, _object, _number, _word, _value, _error ;
		
		_isDigit = function( c /*Char*/ ) 
		{
    		return( ("0" <= c) && (c <= "9") );
    	} ;
			
		_isHexDigit = function( c /*Char*/  ) 
		{
    		return( _isDigit( c ) || (("A" <= c) && (c <= "F")) || (("a" <= c) && (c <= "f")) );
    	} ;
				
        _error = function( msg /*String*/ ) 
        {
        	trace(msg + " : " + (at - 1) + " : " + source) ;
            throw new vegas.string.errors.JSONError( msg, at - 1 , source) ;
        } ;
		
        _next = function() 
        {
            ch = source.charAt(at);
            at += 1;
            return ch;
        } ;
		
		
		_white = function () 
		{
           while (ch) 
           {
                if (ch <= ' ') 
                {
                    _next();
                }
                else if (ch == '/') 
                {
                    switch (_next()) 
                    {
                        
                        case '/':
                            while (_next() && ch != '\n' && ch != '\r') {}
                            break;
                        
                        case '*':
                        
                            _next();
                        
                            for (;;) 
                            {
                                if (ch) 
                                {
                                    if (ch == '*') 
                                    {
                                        if (_next() == '/') 
                                        {
                                            _next();
                                            break;
                                        }
                                    } 
                                    else 
                                    {
                                        _next();
                                    }
                                } 
                                else 
                                {
                                    _error("Unterminated Comment");
                                }
                            }
                            break;
                        
                        default:
                            _error("Syntax Error");
                    }
                } 
                else 
                {
                    break;
                }
            }
        } ;
		
        _string = function () 
        {
            var i, s = '', t, u;
			var outer /*Boolean*/ = false;
			if (ch == '"' || ch == "'") 
			{
				var outerChar = ch ;
				while (_next()) 
				{
                    if (ch == outerChar) 
                    {
                        _next();
                        return s;
                    }
                    else if (ch == '\\') 
                    {
                        switch ( _next() ) 
                        {
                        	case 'b' :
                        	{
                            	s += '\b' ;
                            	break ;
                        	}
                        	case 'f':
                        	{
                            	s += '\f' ;
                            	break ;
                        	}
                        	case 'n':
                        	{
                            	s += '\n' ;
                            	break ;
                        	}
                        	case 'r' :
                        	{
                            	s += '\r' ;
                            	break ;
                        	}
                       	 	case 't' :
                       	 	{
                            	s += '\t';
                            	break;
                       	 	}
                        	case 'u' :
                        	{
                            	u = 0;
                            	for (i = 0; i < 4; i += 1) 
                            	{
                                	t = parseInt(_next(), 16);
                                	if (!isFinite(t)) 
                                	{
	                                    outer = true;
										break;
                                	}
                                	u = u * 16 + t;
                            	}
								if(outer) 
								{
									outer = false;
									break;
								}
                            	s += String.fromCharCode(u);
                            	break;
                        	}
                        	default :
                        	{
                            	s += ch;
                        	}
                        }
                    } 
                    else 
                    {
                        s += ch;
                    }
                }
            }
            _error("Bad String");
        };
		
		_array = function() 
		{
            var a = [];
            if (ch == '[') 
            {
                _next();
                _white();
                if (ch == ']') 
                {
                    _next();
                    return a;
                }
                while (ch) 
                {
                    a.push(_value());
                    _white();
                    if (ch == ']') 
                    {
                        _next();
                        return a;
                    }
                    else if (ch != ',') 
                    {
                        break;
                    }
                    _next();
                    _white();
                }
            }
            _error("Bad Array");
        };
		
		_key = function()
		{
	    	var s = ch;
	    	var outer = false;
		
			var semiColon   = source.indexOf(':', at);
			var quoteIndex  = source.indexOf('"', at) ;
			var squoteIndex = source.indexOf("'", at) ;

			if( (quoteIndex <= semiColon && quoteIndex > -1) || (squoteIndex <= semiColon && squoteIndex > -1))
			{
				var s = _string();
				_white() ;
				if(ch == ':')
				{
					return s ;
				}
				else
				{
					_error("Bad key") ;
				}
			}
	
			while ( _next() ) //Use key handling 
     	  	{
            	if (ch == ':') 
            	{
                	return s;
            	} 
            	if(ch <= ' ')
            	{
				            	
				}
            	else
            	{
	            	s += ch;
            	}
	    	}
	    	
			_error("Bad key") ;
		
		} ;
		
        _object = function () 
        {
            var k, o = {} ;
            if (ch == '{') 
            {
                _next();
                _white();
                if (ch == '}') 
                {
                    _next();
                    return o;
                }
                while (ch) 
                {
                    
                    k = _key() ;
                    
                    _white() ;
                    
                    if (ch != ':') 
                    {
                        break;
                    }
                    
                    _next();
                    
                    o[k] = _value();
                    
                    _white();
                    
                    if (ch == '}') 
                    {
                        _next();
                        return o;
                    } 
                    else if (ch != ',') 
                    {
                        break;
                    }
                    _next();
                    _white();
                }
            }
            _error("Bad Object") ;
        };
		
        _number = function () {
            
            var n = '' ;
            var v    /*Number*/ ;
			var hex  /*String*/ = '' ;
			var sign /*String*/ = '' ;
			
            if (ch == '-') 
            {
                n = '-';
                sign = n ;
                _next();
            }
            
            if( ch == "0" ) 
            {
        		_next() ;
				if( ( ch == "x") || ( ch == "X") ) 
				{
            		_next();
            		while( _isHexDigit( ch ) ) 
            		{
                		hex += ch ;
                		_next();
                	}
            		if( hex == "" ) 
            		{   
            			_error("mal formed Hexadecimal") ;
					} 
					else 
					{
						return Number( sign + "0x" + hex ) ;
					}
            	} 
            	else 
            	{
	            	n += "0" ;
            	}
			}
				
            while ( _isDigit(ch) ) 
            {
                n += ch;
                _next();
            }
            
            if (ch == '.') 
            {
                n += '.';
                while (_next() && ch >= '0' && ch <= '9') 
                {
                    n += ch;
                }
            }
            
            v = 1 * n ;
            
            if (!isFinite(v)) 
            {
                _error("Bad Number");
            }
            else 
            {
                return v;
            }
            
        };
		
        _word = function () 
        {
            switch (ch) 
            {
                case 't':
                {
                    if (_next() == 'r' && _next() == 'u' && _next() == 'e') 
                    {
                        _next();
                        return true;
                    }
                    break;
                }
                case 'f':
                {
                    if (_next() == 'a' && _next() == 'l' && _next() == 's' && _next() == 'e') 
                    {
                        _next();
                        return false;
                    }
                    break;
                }
                case 'n':
                {
                    if (_next() == 'u' && _next() == 'l' && _next() == 'l') 
                    {
                        _next();
                        return null;
                    }
                    break;
                }
            }
            _error("Syntax Error");
        };
		
        _value = function () 
        {
            _white();
            switch (ch) 
            {
                case '{':
                    return _object();
                case '[':
                    return _array();
                case '"':
                    return _string();
                case '-':
                    return _number();
                default:
                    return ch >= '0' && ch <= '9' ? _number() : _word();
            }
        };
		
        return _value() ;
		
	}
	
	/**
	 * Serialize the object and return this string representation.
	 * @return the string serialize representation of an object.
	 */
	vegas.string.JSON.serialize = function (o) /*String*/ 
	{
		var JSON = vegas.string.JSON ;
        var c, i, l /*Number*/ ;
		var s /*String*/ = '' ;
		var v ;
        switch (typeof o) {
			case 'object':
				if (o) {
					if (o instanceof Array) {
						l = o.length ;
						for (i = 0 ; i < l ; ++i) {
							v = JSON.serialize(o[i]);
							if (s) s += ',' ;
							s += v ;
						}
						return '[' + s + ']';
					} else if (typeof o.toString != 'undefined') {
						for (i in o) {
							v = o[i];
							if (typeof v != 'undefined' && typeof v != 'function') {
								v = JSON.serialize(v);
								if (s) s += ',';
								s += JSON.serialize(i) + ':' + v ;
							}
						}
						return '{' + s + '}';
					}
				}
				return 'null';
			
			case 'number':
				return isFinite(o) ? String(o) : 'null' ;
			
			case 'string':
				l = o.length ;
				s = '"';
				for (i = 0 ; i < l ; i += 1) {
					c = o.charAt(i);
					if (c >= ' ') {
						if (c == '\\' || c == '"') {
							s += '\\';
						}
						s += c;
					} else {
						switch (c) {
							case '\b':
								s += '\\b';
								break;
							case '\f':
								s += '\\f';
								break;
							case '\n':
								s += '\\n';
								break;
							case '\r':
								s += '\\r';
								break;
							case '\t':
								s += '\\t';
								break;
							default:
								c = c.charCodeAt() ;
								s += '\\u00' + (Math.floor(c / 16).toString(16)) + ((c % 16).toString(16)) ;
						}
					}
				}
				return s + '"';
				
			case 'boolean':
				return String(o);
			
			default:
				return 'null';
			
        }
    }

}
