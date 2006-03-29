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

/**	LocalizationLoaderEvent

	AUTHOR

		Name : LocalizationLoaderEvent
		Package : asgard.events
		Version : 1.0.0.0
		Date :  2006-02-07
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
		
	CONSTRUCTOR
	
		new LocalizationLoaderEvent(type : String, loader:LocalizationLoader ) ;

	METHOD SUMMARY
	
		- clone()
	
		- getBytesLoaded():Number
	
		- getBytesTotal():Number

		- getData()

		- getLoader():ILoader

		- getLocalization(lang:Lang):Locale
		
		- getName():String
	
		- getPercent():Number
		
		- getTarget():Object
		
		- getType():String
		
		- setTarget(target:Object):Void
		
		- setType(type:String):Void
		
		- toString():String

	INHERIT
	
		CoreObject
			|
			BasicEvent
				|
				LoaderEvent
					|
					LocalizationLoaderEvent
		
	IMPLEMENTS
	
		IEvent

----------  */

import asgard.events.LoaderEvent;
import asgard.system.Lang;
import asgard.system.Locale;
import asgard.system.LocalizationLoader;


/**
 * @author eKameleon
 * @version 1.0.0.0
 */
 
class asgard.events.LocalizationLoaderEvent extends LoaderEvent {

	// ----o Constructor
		
	public function LocalizationLoaderEvent(type : String, loader:LocalizationLoader ) {
		super(type, loader);
	}
	
	// ----o Constant
	
	static public var CHANGE:String = "change" ;

	static private var __ASPF__ = _global.ASSetPropFlags(Lang, ["CHANGE"] , 7, 7) ;
	
	// ----o Public Methods
	
	public function clone() {
		return new LocalizationLoaderEvent( getType(), LocalizationLoader(getLoader())) ;
	}
	
	public function getLocalization(lang:Lang):Locale {
		return LocalizationLoader(getLoader()).getLocalization(lang) ;
	}

}