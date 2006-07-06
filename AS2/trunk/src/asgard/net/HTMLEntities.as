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

/** HTMLEntities

	AUTHOR

		Name : HTMLEntities
		Package : asgard.net
		Version : 1.0.0.0
		Date :  2006-06-27
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

 	PROPERTY SUMMARY
  
  		- static entities:Array
  
  		- static specialchars:Array
  		
  	METHOD SUMMARY

		- decode( text:String, removeCRLF:Boolean ):String

		- encode( text:String ):String

	NOTE
	
	list of HTML entities in CDATA tag:

		€ &euro;
		" &#34; &quot;
		& &#38; &amp;
		< &#60; &lt;
		> &#62; &gt;
		¡ &#161; &iexcl;
		¢ &#162; &cent;
		£ &#163; &pound;
		¤ &#164; &curren;
		¥ &#165; &yen;
		¦ &#166; &brvbar;
		§ &#167; &sect;
		¨ &#168; &uml;
		© &#169; &copy;
		ª &#170; &ordf;
		¬ &#172; &not;
		­ &#173; &shy;
		® &#174; &reg;
		¯ &#175; &macr;
		° &#176; &deg;
		± &#177; &plusmn;
		² &#178; &sup2;
		³ &#179; &sup3;
		´ &#180; &acute;
		µ &#181; &micro;
		¶ &#182; &para;
		· &#183; &middot;
		¸ &#184; &cedil;
		¹ &#185; &sup1;
		º &#186; &ordm;
		» &#187; &raquo;
		¼ &#188; &frac14;
		½ &#189; &frac12;
		¾ &#190; &frac34;
		¿ &#191; &iquest;
		À &#192; &Agrave;
		Á &#193; &Aacute;
		Ã &#195; &Atilde;
		Ä &#196; &Auml;
		Å &#197 &Aring;
		Æ &#198; &AElig;
		Ç &#199; &Ccedil;
		È &#200; &Egrave;
		É &#201; &Eacute;
		Ê &#202; &Ecirc;
		Ì &#204; &Igrave;
		Í &#205; &Iacute;
		Î &#206; &Icirc;
		Ï &#207; &Iuml;
		Ð &#208; &ETH;
		Ñ &#209; &Ntilde;
		Ò &#210; &Ograve;
		Ó &#211; &Oacute;
		Ô &#212; &Ocirc;
		Õ &#213; &Otilde;
		Ö &#214; &Ouml;
		× &#215; &times;
		Ø &#216; &Oslash;
		Ù &#217; &Ugrave;
		Ú &#218; &Uacute;
		Û &#219; &Ucirc;
		Ü &#220; &Uuml;
		Ý &#221; &Yacute;
		Þ &#222; &THORN;
		ß &#223; &szlig;
		à &#224; &agrave;
		á &#225; &aacute;
		â &#226; &acirc;
		ã &#227; &atilde;
		ä &#228; &auml;
		å &#229; &aring;
		æ &#230; &aelig;
		ç &#231; &ccedil;
		è &#232; &egrave;
		é &#233; &eacute;
		ê &#234; &ecirc;
		ë &#235; &euml;
		ì &#236; &igrave;
		í &#237 &iacute;
		î &#238; &icirc;
		ï &#239; &iuml;
		ð &#240; &eth;
		ñ &#241; &ntilde;
		ò &#242; &ograve;
		ó &#243; &oacute;
		ô &#244; &ocirc;
		õ &#245; &otilde;
		ö &#246; &ouml;
		÷ &#247; &divide;
		ø &#248; &oslash;
		ù &#249; &ugrave;
		ú &#250; &uacute;
		û &#251; &ucirc;
		ü &#252; &uuml;
		ý &#253; &yacute;
		þ &#254; &thorn;
		Non-breaking space &#160; &nbsp; (\u00A0 \xA0)

	THANKS
	
		- Zwetan.

**/

// TODO à tester !!

import vegas.util.StringUtil;

/**
 * @author eKameleon
 */
class asgard.net.HTMLEntities {
	
	
	// ----o Constructor
	
	private function HTMLEntities() 
		{
		//	
		}
	
	
	// ----o Public Properties

	static var entities:Array = [ 
		"&euro;", "&quot;", "&amp;", "&lt;", "&gt;", "&iexcl;", "&cent;", "&pound;", "&curren;", "&yen;",
		"&brvbar;", "&sect;", "&uml;", "&copy;", "&ordf;", "&not;", "&shy;", "&reg;", "&macr;", "&deg;",
		"&plusmn;", "&sup2;", "&sup3;", "&acute;", "&micro;", "&para;", "&middot;", "&cedil;", "&sup1;", "&ordm;",
		"&raquo;", "&frac14;", "&frac12;", "&frac34;", "&iquest;", "&Agrave;", "&Aacute;", "&Atilde;", "&Auml;", "&Aring;",
		"&AElig;", "&Ccedil;", "&Egrave;", "&Eacute;", "&Ecirc;", "&Igrave;", "&Iacute;", "&Icirc;", "&Iuml;", "&ETH;",
		"&Ntilde;", "&Ograve;", "&Oacute;", "&Ocirc;", "&Otilde;", "&Ouml;", "&times;", "&Oslash;", "&Ugrave;", "&Uacute;",
		"&Ucirc;", "&Uuml;", "&Yacute;", "&THORN;", "&szlig;", "&agrave;", "&aacute;", "&acirc;", "&atilde;", "&auml;",
		"&aring;", "&aelig;", "&ccedil;", "&egrave;", "&eacute;", "&ecirc;", "&euml;", "&igrave;", "&iacute;", "&icirc;",
		"&iuml;", "&eth;", "&ntilde;", "&ograve;", "&oacute;", "&ocirc;", "&otilde;", "&ouml;", "&divide;", "&oslash;",
		"&ugrave;", "&uacute;", "&ucirc;", "&uuml;", "&yacute;", "&thorn;", "&nbsp;" 
	];
		
	static var specialchars:Array = [ 
		"€", "\"", "&", "<", ">", "¡", "¢", "£", "¤", "¥",
		"¦", "§", "¨", "©", "ª", "¬", "­", "®", "¯", "°",
		"±", "²", "³", "´", "µ", "¶", "·", "¸", "¹", "º",
		"»", "¼", "½", "¾", "¿", "À", "Á", "Ã", "Ä", "Å",
		"Æ", "Ç", "È", "É", "Ê", "Ì", "Í", "Î", "Ï", "Ð",
		"Ñ", "Ò", "Ó", "Ô", "Õ", "Ö", "×", "Ø", "Ù", "Ú",
		"Û", "Ü", "Ý", "Þ", "ß", "à", "á", "â", "ã", "ä",
		"å", "æ", "ç", "è", "é", "ê", "ë", "ì", "í", "î",
		"ï", "ð", "ñ", "ò", "ó", "ô", "õ", "ö", "÷", "ø",
		"ù", "ú", "û", "ü", "ý", "þ", "\u00A0" 
	];

	// ----o Public Methods

	static function decode( text:String, removeCRLF:Boolean ):String 
		{
		var i:Number ;
		var ch:String ;
		var txt:StringUtil ;
		var entity:String ;
		var len:Number = entities.length ;
		for( i=0; i<len ; i++ )
			{
			ch = specialchars[ i ];
			entity = entities[ i ];
			if( text.indexOf( entity ) > -1 )
				{
				txt = new StringUtil(text) ;
				text = txt.replace( entity, ch );
				}
			}

		if( removeCRLF )
			{
			text = text.replace( "\r\n", "" );
			}
		return text;
		}

	static function encode( text:String ):String
		{
		var i:Number ;
		var ch:String ;
		var txt:StringUtil ;
		var entity:String ;
		var len:Number = entities.length ;
		for( i=0; i<len; i++ )
			{
			ch = specialchars[i];
			entity = entities[i];
			if( text.indexOf( ch ) > -1 )
				{
				txt = new StringUtil(text) ;
				text = txt.replace( ch, entity );
				}
			}
			return text.toString() ;
		}

}
