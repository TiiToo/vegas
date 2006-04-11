﻿/*

	Licence
	
		Copyright (c) 2005 JSON.org

		Permission is hereby granted, free of charge, to any person obtaining a copy
		of this software and associated documentation files (the "Software"), to deal
		in the Software without restriction, including without limitation the rights
		to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
		copies of the Software, and to permit persons to whom the Software is
		furnished to do so, subject to the following conditions:
	
		The Software shall be used for Good, not Evil.

		THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
		IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
		FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
		AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
		LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
		OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
		SOFTWARE.
	
	Contributor(s) :
	
		- Ported to Actionscript May 2005 by Trannie Carter <tranniec@designvox.com>, wwww.designvox.com
		
		- Refactoring AS2 and MTASC Compatibilty by Alcaraz Marc (aka eKameleon) <vegas@ekameleon.net>, http://www.ekameleon.net/blog/ - add hexa number parsing.

*/
 
/** JSON

	AUTHOR
	
		Name : JSON
		Package : vegas.string
		Version : 1.0.0.0
		Date :  2006-01-24
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	DESCRIPTION

		JSON (JavaScript object Notation) is a lightweight data-interchange format.
			
		Serializer & deserializer in AS2.
		
		MORE INFORMATION IN : http://www.json.org/
	
	
	METHOD SUMMARY
	
		- static deserialize(source:String):Object
		
		- static serialize(o):String
	
	EXAMPLE

		import vegas.string.JSON ;
		
		// --- Init
		var a:Array = [2, true, "hello"] ;
		var o:Object = { prop1 : 1 , prop2 : 2 } ;
		var s:String = "hello world" ;
		var n:Number = 4 ;
		var b:Boolean = true ;
			
		trace ("*** Serialize") ;
		trace("* a : " + JSON.serialize( a ) )  ;	
		trace("* o : " + JSON.serialize( o ) )  ;
		trace("* s : " + JSON.serialize( s ) )  ;
		trace("* n : " + JSON.serialize( n ) )  ;
		trace("* b : " + JSON.serialize( b ) )  ;
			
		trace ("*** Deserialize") ;
		
		var source:String = '[ {"prop1":0xFF0000, "prop2":2, "prop3":"hello", "prop4":true} , 2, true,	3, [3, 2] ]' ;
		
		var o = JSON.deserialize(source) ;
		for (var prop:String in o) {
			trace(prop + " : " + o[prop] + " -> typeof :: " + typeof(o[prop])) ;
		}
		
		trace ("*** JSONError") ;
		
		var source:String = "[3, 2," ; // test1
		//var source:String = '{"prop1":coucou"}' ; // test2
		var o = JSON.deserialize(source) ;
		for (var prop:String in o) {
			trace(prop + " : " + o[prop]) ;
		}
	
**/

import vegas.string.errors.JSONError;


class vegas.string.JSON {

	// ----o Constructor
	
	private function JSON() {
		//
	}

	// ----o Public Methods

	static public function deserialize(source:String):Object {
		
		source = new String(source) ; // Speed
		var at:Number = 0 ;
        var ch:String = ' ';
		
		// --- MTASC HACK
		var _isDigit:Function ;
		var _isHexDigit:Function ;
		var _white:Function ;
		var _string:Function ;
		var _next:Function ;
		var _array:Function ;
		var _object:Function ;
		var _number:Function ;
		var _word:Function ;
		var _value:Function ;
		var _error:Function ;
		
		_isDigit = function( /*Char*/ c:String ) {
    		return( ("0" <= c) && (c <= "9") );
    	} ;
			
		_isHexDigit = function( /*Char*/ c:String ) {
    		return( _isDigit( c ) || (("A" <= c) && (c <= "F")) || (("a" <= c) && (c <= "f")) );
    	} ;
				
        _error = function(m:String) {
            throw new JSONError( m, at - 1 , source) ;
        } ;
		
        _next = function() {
            ch = source.charAt(at);
            at += 1;
            return ch;
        } ;
		
        _white = function () {
           while (ch) {
                if (ch <= ' ') {
                    _next();
                } else if (ch == '/') {
                    switch (_next()) {
                        case '/':
                            while (_next() && ch != '\n' && ch != '\r') {}
                            break;
                        case '*':
                            _next();
                            for (;;) {
                                if (ch) {
                                    if (ch == '*') {
                                        if (_next() == '/') {
                                            _next();
                                            break;
                                        }
                                    } else {
                                        _next();
                                    }
                                } else {
                                    _error("Unterminated Comment");
                                }
                            }
                            break;
                        default:
                            _error("Syntax Error");
                    }
                } else {
                    break;
                }
            }
        };
		
        _string = function () {
            var i, s = '', t, u;
			var outer:Boolean = false;
			
            if (ch == '"') {
				while (_next()) {
                    if (ch == '"') {
                        _next();
                        return s;
                    } else if (ch == '\\') {
                        switch (_next()) {
                        case 'b':
                            s += '\b';
                            break;
                        case 'f':
                            s += '\f';
                            break;
                        case 'n':
                            s += '\n';
                            break;
                        case 'r':
                            s += '\r';
                            break;
                        case 't':
                            s += '\t';
                            break;
                        case 'u':
                            u = 0;
                            for (i = 0; i < 4; i += 1) {
                                t = parseInt(_next(), 16);
                                if (!isFinite(t)) {
                                    outer = true;
									break;
                                }
                                u = u * 16 + t;
                            }
							if(outer) {
								outer = false;
								break;
							}
                            s += String.fromCharCode(u);
                            break;
                        default:
                            s += ch;
                        }
                    } else {
                        s += ch;
                    }
                }
            }
            _error("Bad String");
        };
		
        _array = function() {
            var a = [];
            if (ch == '[') {
                _next();
                _white();
                if (ch == ']') {
                    _next();
                    return a;
                }
                while (ch) {
                    a.push(_value());
                    _white();
                    if (ch == ']') {
                        _next();
                        return a;
                    } else if (ch != ',') {
                        break;
                    }
                    _next();
                    _white();
                }
            }
            _error("Bad Array");
        };
		
        _object = function () {
            var k, o = {} ;
            if (ch == '{') {
                _next();
                _white();
                if (ch == '}') {
                    _next();
                    return o;
                }
                while (ch) {
                    k = _string();
                    _white();
                    if (ch != ':') {
                        break;
                    }
                    _next();
                    o[k] = _value();
                    _white();
                    if (ch == '}') {
                        _next();
                        return o;
                    } else if (ch != ',') {
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
            var v:Number ;
			var hex:String = '' ;
			var sign:String = '' ;
			
            if (ch == '-') {
                n = '-';
                sign = n ;
                _next();
            }
            
            if( ch == "0" ) {
        		_next() ;
				if( ( ch == "x") || ( ch == "X") ) {
            		_next();
            		while( _isHexDigit( ch ) ) {
                		hex += ch ;
                		_next();
                	}
            		if( hex == "" ) {   
            			_error("mal formed Hexadecimal") ;
					} else {
						return Number( sign + "0x" + hex ) ;
					}
            	} else {
	            	n += "0" ;
            	}
			}
				
            while ( _isDigit(ch) ) {
                n += ch;
                _next();
            }
            if (ch == '.') {
                n += '.';
                while (_next() && ch >= '0' && ch <= '9') {
                    n += ch;
                }
            }
            v = 1 * n ;
            if (!isFinite(v)) {
                _error("Bad Number");
            } else {
                return v;
            }
        };
		
        _word = function () {
            switch (ch) {
                case 't':
                    if (_next() == 'r' && _next() == 'u' && _next() == 'e') {
                        _next();
                        return true;
                    }
                    break;
                case 'f':
                    if (_next() == 'a' && _next() == 'l' && _next() == 's' && _next() == 'e') {
                        _next();
                        return false;
                    }
                    break;
                case 'n':
                    if (_next() == 'u' && _next() == 'l' && _next() == 'l') {
                        _next();
                        return null;
                    }
                    break;
            }
            _error("Syntax Error");
        };
		
        _value = function () {
            _white();
            switch (ch) {
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
	
	static public function serialize(o):String {
        var c, i, l:Number ;
		var s:String = '' ;
		var v ;
        switch (typeof o) {
			case 'object':
				if (o) {
					if (o instanceof Array) {
						l = o.length ;
						for (i = 0 ; i < l ; ++i) {
							v = serialize(o[i]);
							if (s) s += ',' ;
							s += v ;
						}
						return '[' + s + ']';
					} else if (typeof o.toString != 'undefined') {
						for (i in o) {
							v = o[i];
							if (typeof v != 'undefined' && typeof v != 'function') {
								v = serialize(v);
								if (s) s += ',';
								s += serialize(i) + ':' + v ;
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
