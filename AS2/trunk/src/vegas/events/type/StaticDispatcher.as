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

/** ---------- StaticDispatcher

	AUTHOR
	
		Name : StaticDispatcher
		Package : vegas.events.type
		Version : 1.0.0.0
		Date :  2005.10-12
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

  
	DESCRIPTION

		Cette classe utilise le modèle EDispatcher (compatibilité avec anciens projets)
		Cette classe est dépréciée dans Vegas.

	METHOD SUMMARY

		- static addEventListener(eventName:String, obj, func):Void 
		
		- static dispatchEvent(ev):Void
		
		- static eventListenerExists(eventName:String, obj , func):Boolean
		
		- static removeAllEventListeners(eventName:String):Void
		
		- static removeEventListener(eventName:String, obj, func):Void
		
		- static updateEvent(eventName:String, oInit):Void

----------  */

import vegas.events.EDispatcher;

class vegas.events.type.StaticDispatcher {

	// ----o Constructor
	
	private function StaticDispatcher() {
		//
	}

	// ----o Init EDispatcher Methods

	static private var __initDispatcher = EDispatcher.initialize (StaticDispatcher) ;

	// ----o Public Properties

	static public function addEventListener(eventName:String, obj, func):Void {}
	static public function dispatchEvent(ev):Void {}
	static public function eventListenerExists(eventName:String, obj , func):Boolean { return undefined; }
	static public function removeAllEventListeners(eventName:String):Void {}
	static public function removeEventListener(eventName:String, obj, func):Void {}
	static public function updateEvent(eventName:String, oInit):Void {}
	
}