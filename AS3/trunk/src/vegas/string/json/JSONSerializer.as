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
        
        - Alcaraz Marc (aka eKameleon) 2006-01-24 <vegas@ekameleon.net> 
        
            - Refactoring AS2 and MTASC Compatibilty 
            - AS3 version
            - SSAS version (for 'Flash Communication Server' and 'Flash Media Server')
            - Add Hexa Digits in 'deserialize' method
            - Supports in the objects deserialization the key property with quote, double quote or not surrounded by quotes.
            - Supports in string simple or double quotes.    
            
            More informations in the VEGAS page project : http://code.google.com/p/vegas/
            
            NOTE : eden Hexa digits code inspiration -> http://code.google.com/p/edenrr/

*/
package vegas.string.json 
{
    import system.ISerializer;
    
    import vegas.string.errors.JSONError;            

    /**
     * This class is the concrete class of the JSON singleton.
     * <code class="prettyprint">JSON</code> (JavaScript object Notation) is a lightweight data-interchange format.
     * <p>More information in the official site : <a href="http://www.JSON.org/">http://www.JSON.org</a></p>
     * <p>Add Hexa Digits tool in deserialize method - <a href="http://code.google.com/p/edenrr/">eden inspiration</a></p>
     * @example
     * <pre class="prettyprint">
     * import vegas.string.JSON;
     * import vegas.string.errors.JSONError;
     * 
     * import system.Reflection ;
     * 
     * // --- Init
     * 
     * var a:Array = [2, true, "hello"] ;
     * var o:Object = { prop1 : 1 , prop2 : 2 } ;
     * var s:String = "hello world" ;
     * var n:Number = 4 ;
     * var b:Boolean = true ;
     * 
     * trace("# Serialize \r") ;
     * 
     * trace("- a : " + JSON.serialize( a ) )  ;
     * trace("- o : " + JSON.serialize( o ) )  ;
     * trace("- s : " + JSON.serialize( s ) )  ;
     * trace("- n : " + JSON.serialize( n ) )  ;
     * trace("- b : " + JSON.serialize( b ) )  ;
     * 
     * trace ("\r# Deserialize \r") ;
     * 
     * var source:String = '[ { "prop1" : 0xFF0000 , prop2:2, prop3:"hello", prop4:true} , 2, true, 3, [3, 2] ]' ;
     * 
     * o = JSON.deserialize(source) ;
     * 
     * var l:uint = o.length ;
     * for (var i:uint = 0 ; i < l ; i++)
     * {
     *     trace("> " + i + " : " + o[i] + " -> typeof :: " + typeof(o[i])) ;
     *     if (typeof(o[i]) == "object")
     *     {
     *         for (var each:String in o[i])
     *         {
     *             trace("    > " + each + " : " + o[i][each] + " :: " + Reflection.getClassName(o[i][each]) ) ;
     *         }
     *     }
     * }
     * 
     * trace ("\r# JSONError \r") ;
     * 
     * source = "[3, 2," ; // test1
     * 
     * // var source:String = '{"prop1":coucou"}' ; // test2
     * 
     * try
     * {
     *    var errorObj:* = JSON.deserialize(source) ;
     * }
     * catch( e:JSONError )
     * {
     *     trace( e.toString() ) ;
     * }
     * </pre>
     */
    public class JSONSerializer implements ISerializer 
    {


        /**
         * Creates a new JSONSerializer instance.
         */
        public function JSONSerializer()
        {
            super() ;
        }
        
        /**
         * Indicates the indentor string representation.
         */        
        public function get indentor():String
        {
            return _indentor;
        }
        
        /**
         * @private
         */
        public function set indentor(value:String):void
        {
            _indentor = value;
        }        

        /**
         * Indicates the pretty indent value.
         */   
        public function get prettyIndent():int
        {
            return _prettyIndent;
        }        
        
        /**
         * @private
         */
        public function set prettyIndent(value:int):void
        {
        	 _prettyIndent = value ;
        }
        
        /**
         * Indicates the pretty printing flag value.
         */        
        public function get prettyPrinting():Boolean
        {
            return _prettyPrinting ;
        }        
        
        /**
         * @private
         */        
        public function set prettyPrinting(value:Boolean):void
        {
        	_prettyPrinting = value;
        }
        
        /**
         * Parse a string and interpret the source code to the correct object construct.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * "hello world" --> "hello world"
         * "0xFF"        --> 255
         * "{a:1,"b":2}" --> {a:1,b:2}
         * </pre>
         * @return a string representing the data.
         */ 
        public function deserialize( source:String ):*
        {
            var at:Number = 0 ;
            var ch:String = ' ' ;
        
            var _isDigit:Function ;
            var _isHexDigit:Function ;
            var _white:Function ;
            var _string:Function ;
            var _next:Function ;
            var _array:Function ;
            var _key:Function ;
            var _object:Function ;
            var _number:Function ;
            var _word:Function ;
            var _value:Function ;
            var _error:Function ;
        
            _isDigit = function( c:String ):* 
            {
                return( ("0" <= c) && (c <= "9") );
            } ;
            
            _isHexDigit = function( c:String ):* 
            {
                return( _isDigit( c ) || (("A" <= c) && (c <= "F")) || (("a" <= c) && (c <= "f")) );
            } ;
                
            _error = function(m:String):void 
            {
                throw new JSONError( m, at - 1 , source) ;
            } ;
        
            _next = function():* 
            {
                ch = source.charAt(at);
                at += 1;
                return ch;
            } ;
        
            _white = function ():void 
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
                            case '/' :
                            {
                                while (_next() && ch != '\n' && ch != '\r') {}
                                break;
                             }
                            case '*' :
                            {
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
                            }
                            default :
                            {
                                _error("Syntax Error");
                            }
                        }
                    } 
                    else 
                    {
                        break ;
                    }
                }
            } ;
        
            _string = function ():* 
            {
            
                var i:* = '' ;
                var s:* = '' ; 
                var t:* ;
                var u:* ;
                
                var outer:Boolean = false;
            
                if (ch == '"' || ch == "'" ) 
                {
                    var outerChar:String = ch ;
                    while (_next()) 
                    {
                        if (ch == outerChar) 
                        {
                            _next() ;
                            return s ;
                        }
                        else if (ch == '\\') 
                        {
                            switch (_next()) 
                            {
                                case 'b':
                                {
                                    s += '\b' ;
                                    break ;
                                }
                                case 'f' :
                                {
                                    s += '\f';
                                    break ;
                                }
                                case 'n':
                                {
                                    s += '\n';
                                    break ;
                                }
                                case 'r' :
                                {
                                    s += '\r';
                                    break ;
                                }
                                case 't' :
                                {
                                    s += '\t' ;
                                    break ;
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
    
                return null ;
    
            } ;
        
            _array = function():* 
            {
                var a:Array = [];
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
                return null ;
            } ;
        
            _key = function():*
            {
            
                var s:String = ch;
                var outer:Boolean = false;
        
                var semiColon:Number   = source.indexOf(':', at);
                var quoteIndex:Number  = source.indexOf('"', at) ;
                var squoteIndex:Number = source.indexOf("'", at) ;

                if( (quoteIndex <= semiColon && quoteIndex > -1) || (squoteIndex <= semiColon && squoteIndex > -1))
                {
                    s = _string() ;
                    _white() ;
                    if(ch == ':')
                    {
                        return s;
                    }
                    else
                    {
                        _error("Bad key");
                    }
                }
    
                while ( _next() ) // Use key handling 
                   {
                    if (ch == ':') 
                    {
                        return s;
                    } 
                    if(ch <= ' ')
                    {
                        //
                    }
                    else
                    {
                        s += ch;
                    }
                }
                
                _error("Bad key") ;
            
            } ;
        
            _object = function ():* 
            {
                var k:* = {} ;
                var o:* = {} ;
                if (ch == '{') 
                {
                
                    _next();
                    _white();
                
                    if (ch == '}') 
                    {
                        _next() ;
                        return o ;
                    }
                
                    while (ch) 
                    {
                        
                        k = _key() ;
                        
                        _white();
                        
                        if (ch != ':') 
                        {
                            break;
                        }
                        
                        _next();
                        
                        o[k] = _value() ;
    
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
        
            _number = function ():* 
            {
            
                var n:* = '' ;
                var v:* ;
                var hex:String = '' ;
                var sign:String = '' ;
            
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
                    n += ch ;
                    _next() ;
                }
    
                if (ch == '.') 
                {
                    n += '.';
                    while (_next() && ch >= '0' && ch <= '9') 
                    {
                        n += ch ;
                    }
                   }
    
                v = 1 * n ;
        
                if (!isFinite(v)) 
                {
                    _error("Bad Number");
                }
                else 
                {
                    return v ;
                }
            
                return NaN ;
            
            } ;
        
            _word = function ():* 
            {
                
                switch (ch) 
                {
                    
                    case 't' :
                    {
                        if (_next() == 'r' && _next() == 'u' && _next() == 'e') 
                        {
                            _next() ;
                            return true ;
                        }
                        break;
                     }
                    case 'f' :
                    {
                        if (_next() == 'a' && _next() == 'l' && _next() == 's' && _next() == 'e') 
                        {
                            _next() ;
                            return false ;
                        }
                        break;
                     }
                    case 'n':
                    {
                        if (_next() == 'u' && _next() == 'l' && _next() == 'l') 
                        {
                            _next() ;
                            return null ;
                        }
                        break;
                    }
                }
            
                _error("Syntax Error");
                
                return null ;
            
            };
        
            _value = function ():* 
            {
                _white() ;
                switch (ch) 
                {
                    case '{' :
                    {
                        return _object();
                    }
                    case '[' : 
                    {
                        return _array();
                    }
                    case '"' : 
                    case "'" :
                    {
                        return _string();
                    }
                    case '-' : 
                    {
                        return _number();
                    }
                    default  : 
                    {
                        return ( ch >= '0' && ch <= '9' ) ? _number() : _word() ;
                    }
                }
            } ;
        
            return _value() ;
        }
        
        /**
         * Serialize the specified value object passed-in argument.
         */          
        public function serialize( value:* ):String
        {
            var c:String ; // char
            var i:Number ;
            var l:Number ;
            var s:String = '' ;
            var v:* ;
            
            var tof:String = typeof(value) ;
            
            switch (tof) 
            {
            
                case 'object' :
                {
                    if (value)
                    {
                        if (value is Array) 
                        {
                        
                            l = (value as Array).length ;
                        
                            for (i = 0 ; i < l ; ++i) 
                            {
                                v = serialize(value[i]);
                                if (s) s += ',' ;
                                s += v ;
                            }
                            return '[' + s + ']';
                        
                        }
                        else if ( typeof( value.toString ) != 'undefined') 
                        {
                            
                            for (var prop:String in value) 
                            {
                                v = value[prop];
                                if ( (typeof(v) != 'undefined') && (typeof(v) != 'function') ) 
                                {
                                    v = serialize(v);
                                    if (s) 
                                    {
                                        s += ',' ;
                                    }
                                    s += serialize(prop) + ':' + v ;
                                }
                            }
                            return "{" + s + "}";
                        }
                    }
                    return 'null';
                }
            
                case 'number':
                {
                    return isFinite(value) ? String(value) : 'null' ;
                }
                
                case 'string' :
                {
                
                    l = (value as String).length ;
                    s = '"' ;
                    for (i = 0 ; i < l ; i += 1) 
                    {
                        c = (value as String).charAt(i) ;
                        if (c >= ' ') 
                        {
                            if (c == '\\' || c == '"') 
                            {
                                s += '\\';
                            }
                            s += c;
                        } 
                        else 
                        {
                            switch (c) 
                            {
                                
                                case '\b':
                                {
                                    s += '\\b';
                                    break ;
                                }
                                case '\f' :
                                {
                                    s += '\\f' ;
                                    break ;
                                }
                                case '\n' :
                                {
                                    s += '\\n' ;
                                    break ;
                                }
                                case '\r':
                                {
                                    s += '\\r' ;
                                    break ;
                                }
                                case '\t':
                                {
                                    s += '\\t' ;
                                    break ;
                                }
                                default:
                                {
                                    var code:Number = c.charCodeAt() ;
                                    s += '\\u00' + (Math.floor(code / 16).toString(16)) + ((code % 16).toString(16)) ;
                                }
                            }
                        }
                    }
                    return s + '"';
                }
                
                case 'boolean' :
                {
                    return String(value);
                }

                default :
                {
                    return 'null';
                }
            }
        }
                
        /**
         * @private
         */
        private var _prettyIndent:int = 0 ;
        
        /**
         * @private
         */
        private var _prettyPrinting:Boolean = false ;
        
        /**
         * @private
         */
        private var _indentor:String = "    " ;
       
    }
}
