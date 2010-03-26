﻿/*
  Version: MPL 1.1/GPL 2.0/LGPL 2.1
 
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at
  http://www.mozilla.org/MPL/
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the
  License.
  
  The Original Code is [maashaack framework].
  
  The Initial Developers of the Original Code are
  Zwetan Kjukov <zwetan@gmail.com> and Marc Alcaraz <ekameleon@gmail.com>.
  Portions created by the Initial Developers are Copyright (C) 2006-2010
  the Initial Developers. All Rights Reserved.
  
  Contributor(s):
  
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

package graphics 
{
    /**
     * The Align enumeration class provides constant values to align displays or components.
     */
    public final class Align 
    {
        /**
         * Defines the NONE value (0).
         */
        public static const NONE:uint = 0 ;
        
        /**
         * Defines the CENTER value (1).
         */
        public static const CENTER:uint = 1 ;
        
        /**
         * Defines the LEFT value (2).
         */
        public static const LEFT:uint = 2 ;
        
        /**
         * Defines the RIGHT value (4).
         */
        public static const RIGHT:uint = 4 ;
        
        /**
         * Defines the TOP value (8).
         */
        public static const TOP:uint = 8 ;
        
        /**
         * Defines the BOTTOM value (16).
         */
        public static const BOTTOM:uint = 16 ;
        
        /**
         * Defines the REVERSE value (32).
         */
        public static const REVERSE:uint = 32 ;
        
        /**
         * Defines the BOTTOM_LEFT value (18).
         */
        public static const BOTTOM_LEFT:uint = BOTTOM | LEFT ;
        
        /**
         * Defines the BOTTOM_RIGHT value (20).
         */
        public static const BOTTOM_RIGHT:uint = BOTTOM | RIGHT ;
        
        /**
         * Defines the CENTER_LEFT value (3).
         */
        public static const CENTER_LEFT:uint = CENTER | LEFT ;
        
        /**
         * Defines the CENTER_RIGHT value (5).
         */
        public static const CENTER_RIGHT:uint = CENTER | RIGHT ;
        
        /**
         * Defines the TOP_LEFT value (10).
         */
        public static const TOP_LEFT:uint = TOP | LEFT ;
        
        /**
         * Defines the TOP_RIGHT value (12).
         */
        public static const TOP_RIGHT:uint = TOP | RIGHT ;
        
        /**
         * Defines the LEFT_BOTTOM value (50).
         */
        public static const LEFT_BOTTOM:uint = BOTTOM_LEFT | REVERSE ;
        
        /**
         * Defines the RIGHT_BOTTOM value (52).
         */
        public static const RIGHT_BOTTOM:uint = BOTTOM_RIGHT | REVERSE ;
        
        /**
         * Defines the LEFT_TOP value (42).
         */
        public static const LEFT_TOP:uint = TOP_LEFT | REVERSE ;
        
        /**
         * Defines the RIGHT_TOP value (44).
         */
        public static const RIGHT_TOP:uint = TOP_RIGHT | REVERSE ;
        
        /**
         * Converts a string value in this Align value. If the String value isn't valid the Align.CENTER value is return.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import graphics.Align ;
         * var sAlign:String = "l" ;
         * trace( Align.toNumber("l") == Align.LEFT ) ; // true
         * </pre>
         */
        public static function toNumber( str:String ):uint 
        {
            if ( str == null )
            {
                return Align.CENTER ;
            }
            switch (str.toLowerCase()) 
            {
                case "l" : 
                {
                    return Align.LEFT ;
                }
                case "r" :
                {
                    return Align.RIGHT ;
                }
                case "t" :
                {
                    return Align.TOP ;
                }
                case "b" :
                {
                    return Align.BOTTOM ;
                }
                case "tl" :
                {
                    return Align.TOP_LEFT ;
                }
                case "tr" :
                {
                    return Align.TOP_RIGHT ;
                }
                case "bl" :
                {
                    return Align.BOTTOM_LEFT ;
                }
                case "br" :
                {
                    return Align.BOTTOM_RIGHT ;
                }
                case "cl" :
                {
                    return Align.CENTER_LEFT ;
                }
                case "cr" :
                {
                    return Align.CENTER_RIGHT ;
                }
                case "lt" :
                {
                    return Align.LEFT_TOP ;
                }
                case "rt" :
                {
                    return Align.RIGHT_TOP ;
                }
                case "lb" :
                {
                    return Align.LEFT_BOTTOM ;
                }
                case "rb" :
                {
                    return Align.RIGHT_BOTTOM ;
                }    
                default :
                {
                    return Align.CENTER ;
                }
            }
        }
        
        /**
         * Returns the string representation of the specified Align value passed in argument.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import graphics.Align ;
         * trace( Align.toString(Align.LEFT)) ; // "l"
         * trace( Align.toString(Align.TOP_LEFT)) ; // "tl"
         * trace( Align.toString(Align.RIGHT_BOTTOM)) ; // "rb"
         * </pre>
         * @return the string representation of the specified Align value passed in argument.
         */
        public static function toString(n:Number):String 
        {
            switch (n) 
            {
                case Align.BOTTOM       : return "b"  ;
                case Align.BOTTOM_LEFT  : return "bl" ;
                case Align.BOTTOM_RIGHT : return "br" ;
                case Align.CENTER_LEFT  : return "cl" ;
                case Align.CENTER_RIGHT : return "cr" ;
                case Align.LEFT         : return "l"  ;
                case Align.LEFT_BOTTOM  : return "lb" ;
                case Align.LEFT_TOP     : return "lt" ;
                case Align.RIGHT        : return "r"  ;
                case Align.RIGHT_TOP    : return "rt" ;
                case Align.RIGHT_BOTTOM : return "rb" ;
                case Align.TOP          : return "t"  ;
                case Align.TOP_LEFT     : return "tl" ;
                case Align.TOP_RIGHT    : return "tr" ;
                default                 : return ""   ;
            }
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if the specified Align value in argument is a valid Align value else returns <code class="prettyprint">false</code>.
         * @return <code class="prettyprint">true</code> if the specified Align value in argument is a valid Align value else returns <code class="prettyprint">false</code>.
         */
        public static function validate( value:uint ):Boolean 
        {
            var a:Array = 
            [ 
                Align.BOTTOM   , Align.BOTTOM_LEFT , Align.BOTTOM_RIGHT ,
                Align.CENTER   , Align.CENTER_LEFT , Align.CENTER_RIGHT , 
                Align.TOP      , Align.TOP_LEFT    , Align.TOP_RIGHT    ,
                Align.LEFT     , Align.RIGHT
            ] ;
            return a.indexOf(value) > -1 ;
        }
    }
}
