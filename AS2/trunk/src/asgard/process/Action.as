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

/* ---------- Action [interface]

	AUTHOR
	
		Name : Action
		Package : asgard.process
		Version : 1.0.0.0
		Date :  2005-07-05
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
	
	METHOD SUMMARY
	
		- addEventListener( eventName:String, listener, autoRemove:Boolean, priority:Number ):Void
		
		- clone()
		
		- notifyChanged():Void
		
		- notifyCleared():Void
		
		- notifyFinished():Void 
		
		- notifyLooped():Void
		
		- notifyResumed():Void
		
		- notifyStarted():Void
		
		- notifyStopped():Void
		
		- removeEventListener(eventName:String, listener):EventListener
		
		- run():Void
		
	INHERIT
	
		IRunnable

----------  */

import vegas.core.IRunnable;

interface asgard.process.Action extends IRunnable {
	
	function clone() ;
	
	function notifyFinished():Void ;
	
	function notifyStarted():Void ;
	
	// function run():Void
	
}