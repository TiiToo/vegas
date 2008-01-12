/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is LunAS Library.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

import lunas.display.components.AbstractStyle;

/**
 * The IStyle class of the EasyButton component.
 */
class lunas.display.components.button.EasyButtonStyle extends AbstractStyle 
{

	/**
	 * Creates a new EasyButtonStyle instance.
	 */
	public function EasyButtonStyle( init:Object ) 
	{
		super(init) ;
	}

	public static var LABEL_STYLE_NAME:String = "EasyButtonLabel" ;

	var color:Number = 0x000000 ;

	var embedFonts:Boolean = false ;

	var paddingLeft:Number = 4 ;

	var paddingRight:Number = 4 ;

	var selectable:Boolean = false ;	

	var textDisabledColor:Number = 0x000000 ;

	var textRollOverColor:Number = 0xFFFFFF ;
	
	var textSelectedColor:Number = 0xFFFFFF ;
	
	var themeBorderColor:Number = null ;

	var themeBorderAlpha:Number = null ;
	
	var themeAlpha:Number = 100 ;	

	var themeColor:Number = 0xFFFFFF ;

	var themeRollOverColor:Number = 0x1D8D2B ;

	var themeSelectedColor:Number = 0x000000 ;

	var themeDisabledColor:Number = 0xCCCCCC ;

	var thickness:Number = null ;

	/**
	 * Initialize the IStyle.
	 */
	public function initialize():Void 
	{
		var oS:Object = 
		{
			fontFamily:'verdana' , 
			fontSize:"11px" ,
			fontWeight:"bold" ,
			textAlign : "center"
		};
		var css:TextField.StyleSheet = new TextField.StyleSheet() ;
		css.setStyle ( "." + LABEL_STYLE_NAME , oS ) ;
		setStyleSheet(css) ;
	}
	
}