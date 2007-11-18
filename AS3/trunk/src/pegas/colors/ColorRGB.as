/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is PEGAS Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package pegas.colors 
{

	/**
	 * This static tool class is used to transform the RGB color space on a BasicColor instances.
	 * <p>Thanks 2003 Robert Penner - Use freely, giving credit where possible.</p>
	 * <p>This code is based on the book : Robert Penner's Programming Macromedia Flash MX. More informations in :
	 * <ul>
	 * <li>http://www.robertpenner.com/profmx
 	 * <li>http://www.amazon.com/exec/obidos/ASIN/0072223561/robertpennerc-20
 	 * </ul>
 	 * </p>
 	 * @author eKameleon
 	 */
	public class ColorRGB 
	{
		
		/**
		 * Returns the string representation of the passed color with ECMAScript formatting (0xrrggbb).
		 * @return the string representation of the passed color with ECMAScript formatting (0xrrggbb).
		 */
		public static function getRGBStr( c:Color ):String 
		{
			var str:String = c.getRGB().toString(16);
			var toFill:Number = 6 - str.length;
			while (toFill--) 
			{
				str = "0" + str ;
			}	
			return str.toUpperCase();
		}
	
		/**
		 * Returns the object representation of the color number passed in argument. 
	 	 * This object contains the properties r, g and b for the red, the green and the blue component of the color.
		 * @return the object representation of the color number passed in argument.
	 	 */
		public static function hex2rgb(hex:Number):Object 
		{
			var r:Number, g:Number, b:Number, gb:Number ;
			r = hex>>16 ;
			gb = hex ^ r << 16 ;
			g = gb>>8 ;
			b = gb^g<<8 ;
			return {r:r,g:g,b:b} ;
		}
	
		/**
		 * Converts the red, green, blue arguments in a HTML number color (base 10).
		 */
		public static function rgb2hex(r:Number, g:Number, b:Number):Number  
		{	
			return ((r << 16) | (g << 8) | b);
		}
	
		/**
		 * Sets the color of the passed Color instance with the specified string expression of the color.
		 */
		public static function setRGBStr( c:Color, str:String ):void 
		{
			c.setRGB (parseInt (str.substr (-6, 6), 16));
		}
			
	}

}
