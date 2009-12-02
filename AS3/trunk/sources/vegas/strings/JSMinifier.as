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
  ALCARAZ Marc <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2010
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
  --------------------------------------------------------------
  
  This work is an adaptation of jsminc.c published by Douglas Crockford.
  
  Permission is hereby granted to use the ActionScript version under the same
  conditions as the jsmin.c on which it is based.
  
  jsmin.c 2008-08-03
  
  Copyright (c) 2002 Douglas Crockford  (www.crockford.com)
  
  Permission is hereby granted, free of charge, to any person obtaining a copy of
  this software and associated documentation files (the "Software"), to deal in
  the Software without restriction, including without limitation the rights to
  use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
  of the Software, and to permit persons to whom the Software is furnished to do
  so, subject to the following conditions:
  
  The above copyright notice and this permission notice shall be included in all
  copies or substantial portions of the Software.
  
  The Software shall be used for Good, not Evil.
  
  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  SOFTWARE.

*/

package vegas.strings 
{
    import system.process.Runnable;

    import vegas.strings.jsminifier.JSMinifierStrings;

    /**
     * Provides a script to remove comments and unnecessary whitespaces from JavaScript or basic ECMAScript files.
     * <pre class="prettyprint">
     * import vegas.strings.JSMinifier ;
     * 
     * var input:String = "var a =       1 ; \r\n var b      = 2 ;  var c = 3    ;  " ;
     * 
     * var minifier:JSMinifier = new JSMinifier( input , JSMinifier.NORMAL ) ;
     * 
     * minifier.run() ;
     * 
     * var output:String = minifier.output ; 
     * 
     * trace("old size : " + minifier.oldSize ) ;
     * trace("new size : " + minifier.newSize ) ;
     * trace("input    : " + minifier.input ) ;
     * trace("output   : " + output ) ;
     * </pre>
     */
    public class JSMinifier implements Runnable
    {
        /**
         * Creates a new JSMinifier instance.
         * @param input The String source to minify.
         * @param level The level of compression :
         * <li>1 : minimal, keep linefeeds if single</li>
         * <li>2 : normal, the standard algorithm</li>
         * <li>3 : agressive, remove any linefeed and doesn't take care of potential missing semicolons (can be regressive)</li>
         */
        public function JSMinifier( input:String = "" , level:uint = 2 )
        {
            this.input   = input ;
            this.level   = Math.max( Math.min( level, 3 ), 1 ) ;
        }
        
        /**
         * Original algorithm but keep linefeeds if single.
         */
        public static const MINIMAL:uint = 1 ;
        
        /**
         * Original algorithm (conservative).
         */
        public static const NORMAL:uint = 2 ;
        
        /**
         * Remove more linefeed than the original algorithm but can be regressive
         */
        public static const AGRESSIVE:uint = 3 ;
        
        /**
         * The level of compression.
         * <li>1 : minimal, keep linefeeds if single</li>
         * <li>2 : normal, the standard algorithm</li>
         * <li>3 : agressive, remove any linefeed and doesn't take care of potential missing semicolons (can be regressive)</li>
         */
        public var level:uint ;
        
        /**
         * The input String to minimize.
         */
        public function get input():String
        {
            return _input ;
        }
        
        /**
         * @private
         */
        public function set input( str:String ):void
        {
            _input = str || "" ;
            l        = _input.length ;
            newSize  = l ;
            oldSize  = l ;
        }
        
        /**
         * Store the original size of the input source.
         */
        public var oldSize:uint ;
        
        /**
         * The output result of the minifier process.
         */
        public function get output():String
        {
            return _output ;
        }
        
        /**
         * Store the new size of the output source.
         */
        public var newSize:uint ;
        
        /**
         * minify the javascript/ecmascript String input value.
         */
        public function run( ...arguments:Array ):void 
        {
            if( arguments.length > 0 )
            {
                if ( arguments[0] != null && arguments[0] is String )
                {
                    input = arguments[0] as String ;
                }
                if ( arguments[1] != null && arguments[1] is Number )
                {
                    level = new uint(arguments[1]) ;
                    level = Math.max( Math.min( level, 3 ), 1 ) ;
                }
            }
            a            = ""  ;
            b            = ""  ;
            theLookahead = EOF ;
            i            =  0  ;
            l            = _input.length ;
            newSize      = l ;
            oldSize      = l ;
            _output      = modify() ;
            newSize      = _output.length ;
        }
        
        private var a:String            ;
        private var b:String            ;
        private var theLookahead:String ;
        
        private var _input:String  ;
        private var _output:String ;
        
        private var i:int ;
        private var l:int ;
        
        private static const EOF:String     = "\uFFFC" ;
        private static const LETTERS:String = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz' ;
        private static const DIGITS:String  = '0123456789' ;
        private static const ALNUM:String   = LETTERS + DIGITS + '_$\\' ;
        
        /**
         * Do something! What you do is determined by the argument:
         * 1 : Output A. Copy B to A. Get the next B.
         * 2 : Copy B to A. Get the next B. (Delete A).
         * 3 : Get the next B. (Delete B).
         * action treats a string as a single character. Wow!
         * action recognizes a regular expression if it is preceded by ( or , or =.
         */
        protected function action( d:uint ):String
        {
            var r:Array = [] ;
            if (d == 1) 
            {
                r.push(a) ;
            }
            if (d < 3) 
            {
                a = b ;
                if (a == '\'' || a == '"') 
                {
                    for (;;) 
                    {
                        r.push(a);
                        a = get();
                        if (a == b) 
                        {
                            break;
                        }
                        if (a <= '\n') 
                        {
                            throw new SyntaxError( JSMinifierStrings.unterminatedStringLiteral + a ) ;
                        }
                        if (a == '\\') 
                        {
                            r.push(a);
                            a = get();
                        }
                    }
                }
            }
            
            b = next();
            
            if (b == '/' && has( '(,=:[!&|' , a ) ) 
            {
                r.push(a);
                r.push(b);
                for (;;) 
                {
                    a = get();
                    
                    if (a == '/') 
                    {
                        break;
                    } 
                    else if (a =='\\') 
                    {
                        r.push(a);
                        a = get();
                    }
                    else if (a <= '\n') 
                    {
                        throw new SyntaxError( JSMinifierStrings.unterminatedRegularExpression ) ;
                    }
                    r.push(a);
                }
                b = next();
            }
            return r.join("");
        }
        
        /**
         * Returns the next character. Watch out for lookahead. 
         * If the character is a control character, translate it to a space or linefeed.
         */
        private function get():String
        {
            var c:String = theLookahead ;
            if ( i == l ) 
            {
                return EOF ;
            }
            theLookahead = EOF ;
            if ( c == EOF ) 
            {
                c = _input.charAt( i ) ;
                ++i ;
            }
            if ( c >= ' ' ) 
            {
                return c ;
            }
            if ( isLineTerminator( c  ) ) 
            {
                return '\n' ;
            }
            return ' ' ;
        }
        
        /**
         * Indicates if the passed-in character is include in the specified source.
         * @return <code class="prettyprint">true</code> if the passed-in character is include in the specified source.
         */
        private function has( source:String , char:String ):Boolean
        {
            return source.indexOf(char) > -1;
        }
        
        /**
         * Indicates if the specified character is an alpha (A-Z or a-z) character.
         * @return <code class="prettyprint">true</code> if the specified character is an alpha (A-Z or a-z) character.
         */
        private function isAlpha( c:String ):Boolean
        {
            return c != EOF && ( has(ALNUM , c) || c.charCodeAt(0) > 126 ) ;
        }
        
        /**
         * Indicates if the specified character is a line terminator.
         * <p>Note: line terminators</p>
         * <pre class="prettyprint">
         * "\n" - u000A - LF
         * "\R" - u000D - CR
         * ???  - u2028 - LS
         * ???  - u2029 - PS
         * see: ECMA-262 spec 7.3 (PDF p24/188)
         * </p>
         */
        private function isLineTerminator( c:String ):Boolean
        {
            switch( c )
            {
                case "\u000A": 
                case "\u000D": 
                case "\u2028": 
                case "\u2029":
                {
                    return true;
                }
                default:
                {
                    return false;
                }
            }
        }
        
        /**
         * Copy the input to the output, deleting the characters which are insignificant to JavaScript.
         * Comments will be removed. Tabs will be replaced with spaces. 
         * Carriage returns will be replaced with linefeeds.
         * Most spaces and linefeeds will be removed.
         */
        private function modify():String
        {
            var r:Array = []  ;
            r.push( action(3) ) ;
            while ( a != EOF )  
            {
                switch (a) 
                {
                    case ' ':
                    {    
                        if (isAlpha(b)) 
                        {
                            r.push(action(1));
                        } 
                        else 
                        {
                            r.push(action(2));
                        }
                        break;
                    }
                    case '\n' :
                    {
                        switch (b) 
                        {
                            case '{':
                            case '[':
                            case '(':
                            case '+':
                            case '-':
                            {
                                r.push(action(1)) ;
                                break;
                            }
                            case ' ':
                            {
                                r.push(action(3)) ;
                                break;
                            }
                            default:
                            {
                                if ( isAlpha(b) ) 
                                {
                                    r.push( action(1) ) ;
                                } 
                                else 
                                {
                                    if (level == 1 && b != '\n') 
                                    {
                                        r.push(action(1));
                                    } 
                                    else 
                                    {
                                        r.push(action(2));
                                    }
                                }
                            }
                        }
                        break ;
                    }
                    default :
                    {
                        switch (b) 
                        {
                            case ' ':
                            {
                                if (isAlpha(a)) 
                                {
                                    r.push( action(1) ) ;
                                    break;
                                }
                                r.push(action(3));
                                break;
                            }
                            
                            case '\n' :
                            {
                                if (level == 1 && a != '\n') 
                                {
                                    r.push( action(1) ) ;
                                }
                                else 
                                {
                                    switch (a) 
                                    {
                                        case '}':
                                        case ']':
                                        case ')':
                                        case '+':
                                        case '-':
                                        case '"':
                                        case '\'':
                                        {
                                            if (level == 3) 
                                            {
                                                r.push( action(3) ) ;
                                            }
                                            else 
                                            {
                                                r.push( action(1) ) ;
                                            }
                                            break;
                                        }
                                        default:
                                        {
                                            if (isAlpha(a)) 
                                            {
                                                r.push( action(1) );
                                            } 
                                            else 
                                            {
                                                r.push( action(3) );
                                            }
                                        }
                                    }
                                }
                                break;
                            }
                            default :
                            {
                                r.push(action(1) ) ;
                                break;
                            }
                        }
                    }
                }
            }
            return r.join("");
        }
        
        /**
         * Returns the next character, excluding comments. 
         * peek() is used to see if a '/' is followed by a '/' or '*'.
         */
        private function next():String 
        {
            var c:* = get() ;
            if (c == '/') 
            {
                switch ( peek() ) 
                {
                    case '/' :
                    {
                        for (;;) 
                        {
                            c = get() ;
                            if ( c <= '\n' ) 
                            {
                                return c ;
                            }
                        }
                        break ;
                    }
                    case '*':
                    {
                        get();
                        if( peek() == '!' ) 
                        {
                            var d:String = '/*!' ;
                            for (;;) 
                            {
                                c = get() ;
                                switch ( c ) 
                                {
                                    case '*':
                                    {
                                        if (peek() == '/') 
                                        {
                                            get();
                                            return d + '*/' ;
                                        }
                                        break;
                                    }
                                    case EOF:
                                    {
                                        throw new SyntaxError( JSMinifierStrings.unterminatedComment ) ;
                                    }
                                    default:
                                    {
                                        d+=c ;
                                    }
                                }
                            }
                        } 
                        else 
                        {
                            for (;;) 
                            {
                                switch (get()) 
                                {
                                    case '*' :
                                    {
                                        if (peek() == '/') 
                                        {
                                            get() ;
                                            return ' ' ;
                                        }
                                        break;
                                    }
                                    case EOF :
                                    {
                                        throw new SyntaxError( JSMinifierStrings.unterminatedComment ) ;
                                    }
                                }
                            }
                        }
                        break;
                    }
                    default:
                    {
                        return c;
                    }
                }
            }
            return c ;
        }
        
        /**
         * Returns the next character without getting it.
         * @return the next character without getting it.
         */
        private function peek():String 
        {
            theLookahead = get();
            return theLookahead ;
        }
    }
}
