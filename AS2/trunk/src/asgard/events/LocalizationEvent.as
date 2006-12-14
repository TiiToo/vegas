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
  Portions created by the Initial Developer are Copyright (C) 2004-2007
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

/**	LocalizationLoaderEvent

	AUTHOR

		Name : LocalizationLoaderEvent
		Package : asgard.events
		Version : 1.0.0.0
		Date :  2006-03-25
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
		
	CONSTRUCTOR
	
		new LocalizationEvent(type:String, localization:Localization ) ;

	METHOD SUMMARY
	
		- cancel():Void
		
		- clone():BasicEvent
		
		- getBubbles():Boolean
		
		- getContext()
		
		- getCurrent()
		
		- getCurrentTarget()
		
		- getEventPhase():Number
		
		- getLocale(sID:String):Locale
		
		- getTarget()
		
		- getTimeStamp():Number
		
		- getType():String
		
		- hashCode():Number
		
		- initEvent(type:String, bubbles:Boolean, cancelable:Boolean)
		
		- isCancelled():Boolean
		
		- isQueued():Boolean
		
		- queueEvent():Void
		
		- setBubbles(b:Boolean):Void
		
		- setContext(context):Void
		
		- setCurrentTarget(target):Void
		
		- setEventPhase(n:Number):Void
		
		- setTarget(target):Void
		
		- setType(type:String):Void
		
		- stopImmediatePropagation():Void
		
		- toSource(indent : Number, indentor : String):String
		
		- toString():String

	INHERIT
	
		CoreObject → BasicEvent → DynamicEvent → LoaderEvent → ConfigLoaderEvent
		
	IMPLEMENTS 
		
		Event, ICloneable, IFormattable, IHashable, ISerializable

	SEE ALSO
	
		Locale, Localization

**/

import asgard.system.Locale;
import asgard.system.Localization;

import vegas.events.BasicEvent;

/**
 * @author eKameleon
 * @version 1.0.0.0
 * @date 2006-03-24
 */
  
class asgard.events.LocalizationEvent extends BasicEvent {

	// ----o Constructor
		
	public function LocalizationEvent(type : String, localization:Localization, context, bubbles:Boolean, eventPhase:Number, time:Number, stop:Number) {
		super(type, localization, context, bubbles, eventPhase, time, stop) ;
	}
	
	// ----o Public Methods
	
	public function clone() {
		return new LocalizationEvent( getType (), Localization.getInstance() ) ;
	}
	
	public function getCurrent() {
		return Localization.getInstance().getCurrent() ;
	}

	public function getLocale(sID:String):Locale {
		return Localization.getInstance().getLocale(sID) ;
	}

}