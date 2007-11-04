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
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

import vegas.data.map.HashMap;
import vegas.util.ArrayUtil;

// TODO change the full string of the Lang reference + localization.

/**
 * The Lang class register all international lang of the application. Use this class in the Localization model of ASGard.
 * @author eKameleon
 */
class asgard.system.Lang extends String 
{

	/**
	 * Creates a new Lang instance.
	 */
	public function Lang(s) 
	{
		super(s) ;
	}
	
	public static var CS:Lang    = new Lang("cs") ;

	public static var DA:Lang    = new Lang("da") ;

	public static var NL:Lang    = new Lang("nl") ;

	public static var EN:Lang    = new Lang("en") ;

	public static var FI:Lang    = new Lang("fi") ;

	public static var FR:Lang    = new Lang("fr") ;

	public static var DE:Lang    = new Lang("de") ;

	public static var HU:Lang    = new Lang("hu") ;

	public static var IT:Lang    = new Lang("it") ;

	public static var JA:Lang    = new Lang("ja") ;

	public static var KO:Lang    = new Lang("ko") ;

	public static var NO:Lang    = new Lang("no") ;

	public static var XU:Lang    = new Lang("xu") ;

	public static var PL:Lang    = new Lang("pl") ;

	public static var PT:Lang    = new Lang("pt") ;

	public static var RU:Lang    = new Lang("ru") ;

	public static var ZH_CN:Lang = new Lang("zh-CN") ;

	public static var ES:Lang    = new Lang("es") ;

	public static var SV:Lang    = new Lang("sv") ;

	public static var ZH_TW:Lang = new Lang("zh-TW") ;

	public static var TR:Lang    = new Lang("tr") ;

	public static var CS_FULL:String = "Tchèque" ;

	public static var DA_FULL:String = "Danois" ;

	public static var NL_FULL:String = "Hollandais" ;

	public static var EN_FULL:String = "Anglais" ;

	public static var FI_FULL:String = "Finlandais" ;

	public static var FR_FULL:String = "Français" ;

	public static var DE_FULL:String = "Allemand" ;

	public static var HU_FULL:String = "Hongrois" ;

	public static var IT_FULL:String = "Italien" ;

	public static var JA_FULL:String = "Japonais" ;

	public static var KO_FULL:String = "Coréen" ;

	public static var NO_FULL:String = "Norvégien" ;

	public static var XU_FULL:String = "Autre/Inconnu" ;

	public static var PL_FULL:String = "Polonais" ;

	public static var PT_FULL:String = "Portugais" ;

	public static var RU_FULL:String = "Russe" ;

	public static var ZH_CN_FULL:String = "Chinois simplifié" ;

	public static var ES_FULL:String = "Espagnol" ;

	public static var SV_FULL:String = "Suédois" ;

	public static var ZH_TW_FULL:String = "Chinois Traditionnel" ;

	public static var TR_FULL:String = "Turc" ;

	public static var LANGS:HashMap = new HashMap () ;
	
	/**
	 * Returns the name of the Lang define with the specified id in argument.
	 * @return the name of the Lang define with the specified id in argument.
	 */
	public static function get(id:String):String 
	{
		if (LANGS.size() == 0) 
		{
			Lang.initialize() ;
		}
		return LANGS.get(id) ;			
	}

	/**
	 * Initialize the model of this class.
	 */
	public static function initialize():Void 
	{
		LANGS.clear() ;
		LANGS.put(CS, CS_FULL) ;
		LANGS.put(DA, DA_FULL) ;
		LANGS.put(NL, NL_FULL) ;
		LANGS.put(EN, EN_FULL) ;
		LANGS.put(FI, FI_FULL);
		LANGS.put(FR, FR_FULL);
		LANGS.put(DE, DE_FULL) ;
		LANGS.put(HU, HU_FULL) ;
		LANGS.put(IT, IT_FULL) ;
		LANGS.put(JA, JA_FULL) ;
		LANGS.put(KO, KO_FULL) ;
		LANGS.put(NO, NO_FULL) ;
		LANGS.put(XU, XU_FULL) ;
		LANGS.put(PL, PL_FULL) ;
		LANGS.put(PT, PT_FULL) ;
		LANGS.put(RU, RU_FULL) ;
		LANGS.put(ZH_CN, ZH_CN_FULL) ;
		LANGS.put(ES, ES_FULL) ;
		LANGS.put(SV, SV_FULL) ;
		LANGS.put(ZH_TW, ZH_TW_FULL) ;
		LANGS.put(TR, TR_FULL) ;
	}

	/**
	 * Inserts a new Lang in the Lang model.
	 */
	public static function put( lang:Lang , label:String ) 
	{
		return LANGS.put(lang, label) ;
	}

	/**
	 * Removes a new Lang in the Lang model.
	 */
	public static function remove( lang:Lang ) 
	{
		return LANGS.remove(lang) ;
	}

	/**
	 * Validate the specified lang in argument.
	 * @return {@code true} if the lang passed in argument is registered in the model.
	 */
	public static function validate( lang:String ):Boolean 
	{
		
		var langs:Array = 
		[
			CS, DA, NL, EN, FI, FR,
			DE, HU, IT, JA, KO, NO,
			XU, PL, PT, RU, ZH_CN,
			ES, SV, ZH_TW, TR
		] ;
		
		return ArrayUtil.contains(langs, lang) ;
	}

	private static var __INITLANGS__ = Lang.initialize() ;
	
}


