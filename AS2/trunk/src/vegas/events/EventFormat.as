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

/* ------- 	EventFormat

	AUTHOR
	
		Name : EventFormat
		Package : vegas.events
		Version : 1.0.0.0
		Date :  2005-10-14
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	METHOD SUMMARY
	
		- formatToString(o):String
		
		- toString():String

	IMPLEMENTS
	
		IFormat, IFormattable, IHashable

----------  */

import vegas.core.CoreObject;
import vegas.core.IFormat;
import vegas.events.Event;
import vegas.events.EventPhase;
import vegas.util.ConstructorUtil;

class vegas.events.EventFormat extends CoreObject implements IFormat {

	// ----o Constructor

	public function EventFormat() {
		//
	}

	// ----o Public Methods

	public function formatToString(o):String {
		var ev:Event = Event(o) ;
		var phase:Number = ev.getEventPhase() ;
		var name:String = ConstructorUtil.getName(ev);
		var txt:String = "[" + name ;
		if (ev.getType()) txt += " " + ev.getType() ;
		switch (phase) {
			case EventPhase.CAPTURING_PHASE :
				txt += ", CAPTURING" ;
				break;
			case EventPhase.AT_TARGET:
				txt += ", AT TARGET" ;
				break ;
			case EventPhase.BUBBLING_PHASE:
				txt += ", BUBBLING" ;
				break ;
			default :
				txt += ", (inactive)" ;
				break;
		}
		if (ev.getBubbles() && phase != EventPhase.BUBBLING_PHASE) {
			txt += ", bubbles" ;
		}
		if (ev.isCancelled()) {
			txt += ", can cancel" ;
		}
		txt += "]" ;
		return txt ;
	}
	
}