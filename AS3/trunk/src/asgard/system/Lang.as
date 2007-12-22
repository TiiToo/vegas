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
package asgard.system
{
	import vegas.core.CoreObject;
	import vegas.data.map.HashMap;
	import vegas.util.Serializer;	

	/**
	 * This static enumeration class defines the language code of the system on which the player is running. 
	 * The language is specified as a lowercase two-letter language code from ISO 639-1. 
	 * For Chinese, an additional uppercase two-letter country code from ISO 3166 distinguishes between Simplified and Traditional Chinese. 
	 * The languages codes are based on the English names of the language: for example, 'hu' specifies Hungarian.
     * <p><b>Example :</b></p>
     * <code>
	 * import asgard.system.Lang ;
	 * 
	 * trace("---- Lang.FR") ;
	 * 
	 * trace("> Lang.FR : " + Lang.FR) ;
	 * trace("> Lang.FR label : " + Lang.FR.label) ;
	 * trace("> Lang.FR toSource() : " + Lang.FR.toSource()) ;
	 * 
	 * trace("---- validate") ;
	 * 
	 * trace("> Lang.validate 'fr' : "   + Lang.validate("fr")) ;
	 * trace("> Lang.validate 'japo' : " + Lang.validate("japo")) ;
	 * trace("> Lang.validate 'fr' : "   + Lang.validate(Lang.FR)) ;
	 * 
	 * trace("---- Lang.Langs map") ;
	 * 
	 * trace("> Lang.Langs : " + Lang.LANGS) ;
	 * trace("> Lang.size() : " + Lang.size()) ;
	 * </code>
	 * @author eKameleon
	 * @see Capabilities.language
	 */
	public final class Lang extends CoreObject
	{
		
		/**
		 * Creates a new Lang instance.
		 */
		public function Lang( idLang:String , label:String )
		{
			this.label = label ;
			this.value = idLang ;
			put(this) ;
		}
		
		public static const CS:Lang    = new Lang("cs", "Czech") ;

		public static const ES:Lang    = new Lang("es", "Spanish") ;

		public static const DA:Lang    = new Lang("da", "Danish") ;

		public static const DE:Lang    = new Lang("de", "German") ;

		public static const EN:Lang    = new Lang("en", "English") ;

		public static const FI:Lang    = new Lang("fi", "Finnish") ;
		
		public static const FR:Lang    = new Lang("fr", "French") ;

		public static const HU:Lang    = new Lang("hu", "Hungarian") ;

		public static const IT:Lang    = new Lang("it", "Italian") ;
		
		public static const JA:Lang    = new Lang("ja", "Japanese") ;

		public static const KO:Lang    = new Lang("ko", "Korean") ;

		public static const NL:Lang    = new Lang("nl", "Dutch") ;

		public static const NO:Lang    = new Lang("no", "Norwegian") ;
		
		public static const XU:Lang    = new Lang("xu", "Other/unknown") ;
		
		public static const PL:Lang    = new Lang("pl", "Polish") ;
		
		public static const PT:Lang    = new Lang("pt", "Portuguese") ;
		
		public static const RU:Lang    = new Lang("ru", "Russian") ;
	
		public static const SV:Lang    = new Lang("sv", "Swedish") ;
	
		public static const TR:Lang    = new Lang("tr", "Turkish") ;
		
		public static const ZH_CN:Lang = new Lang("zh-CN", "Simplified Chinese") ;
		
		public static const ZH_TW:Lang = new Lang("zh-TW", "Traditional Chinese") ;
		
		/**
		 * The map 
		 */
		public static var LANGS:HashMap = new HashMap () ;

		/**
		 * The label of the current Lang instance.
		 */		
		public var label:String = null ;

		/**
		 * The value of the current Lang instance.
		 */		
		public var value:String = null ;
		
		/**
		 * Returns a Lang instance with the specified 'id' value.
		 * @return a Lang instance with the specified 'id' value.
		 */
		public static function get( id:String ):Lang
		{
			return LANGS.get(id) ;			
		}
		
		/**
		 * Insert a new key/value entry with a passed-in Lang argument.
		 */
		public static function put( lang:Lang ):*
		{
			return LANGS.put( lang.valueOf() , lang ) ;
		}
		
		/**
		 * Removes the specified Lang reference in the static LANGS HashMap.
		 */
		public static function remove( lang:Lang ):*
		{
			return LANGS.remove( lang.valueOf() ) ;
		}
		
		/**
		 * Returns the number of Lang reference register in the static LANGE HashMap.
		 * @return the number of Lang reference register in the static LANGE HashMap.
		 */
		public static function size():uint
		{
			return LANGS.size() ;
		}

		/**
		 * Returns the eden string representation of the object.
		 * @return the eden string representation of the object.
		 */
		public override function toSource( indent:int = 0 ):String 
		{
			return 'new Lang(' + Serializer.toSource(value) + ',' + Serializer.toSource(label) + ')' ;
		}

		/**
		 * Returns the string representation of this instance.
		 * @return the string representation of this instance.
		 */
		public override function toString():String
		{
			return value ;
		}
		
		/**
		 * Returns true if the passed value is a valid Lang reference.
		 * @return true if the passed value is a valid Lang reference.
		 */
		public static function validate( lang:* ):Boolean 
		{
		
			var sLang:String = (lang as String).toString() ;
		
			var langs:Array = LANGS.getKeys() ;
			for each ( var current:String in langs )
			{
				if (current == sLang) return true ;
			}
			return false ;
			
		}
		
		/**
		 * Returns the value of this instance.
		 * @return the value of this instance.
		 */
		public function valueOf():String
		{
			return value ;
		}


	
	}

}