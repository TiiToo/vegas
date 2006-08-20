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
		Date :  2006-04-08
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
	
		- static htmlToNumber( sHTML:String ):Number

		- toBoolean():Boolean

		- toObject():Object

		- toString():String
				
		- valueOf():Number

	SEE
	
		Basic HTML data types - W3C HTML 4 Specifications :
			
			http://www.w3.org/TR/html4/types.html (chap 6.5)

*/

import vegas.core.IConvertible;
import vegas.core.IFormattable;
import vegas.util.ObjectUtil;
import vegas.util.StringUtil;

class asgard.colors.ColorHTML extends Number implements IConvertible, IFormattable {
	
	// ----o Constructor
	
	private function ColorHTML( n:Number , name:String) {
		super(n) ;
		_name = name ;
	}
	
	// ----o Constants
	
	static public var AQUA:ColorHTML    = new ColorHTML(0x00FFFF , "Aqua") ;
	
	static public var BLACK:ColorHTML   = new ColorHTML(0x000000 , "Black") ;

	static public var BLUE:ColorHTML    = new ColorHTML(0x0000FF , "Blue") ;

	static public var FUCHSIA:ColorHTML = new ColorHTML(0xFF00FF , "Fuchsia") ;

	static public var GRAY:ColorHTML    = new ColorHTML(0x808080 , "Gray") ;
	
	static public var GREEN:ColorHTML   = new ColorHTML(0x008000 , "Green") ;
	
	static public var LIME:ColorHTML    = new ColorHTML(0x00FF00 , "Lime") ;
	
	static public var OLIVE:ColorHTML   = new ColorHTML(0x808000 , "Olive") ;
	
	static public var MAROON:ColorHTML  = new ColorHTML(0x800000 , "Maroon") ; 	
	
	static public var NAVY:ColorHTML    = new ColorHTML(0x000080 , "Navy") ;
	
	static public var PURPLE:ColorHTML  = new ColorHTML(0x800080 , "Purple") ;
	
	static public var RED:ColorHTML     = new ColorHTML(0xFF0000 , "Red") ;
	
	static public var SILVER:ColorHTML  = new ColorHTML(0xC0C0C0 , "Silver") ;

	static public var TEAL:ColorHTML    = new ColorHTML(0x008080 , "Teal") ;

	static public var WHITE:ColorHTML   = new ColorHTML(0xFFFFFF , "White") ;
	
	static public var YELLOW:ColorHTML  = new ColorHTML(0xFFFF00 , "Yellow") ;

	static private var __ASPF__ = _global.ASSetPropFlags(ColorHTML, null , 7, 7) ;

	// ----o Public Methods
	
	static public function htmlToNumber( sHTML:String ):Number {
		var s = new StringUtil(sHTML) ;
		if (s.firstChar() == "#" && s.length > 1 && s.length <= 7) {
			s = s.splice(1) ;
			return parseInt("0x" + s) ;
		}
		return null ;
	}

	public function toBoolean():Boolean {
		return ObjectUtil.toBoolean(this) ;	
	}
	

	public function toNumber():Number {
		return ObjectUtil.toNumber(this) ;	
	}

	public function toObject():Object {
		return ObjectUtil.toObject(this) ;	
	}
	
	public function toString():String {
		return 	_name ;
	}

	// ----o Private Properties
	
	private var _name:String ;
	
}