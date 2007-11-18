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
	import pegas.colors.ColorHTML;
	
	import vegas.data.map.HashMap;	

	/**
	 * All SVG W3C standard colors. 
	 * Basic HTML data types - W3C HTML 4 Specifications : <a href='http://www.w3.org/TR/html4/types.html (chap 6.5)'>http://www.w3.org/TR/html4/types.html</a> (chap 6.5).
	 * Scalable Vector Graphics Color Names : <a href='http://www.december.com/html/spec/colorsvg.html'>http://www.december.com/html/spec/colorsvg.html</a>
	 * @author eKameleon
 	 */
	public class ColorSVG extends ColorHTML 
	{
		


		/**
		 * Creates a new ColorSVG instance.
		 * @param n the value hex of the color.
		 * @param the name of the color.
		 */
		public function ColorSVG( value:Number , name:String )
		{
			super( value, name ) ;
			ELEMENTS.put( name.toLowerCase(), this ) ;
		}
		
		/**
		 * The Map of all SVG colors.
		 */
		public static var ELEMENTS:HashMap = new HashMap() ;

		public static const ALICE_BLUE:ColorSVG    = new ColorSVG(0xF0F8FF , "AliceBlue") ;
	
		public static const ANTIQUE_WHITE:ColorSVG = new ColorSVG(0xFAEBD7 , "AntiqueWhite") ;

		public static const AQUA:ColorSVG = new ColorSVG(0x00FFFF , "Aqua") ;
		
		public static const AQUA_MARINE:ColorSVG = new ColorSVG(0x00FFFF , "AquaMarine") ;
		
		public static const AZURE:ColorSVG = new ColorSVG(0xF0FFFF, "Azure") ;
		
		public static const BEIGE:ColorSVG = new ColorSVG(0xF5F5DC, "Beige") ;
		
		public static const BISQUE:ColorSVG = new ColorSVG(0xFFE4C4, "Bisque") ;
		
		public static const BLACK:ColorSVG = new ColorSVG(0x000000 , "Black") ;
	
		public static const BLANCHE_DALMOND:ColorSVG = new ColorSVG(0xFFEBCD, "BlancheDalmond") ;
	
		public static const BLUE:ColorSVG = new ColorSVG(0x0000FF , "Blue") ;
	
		public static const BLUE_VIOLET:ColorSVG = new ColorSVG(0x8A2BE2 , "BlueViolet") ;
	
		public static const BROWN:ColorSVG = new ColorSVG(0xA52A2A, "Brown") ;
	
		public static const BURLY_WOOD:ColorSVG = new ColorSVG(0xDEB887, "BurlyWood") ;
	
		public static const CADET_BLUE:ColorSVG = new ColorSVG(0x5F9EA0, "CadetBlue") ;
		
		public static const CHARTREUSE:ColorSVG = new ColorSVG(0x7FFF00, "Chartreuse") ;
	
		public static const CHOCOLATE:ColorSVG = new ColorSVG(0xD2691E, "Chocolate") ;
	
		public static const CORAL:ColorSVG = new ColorSVG(0xFF7F50, "Coral") ;
	
		public static const CORN_FLOWER_BLUE:ColorSVG = new ColorSVG(0x6495ED , "CornFlowerBlue") ;
		
		public static const CORN_SILK:ColorSVG = new ColorSVG(0xFFF8DC, "CornSilk") ;
		
		public static const CRIMSON:ColorSVG = new ColorSVG(0xDC143C, "CrimSon") ;
		
		public static const CYAN:ColorSVG = new ColorSVG(0x00FFFF, "Cyan") ;
			
		public static const DARK_BLUE:ColorSVG = new ColorSVG(0x00008B, "Darkblue") ;
	
		public static const DARK_CYAN:ColorSVG = new ColorSVG(0x0008B8B , "DarkCyan") ;
	
		public static const DARK_GOLDEN_ROD:ColorSVG = new ColorSVG(0xB8860B, "DarkGoldenRod") ;
	
		public static const DARK_GRAY:ColorSVG = new ColorSVG(0xA9A9A9, "DarkGray") ;
	
		public static const DARK_GREEN:ColorSVG = new ColorSVG(0x006400, "DarkGreen") ;
	
		public static const DARK_GREY:ColorSVG = new ColorSVG(0xA9A9A9, "DarkGrey") ;
	
		public static const DARK_KHAKI:ColorSVG = new ColorSVG(0xBDB76B, "DarkKhaki") ;
	
		public static const DARK_MAGENTA:ColorSVG = new ColorSVG(0x8B008B, "DarkMagenta") ;
		
		public static const DARK_OLIVE_GREEN:ColorSVG = new ColorSVG(0x556B2F, "DarkOliveGreen") ;
	
		public static const DARK_ORANGE:ColorSVG = new ColorSVG(0xFF8C00, "DarkOrange") ;
		
		public static const DARK_ORCHID:ColorSVG = new ColorSVG(0x9932CC, "DarkOrchid") ;
		
		public static const DARK_RED:ColorSVG = new ColorSVG(0x8b0000, "DarkRed") ;
	
		public static const DARK_SALMON:ColorSVG = new ColorSVG(0xE9967A, "DarkSalmon") ;
	
		public static const DARK_SEA_GREEN:ColorSVG = new ColorSVG(0x8FBC8F, "DarkSeaGreen") ;
	
		public static const DARK_SLATE_BLUE:ColorSVG = new ColorSVG(0x483F8B, "DarkSlateBlue") ;
		
		public static const DARK_SLATE_GRAY:ColorSVG = new ColorSVG(0x2F4F4F, "DarkSlateGray") ;
		
		public static const DARK_SLATE_GREY:ColorSVG = new ColorSVG(0x2F4F4F, "DarkSlateGrey") ;
		
		public static const DARK_TURQUOISE:ColorSVG = new ColorSVG(0x00CED1, "DarkTurquoise") ;
		
		public static const DARK_VIOLET:ColorSVG = new ColorSVG(0x9400D3, "DarkViolet") ;
		
		public static const DEEP_PINK:ColorSVG = new ColorSVG(0xff1493, "DeepPink") ;
		
		public static const DEEP_SKY_BLUE:ColorSVG = new ColorSVG(0x00bfff, "DeepSkyBlue") ;
		
		public static const DIM_GRAY:ColorSVG = new ColorSVG(0x696969, "DimGray") ;
		
		public static const DIM_GREY:ColorSVG = new ColorSVG(0x696969, "DimGrey") ;
		
		public static const DODGER_BLUE:ColorSVG = new ColorSVG(0x1e90ff, "DodgerBlue") ;
		
		public static const FIRE_BRICK:ColorSVG = new ColorSVG(0xb22222, "FireBrick") ;
		
		public static const FLORAL_WHITE:ColorSVG = new ColorSVG(0xfffaf0, "FloralWhite") ;
		
		public static const FOREST_GREEN:ColorSVG = new ColorSVG(0x228b22, "ForestGreen") ;
		
		public static const FUCHSIA:ColorSVG = new ColorSVG(0xff00ff , "Fuchsia") ;
		
		public static const GAINSBORO:ColorSVG = new ColorSVG(0xdcdcdc, "Gainsboro") ;
		
		public static const GHOST_WHITE:ColorSVG = new ColorSVG(0xf8f8ff, "GhostWhite") ;
		
		public static const GOLD:ColorSVG = new ColorSVG(0xffd700, "Gold") ;
		
		public static const GOLD_EN_ROD:ColorSVG = new ColorSVG(0xdaa520, "GoldEnRod") ;
		
		public static const GRAY:ColorSVG = new ColorSVG(0x808080 , "Gray") ;
		
		public static const GREY:ColorSVG = new ColorSVG(0x808080, "Grey") ;
		
		public static const GREEN:ColorSVG = new ColorSVG(0x008000 , "Green") ;
	
		public static const GREEN_YELLOW:ColorSVG = new ColorSVG(0xadff2f, "GreenYellow") ;
		
		public static const HONEY_DEW:ColorSVG = new ColorSVG(0xf0fff0, "HoneyDew") ;
		
		public static const HOT_PINK:ColorSVG = new ColorSVG(0xff69b4, "HotPink") ;
		
		public static const INDIAN_RED:ColorSVG = new ColorSVG(0xcd5c5c, "IndianRed") ;
		
		public static const INDIGO:ColorSVG = new ColorSVG(0x4b0082, "Indigo") ;
		
		public static const IVORY:ColorSVG = new ColorSVG(0xfffff0, "Ivory") ;
		
		public static const KHAKI:ColorSVG = new ColorSVG(0xf0e68c, "Khaki") ;
		
		public static const LAVENDER:ColorSVG = new ColorSVG(0xe6e6fa, "Lavender") ;
		
		public static const LAVENDER_BLUSH:ColorSVG = new ColorSVG(0xfff0f5, "LavenderBlush") ;
		
		public static const LAWN_GREEN:ColorSVG = new ColorSVG(0x7cfc00, "LawnGreen") ;
		
		public static const LEMON_CHIFFON:ColorSVG = new ColorSVG(0xfffacd, "LemonChiffon") ;
		
		public static const LIGHT_BLUE:ColorSVG = new ColorSVG(0xadd8e6, "LightBlue") ;
		
		public static const LIGHT_CORAL:ColorSVG = new ColorSVG(0xf08080, "LightCoral") ;
		
		public static const LIGHT_CYAN:ColorSVG = new ColorSVG(0xe0ffff, "LightCyan") ;
		
		public static const LIGHT_GOLDEN_ROD_YELLOW:ColorSVG = new ColorSVG(0xfafad2, "LightGoldenRodYellow") ;
			
		public static const LIGHT_GRAY:ColorSVG = new ColorSVG(0xd3d3d3, "LightGray") ;
		
		public static const LIGHT_GREEN:ColorSVG = new ColorSVG(0x90ee90, "LightGreen") ;
		
		public static const LIGHT_GREY:ColorSVG = new ColorSVG(0xd3d3d3, "LightGrey") ;
		
		public static const LIGHT_PINK:ColorSVG = new ColorSVG(0xffb6c1, "LightPink") ;
		
		public static const LIGHT_SALMON:ColorSVG = new ColorSVG(0xffa07a, "LightSalmon") ;
		
		public static const LIGHT_SEA_GREEN:ColorSVG = new ColorSVG(0x20b2aa, "LightSeaGreen") ;
		
		public static const LIGHT_SKY_BLUE:ColorSVG = new ColorSVG(0x87cefa, "LightSkyBlue") ;
		
		public static const LIGHT_SLATE_GRAY:ColorSVG = new ColorSVG(0x778899, "LightSlateGray") ;
			
		public static const LIGHT_SLATE_GREY:ColorSVG = new ColorSVG(0x778899, "LightSlateGrey") ;
			
		public static const LIGHT_STEEL_BLUE:ColorSVG = new ColorSVG(0xb0c4de, "LightSteelBlue") ;
	
		public static const LIGHT_YELLOW:ColorSVG = new ColorSVG(0xffffe0, "LightYellow") ;
	
		public static const LIME:ColorSVG = new ColorSVG(0x00FF00 , "Lime") ;
	
		public static const LIME_GREEN:ColorSVG = new ColorSVG(0x32cd32, "LimeGreen") ;
		
		public static const LINEN:ColorSVG = new ColorSVG(0xfaf0e6, "Linen") ;
		
		public static const MAGENTA:ColorSVG = new ColorSVG(0xff00ff, "Magenta") ;
		
		public static const MAROON:ColorSVG = new ColorSVG(0x800000 , "Maroon") ;
		
		public static const MEDIUM_AQUA_MARINE:ColorSVG = new ColorSVG(0x66cdaa, "MediumAquaMarine") ;
	
		public static const MEDIUM_BLUE:ColorSVG = new ColorSVG(0x0000cd, "MediumBlue") ;
	
		public static const MEDIUM_ORCHID:ColorSVG = new ColorSVG(0xba55d3, "MediumOrchid") ;
	
		public static const MEDIUM_PURPLE:ColorSVG = new ColorSVG(0x9370db, "MediumPurple") ;
	
		public static const MEDIUM_SEA_GREEN:ColorSVG = new ColorSVG(0x3cb371, "MediumSeaGreen") ;

		public static const MEDIUM_SLATE_BLUE:ColorSVG = new ColorSVG(0x7b68ee, "MediumSlateBlue") ;

		public static const MEDIUM_SPRING_GREEN:ColorSVG = new ColorSVG(0x00fa9a, "MediumSpringGreen") ;

		public static const MEDIUM_TURQUOISE:ColorSVG = new ColorSVG(0x48d1cc, "MediumTurquoise") ;

		public static const MEDIUM_VIOLET_RED:ColorSVG = new ColorSVG(0xc71585, "MediumVioletRed") ;

		public static const MIDNIGHT_BLUE:ColorSVG = new ColorSVG(0x191970, "MidnightBlue") ;

		public static const MINT_CREAM:ColorSVG = new ColorSVG(0xf5fffa, "MintCream") ;

		public static const MISTY_ROSE:ColorSVG = new ColorSVG(0xffe4e1, "MistyRose") ;

		public static const MOCCASIN:ColorSVG = new ColorSVG(0xffe4b5, "Moccasin") ;

		public static const NAVAJO_WHITE:ColorSVG = new ColorSVG(0xffdead, "NavajoWhite") ;
		
		public static const NAVY:ColorSVG = new ColorSVG( 0x000080 , "Navy") ;
	
		public static const NONE:ColorSVG = new ColorSVG( 0x000000 , "None") ;
	
		public static const OLD_LACE:ColorSVG = new ColorSVG(0xfdf5e6, "LodLace") ;
	
		public static const OLIVE:ColorSVG = new ColorSVG(0x808000 , "Olive") ;
	
		public static const OLIVE_DRAB:ColorSVG = new ColorSVG(0x6b8e23, "OliveDrab") ;
	
		public static const ORANGE:ColorSVG = new ColorSVG(0xffa500, "Orange") ;
	
		public static const ORANGE_RED:ColorSVG = new ColorSVG(0xff4500, "OrangeRed") ;
	
		public static const ORCHID:ColorSVG = new ColorSVG(0xda70d6, "Orchid") ;
	
		public static const PALE_GOLDEN_ROD:ColorSVG = new ColorSVG(0xeee8aa, "PaleGoldenRod") ;
	
		public static const PALE_GREEN:ColorSVG = new ColorSVG(0x98fb98, "PaleGreen") ;
	
		public static const PALE_TURQUOISE:ColorSVG = new ColorSVG(0xafeeee, "PaleTurquoise") ;
	
		public static const PALE_VIOLET_RED:ColorSVG = new ColorSVG(0xdb7093, "PaleVioletRed") ;
	
		public static const PAPAYA_WHIP:ColorSVG = new ColorSVG(0xffefd5, "PapayaWhip") ;
	
		public static const PEACHPUFF:ColorSVG = new ColorSVG(0xffdab9, "PeachPuff") ;
	
		public static const PERU:ColorSVG = new ColorSVG(0xcd853f, "Peru") ;
	
		public static const PINK:ColorSVG = new ColorSVG(0xffc0cb, "Pink") ;
	
		public static const PLUM:ColorSVG = new ColorSVG(0xdda0dd, "Plum") ;
	
		public static const POWDER_BLUE:ColorSVG = new ColorSVG(0xb0e0e6, "PowderBlue") ;
	
		public static const PURPLE:ColorSVG = new ColorSVG(0x800080 , "Purple") ;
	
		public static const RED:ColorSVG = new ColorSVG(0xFF0000 , "Red") ;
	
		public static const ROSY_BROWN:ColorSVG = new ColorSVG(0xbc8f8f, "RosyBrown") ;
	
		public static const ROYAL_BLUE:ColorSVG = new ColorSVG(0x4169e1, "RoyalBlue") ;
	
		public static const SADDLE_BROWN:ColorSVG = new ColorSVG(0x8b4513, "SaddleBrown") ;
	
		public static const SALMON:ColorSVG = new ColorSVG(0xfa8072, "Salmon") ;
	
		public static const SANDY_BROWN:ColorSVG = new ColorSVG(0xf4a460, "SandyBrown") ;
	
		public static const SEA_GREEN:ColorSVG = new ColorSVG(0x2e8b57, "SeaGreen") ;
	
		public static const SEA_SHELL:ColorSVG = new ColorSVG(0xfff5ee, "SeaShell") ;
	
		public static const SIENNA:ColorSVG = new ColorSVG(0xa0522d, "Sienna") ;
	
		public static const SILVER:ColorSVG = new ColorSVG(0xC0C0C0 , "Silver") ;
	
		public static const SKY_BLUE:ColorSVG = new ColorSVG(0x87ceeb, "SkyBlue") ;
	
		public static const SLATE_BLUE:ColorSVG = new ColorSVG(0x6a5acd, "SlateBlue") ;
	
		public static const SLATE_GRAY:ColorSVG = new ColorSVG(0x708090, "SlateGray") ;
	
		public static const SLATE_GREY:ColorSVG = new ColorSVG(0x708090, "SlateGrey") ;
	
		public static const SNOW:ColorSVG = new ColorSVG(0xFFFAFA, "Snow") ;

		public static const SPRING_GREEN:ColorSVG = new ColorSVG(0x00FF7F, "SpringGreen") ;

		public static const STEEL_BLUE:ColorSVG = new ColorSVG(0x4682b4, "SteelBlue") ;

		public static const TAN:ColorSVG = new ColorSVG(0xD2B48C, "Tan") ;

		public static const TEAL:ColorSVG = new ColorSVG(0x008080 , "Teal") ;

		public static const THISTLE:ColorSVG = new ColorSVG(0xD8BFD8, "Thistle") ;

		public static const TOMATO:ColorSVG = new ColorSVG(0xFF6347 , "Tomato") ;

		public static const TURQUOISE:ColorSVG = new ColorSVG(0x40E0D0 , "Turquoise") ;

		public static const VIOLET:ColorSVG = new ColorSVG(0xEE82EE, "Violet") ;

		public static const WHEAT:ColorSVG = new ColorSVG(0xF5DEB3, "Wheat") ;

		public static const WHITE:ColorSVG = new ColorSVG(0xFFFFFF , "White") ;
	
		public static const WHITE_SMOKE:ColorSVG = new ColorSVG(0xF5F5F5, "WhiteSmoke") ;
	
		public static const YELLOW:ColorSVG = new ColorSVG(0xFFFF00 , "Yellow") ;
	
		public static const YELLOW_GREEN:ColorSVG = new ColorSVG(0x9ACD32 , "YellowGreen") ;
		
		/**
	 	 * Returns true if the object passed in argument is in the map of ColorSVG elements.
		 * @return true if the object passed in argument is in the map of ColorSVG elements.
		 */
		public static function contains( o:* ):Boolean
		{
			if ( o is ColorSVG )
			{
				return ColorSVG.ELEMENTS.containsKey( o.name.toLowerCase() ) ;
			}
			else if ( o is String )
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

}
