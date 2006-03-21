﻿/*

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

/* ---------- MovieClipDispatcher 1.0.0

	AUTHOR

		Name : MovieClipDispatcher
		Package : vegas.events.type
		Version : 1.0.0.0
		Date :  2005-10-12
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	METHOD SUMMARY

		- addEventListener(eventName:String, obj, func):Void 
		
		- dispatchEvent(ev):Void
		
		- eventListenerExists(eventName:String, obj , func):Boolean
		
		- removeAllEventListeners(eventName:String):Void
		
		- removeEventListener(eventName:String, obj, func):Void
		
		- updateEvent(eventName:String, oInit):Void

	INHERIT
	
		Object > MovieClip > MovieClipDispatcher

	IMPLEMENT
	
		IDispatcher
		
----------  */

import vegas.events.EDispatcher ;
import vegas.events.IDispatcher ;
import vegas.core.HashCode ;
import vegas.core.IFormattable ;
import vegas.core.IHashable ;

class vegas.events.type.MovieClipDispatcher extends MovieClip implements IDispatcher, IFormattable, IHashable {

	// ----o Constructor
	
	private function MovieClipDispatcher() {
		//
	}

	// ----o Init HashCode
	
	static private var _initHashCode:Boolean = HashCode.initialize(MovieClipDispatcher.prototype) ;
	

	// ----o EventDispatcher
	
	static private var _initDispatcher = EDispatcher.initialize(MovieClipDispatcher.prototype) ; 
		
	// ----o Public Properties

	public function addEventListener(eventName:String, obj, func):Void {
		//
	}
	
	public function dispatchEvent(ev):Void {
		//
	}
		
	public function eventListenerExists(eventName:String, obj , func):Boolean { 
		return undefined ;
	}

	public function hashCode():Number {
		return null ;
	}
	
	public function removeAllEventListeners(eventName:String):Void {
		//
	}
	
	public function removeEventListener(eventName:String, obj, func):Void {
		//
	}
	
	public function updateEvent(eventName:String, oInit):Void {
		//
	}

}