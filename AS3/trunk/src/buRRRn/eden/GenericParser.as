
/*
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is [eden: ECMASCript data exchange notation for AS3]. 
  
  The Initial Developer of the Original Code is
  Zwetan Kjukov <zwetan@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2006-2007
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):
*/

package buRRRn.eden
    {
    
    /* Class: GenericParser
    */
    public class GenericParser
        {
        private var _source:String;
        public var  pos:uint;
        public var  ch:String;
        
        public static var verbose:Boolean = false;
        
        public function GenericParser( source:String )
            {
            _source = source;
            pos    = 0;
            ch     = "";
            }

        public function get source():String
            {
            return _source;
            }
        
        public function debug( str:String ):void
            {
            if( verbose )
                {
                trace( str );
                }
            }
        
        /* Method: getCharAt
        */
        public function getCharAt( pos:uint ):String
            {
            return source.charAt( pos );
            }
        
        /* Method: getChar
        */
        public function getChar():String
            {
            return source.charAt( pos );
            }
        
        /* Method: next
        */
        public function next():String
            {
            ch = getChar();
            pos++;
            debug( ch );
            return ch;
            }
        
        /* Method: hasMoreChar
        */
        public function hasMoreChar():Boolean
            {
            return pos <= (source.length-1);
            }
        
        /* Method: eval
           To override.
        */
        public function eval():*
            {
            return undefined;
            }
        
        /* Method: evaluate
           To override.
        */
        public static function evaluate( source:String ):*
            {
            var parser:GenericParser = new buRRRn.eden.GenericParser( source );
            return parser.eval();
            }
        
        /* Method: isAlpha
        */
        public static function isAlpha( c:String ):Boolean
            {
            return (("A" <= c) && (c <= "Z")) || (("a" <= c) && (c <= "z"));
            }
    
        /* Method: isASCII
        */
        public static function isASCII( c:String ):Boolean
            {
            return c.charCodeAt( 0 ) <= 255;
            }
        
        /* Method: isDigit
        */
        public static function isDigit( c:String ):Boolean
            {
            return ("0" <= c) && (c <= "9");
            }
        
        /* Method: isHexDigit
        */
        public static function isHexDigit( c:String ):Boolean
            {
            return isDigit( c ) || (("A" <= c) && (c <= "F")) || (("a" <= c) && (c <= "f"));
            }
        
        /* Method: isUnicode
        */
        public static function isUnicode( c:String ):Boolean
            {
            return c.charCodeAt( 0 ) > 255;
            }
        
        }
    
    }

