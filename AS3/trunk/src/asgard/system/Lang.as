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
	import vegas.data.map.HashMap ;
	import vegas.util.Serializer ;
	
	/**
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
	 * trace("> Lang.validate 'fr' : " + Lang.validate("fr")) ;
	 * trace("> Lang.validate 'japo' : " + Lang.validate("japo")) ;
	 * trace("> Lang.validate 'fr' : " + Lang.validate(Lang.FR)) ;
	 * 
	 * trace("---- Lang.Langs map") ;
	 * 
	 * trace("> Lang.Langs : " + Lang.LANGS) ;
	 * trace("> Lang.size() : " + Lang.size()) ;
	 * </code>
	 * @author eKameleon
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
		 */
		public static function get( id:String ):Lang
		{
			return LANGS.get(id) ;			
		}

		public static function put( lang:Lang ):*
		{
			return LANGS.put( lang.valueOf() , lang ) ;
		}

		public static function remove( lang:Lang ):*
		{
			return LANGS.remove( lang.valueOf() ) ;
		}

		public static function size():uint
		{
			return LANGS.size() ;
		}

		override public function toSource(...arguments:Array):String
		{
			return 'new Lang(' + Serializer.toSource(value) + ',' + Serializer.toSource(label) + ')' ;
		}

		/**
		 * Returns the string representation of this instance.
		 * @return the string representation of this instance.
		 */
		override public function toString():String
		{
			return value ;
		}
		
		/**
		 * Returns true if the passed value is a valid Lang reference. 
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

		public static const CS:Lang    = new Lang("cs", "Tchèque") ;

		public static const DA:Lang    = new Lang("da", "Danois") ;

		public static const NL:Lang    = new Lang("nl", "Hollandais") ;

		public static const EN:Lang    = new Lang("en", "Anglais") ;

		public static const FI:Lang    = new Lang("fi", "Finlandais") ;

		public static const FR:Lang    = new Lang("fr", "Français") ;

		public static const DE:Lang    = new Lang("de", "Allemand") ;

		public static const HU:Lang    = new Lang("hu", "Hongrois") ;

		public static const IT:Lang    = new Lang("it", "Italien") ;

		public static const JA:Lang    = new Lang("ja", "Japonais") ;

		public static const KO:Lang    = new Lang("ko", "Coréen") ;

		public static const NO:Lang    = new Lang("no", "Norvégien") ;

		public static const XU:Lang    = new Lang("xu", "Autre/Inconnu") ;

		public static const PL:Lang    = new Lang("pl", "Polonais") ;

		public static const PT:Lang    = new Lang("pt", "Portugais") ;

		public static const RU:Lang    = new Lang("ru", "Russe") ;

		public static const ZH_CN:Lang = new Lang("zh-CN", "Chinois simplifié") ;

		public static const ES:Lang    = new Lang("es", "Espagnol") ;

		public static const SV:Lang    = new Lang("sv", "Suédois") ;

		public static const ZH_TW:Lang = new Lang("zh-TW", "Chinois Traditionnel") ;

		public static const TR:Lang    = new Lang("tr", "Turc") ;

	}

}