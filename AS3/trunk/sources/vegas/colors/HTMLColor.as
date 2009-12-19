/*

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


package vegas.colors
{
    import graphics.colors.RGBA;
    
    /**
     * Enumeration static class to defined Basic HTML data types.
     * <p>Read the about it the <a href="http://www.w3.org/TR/html4/types.html">W3C HTML 4 Specifications</a> (chap 6.5)</p>
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import vegas.colors.HTMLColor ;
     * 
     * var n:Number = HTMLColor.htmlToNumber( "#FF0000" ) ;
     * trace("convert #FF0000 : "  + n) ;
     * 
     * var c:HTMLColor = HTMLColor.YELLOW ;
     * trace("c.toString()     : " + c.toString() ) ;
     * 
     * trace("c.toString(true) : " + c.toString(true) ) ;
     * trace("c.valueOf()      : " + c.valueOf() ) ;
     * 
     * var htmlCode:String = HTMLColor.hexToHtml( 0xFF0000 ) ;
     * 
     * trace("convert 0xFF0000 : "  + htmlCode) ;
     * 
     * // output:
     * // convert #FF0000 : 16711680
     * // c.toString()     : Yellow
     * // c.toString(true) : [RGBA r:255 g:255 b:0 a:0 hex:0x00FFFF00]
     * // c.valueOf()      : 16776960
     * // convert 0xFF0000 : #FF0000
     * </pre>
     */
    public class HTMLColor extends RGBA
    {
        /**
         * Creates a new HTMLColor instance.
         * @param value the decimal color number value.
         * @param name the name of the color.
         */
        public function HTMLColor( value:Number = 0 , name:String = null )
        {
            fromNumber( value ) ;
            this.name = name ;
        }
        
        /**
         * The html 'aqua' color static reference.
         */
        public static const AQUA:HTMLColor = new HTMLColor(0x00FFFF , "Aqua") ;
        
        /**
         * The html 'black' color static reference.
         */
        public static const BLACK:HTMLColor = new HTMLColor(0x000000 , "Black") ;

        /**
         * The html 'blue' color static reference.
         */
        public static const BLUE:HTMLColor = new HTMLColor(0x0000FF , "Blue") ;

        /**
         * The html 'fuchsia' color static reference.
         */
        public static const FUCHSIA:HTMLColor = new HTMLColor(0xFF00FF , "Fuchsia") ;
        
        /**
         * The html 'gray' color static reference.
         */
        public static const GRAY:HTMLColor = new HTMLColor(0x808080 , "Gray") ;
        
        /**
         * The html 'green' color static reference.
         */
        public static const GREEN:HTMLColor = new HTMLColor(0x008000 , "Green") ;
        
        /**
         * The html 'lime' color static reference.
         */
        public static const LIME:HTMLColor = new HTMLColor(0x00FF00 , "Lime") ;
        
        /**
         * The html 'olive' color static reference.
         */
        public static const OLIVE:HTMLColor = new HTMLColor(0x808000 , "Olive") ;
        
        /**
         * The html 'maroon' color static reference.
         */
        public static const MAROON:HTMLColor = new HTMLColor(0x800000 , "Maroon") ;
        
        /**
         * The html 'navy' color static reference.
         */
        public static const NAVY:HTMLColor    = new HTMLColor(0x000080 , "Navy") ;
        
        /**
         * The html 'purple' color static reference.
         */
        public static const PURPLE:HTMLColor  = new HTMLColor(0x800080 , "Purple") ;
        
        /**
         * The html 'red' color static reference.
         */
        public static const RED:HTMLColor     = new HTMLColor(0xFF0000 , "Red") ;

        /**
         * The html 'silver' color static reference.
         */
        public static const SILVER:HTMLColor  = new HTMLColor(0xC0C0C0 , "Silver") ;

        /**
         * The html 'teal' color static reference.
         */
        public static const TEAL:HTMLColor    = new HTMLColor(0x008080 , "Teal") ;

        /**
         * The html 'white' color static reference.
         */
        public static const WHITE:HTMLColor   = new HTMLColor(0xFFFFFF , "White") ;
        
        /**
         * The html 'yellow' color static reference.
         */
        public static const YELLOW:HTMLColor  = new HTMLColor(0xFFFF00 , "Yellow") ;
        
        /**
         * The name of the color.
         */
        public var name:String ;
        
        /**
         * The value of the color.
         */
        public var value:Number ;
        
        /**
         * Converts the string passed in argument (the html color) in a number representation.
         */
        public static function htmlToNumber( sHTML:String ):Number 
        {
            if ( sHTML.charAt(0) == "#" && sHTML.length > 1 && sHTML.length <= 7) 
            {
                return parseInt( "0x" + sHTML.substr(1) ) ;
            }
            return 0 ;
        }
        
        /**
         * Converts the number passed in argument (the html color in hex with ECMAScript notation 0xrrggbb) in a HTML string representation.
         */
        public static function hexToHtml( hex:Number ):String
        {
            return "#" + (hex.toString(16)).toUpperCase() ; 
        }
            
        /**
         * Returns the string representation of this instance.
         * <pre class="prettyprint">
         * var c:HTMLColor = HTMLColor.YELLOW ;
         * trace( c.toString() + " : " + c.toString(true) ) ;
         * </pre>
         * @param verbose A boolean used to use the verbose mode and see all components and informations about this instance.
         * @return the string representation of this instance
         */
        public override function toString():String 
        {
            return this.name ;
        }
    }

}