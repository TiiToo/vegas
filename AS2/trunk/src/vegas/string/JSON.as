/*

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
		
		- Refactoring AS2 and MTASC Compatibilty by Alcaraz Marc (aka eKameleon) <vegas@ekameleon.net>, http://www.ekameleon.net/blog/

*/
 
/* ------ JSON

	AUTHOR
	
		Name : JSON
		Package : vegas.string
		Version : 1.0.0.0
		Date :  2006-01-24
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	Description 

		JSON (JavaScript Object Notation)
			
		serializer & deserializer in AS2 and
		
		MORE INFORMATION IN : http://www.crockford.com/JSON/index.html
	
	
	EXAMPLE

		import vegas.string.JSON ;
		
		// --- Init
		var o:Object = { prop1 : 1 , prop2 : 2 } ;
		var s:String = "coucou, coucou, label" ;
		var n:Number = 4 ;
		var b:Boolean = true ;
			
		trace ("*** Serialize") ;
			
		trace("* o : " + JSON.serialize( o ) )  ;
		trace("* s : " + JSON.serialize( s ) )  ;
		trace("* n : " + JSON.serialize( n ) )  ;
		trace("* b : " + JSON.serialize( b ) )  ;
			
		trace ("*** Deserialize") ;
		
		var source:String = '[ {"prop1":1, "prop2":2, "prop3":"hello", "prop4":true} , 2, true,	3, [3, 2] ]' ;
		
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
	
*/

import vegas.string.errors.JSONError;

class vegas.string.JSON {

	// ----o Constructor
	
	private function JSON() {
		//
	}

	// ----o Public Methods

	static public function serialize(o):String {
        var c, i, l:Number ;
		var s:String = '';
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
            return isFinite(o) ? String(o) : 'null';
        case 'string':
            l = o.length ;
            s = '"';
            for (i = 0; i < l; i += 1) {
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
                            c = c.charCodeAt();
                            s += '\\u00' + Math.floor(c / 16).toString(16) +
                                (c % 16).toString(16);
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

	static public function deserialize(source:String):Object {
        
		source = new String(source) ; // Speed
		var at:Number = 0 ;
        var ch:String = ' ';
		
        var error = function(m) {
            throw new JSONError( m, at - 1 , source) ;
        };
		
        var next = function() {
            ch = source.charAt(at);
            at += 1;
            return ch;
        };
		
        var white = function () {
            while (ch) {
                if (ch <= ' ') {
                    next();
                } else if (ch == '/') {
                    switch (next()) {
                        case '/':
                            while (next() && ch != '\n' && ch != '\r') {}
                            break;
                        case '*':
                            next();
                            for (;;) {
                                if (ch) {
                                    if (ch == '*') {
                                        if (next() == '/') {
                                            next();
                                            break;
                                        }
                                    } else {
                                        next();
                                    }
                                } else {
                                    error("Unterminated comment");
                                }
                            }
                            break;
                        default:
                            error("Syntax error");
                    }
                } else {
                    break;
                }
            }
        };
		
        var string = function () {
            var i, s = '', t, u;
			var outer:Boolean = false;
			
            if (ch == '"') {
				while (next()) {
                    if (ch == '"') {
                        next();
                        return s;
                    } else if (ch == '\\') {
                        switch (next()) {
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
                                t = parseInt(next(), 16);
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
            error("Bad string");
        };

        var array = function() {
            var a = [];

            if (ch == '[') {
                next();
                this.white();
                if (ch == ']') {
                    next();
                    return a;
                }
                while (ch) {
                    a.push(this.value());
                    this.white();
                    if (ch == ']') {
                        next();
                        return a;
                    } else if (ch != ',') {
                        break;
                    }
                    next();
                    this.white();
                }
            }
            error("Bad array");
        };

        var object = function () {
            var k, o = {};

            if (ch == '{') {
                next();
                this.white();
                if (ch == '}') {
                    next();
                    return o;
                }
                while (ch) {
                    k = this.string();
                    this.white();
                    if (ch != ':') {
                        break;
                    }
                    next();
                    o[k] = this.value();
                    this.white();
                    if (ch == '}') {
                        next();
                        return o;
                    } else if (ch != ',') {
                        break;
                    }
                    next();
                    this.white();
                }
            }
            error("Bad object") ;
        };

        var number = function () {
            var n = '', v;

            if (ch == '-') {
                n = '-';
                next();
            }
            while (ch >= '0' && ch <= '9') {
                n += ch;
                next();
            }
            if (ch == '.') {
                n += '.';
                while (next() && ch >= '0' && ch <= '9') {
                    n += ch;
                }
            }
            v = n;
            if (!isFinite(v)) {
                error("Bad number");
            } else {
                return v;
            }
        };

        var word = function () {
            switch (ch) {
                case 't':
                    if (next() == 'r' && next() == 'u' && next() == 'e') {
                        next();
                        return true;
                    }
                    break;
                case 'f':
                    if (next() == 'a' && next() == 'l' && next() == 's' &&
                            next() == 'e') {
                        next();
                        return false;
                    }
                    break;
                case 'n':
                    if (next() == 'u' && next() == 'l' && next() == 'l') {
                        next();
                        return null;
                    }
                    break;
            }
            error("Syntax error");
        };

        var value = function () {
            this.white();
            switch (ch) {
                case '{':
                    return this.object();
                case '[':
                    return this.array();
                case '"':
                    return this.string();
                case '-':
                    return this.number();
                default:
                    return ch >= '0' && ch <= '9' ? this.number() : this.word();
            }
        };

        return value();
		
    }
}
