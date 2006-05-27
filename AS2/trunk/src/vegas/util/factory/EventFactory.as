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

/** EventFactory

	AUTHOR

		Name : EventFactory
		Package : vegas.util.factory
		Version : 1.0.0.0
		Date :  2006-01-19
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
	
	DESCRIPTION
		
		Permet de créer un objet qui implémente l'interface Event

	METHOD SUMMARY
	
		- static public create(o, target:Object, context:Object):Event
	
**/

import vegas.events.BasicEvent;
import vegas.events.Event;
import vegas.events.EventTarget;
import vegas.util.TypeUtil;

class vegas.util.factory.EventFactory {

	// ----o Constructor
	
	private function EventFactory() {
		//
	}

	// ----o Public Methods
	
	static public function create(o, target:EventTarget, context:Object):Event {
		
		var e:Event = null ;
		
		if (o instanceof Event) {
			
			if (o.getTarget() == null) o.setTarget(target) ;
			if (context) o.setContext(context) ;
			e = o ;
			
		} else if (TypeUtil.typesMatch(o, String)) {
			
			e = new BasicEvent(o, target, context) ;
			
		} else if (TypeUtil.typesMatch(o, Object)) {
			
			if (o.type == undefined) return null ;
			e = new BasicEvent(o.type, o.target , o.context) ;
			if (target) e.setTarget(target) ;
			if (context) e.setContext(context) ;
			
		}
		
		if (!e.getCurrentTarget()) e.setCurrentTarget(e.getTarget()) ;
		return e ;
	}
}