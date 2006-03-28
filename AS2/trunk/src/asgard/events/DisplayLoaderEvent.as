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

import asgard.display.DisplayLoader;
import asgard.events.LoaderEvent;

/**
 * @author eKameleon
 * @version 1.0.0.0
 */
 
class asgard.events.DisplayLoaderEvent extends LoaderEvent {

	// ----o Constructor
		
	public function DisplayLoaderEvent(type : String, dLoader:DisplayLoader ) {
		super(type, dLoader);
	}
	
	// ----o Public Methods
	
	public function clone() {
		return new DisplayLoaderEvent( getType(), getLoader()) ;
	}
	
	public function getLoader():DisplayLoader {
		return DisplayLoader(_oLoader) ;
	}
	
	public function getView():MovieClip {
		return getLoader().getContent();
	}
	
}