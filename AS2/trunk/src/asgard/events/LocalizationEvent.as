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
		
	public function LocalizationEvent(type : String, localization:Localization ) {
		super(type, localization) ;
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