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
	import system.IEquatable;
	
	import vegas.core.CoreObject;
	import vegas.core.IConvertible;
	import vegas.util.ObjectUtil;	

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
	public class ColorHTML extends CoreObject implements IConvertible, IEquatable
	{
		
		/**
		 * Creates a new ColorHTML instance.
		 * @param value the decimal color number value.
		 * @param name the name of the color.
		 */
		public function ColorHTML( value:Number=NaN , name:String=null )
		{
			super();
			if ( name != null )
			{
				this.name = name ;
			}
			if ( !isNaN(value) ) 
			{
				this.value = value ;
			}
		}

		/**
		 * The html 'aqua' color static reference.
		 */
		public static const AQUA:ColorHTML    = new ColorHTML(0x00FFFF , "Aqua") ;

		/**
		 * The html 'black' color static reference.
		 */
		public static const BLACK:ColorHTML   = new ColorHTML(0x000000 , "Black") ;

		/**
		 * The html 'blue' color static reference.
		 */
		public static const BLUE:ColorHTML    = new ColorHTML(0x0000FF , "Blue") ;

		/**
		 * The html 'fuchsia' color static reference.
		 */
		public static const FUCHSIA:ColorHTML = new ColorHTML(0xFF00FF , "Fuchsia") ;

		/**
		 * The html 'gray' color static reference.
		 */
		public static const GRAY:ColorHTML    = new ColorHTML(0x808080 , "Gray") ;

		/**
		 * The html 'green' color static reference.
		 */
		public static const GREEN:ColorHTML   = new ColorHTML(0x008000 , "Green") ;

		/**
		 * The html 'lime' color static reference.
		 */
		public static const LIME:ColorHTML    = new ColorHTML(0x00FF00 , "Lime") ;
	
		/**
		 * The html 'olive' color static reference.
		 */
		public static const OLIVE:ColorHTML   = new ColorHTML(0x808000 , "Olive") ;

		/**
		 * The html 'maroon' color static reference.
		 */
		public static const MAROON:ColorHTML  = new ColorHTML(0x800000 , "Maroon") ; 	

		/**
		 * The html 'navy' color static reference.
		 */
		public static const NAVY:ColorHTML    = new ColorHTML(0x000080 , "Navy") ;

		/**
		 * The html 'purple' color static reference.
		 */
		public static const PURPLE:ColorHTML  = new ColorHTML(0x800080 , "Purple") ;

		/**
		 * The html 'red' color static reference.
		 */
		public static const RED:ColorHTML     = new ColorHTML(0xFF0000 , "Red") ;

		/**
		 * The html 'silver' color static reference.
		 */
		public static const SILVER:ColorHTML  = new ColorHTML(0xC0C0C0 , "Silver") ;

		/**
		 * The html 'teal' color static reference.
		 */
		public static const TEAL:ColorHTML    = new ColorHTML(0x008080 , "Teal") ;

		/**
		 * The html 'white' color static reference.
		 */
		public static const WHITE:ColorHTML   = new ColorHTML(0xFFFFFF , "White") ;

		/**
		 * The html 'yellow' color static reference.
		 */
		public static const YELLOW:ColorHTML  = new ColorHTML(0xFFFF00 , "Yellow") ;

    	/**
		 * The name of the color.
		 */
		public var name:String ;
	
		/**
		 * The value of the color.
		 */
		public var value:Number ;

		/**
		 * Compares the specified object with this object for equality.
		 * @return {@code true} if the the specified object is equal with this object.
	 	 */
		public function equals( o:* ):Boolean 
		{
			return ( o.valueOf() == valueOf() && toString() == o.toString()) ;	
		}

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
		public override function toString():String 
		{
			return this.name ;
		}

		/**
		 * Returns the value in number of this ColorHTML instance.
		 * @return the value in number of this ColorHTML instance.
		 */
		public function valueOf():Number
		{
			return this.value ;	
		}
	
	}

}