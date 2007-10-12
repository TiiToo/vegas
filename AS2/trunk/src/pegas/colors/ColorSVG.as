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
  Portions created by the Initial Developer are Copyright (C) 2004-2007
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

import pegas.colors.ColorHTML;

import vegas.data.map.HashMap;
import vegas.util.TypeUtil;


/**
 * All SVG W3C standard colors. 
 * Basic HTML data types - W3C HTML 4 Specifications : <a href='http://www.w3.org/TR/html4/types.html (chap 6.5)'>http://www.w3.org/TR/html4/types.html</a> (chap 6.5).
 * Scalable Vector Graphics Color Names : <a href='http://www.december.com/html/spec/colorsvg.html'>http://www.december.com/html/spec/colorsvg.html</a>
 * @author eKameleon
 */
class pegas.colors.ColorSVG extends ColorHTML 
{
	
	/**
	 * Creates a new ColorSVG instance.
	 * @param n the value hex of the color.
	 * @param the name of the color.
	 */
	public function ColorSVG( n:Number , name:String) 
	{
		super(n, name) ;
		
		if ( ColorSVG.ELEMENTS == null )
		{
			ColorSVG.ELEMENTS = new HashMap() ;
		}
		
		ColorSVG.ELEMENTS.put( name.toLowerCase(), this) ;
		
	}

	/**
	 * The hashmap of all SVG colors.
	 */
	public static var ELEMENTS:HashMap = null ;

	public static var ALICE_BLUE:ColorSVG = new ColorSVG(0xF0F8FF , "AliceBlue") ;
	
	public static var ANTIQUE_WHITE:ColorSVG = new ColorSVG(0xFAEBD7 , "AntiqueWhite") ;
	
	public static var AQUA:ColorSVG = new ColorSVG(0x00FFFF , "Aqua") ;
	
	public static var AQUA_MARINE:ColorSVG = new ColorSVG(0x00FFFF , "AquaMarine") ;
	
	public static var AZURE:ColorSVG = new ColorSVG(0xF0FFFF, "Azure") ;
	
	public static var BEIGE:ColorSVG = new ColorSVG(0xF5F5DC, "Beige") ;
	
	public static var BISQUE:ColorSVG = new ColorSVG(0xFFE4C4, "Bisque") ;
	
	public static var BLACK:ColorSVG = new ColorSVG(0x000000 , "Black") ;

	public static var BLANCH_DALMOND = new ColorSVG(0xFFEBCD, "BlancheDalmond") ;

	public static var BLUE:ColorSVG = new ColorSVG(0x0000FF , "Blue") ;

	public static var BLUE_VIOLET:ColorSVG = new ColorSVG(0x8A2BE2 , "BlueViolet") ;

	public static var BROWN:ColorSVG = new ColorSVG(0xA52A2A, "Brown") ;

	public static var BURLY_WOOD:ColorSVG = new ColorSVG(0xDEB887, "BurlyWood") ;

	public static var CADET_BLUE:ColorSVG = new ColorSVG(0x5F9EA0, "CadetBlue") ;
	
	public static var CHARTREUSE:ColorSVG = new ColorSVG(0x7FFF00, "Chartreuse") ;

	public static var CHOCOLATE:ColorSVG = new ColorSVG(0xD2691E, "Chocolate") ;

	public static var CORAL:ColorSVG = new ColorSVG(0xFF7F50, "Coral") ;

	public static var CORN_FLOWER_BLUE:ColorSVG = new ColorSVG(0x6495ED , "CornFlowerBlue") ;
	
	public static var CORN_SILK:ColorSVG = new ColorSVG(0xFFF8DC, "CornSilk") ;
	
	public static var CRIMSON:ColorSVG = new ColorSVG(0xDC143C, "CrimSon") ;
	
	public static var CYAN:ColorSVG = new ColorSVG(0x00FFFF, "Cyan") ;
		
	public static var DARK_BLUE:ColorSVG = new ColorSVG(0x00008B, "Darkblue") ;

	public static var DARK_CYAN:ColorSVG = new ColorSVG(0x0008B8B , "DarkCyan") ;

	public static var DARK_GOLDEN_ROD:ColorSVG = new ColorSVG(0xB8860B, "DarkGoldenRod") ;

	public static var DARK_GRAY:ColorSVG = new ColorSVG(0xA9A9A9, "DarkGray") ;

	public static var DARK_GREEN:ColorSVG = new ColorSVG(0x006400, "DarkGreen") ;

	public static var DARK_GREY:ColorSVG = new ColorSVG(0xA9A9A9, "DarkGrey") ;

	public static var DARK_KHAKI:ColorSVG = new ColorSVG(0xBDB76B, "DarkKhaki") ;

	public static var DARK_MAGENTA:ColorSVG = new ColorSVG(0x8B008B, "DarkMagenta") ;
	
	public static var DARK_OLIVE_GREEN:ColorSVG = new ColorSVG(0x556B2F, "DarkOliveGreen") ;

	public static var DARK_ORANGE:ColorSVG = new ColorSVG(0xFF8C00, "DarkOrange") ;
	
	public static var DARK_ORCHID:ColorSVG = new ColorSVG(0x9932CC, "DarkOrchid") ;
	
	public static var DARK_RED:ColorSVG = new ColorSVG(0x8b0000, "DarkRed") ;

	public static var DARK_SALMON:ColorSVG = new ColorSVG(0xE9967A, "DarkSalmon") ;

	public static var DARK_SEA_GREEN:ColorSVG = new ColorSVG(0x8FBC8F, "DarkSeaGreen") ;

	public static var DARK_SLATE_BLUE:ColorSVG = new ColorSVG(0x483F8B, "DarkSlateBlue") ;
	
	public static var DARK_SLATE_GRAY:ColorSVG = new ColorSVG(0x2F4F4F, "DarkSlateGray") ;
	
	public static var DARK_SLATE_GREY:ColorSVG = new ColorSVG(0x2F4F4F, "DarkSlateGrey") ;
	
	public static var DARK_TURQUOISE:ColorSVG = new ColorSVG(0x00CED1, "DarkTurquoise") ;
	
	public static var DARK_VIOLET:ColorSVG = new ColorSVG(0x9400D3, "DarkViolet") ;
	
	public static var DEEP_PINK:ColorSVG = new ColorSVG(0xff1493, "DeepPink") ;
	
	public static var DEEP_SKY_BLUE:ColorSVG = new ColorSVG(0x00bfff, "DeepSkyBlue") ;
	
	public static var DIM_GRAY:ColorSVG = new ColorSVG(0x696969, "DimGray") ;
	
	public static var DIM_GREY:ColorSVG = new ColorSVG(0x696969, "DimGrey") ;
	
	public static var DODGER_BLUE:ColorSVG = new ColorSVG(0x1e90ff, "DodgerBlue") ;
	
	public static var FIRE_BRICK:ColorSVG = new ColorSVG(0xb22222, "FireBrick") ;
	
	public static var FLORAL_WHITE:ColorSVG = new ColorSVG(0xfffaf0, "FloralWhite") ;
	
	public static var FOREST_GREEN:ColorSVG = new ColorSVG(0x228b22, "ForestGreen") ;
	
	public static var FUCHSIA:ColorSVG = new ColorSVG(0xff00ff , "Fuchsia") ;
	
	public static var GAINSBORO:ColorSVG = new ColorSVG(0xdcdcdc, "Gainsboro") ;
	
	public static var GHOST_WHITE:ColorSVG = new ColorSVG(0xf8f8ff, "GhostWhite") ;
	
	public static var GOLD:ColorSVG = new ColorSVG(0xffd700, "Gold") ;
	
	public static var GOLD_EN_ROD:ColorSVG = new ColorSVG(0xdaa520, "GoldEnRod") ;
	
	public static var GRAY:ColorSVG = new ColorSVG(0x808080 , "Gray") ;
	
	public static var GREY:ColorSVG = new ColorSVG(0x808080, "Grey") ;
	
	public static var GREEN:ColorSVG = new ColorSVG(0x008000 , "Green") ;
	
	public static var GREEN_YELLOW:ColorSVG = new ColorSVG(0xadff2f, "GreenYellow") ;
	
	public static var HONEY_DEW:ColorSVG = new ColorSVG(0xf0fff0, "HoneyDew") ;
	
	public static var HOT_PINK:ColorSVG = new ColorSVG(0xff69b4, "HotPink") ;
	
	public static var INDIAN_RED:ColorSVG = new ColorSVG(0xcd5c5c, "IndianRed") ;
	
	public static var INDIGO:ColorSVG = new ColorSVG(0x4b0082, "Indigo") ;
	
	public static var IVORY:ColorSVG = new ColorSVG(0xfffff0, "Ivory") ;
	
	public static var KHAKI:ColorSVG = new ColorSVG(0xf0e68c, "Khaki") ;
	
	public static var LAVENDER:ColorSVG = new ColorSVG(0xe6e6fa, "Lavender") ;
	
	public static var LAVENDER_BLUSH:ColorSVG = new ColorSVG(0xfff0f5, "LavenderBlush") ;
	
	public static var LAWN_GREEN:ColorSVG = new ColorSVG(0x7cfc00, "LawnGreen") ;
	
	public static var LEMON_CHIFFON:ColorSVG = new ColorSVG(0xfffacd, "LemonChiffon") ;
	
	public static var LIGHT_BLUE:ColorSVG = new ColorSVG(0xadd8e6, "LightBlue") ;
	
	public static var LIGHT_CORAL:ColorSVG = new ColorSVG(0xf08080, "LightCoral") ;
	
	public static var LIGHT_CYAN:ColorSVG = new ColorSVG(0xe0ffff, "LightCyan") ;
	
	public static var LIGHT_GOLDEN_ROD_YELLOW:ColorSVG = new ColorSVG(0xfafad2, "LightGoldenRodYellow") ;
		
	public static var LIGHT_GRAY:ColorSVG = new ColorSVG(0xd3d3d3, "LightGray") ;
	
	public static var LIGHT_GREEN:ColorSVG = new ColorSVG(0x90ee90, "LightGreen") ;
	
	public static var LIGHT_GREY:ColorSVG = new ColorSVG(0xd3d3d3, "LightGrey") ;
	
	public static var LIGHT_PINK:ColorSVG = new ColorSVG(0xffb6c1, "LightPink") ;
	
	public static var LIGHT_SALMON:ColorSVG = new ColorSVG(0xffa07a, "LightSalmon") ;
	
	public static var LIGHT_SEA_GREEN:ColorSVG = new ColorSVG(0x20b2aa, "LightSeaGreen") ;
	
	public static var LIGHT_SKY_BLUE:ColorSVG = new ColorSVG(0x87cefa, "LightSkyBlue") ;
	
	public static var LIGHT_SLATE_GRAY:ColorSVG = new ColorSVG(0x778899, "LightSlateGray") ;
	
	public static var LIGHT_SLATE_GREY:ColorSVG = new ColorSVG(0x778899, "LightSlateGrey") ;
	
	public static var LIGHT_STEEL_BLUE:ColorSVG = new ColorSVG(0xb0c4de, "LightSteelBlue") ;
	
	public static var LIGHT_YELLOW:ColorSVG = new ColorSVG(0xffffe0, "LightYellow") ;
	
	public static var LIME:ColorSVG = new ColorSVG(0x00FF00 , "Lime") ;
	
	public static var LIME_GREEN:ColorSVG = new ColorSVG(0x32cd32, "LimeGreen") ;
	
	public static var LINEN:ColorSVG = new ColorSVG(0xfaf0e6, "Linen") ;
	
	public static var MAGENTA:ColorSVG = new ColorSVG(0xff00ff, "Magenta") ;
	
	public static var MAROON:ColorSVG = new ColorSVG(0x800000 , "Maroon") ;
	
	public static var MEDIUM_AQUA_MARINE:ColorSVG = new ColorSVG(0x66cdaa, "MediumAquaMarine") ;
	
	public static var MEDIUM_BLUE:ColorSVG = new ColorSVG(0x0000cd, "MediumBlue") ;
	
	public static var MEDIUM_ORCHID:ColorSVG = new ColorSVG(0xba55d3, "MediumOrchid") ;
	
	public static var MEDIUM_PURPLE:ColorSVG = new ColorSVG(0x9370db, "MediumPurple") ;
	
	public static var MEDIUM_SEA_GREEN:ColorSVG = new ColorSVG(0x3cb371, "MediumSeaGreen") ;

	public static var MEDIUM_SLATE_BLUE:ColorSVG = new ColorSVG(0x7b68ee, "MediumSlateBlue") ;

	public static var MEDIUM_SPRING_GREEN:ColorSVG = new ColorSVG(0x00fa9a, "MediumSpringGreen") ;

	public static var MEDIUM_TURQUOISE:ColorSVG = new ColorSVG(0x48d1cc, "MediumTurquoise") ;

	public static var MEDIUM_VIOLET_RED:ColorSVG = new ColorSVG(0xc71585, "MediumVioletRed") ;

	public static var MIDNIGHT_BLUE:ColorSVG = new ColorSVG(0x191970, "MidnightBlue") ;

	public static var MINT_CREAM:ColorSVG = new ColorSVG(0xf5fffa, "MintCream") ;

	public static var MISTY_ROSE:ColorSVG = new ColorSVG(0xffe4e1, "MistyRose") ;

	public static var MOCCASIN:ColorSVG = new ColorSVG(0xffe4b5, "Moccasin") ;

	public static var NAVAJO_WHITE:ColorSVG = new ColorSVG(0xffdead, "NavajoWhite") ;
		
	public static var NAVY:ColorSVG = new ColorSVG(0x000080 , "Navy") ;
	
	public static var NONE:ColorSVG = new ColorSVG(null , "None") ;
	
	public static var OLD_LACE:ColorSVG = new ColorSVG(0xfdf5e6, "LodLace") ;
	
	public static var OLIVE:ColorSVG = new ColorSVG(0x808000 , "Olive") ;
	
	public static var OLIVE_DRAB:ColorSVG = new ColorSVG(0x6b8e23, "OliveDrab") ;
	
	public static var ORANGE:ColorSVG = new ColorSVG(0xffa500, "Orange") ;
	
	public static var ORANGE_RED:ColorSVG = new ColorSVG(0xff4500, "OrangeRed") ;
	
	public static var ORCHID:ColorSVG = new ColorSVG(0xda70d6, "Orchid") ;
	
	public static var PALE_GOLDEN_ROD:ColorSVG = new ColorSVG(0xeee8aa, "PaleGoldenRod") ;
	
	public static var PALE_GREEN:ColorSVG = new ColorSVG(0x98fb98, "PaleGreen") ;
	
	public static var PALE_TURQUOISE:ColorSVG = new ColorSVG(0xafeeee, "PaleTurquoise") ;
	
	public static var PALE_VIOLET_RED:ColorSVG = new ColorSVG(0xdb7093, "PaleVioletRed") ;
	
	public static var PAPAYA_WHIP:ColorSVG = new ColorSVG(0xffefd5, "PapayaWhip") ;
	
	public static var PEACHPUFF:ColorSVG = new ColorSVG(0xffdab9, "PeachPuff") ;
	
	public static var PERU:ColorSVG = new ColorSVG(0xcd853f, "Peru") ;
	
	public static var PINK:ColorSVG = new ColorSVG(0xffc0cb, "Pink") ;
	
	public static var PLUM:ColorSVG = new ColorSVG(0xdda0dd, "Plum") ;
	
	public static var POWDER_BLUE:ColorSVG = new ColorSVG(0xb0e0e6, "PowderBlue") ;
	
	public static var PURPLE:ColorSVG = new ColorSVG(0x800080 , "Purple") ;
	
	public static var RED:ColorSVG = new ColorSVG(0xFF0000 , "Red") ;
	
	public static var ROSY_BROWN:ColorSVG = new ColorSVG(0xbc8f8f, "RosyBrown") ;
	
	public static var ROYAL_BLUE:ColorSVG = new ColorSVG(0x4169e1, "RoyalBlue") ;
	
	public static var SADDLE_BROWN:ColorSVG = new ColorSVG(0x8b4513, "SaddleBrown") ;
	
	public static var SALMON:ColorSVG = new ColorSVG(0xfa8072, "Salmon") ;
	
	public static var SANDY_BROWN:ColorSVG = new ColorSVG(0xf4a460, "SandyBrown") ;
	
	public static var SEA_GREEN:ColorSVG = new ColorSVG(0x2e8b57, "SeaGreen") ;
	
	public static var SEA_SHELL:ColorSVG = new ColorSVG(0xfff5ee, "SeaShell") ;
	
	public static var SIENNA:ColorSVG = new ColorSVG(0xa0522d, "Sienna") ;
	
	public static var SILVER:ColorSVG = new ColorSVG(0xC0C0C0 , "Silver") ;
	
	public static var SKY_BLUE:ColorSVG = new ColorSVG(0x87ceeb, "SkyBlue") ;
	
	public static var SLATE_BLUE:ColorSVG = new ColorSVG(0x6a5acd, "SlateBlue") ;
	
	public static var SLATE_GRAY:ColorSVG = new ColorSVG(0x708090, "SlateGray") ;
	
	public static var SLATE_GREY:ColorSVG = new ColorSVG(0x708090, "SlateGrey") ;
	
	public static var SNOW:ColorSVG = new ColorSVG(0xFFFAFA, "Snow") ;

	public static var SPRING_GREEN:ColorSVG = new ColorSVG(0x00FF7F, "SpringGreen") ;

	public static var STEEL_BLUE:ColorSVG = new ColorSVG(0x4682b4, "SteelBlue") ;

	public static var TAN:ColorSVG = new ColorSVG(0xD2B48C, "Tan") ;

	public static var TEAL:ColorSVG = new ColorSVG(0x008080 , "Teal") ;

	public static var THISTLE:ColorSVG = new ColorSVG(0xD8BFD8, "Thistle") ;

	public static var TOMATO:ColorSVG = new ColorSVG(0xFF6347 , "Tomato") ;

	public static var TURQUOISE:ColorSVG = new ColorSVG(0x40E0D0 , "Turquoise") ;

	public static var VIOLET:ColorSVG = new ColorSVG(0xEE82EE, "Violet") ;

	public static var WHEAT:ColorSVG = new ColorSVG(0xF5DEB3, "Wheat") ;

	public static var WHITE:ColorSVG = new ColorSVG(0xFFFFFF , "White") ;
	
	public static var WHITE_SMOKE:ColorSVG = new ColorSVG(0xF5F5F5, "WhiteSmoke") ;
	
	public static var YELLOW:ColorSVG = new ColorSVG(0xFFFF00 , "Yellow") ;
	
	public static var YELLOW_GREEN:ColorSVG = new ColorSVG(0x9ACD32 , "YellowGreen") ;
	
	/**
	 * Returns true if the object passed in argument is in the map of ColorSVG elements.
	 * @return true if the object passed in argument is in the map of ColorSVG elements.
	 */
	public static function contains( o ):Boolean
	{
		if (o instanceof ColorSVG)
		{
			return ColorSVG.ELEMENTS.containsKey( o.name.toLowerCase() ) ;
		}
		else if (TypeUtil.typesMatch(o, String))
		{
			return ColorSVG.ELEMENTS.containsKey(o.toLowerCase()) ;
		}
		else
		{
			return false ;	
		}
	}
	
	/**
	 * Returns the current ColorSVG reference specified with the name passed in parameter.
	 * @return the current ColorSVG reference specified with the name passed in parameter.
	 */
	public static function get( name:String ):ColorSVG 
	{
		return ColorSVG.ELEMENTS.get(name.toLowerCase()) ;
	}

}