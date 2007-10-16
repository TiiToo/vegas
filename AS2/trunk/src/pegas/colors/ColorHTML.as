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

import vegas.core.IConvertible;
import vegas.core.IEquality;
import vegas.core.IFormattable;
import vegas.util.ObjectUtil;
import vegas.util.StringUtil;

/**
 * Enumeration static class to defined Basic HTML data types : <a href="http://www.w3.org/TR/html4/types.html">W3C HTML 4 Specifications</a> (chap 6.5)
 * <p><b>Example :</b></p>
 * {@code
 * import pegas.colors.ColorHTML ;
 * 
 * var n:Number = ColorHTML.htmlToNumber( "#FF0000" ) ;
 * trace("convert #FF0000 : "  + n) ;
 * 
 * var c:ColorHTML = ColorHTML.YELLOW ;
 * trace(c.toString() + " : " + c.valueOf()) ;
 * }
 */
class pegas.colors.ColorHTML extends Number implements IConvertible, IEquality, IFormattable 
{
	
	/**
	 * Creates a new ColorHTML instance.
	 */
	function ColorHTML( n:Number , name:String) 
	{
		super(n) ;
		this.name = name ;
		this.value = n ;
	}
	
	public static var AQUA:ColorHTML    = new ColorHTML(0x00FFFF , "Aqua") ;
	
	public static var BLACK:ColorHTML   = new ColorHTML(0x000000 , "Black") ;

	public static var BLUE:ColorHTML    = new ColorHTML(0x0000FF , "Blue") ;

	public static var FUCHSIA:ColorHTML = new ColorHTML(0xFF00FF , "Fuchsia") ;

	public static var GRAY:ColorHTML    = new ColorHTML(0x808080 , "Gray") ;
	
	public static var GREEN:ColorHTML   = new ColorHTML(0x008000 , "Green") ;
	
	public static var LIME:ColorHTML    = new ColorHTML(0x00FF00 , "Lime") ;
	
	public static var OLIVE:ColorHTML   = new ColorHTML(0x808000 , "Olive") ;
	
	public static var MAROON:ColorHTML  = new ColorHTML(0x800000 , "Maroon") ; 	
	
	public static var NAVY:ColorHTML    = new ColorHTML(0x000080 , "Navy") ;
	
	public static var PURPLE:ColorHTML  = new ColorHTML(0x800080 , "Purple") ;
	
	public static var RED:ColorHTML     = new ColorHTML(0xFF0000 , "Red") ;
	
	public static var SILVER:ColorHTML  = new ColorHTML(0xC0C0C0 , "Silver") ;

	public static var TEAL:ColorHTML    = new ColorHTML(0x008080 , "Teal") ;

	public static var WHITE:ColorHTML   = new ColorHTML(0xFFFFFF , "White") ;
	
	public static var YELLOW:ColorHTML  = new ColorHTML(0xFFFF00 , "Yellow") ;

	/**
	 * The string representation of the color name.
	 */	
	public var name:String ;
	
	/**
	 * The value (number) of the color.
	 */
	public var value:Number ;

	/**
	 * Compares the specified object with this object for equality.
	 * @return {@code true} if the the specified object is equal with this object.
	 */
	public function equals( o ):Boolean 
	{
		return ( o.valueOf() == valueOf() && toString() == o.toString()) ;	
	}

	/**
	 * Converts the string passed in argument (the html color) in a number representation.
	 */
	public static function htmlToNumber( sHTML:String ):Number 
	{
		var s = new StringUtil(sHTML) ;
		if (s.firstChar() == "#" && s.length > 1 && s.length <= 7) 
		{
			s = s.splice(1) ;
			return parseInt("0x" + s) ;
		}
		return null ;
	}

	/**
	 * Converts the number passed in argument (the html color in hex with ECMAScript notation 0xrrggbb) in a HTML string representation.
	 */
	public static function hexToHtml( hex:Number):String
	{
		return "#" + (hex.toString(16)).toUpperCase() ; 
	}

	/**
	 * Converts an object to an equivalent Boolean value.
	 */
	public function toBoolean():Boolean 
	{
		return ObjectUtil.toBoolean(this) ;	
	}

	/**
	 * Converts an object to an equivalent Number value.
	 */
	public function toNumber():Number 
	{
		return ObjectUtil.toNumber(this) ;	
	}

	/**
	 * Converts an object to an equivalent Object value.
	 */
	public function toObject():Object 
	{
		return ObjectUtil.toObject(this) ;	
	}

	/**
	 * Returns the string representation of this instance.
	 * @return the string representation of this instance
	 */
	public function toString():String 
	{
		return name ;
	}
	
	/**
	 * Return the value in number of this ColorHTML instance.
	 */
	public function valueOf():Number
	{
		return value ;	
	}

}