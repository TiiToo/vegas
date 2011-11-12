/*

  Version: MPL 1.1/GPL 2.0/LGPL 2.1
 
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is VEGAS Framework.
  
  The Initial Developer of the Original Code is 
  ALCARAZ Marc <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2011
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
  Alternatively, the contents of this file may be used under the terms of
  either the GNU General Public License Version 2 or later (the "GPL"), or
  the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
  in which case the provisions of the GPL or the LGPL are applicable instead
  of those above. If you wish to allow use of your version of this file only
  under the terms of either the GPL or the LGPL, and not to allow others to
  use your version of this file under the terms of the MPL, indicate your
  decision by deleting the provisions above and replace them with the notice
  and other provisions required by the LGPL or the GPL. If you do not delete
  the provisions above, a recipient may use your version of this file under
  the terms of any one of the MPL, the GPL or the LGPL.
  
*/

package vegas.strings 
{
    import core.strings.trim;
    
    import system.process.Runnable;
    
    /**
     * Provides a script to remove comments and unnecessary whitespaces from ECMAScript strings. You can use this class to minify .eden, .json, .js files.
     * <pre class="prettyprint">
     * import vegas.strings.Minifier ;
     * 
     * var input:String = "var a =       1 ; \r\n var b      = 2 ;  var c = 3    ;  " ;
     * 
     * var minifier:Minifier = new Minifier( input , Minifier.NORMAL ) ;
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
    public class Minifier implements Runnable
    {
        /**
         * Creates a new JSMinifier instance.
         * @param input The String source to minify.
         * @param level The level of compression :
         * <li>1 : minimal, keep linefeeds if single</li>
         * <li>2 : normal, the standard algorithm</li>
         * <li>3 : agressive, remove any linefeed and doesn't take care of potential missing semicolons (can be regressive)</li>
         */
        public function Minifier( input:String = "" , level:uint = 2 )
        {
            this.input = input ;
            this.level = level ;
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
         * The level of compression of the minifier.
         * <ul>
         * <li>1 : minimal, keep linefeeds if single</li>
         * <li>2 : normal, the standard algorithm</li>
         * <li>3 : agressive, remove any linefeed and doesn't take care of potential missing semicolons (can be regressive)</li>
         * </ul>
         */
        public function get level():uint
        {
            return _level ;
        }
        
        /**
         * @private
         */
        public function set level( value:uint ):void
        {
            _level = Math.max( Math.min( value , 3 ) , 1 ) ;
        }
        
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
            _input    = str || "" ;
            _newSize  = _input.length ;
            _oldSize  = _newSize ;
            _output   = _input ;
        }
        
        /**
         * Indicates the original size of the input source.
         */
        public function get oldSize():uint
        {
            return _oldSize ;
        }
        
        /**
         * The output result of the minifier process.
         */
        public function get output():String
        {
            return _output || "" ;
        }
        
        /**
         * Indicates the new size of the output source.
         */
        public function get newSize():uint
        {
            return _newSize ;
        }
        
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
                    this.level = uint( arguments[1] ) ;
                }
            }
            a            = ""  ;
            b            = ""  ;
            theLookahead = EOF ;
            i            =  0  ;
            _input       = trim(_input) ;
            l            = _input.length ;
            _oldSize     = l ;
            _output      = modify() ;
            _newSize     = _output.length ;
        }
        
        ///////////////////////////////////////////////////////////////
        
        private var a:String            ;
        private var b:String            ;
        private var theLookahead:String ;
        
        private var _input:String  ;
        private var _output:String ;
        
        private var _oldSize:uint ;
        private var _newSize:uint ;
        
        private var _level:uint ;
        
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
                            throw new SyntaxError( MinifierStrings.unterminatedStringLiteral + a ) ;
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
            
            if (b == '/' && '(,=:[!&|'.indexOf( a ) > -1 ) 
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
                        throw new SyntaxError( MinifierStrings.unterminatedRegularExpression ) ;
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
         * Indicates if the specified character is an alpha (A-Z or a-z) character.
         * @return <code class="prettyprint">true</code> if the specified character is an alpha (A-Z or a-z) character.
         */
        private function isAlpha( c:String ):Boolean
        {
            return c != EOF && ( ALNUM.indexOf(c) > -1 || c.charCodeAt(0) > 126 ) ;
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
                                    if (_level == 1 && b != '\n') 
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
                                if (_level == 1 && a != '\n') 
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
                                            if (_level == 3) 
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
                                        throw new SyntaxError( MinifierStrings.unterminatedComment ) ;
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
                                        throw new SyntaxError( MinifierStrings.unterminatedComment ) ;
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
