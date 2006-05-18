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

/** Message

	AUTHOR
	
		Name : Message
		Package : asgard.process
		Version : 1.0.0.0
		Date :  2006-01-07
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	DESCRIPTION 
	
		Action qui permet de placer une pause et si il faut de notifier un message
	
	CONSTANT SUMMARY
	
		ME : indique que le message est destiné uniquement à celui qui l'écrit
		ALL : indique que le message est destiné à tous les utilisateurs

	PROPERTY SUMMARY
	
		- duration:Number [R/W]
		
		- face : attitude prise pendant l'envoi du message
		
		- to : ME , ALL ou une clé indiquant qui va recevoir ce message.
		
		- useSeconds:Boolean

	METHOD SUMMARY
	
		- addEventListener( eventName:String, listener, autoRemove:Boolean, priority:Number ):Void
		
		- clone():Message
		
		- getDuration():Number
		
		- notifyFinished():Void 
		
		- notifyStarted():Void 
		
		- removeEventListener(eventName:String, listener):EventListener
		
		- run():Void
		
		- setDuration(duration:Number):Void
		
		- start():Void
		
		- stop():Void
		
		- toString():String
	
	EVENT SUMMARY
	
		- ActionEventType.FINISH
		
		- ActionEventType.START
	
	INHERIT
	
		CoreObject > AbstractCoreEventDispatcher > AbstractAction > Pause

	IMPLEMENTS
	
		Action, IEventDispatcher, ICloneable, IRunnable, ISerializable, IFormattable
	
**/

import asgard.process.Pause;

import vegas.util.serialize.Serializer;

class asgard.process.Message extends Pause {

	// ----o Constructor
	
	public function Message(p_msg:String, p_face:String, p_duration:Number, p_to:Number, seconds:Boolean ) {
		super(p_duration || 1500, seconds) ;
		message = p_msg ;
		face = p_face ;
		to = p_to ;
	}

	// ----o Constants
	
	static public var ME:Number = 0 ;
	static public var ALL:Number = 1 ;
	
	static private var __ASPF__ = _global.ASSetPropFlags(Message, null , 7, 7) ;
	
	// ----o Public Properties

	public var message:String ;
	public var face:String ;
	public var to:Number ;
	
	// ----o Public Methods

	public function clone() {
		return new Message(message, face, _duration, to, useSeconds) ;
	}

	/*override*/ public function toSource(indent:Number, indentor:String):String {
		return Serializer.getSourceOf(this, [message, face, duration, to, Serializer.toSource(useSeconds) ]) ;
	}
	
	public function toString(Void):String {
		return "[Message : " + message + "]" ;
	}

}

