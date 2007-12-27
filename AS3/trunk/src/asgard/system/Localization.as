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
	import asgard.events.LocalizationEvent;
	
	import vegas.core.Identifiable;
	import vegas.data.map.HashMap;
	import vegas.events.AbstractCoreEventDispatcher;	

	/**
	 * The Localization class allows to manage via textual files with 'JSON' or 'eden' format to charge the textual contents 
	 * of an application according to the parameters of languages chosen by the users.
	 * <p>It is possible to define several singletons of the Localization class to manage several elements in the application, but for this it's necessary to use the static property getInstance(sName). 
	 * Thus all the authorities become of Singletons reusable a little everywhere in the application rather quickly.</p> 
	 * @author eKameleon
	 * @see Lang
	 * @see Locale
	 */
	public class Localization extends AbstractCoreEventDispatcher implements Identifiable
	{

		/**
		 * Creates a new Localization instance.
		 * @param sName the name of the object.
		 */
		public function Localization( id:*, bGlobal:Boolean = false, sChannel:String = null )
		{
			_map = new HashMap() ;
			_id = id ;
			super(bGlobal, sChannel);
		}
		
		/**
		 * The name of the event when the localization is changed.
		 */
		public static var CHANGE:String = LocalizationEvent.CHANGE  ;

		/**
		 * (read-write) Indicates the current {@code Lang} object selected in the current localization.
		 */
		public function get current():Lang 
		{
			return _current ;
		}
			
		/**
		 * @private
		 */
		public function set current( lang:Lang ):void
		{
			if ( Lang.validate(lang) ) 
			{
				_current = lang ;
				if ( contains(lang) ) 
				{
					notifyChange() ;
				}
				else 
				{
					ILocalizationLoader(_loader).load(_current) ;
				}
		}
		}	

		/**
		 * (read-write) Returns the id of this object.
		 * @return the id of this object.
		 */
		public function get id():*
		{
			return _id ;
		}
	
		/**
		 * @private
		 */
		public function set id( id:* ):void
		{
			_id = id ;
		}
		
		/**
		 * Returns {@code true} if this Localization contains the specified Lang.
	 	 * @return {@code true} if this Localization contains the specified Lang.
		 */
		public function contains( lang:Lang ):Boolean 
		{	 
			return _map.containsKey( lang.value ) ;
		}
	
		/**
		 * Returns the current {@code Locale} object defines with the specified {@code Lang} object in argument.
		 * @return the current {@code Locale} object defines with the specified {@code Lang} object in argument.
		 */
		public function get( lang:* ):Locale 
		{
			return _map.get(lang) ;
		}

		/**
		 * Notify when the Localization change.
		 */
		public function notifyChange():void 
		{
			dispatchEvent( new LocalizationEvent( _sTypeCHANGE , this ) ) ;
		}

		/**
		 * @private
		 */
		private var _current:Lang = null ;
		
		/**
		 * @privatz
		 */
		private var _id:* ;
		
		/**
		 * @private
		 */
		private var _map:HashMap = null ;
		
		/**
		 * @private
		 */
		private var _sTypeCHANGE:String = LocalizationEvent.CHANGE ;
		
	}
}
