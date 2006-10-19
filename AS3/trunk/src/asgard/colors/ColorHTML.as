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
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2005
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

/** ColorHTML

	AUTHOR

		Name : ColorHTML
		Package : asgard.colors
		Version : 1.0.0.0
		Date :  2006-10-16
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	USE
	
		import asgard.colors.ColorHTML ;
		
		var n:Number = ColorHTML.htmlToNumber( "#FF0000" ) ;
		trace("convert #FF0000 : "  + n) ;
		
		var c:ColorHTML = ColorHTML.YELLOW ;
		trace(c.toString() + " : " + c.valueOf()) ;
	
	CONSTANT SUMMARY
	
		- AQUA:ColorHTML
		
		- BLACK:ColorHTML
		
		- BLUE:ColorHTML
		
		- FUCHSIA:ColorHTML
		
		- GRAY:ColorHTML
		
		- GREEN:ColorHTML
		
		- LIME:ColorHTML
		
		- OLIVE:ColorHTML
		
		- MAROON:ColorHTML
		
		- NAVY:ColorHTML
		
		- PURPLE:ColorHTML
		
		- RED:ColorHTML
		
		- SILVER:ColorHTML
		
		- TEAL:ColorHTML
		
		- WHITE:ColorHTML
		
		- YELLOW:ColorHTML

	METHOD SUMMARY
		
		- equals(o):Boolean
		
		- static hexToHtml( hex:Number ):String
		
		- static htmlToNumber( sHTML:String ):Number
		
		- toBoolean():Boolean
		
		- toObject():Object
		
		- toString():String
				
		- valueOf():Number

	INHERIT
	
		CoreObject → ColorHTML

	IMPLEMENTS
	
		IConvertible, IEquality, IFormattable

	SEE ALSO
	
		Basic HTML data types - W3C HTML 4 Specifications :
			
			http://www.w3.org/TR/html4/types.html (chap 6.5)

*/

package asgard.colors
{

	import vegas.core.CoreObject;
	import vegas.core.IConvertible;
	import vegas.core.IEquality;
	import vegas.util.ObjectUtil ;
	import vegas.util.StringUtil ;

	public class ColorHTML extends CoreObject implements IConvertible, IEquality
	{
		
		/**
		 * Creates a new ColorHTML instance.
		 */
		public function ColorHTML( value:Number , name:String )
		{
			super();
			this.name = name ;
			this.value = value ;
		}

		// ----o Constants
		
		static public const AQUA:ColorHTML    = new ColorHTML(0x00FFFF , "Aqua") ;
		
		static public const BLACK:ColorHTML   = new ColorHTML(0x000000 , "Black") ;
	
		static public const BLUE:ColorHTML    = new ColorHTML(0x0000FF , "Blue") ;
	
		static public const FUCHSIA:ColorHTML = new ColorHTML(0xFF00FF , "Fuchsia") ;
	
		static public const GRAY:ColorHTML    = new ColorHTML(0x808080 , "Gray") ;
			
		static public const GREEN:ColorHTML   = new ColorHTML(0x008000 , "Green") ;
		
		static public const LIME:ColorHTML    = new ColorHTML(0x00FF00 , "Lime") ;
		
		static public const OLIVE:ColorHTML   = new ColorHTML(0x808000 , "Olive") ;
		
		static public const MAROON:ColorHTML  = new ColorHTML(0x800000 , "Maroon") ; 	
		
		static public const NAVY:ColorHTML    = new ColorHTML(0x000080 , "Navy") ;
		
		static public const PURPLE:ColorHTML  = new ColorHTML(0x800080 , "Purple") ;
		
		static public const RED:ColorHTML     = new ColorHTML(0xFF0000 , "Red") ;
		
		static public const SILVER:ColorHTML  = new ColorHTML(0xC0C0C0 , "Silver") ;
	
		static public const TEAL:ColorHTML    = new ColorHTML(0x008080 , "Teal") ;
	
		static public const WHITE:ColorHTML   = new ColorHTML(0xFFFFFF , "White") ;
		
		static public const YELLOW:ColorHTML  = new ColorHTML(0xFFFF00 , "Yellow") ;

		// ----o Public Properties
		
		/**
		 * The name of the color.
		 */
		public var name:String ;
	
		/**
		 * The value of the color.
		 */
		public var value:Number ;

		// ----o Public Methods

		public function equals( o:* ):Boolean 
		{
			return ( o.valueOf() == valueOf() && toString() == o.toString()) ;	
		}
	
		static public function htmlToNumber( sHTML:String ):Number 
		{
			if (StringUtil.firstChar(sHTML) == "#" && s.length > 1 && s.length <= 7) 
			{
				var s:String = StringUtil.splice(sHTML, 1) ;
				return parseInt("0x" + s) ;
			}
			return undefined ;
		}
	
		static public function hexToHtml( hex:Number):String
		{
			return "#" + (hex.toString(16)).toUpperCase() ; 
		}
	
		public function toBoolean():Boolean 
		{
			return ObjectUtil.toBoolean(this) ;	
		}
		
		public function toNumber():Number 
		{
			return ObjectUtil.toNumber(this) ;	
		}
	
		public function toObject():Object 
		{
			return ObjectUtil.toObject(this) ;	
		}
		
		override public function toString():String 
		{
			return name ;
		}
		
		public function valueOf():Number
		{
			return value ;	
		}
	
	}

}