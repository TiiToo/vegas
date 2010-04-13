﻿/*  Version: MPL 1.1/GPL 2.0/LGPL 2.1   The contents of this file are subject to the Mozilla Public License Version  1.1 (the "License"); you may not use this file except in compliance with  the License. You may obtain a copy of the License at  http://www.mozilla.org/MPL/    Software distributed under the License is distributed on an "AS IS" basis,  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License  for the specific language governing rights and limitations under the  License.    The Original Code is [maashaack framework].    The Initial Developers of the Original Code are  Zwetan Kjukov <zwetan@gmail.com> and Marc Alcaraz <ekameleon@gmail.com>.  Portions created by the Initial Developers are Copyright (C) 2006-2010  the Initial Developers. All Rights Reserved.    Contributor(s):    Alternatively, the contents of this file may be used under the terms of  either the GNU General Public License Version 2 or later (the "GPL"), or  the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),  in which case the provisions of the GPL or the LGPL are applicable instead  of those above. If you wish to allow use of your version of this file only  under the terms of either the GPL or the LGPL, and not to allow others to  use your version of this file under the terms of the MPL, indicate your  decision by deleting the provisions above and replace them with the notice  and other provisions required by the LGPL or the GPL. If you do not delete  the provisions above, a recipient may use your version of this file under  the terms of any one of the MPL, the GPL or the LGPL.*/package graphics.colors {    import system.hack;        /**     * Manipulates and transforms <code class="prettyprint">colors</code> : CMY, CMYK, HSV, HSL, RGB, XYZ, Yxy, etc.     */    public final class Colors     {        use namespace hack ;                /**         * Returns the RGB representation of the specified CMY object.         * <p><b>Example :</b></p>         * <pre class="prettyprint">         * import graphics.colors.Colors ;         * import graphics.colors.CMY ;         * import graphics.colors.RGB ;         *          * var cmy:CMY = new CMY( 0 , 1 , 1 ) ;         * var rgb:RGB = Colors.CMY2RGB( cmy ) ;         *          * trace( rgb ) ; // [RGB r:255 g:0 b:0 hex:0xFF0000]         * </pre>         * @return the RGB representation of the specified CMY object.         */        public static function CMY2RGB( cmy:CMY ):RGB        {            return new RGB            (                 ( 1 - cmy.c ) * 0xFF ,                ( 1 - cmy.m ) * 0xFF ,                ( 1 - cmy.y ) * 0xFF             ) ;        }                /**         * Converts the specified CMY object in this CMYK representation.         * @return The CMYK representation of the specified CMY object.         */        public static function CMY2CMYK( cmy:CMY ):CMYK        {            var cmyk:CMYK = new CMYK() ;            var k:Number = 1 ;            if ( cmy._c < k )               {                k = cmy._c ;            }            if ( cmy._m < k )            {                k = cmy._m ;            }            if ( cmy._y < k )            {            	k = cmy._y ;            }            if ( k == 1 ) //Black             {                cmyk._c = 0 ;               cmyk._m = 0 ;               cmyk._y = 0 ;            }            else             {               cmyk.c = ( cmy._c - k ) / ( 1 - k ) ;               cmyk.m = ( cmy._m - k ) / ( 1 - k ) ;               cmyk.y = ( cmy._y - k ) / ( 1 - k ) ;            }            cmyk.k = k ;            return cmyk ;        }                /**         * Converts the specified CMY object in this CMYK representation.         * @return The CMYK representation of the specified CMY object.         */        public static function CMYK2CMY( cmyk:CMYK ):CMY        {            var cmy:CMY = new CMY() ;            cmy.c = cmyk._c * ( 1 - cmyk._k ) + cmyk._k ;            cmy.m = cmyk._m * ( 1 - cmyk._k ) + cmyk._k ;            cmy.y = cmyk._y * ( 1 - cmyk._k ) + cmyk._k ;            return cmy ;        }                /**         * Returns the RGB representation of the passed-in HSL color.         * <p><b>Example :</b></p>         * <pre class="prettyprint">         * import graphics.colors.Colors ;         * import graphics.colors.HSL ;         * import graphics.colors.RGB ;         *          * var hsl:HSL = new HSL( 0 , 1 , 0.5 ) ;         * var rgb:RGB = Colors.HSL2RGB( hsl ) ;          *          * trace( rgb ) ; // [RGB r:255 g:0 b:0 hex:0xFF0000]         * </pre>         * @return the RGB representation of the passed-in HSL color.         */                public static function HSL2RGB( hsl:HSL ):RGB        {            var rgb:RGB = new RGB() ;            rgb.fromNumber( HSL2RGBNumber( hsl ) ) ;            return rgb ;        }                /**         * Returns the rgb number representation of the passed-in HSL color.         * <p><b>Example :</b></p>         * <pre class="prettyprint">         * import graphics.colors.Colors ;         * import graphics.colors.HSL ;         *          * var hsl:HSL    = new HSL( 0 , 1 , 0.5 ) ;         * var rgb:Number = Colors.HSL2RGBNumber( hsl ) ;          *          * trace( rgb ) ; // 0xFF0000         * </pre>         * @return the rgb number representation of the passed-in HSL color.         */                public static function HSL2RGBNumber( hsl:HSL):Number        {            var r:Number = 0 ;            var g:Number = 0 ;            var b:Number = 0 ;            if ( hsl._s == 0 )            {                r = hsl._l ;                g = hsl._l ;                b = hsl._l ;             }            else            {                var h:Number = hsl._h / 360 ; // 0..360 to 0..1                 var q:Number = ( hsl._l < 0.5 ) ? ( hsl._l * ( 1 + hsl._s) ) : ( ( hsl._l + hsl._s ) - ( hsl._l * hsl._s ) ) ;                var p:Number = ( 2 * hsl._l ) - q ;                r = hue2rgb( p , q , h + 1/3 ) ;                g = hue2rgb( p , q , h ) ;                b = hue2rgb( p , q , h - 1/3 ) ;             }            r *= 0xFF ;            g *= 0xFF ;            b *= 0xFF ;            return ( r << 16 ) | ( g << 8 ) | b ;        }                /**         * Returns the RGB representation of the passed-in HSV color.         * <p><b>Example :</b></p>         * <pre class="prettyprint">         * import graphics.colors.Colors ;         * import graphics.colors.HSV ;         * import graphics.colors.RGB ;         *          * var hsv:HSV = new HSL( 0 , 1 , 1 ) ;         * var rgb:RGB = Colors.HSV2RGB( hsv ) ;          *          * trace( rgb ) ; // [RGB r:255 g:0 b:0 hex:0xFF0000]         * </pre>         * @return the RGB representation of the passed-in HSV color.         */                public static function HSV2RGB( hsv:HSV ):RGB        {            var rgb:RGB = new RGB() ;            rgb.fromNumber( HSV2RGBNumber( hsv ) ) ;            return rgb ;        }                /**         * Returns the rgb number representation of the passed-in HSV color.         * <p><b>Example :</b></p>         * <pre class="prettyprint">         * import graphics.colors.Colors ;         * import graphics.colors.HSV ;         *          * var hsv:HSV    = new HSV( 0 , 1 , 1 ) ;         * var rgb:Number = Colors.HSV2RGBNumber( hsl ) ;          *          * trace( rgb ) ; // 0xFF0000         * </pre>         * @return the rgb number representation of the passed-in HSV color.         */                public static function HSV2RGBNumber( hsv:HSV ):Number        {            var r:Number = 0 ;            var g:Number = 0 ;            var b:Number = 0 ;            if ( hsv._s == 0 )            {                r = hsv._v ;                g = hsv._v ;                b = hsv._v ;             }            else            {                var hi:uint  = ( hsv._h / 60 ) % 6 ;                var f:Number = hsv._h / 60 - hi ;                var p:Number = hsv._v * (1 - hsv._s) ;                var q:Number = hsv._v * (1 - hsv._s * f ) ;                var t:Number = hsv._v * (1 - hsv._s * (1 - f) ) ;                switch( hi )                {                    case 0 :                    {                        r = hsv._v ;                        g = t ;                        b = p ;                        break;                    }                    case 1 :                    {                        r = q ;                        g = hsv._v ;                        b = p ;                        break;                    }                    case 2 :                    {                        r = p ;                        g = hsv._v ;                        b = t ;                        break;                    }                    case 3 :                    {                        r = p ;                        g = q ;                        b = hsv._v ;                        break;                    }                    case 4 :                    {                        r = t ;                        g = p ;                        b = hsv._v ;                        break;                    }                    case 5 :                    {                        r = hsv._v ;                        g = p ;                        b = q ;                        break;                    }                 }             }            r *= 0xFF ;            g *= 0xFF ;            b *= 0xFF ;            return ( r << 16 ) | ( g << 8 ) | b ;        }                /**         * Returns the CMY representation of the specified RGB object.         * <p><b>Example :</b></p>         * <pre class="prettyprint">         * import graphics.colors.Colors ;         * import graphics.colors.CMY ;         * import graphics.colors.RGB ;         *          * var rgb:RGB = new RGB( 255 , 0 , 0 ) ;         * var cmy:CMY = Colors.RGB2CMY( rgb ) ;         *          * trace( cmy ) ; // [CMY c:0 m:1 y:1]         * </pre>         * @return the CMY representation of the specified RGB object.         */        public static function RGB2CMY( rgb:RGB ):CMY        {            return new CMY            (                 1 - ( rgb.r / 0xFF ) ,                1 - ( rgb.g / 0xFF ) ,                1 - ( rgb.b / 0xFF )             ) ;        }                /**         * Returns the HSL representation of the passed-in RGB parameter.         * <p><b>Example :</b></p>         * <pre class="prettyprint">         * import graphics.colors.Colors ;         * import graphics.colors.HSL ;         * import graphics.colors.RGB ;         *          * var rgb:RGB = new RGB(255,0,0)  ;         * var hsl:HSL = Colors.RGB2HSL( rgb ) ;          *          * trace( hsl ) ; // [HSL h:0 s:1 l:0.5]         * </pre>         * @return the HSL representation of the passed-in RGB parameter.         */        public static function RGB2HSL( rgb:RGB ):HSL        {            var hsl:HSL    = new HSL() ;                        var r:Number   = rgb._red   / 0xFF ;            var g:Number   = rgb._green / 0xFF ;            var b:Number   = rgb._blue  / 0xFF ;                        var max:Number = Math.max( r, g, b );            var min:Number = Math.min( r, g, b );                        var d:Number = (max + min) / 2 ;                         hsl.h = d ;            hsl.s = d ;            hsl.l = d ;                         if ( max == min ) // achromatic            {                hsl.h = 0 ;                hsl.s = 0 ;                hsl.l = 0 ;            }            else            {                d = max - min;                hsl.s = ( hsl.l > 0.5 ) ? d / (2 - max - min) : d / (max + min) ;                switch(max)                {                    case r :                     {                        hsl.h = (g - b) / d + (g < b ? 6 : 0) ;                         break ;                    }                    case g :                     {                        hsl.h = (b - r) / d + 2 ;                        break ;                    }                    case b :                     {                        hsl.h = (r - g) / d + 4 ;                        break ;                    }                }                hsl.h /= 6  ;                hsl.h *= 360 ;            }            return hsl ;        }                /**         * Returns the HSV representation of the passed-in RGB parameter.         * <p><b>Example :</b></p>         * <pre class="prettyprint">         * import graphics.colors.Colors ;         * import graphics.colors.HSV ;         * import graphics.colors.RGB ;         *          * var rgb:RGB = new RGB(255,0,0)  ;         * var hsv:HSV = Colors.RGB2HSV( rgb ) ;          *          * trace( hsv ) ; // [HSV h:0 s:1 v:1]         * </pre>         * @return the HSV representation of the passed-in RGB parameter.         */        public static function RGB2HSV( rgb:RGB ):HSV        {            var hsv:HSV    = new HSV() ;            var r:Number   = rgb._red   / 0xFF ;            var g:Number   = rgb._green / 0xFF ;            var b:Number   = rgb._blue  / 0xFF ;            var max:Number = Math.max( r, Math.max(g, b) );            var min:Number = Math.min( r, Math.min(g, b) );            switch(max)            {                case r :                {                    hsv.h = 60 * (g - b) / (max - min) ;                    break;                }                case g :                {                    hsv.h = 60 * (b - r) / (max - min) + 120 ;                    break;                }                case b :                {                    hsv.h = 60 * (r - g) / (max - min) + 240 ;                    break;                }            }            hsv.s = (max - min) / max;            hsv.v = max ;            return hsv ;        }                /**         * Transform the specified RGB in this XYZ representation.         * @return the XYZ representation of the passed-in RGB parameter.         */        public static function RGB2XYZ( rgb:RGB ):XYZ        {            var xyz:XYZ    = new XYZ() ;                        var r:Number   = rgb._red   / 0xFF ;            var g:Number   = rgb._green / 0xFF ;            var b:Number   = rgb._blue  / 0xFF ;                        if ( r > 0.04045 )             {                r = ( ( r + 0.055 ) / 1.055 ) ^ 2.4 ;            }            else            {                r /= 12.92 ;            }                        if ( g > 0.04045 )            {                g = ( ( g + 0.055 ) / 1.055 ) ^ 2.4 ;            }            else            {                g /= 12.92 ;            }                        if ( b > 0.04045 )            {                b = ( ( b + 0.055 ) / 1.055 ) ^ 2.4 ;            }            else            {                b /= 12.92 ;            }                        r *= 100 ;            g *= 100 ;            b *= 100 ;                        // Observer. = 2°, Illuminant = D65                        xyz.X = r * 0.4124 + g * 0.3576 + b * 0.1805 ;            xyz.Y = r * 0.2126 + g * 0.7152 + b * 0.0722 ;            xyz.Z = r * 0.0193 + g * 0.1192 + b * 0.9505 ;                        return xyz ;        }                /**         * Returns the YUV representation of the passed-in RGB parameter.         * <p><b>Example :</b></p>         * <pre class="prettyprint">         * import graphics.colors.Colors ;         * import graphics.colors.RGB ;         * import graphics.colors.YUV ;         *          * var rgb:RGB = new RGB(255,0,0)  ;         * var yuv:YUV = Colors.RGB2YUV( rgb ) ;          *          * trace( rgb ) ; // [RGB r:255 g:0 b:0 hex:0xFF0000]         * trace( yuv ) ; // [YUV y:76.24499999999999 u:84.97232 v:255.5]         * </pre>         * @return the YUV representation of the passed-in RGB parameter.         */        public static function RGB2YUV( rgb:RGB ):YUV        {            var r:Number = rgb.r ;            var g:Number = rgb.g ;            var b:Number = rgb.b ;            var y:Number = r *  .299000 + g *  .587000 + b *  .114000 ;            var u:Number = r * -.168736 + g * -.331264 + b *  .500000 + 128 ;            var v:Number = r *  .500000 + g * -.418688 + b * -.081312 + 128 ;            return new YUV( y , u , v ) ;        }                /**         * Transform the specified XYZ in this RGB representation (use Observer = 2°, Illuminant = D65).         * @return the RGB representation of the passed-in XYZ parameter.         */        public static function XYZ2RGB( xyz:XYZ ):RGB        {            var x:Number = xyz._x / 100 ; // X from 0 to  95.047            var y:Number = xyz._y / 100 ; // Y from 0 to 100.000            var z:Number = xyz._z / 100 ; // Z from 0 to 108.883                        var r:Number = x *  3.2406 + y * -1.5372 + z * -0.4986 ;            var g:Number = x * -0.9689 + y *  1.8758 + z *  0.0415 ;            var b:Number = x *  0.0557 + y * -0.2040 + z *  1.0570 ;                        var diff:Number = 1 / 2.4 ;                        if ( r > 0.0031308 )            {            	 r = ( 1.055 * Math.pow( r , diff ) ) - 0.055 ;            }            else             {                r *= 12.92 ;            }                        if ( g > 0.0031308 )            {                g = ( 1.055 * Math.pow( g , diff ) ) - 0.055 ;            }            else            {                g *= 12.92 ;            }                        if ( b > 0.0031308 )            {                b = ( 1.055 * Math.pow( b , diff ) ) - 0.055 ;            }            else            {                b *= 12.92 ;            }                        r *= 255 ;            g *= 255 ;            b *= 255 ;                        return new RGB(r,g,b) ;        }                /**         * Transform the specified XYZ in this Yxy representation (use Observer = 2°, Illuminant = D65).         * @return the Yxy representation of the passed-in XYZ parameter.         */        public static function XYZ2Yxy( xyz:XYZ ):Yxy        {            var r:Yxy = new Yxy() ;            r.Y = xyz.Y ;            r.x = xyz.X / ( xyz.X + xyz.Y + xyz.Z ) ;            r.y = xyz.Y / ( xyz.X + xyz.Y + xyz.Z ) ;            return r ;        }                /**         * Transform the specified Yxy in this XYZ representation (use Observer = 2°, Illuminant = D65).         * @return the XYZ representation of the passed-in Yxy parameter.         */        public static function Yxy2XYZ( color:Yxy ):XYZ        {            var r:XYZ = new XYZ() ;            r.X = color.x * ( color.Y / color.y ) ;            r.Y = color.Y ;            r.Z = ( 1 - color.x - color.y ) * ( color.Y / color.y ) ;            return r ;        }                /**         * Returns the RGB representation of the passed-in YUV parameter.         * <p><b>Example :</b></p>         * <pre class="prettyprint">         * import graphics.colors.Colors ;         * import graphics.colors.RGB ;         * import graphics.colors.YUV ;         *          * var yuv:YUV = new YUV(76.24499999999999,84.97232,255.5)  ;         * var rgb:RGB = Colors.YUV2RGB( yuv ) ;         *          * trace( yuv ) ; // [YUV y:76.24499999999999 u:84.97232 v:255.5]         * trace( rgb ) ; // [RGB r:255 g:0 b:0 hex:0xFF0000]         * </pre>         * @return the RGB representation of the passed-in YUV parameter.         */        public static function YUV2RGB( yuv:YUV ):RGB        {            var y:Number = yuv.y ;            var u:Number = yuv.u ;            var v:Number = yuv.v ;            var r:Number = y + 1.4075 * (v - 128) ;            var g:Number = y - 0.3455 * (u - 128) - (0.7169 * (v - 128)) ;            var b:Number = y + 1.7790 * (u - 128) ;            return new RGB( r , g , b ) ;        }                /**         * Converts the hue values in rgb values.         * @private         */        private static function hue2rgb(p:Number, q:Number, hue:Number):Number        {            if( hue < 0 )             {                hue += 1 ;            }            if( hue > 1 )             {                hue -= 1 ;            }            if( ( 6 * hue ) < 1 )             {                return p + (q - p) * 6 * hue ;            }            if( ( 2 * hue ) < 1 )             {                return q ;            }            if( ( 3 * hue ) < 2 )             {                return p + ( q - p ) * ( ( 2/3 - hue ) * 6 ) ;            }            return p ;        };    }}