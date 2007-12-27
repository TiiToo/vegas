﻿/*

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

package asgard.events
{
	import flash.events.Event;
	
	import asgard.system.Lang;
	import asgard.system.Localization;
	
	import vegas.events.BasicEvent;	

	/**
	 * The LocalizationEvent is used in the Localization singleton to notify a change.
	 * @param type the string type of the instance. 
	 * @param target the target of the event.
	 * @param context the optional context object of the event.
	 * @param bubbles indicates if the event is a bubbling event.
	 * @param cancelable indicates if the event is a cancelable event.
	 * @param time this optional parameter is used in the eden deserialization to copy the timestamp value of this event.
	 * @author eKameleon
	 */
	public class LocalizationEvent extends BasicEvent
	{
		
		/**
	 	 * Creates a new LocalizationEvent instance.
		 */
		public function LocalizationEvent( type:String , target:Object = null , context:* = null , bubbles:Boolean = false , cancelable:Boolean = false, time:Number = 0 )
		{
			super( type, target, context, bubbles, cancelable, time );
		}
	
		/**
		 * The name of the event when the localization is changed.
		 */
		public static var CHANGE:String = "change"  ;
		
		/**
		 * The default singleton name of the Localization singletons.
		 */
		public static var DEFAULT_NAME:String = "" ;
		
		/**
	 	 * Returns a shallow copy of this object.
		 * @return a shallow copy of this object.
		 */
		public override function clone():Event
		{
			return new LocalizationEvent( type , target, context ) ;
    	}
	
		/**
		 * Returns the current Lang of the Localization singleton.
		 * @return the current Lang of the Localization singleton.
		 */
		public function getCurrent():Lang
		{
			var localization:Localization = target as Localization ;
			return ( localization != null ) ? ( target as Localization ).current : null ;
		}

		/**
		 * Returns the current {@code Local} reference or the internal value of the Local property passed in argument with the string in argument.
		 * @return the current {@code Local} reference or the internal value of the Local property passed in argument with the string in argument.
		 */
		public function getLocale( sID:String=null ):*
		{
			var localization:Localization = target as Localization ;
			return ( localization != null ) ? ( target as Localization ).getLocale( sID ) : null ;
		}
	
	}

}