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
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2010
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

package vegas.media.subtitles
{
    import core.chars.isDigit;
    import core.strings.lineTerminatorChars;
    import core.strings.trim;
    
    import system.text.parser.GenericParser;
    
    /**
     * Parses a specific string (SRT subtitle format) and creates an Array of Caption objects.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import vegas.media.subtitles.SRTParser ;
     * 
     * var source:String  = "1\r" ;
     *               srt += "00:00:20,000 --> 00:00:24,400\r" ;
     *               srt += "You can use a SRTParser instance\r" ;
     *               srt += "to eval your external subtitles files.\r" ;
     *               srt += "\n" ; 
     *               srt += "2\r" ; 
     *               srt += "00:00:24,600 --> 00:00:27,800\r" ; 
     *               srt += "You must use the Array of Caption objects.\r" ;
     *               srt += "\n" ; 
     *               srt += "3\r" ; 
     *               srt += "00:00:30,600 --> 00:00:35,200\r" ; 
     *               srt += "You can creates your custom subtitle engine now." ;
     *  
     *  var parser:SRTParser = new SRTParser(srt) ;
     *  
     *  var captions:Array   = parser.eval() ;
     *  
     *  trace( " captions:" + captions ) ;
     * </pre>
     */
    public class SRTParser extends GenericParser
    {
        /**
         * Creates a new SRTParser instance.
         * @param source The string expression to parse.
         */
        public function SRTParser( source:String = null )
        {
            super( source ) ;
        }
        
        /**
         * @private
         */
        public function set source( expression:String ):void
        {
            _source = expression ;
        }
        
        /**
         * Evaluates the String source and return a list of SRT captions.
         */
        public function eval():Vector.<Caption>
        {
            if ( _source == null && _source.length == 0 )
            {
                return null ;
            }
            var caption:Caption ;
            var captions:Vector.<Caption> = new Vector.<Caption>() ;
            _count = 0 ;
            _index = 0 ;
            while( hasMoreChar() )
            {
                if ( _index > 0 && _count == _index )
                {
                    caption = new Caption( {id:_index} ) ;
                    if( _scanTimeRange( caption ) )
                    {
                        _scanText( caption ) ;
                        captions.push( caption ) ;
                        _index ++ ;
                    }
                }
                else
                {
                    _scanIndex() ;
                }
            }
            return ( (captions != null) || (captions.length > 0) ) ? captions : null ;
        }
        
        /**
         * @private
         */
        private var _count:uint ;
        
        /**
         * @private
         */
        private var _index:int ;
        
        /**
         * Indicates if the passed-in character is a line terminator.
         */
        private function _isLineTerminator( c:String ):Boolean
        {
            return lineTerminatorChars.indexOf( c ) > -1 ;
        }
        
        /**
         * Indicates if the parser find the next index.
         */
        private function _scanIndex():void
        {
            next() ;
            
            var value:String = "" ;
            
            while( isDigit( ch ) )
            {
                value += ch ;
                next() ;
            }
            
            var result:Number = Number(value) ;
            
            if( isNaN( result ) || !_isLineTerminator(ch) )
            {
                return ;
            }
            
            if ( _index == 0 && result > 0 )
            {
                _index = result ;
            }
            
            if(  _index == result && _isLineTerminator(ch) )
            {
                _count = _index ;
            }
        }
        
        /**
         * Indicates if the parser find the next range expression.
         */
        private function _scanText( caption:Caption ):void
        {
            var text:String = "" ;
            while( hasMoreChar() )
            {
                next() ;
                if( _isLineTerminator(ch) && _isLineTerminator(getCharAt(pos+1) ) )
                {
                    break ;
                }
                else
                {
                    text += ch ;
                }
            }
            text = text.split("\n").join("") ; // filter and remove the \n characters in the text to fix CRLF problems.
            caption.text = trim(text) ;
        }
        
        /**
         * Indicates if the parser find the next range expression.
         */
        private function _scanTimeRange( caption:Caption ):Boolean
        {
            var line:String = "" ;
            
            next() ;
            
            while( !_isLineTerminator( ch ) )
            {
                line += ch;
                next() ;
            }
            
            var range:Array = line.split(/[ ]+-->[ ]+/gm) ;
            
            if ( range.length == 2 )
            {
                caption.start = _toSeconds(range[0]);
                caption.end   = _toSeconds(range[1]);
                return true ;
            }
            else
            {
                return false ;
            }
        }
        
        /**
         * Converts a String expression to seconds, with these formats supported :
         * <ul>
         * <li>hh:mm:ss,000<li>
         * <li>hh:mm:ss.000</li>
         * <li>hh:mm.ss</li>
         * <li>1.0s</li>
         * <li>1.0m</li>
         * <li>1.0h</li>
         * </ul>
         */
        private function _toSeconds( str:String ):Number
        {
            var sec:Number = 0;
            var suffix:String = str.substr(-1) ;
            switch( suffix )
            {
                case "s" :
                {
                    sec = Number(str.substr(0, str.length - 1)) ;
                    break ;
                }
                case "m" :
                {
                    sec = Number(str.substr(0, str.length - 1)) * 60 ;
                    break ;
                }
                case "h" :
                {
                    sec = Number(str.substr(0, str.length - 1)) * 3600 ;
                    break ;
                }
                default :
                {
                    var a:Array = str.split(':') ;
                    if ( a.length > 1 )
                    {
                        if ( a[2] && String(a[2] ).indexOf(',') != -1)
                        {
                            a[2] = String(a[2]).replace(/\,/, ".") ;
                        }
                        sec  = Number(a[ a.length - 1 ]) ;
                        sec += Number(a[ a.length - 2 ]) * 60 ;
                        if ( a.length == 3 )
                        {
                            sec += Number(a[a.length - 3]) * 3600 ;
                        }
                    }
                    else
                    {
                        sec = Number(str) ;
                    }
                }
            }
            return sec;
        }
    }
}
