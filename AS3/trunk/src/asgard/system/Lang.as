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

/* Lang

	AUTHOR

		Name : Lang
		Package : asgard.system
		Version : 1.0.0.0
		Date :  2006-08-16
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	EXAMPLE
	
		import asgard.system.Lang ;
		
		trace("---- Lang.FR") ;
			
		trace("> Lang.FR : " + Lang.FR) ;
		trace("> Lang.FR label : " + Lang.FR.label) ;
		trace("> Lang.FR toSource() : " + Lang.FR.toSource()) ;
		
		trace("---- validate") ;
		
		trace("> Lang.validate 'fr' : " + Lang.validate("fr")) ;
		trace("> Lang.validate 'japo' : " + Lang.validate("japo")) ;
		trace("> Lang.validate 'fr' : " + Lang.validate(Lang.FR)) ;
		
		trace("---- Lang.Langs map") ;
		
		trace("> Lang.Langs : " + Lang.LANGS) ;
		trace("> Lang.size() : " + Lang.size()) ;
	

*/

// TODO : add localization

package asgard.system
{
	
	import vegas.core.CoreObject;
	import vegas.data.map.HashMap ;
	import vegas.util.Serializer ;
	
	/**
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
		static public var LANGS:HashMap = new HashMap () ;

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
		static public function get( id:String ):Lang
		{
			return LANGS.get(id) ;			
		}

		static public function put( lang:Lang ):*
		{
			return LANGS.put( lang.valueOf() , lang ) ;
		}

		static public function remove( lang:Lang ):*
		{
			return LANGS.remove( lang.valueOf() ) ;
		}

		static public function size():uint
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
		static public function validate( lang:* ):Boolean 
		{
		
			var sLang:String = lang.toString() ;
		
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

		// ----o Constants

		static public const CS:Lang    = new Lang("cs", "Tchèque") ;
		static public const DA:Lang    = new Lang("da", "Danois") ;
		static public const NL:Lang    = new Lang("nl", "Hollandais") ;
		static public const EN:Lang    = new Lang("en", "Anglais") ;
		static public const FI:Lang    = new Lang("fi", "Finlandais") ;
		static public const FR:Lang    = new Lang("fr", "Français") ;
		static public const DE:Lang    = new Lang("de", "Allemand") ;
		static public const HU:Lang    = new Lang("hu", "Hongrois") ;
		static public const IT:Lang    = new Lang("it", "Italien") ;
		static public const JA:Lang    = new Lang("ja", "Japonais") ;
		static public const KO:Lang    = new Lang("ko", "Coréen") ;
		static public const NO:Lang    = new Lang("no", "Norvégien") ;
		static public const XU:Lang    = new Lang("xu", "Autre/Inconnu") ;
		static public const PL:Lang    = new Lang("pl", "Polonais") ;
		static public const PT:Lang    = new Lang("pt", "Portugais") ;
		static public const RU:Lang    = new Lang("ru", "Russe") ;
		static public const ZH_CN:Lang = new Lang("zh-CN", "Chinois simplifié") ;
		static public const ES:Lang    = new Lang("es", "Espagnol") ;
		static public const SV:Lang    = new Lang("sv", "Suédois") ;
		static public const ZH_TW:Lang = new Lang("zh-TW", "Chinois Traditionnel") ;
		static public const TR:Lang    = new Lang("tr", "Turc") ;
		
	}
}