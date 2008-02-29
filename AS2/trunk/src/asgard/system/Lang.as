/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is ASGard Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
 */
import vegas.data.map.HashMap;
import vegas.util.ArrayUtil;
import vegas.util.TypeUtil;

/**
 * This static enumeration class defines the language code of the system on which the player is running. 
 * The language is specified as a lowercase two-letter language code from ISO 639-1. 
 * For Chinese, an additional uppercase two-letter country code from ISO 3166 distinguishes between Simplified and Traditional Chinese. 
 * The languages codes are based on the English names of the language: for example, 'hu' specifies Hungarian.
 * @author eKameleon
 */
class asgard.system.Lang extends String 
{

    /**
     * Creates a new Lang instance.
     */
    public function Lang( id:String , label:String ) 
    {
        super( id ) ;
        this.label = label ;
        Lang.put( this ) ;
    }
    
    /**
     * The label of the current Lang instance.
     */        
    public var label:String = null ;    
    
    /**
     * Indicates the 'Czech' language reference.
     */    
    public static var CS:Lang = new Lang("cs" , "Czech") ;

    /**
     * Indicates the 'Danish' language reference.
     */
    public static var DA:Lang = new Lang("da" , "Danish") ;

    /**
     * Indicates the 'German' language reference.
     */
    public static var DE:Lang = new Lang("de" , "German") ;

    /**
     * Indicates the 'English' language reference.
     */
    public static var EN:Lang = new Lang("en" , "English") ;

    /**
     * Indicates the 'Spanish' language reference.
     */
    public static var ES:Lang = new Lang("es" , "Spanish") ;

    /**
     * Indicates the 'Finnish' language reference.
     */
    public static var FI:Lang = new Lang("fi" , "Finnish") ;

    /**
     * Indicates the 'French' language reference.
     */
    public static var FR:Lang = new Lang("fr" , "French") ;

    /**
     * Indicates the 'Hungarian' language reference.
     */
    public static var HU:Lang = new Lang("hu" , "Hungarian") ;

    /**
     * Indicates the 'Italian' language reference.
     */
    public static var IT:Lang = new Lang("it" , "Italian") ;

    /**
     * Indicates the 'Japanese' language reference.
     */
    public static var JA:Lang = new Lang("ja" , "Japanese") ;
    
    /**
     * Indicates the 'Korean' language reference.
     */
    public static var KO:Lang = new Lang("ko" , "Korean") ;

    /**
     * Indicates the 'Dutch' language reference.
     */
    public static var NL:Lang = new Lang("nl" , "Dutch") ;

    /**
     * Indicates the 'Norwegian' language reference.
     */
    public static var NO:Lang = new Lang("no" , "Norwegian") ;

    /**
     * Indicates the 'Other/unknown' language reference.
     */
    public static var XU:Lang = new Lang("xu" , "Other/unknown") ;

    /**
     * Indicates the 'Polish' language reference.
     */
    public static var PL:Lang = new Lang("pl" , "Polish") ;

    /**
     * Indicates the 'Portuguese' language reference.
     */
    public static var PT:Lang = new Lang("pt" , "Portuguese") ;

    /**
     * Indicates the 'Russian' language reference.
     */    
    public static var RU:Lang = new Lang("ru" , "Russian") ;

    /**
     * Indicates the 'Turkish' language reference.
     */
    public static var TR:Lang = new Lang("tr" , "Turkish") ;

    /**
     * Indicates the 'Swedish' language reference.
     */
    public static var SV:Lang = new Lang("sv" , "Swedish") ;

    /**
     * Indicates the 'Simplified Chinese' language reference.
     */
    public static var ZH_CN:Lang = new Lang("zh-CN" , "Simplified Chinese") ;

    /**
     * Indicates the 'Traditional Chinese' language reference.
     */
    public static var ZH_TW:Lang = new Lang("zh-TW" , "Traditional Chinese") ;

    /**
     * The map of all existing Lang reference in the application.
     */
    public static var LANGS:HashMap ;
    
    /**
     * Returns a Lang instance with the specified 'id' value.
     * @return a Lang instance with the specified 'id' value.
     */
    public static function get( id:String ):Lang 
    {
    	return LANGS.get( id.valueOf() ) ;            
    }

    /**
     * Inserts a new Lang in the Lang model.
     */
    public static function put( lang:Lang )
    {
    	if ( LANGS == null )
    	{
    		LANGS = new HashMap() ;
    	}    	
    	return LANGS.put( lang.valueOf() , lang ) ;
    }

    /**
     * Removes a new Lang in the Lang model.
     */
    public static function remove( lang:Lang ) 
    {
        return LANGS.remove( lang.valueOf() ) ;
    }

    /**
     * Returns the number of Lang reference register in the static LANGE HashMap.
     * @return the number of Lang reference register in the static LANGE HashMap.
     */
    public static function size():Number
    {
        return LANGS.size() ;
    }

    /**
     * Validate the specified lang in argument.
     * @return {@code true} if the lang passed in argument is registered in the model.
     */
    public static function validate( lang ):Boolean 
    {
        var s:String ;
        if ( lang instanceof Lang )
        {
            s = lang.toString() ;
        }
        else if ( TypeUtil.typesMatch( lang , String ) )
        {
            s = lang ;
        }
        else
        {
            return false ;
        }
        return ArrayUtil.contains(LANGS.getKeys(), s) ;
    }
    
}


