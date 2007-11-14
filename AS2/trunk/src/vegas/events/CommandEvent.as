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
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
 
import vegas.events.BasicEvent;
import vegas.events.Command;

/**
 * This event contains a Command object.
 * @author eKameleon
 */
class vegas.events.CommandEvent extends BasicEvent
{
	
	/**
	 * Creates a new CommandEvent instance.
	 * @param type the string type of the instance. 
	 * @param co The Command of the event.
	 * @param target the target of the event.
	 * @param context the optional context object of the event.
	 * @param bubbles indicates if the event is a bubbling event.
	 * @param eventPhase the current EventPhase of the event.
	 * @param time this parameter is used in the Eden deserialization.
	 * @param stop this parameter is used in the Eden deserialization.
	 */
	public function CommandEvent( type:String, co:Command , target, context, bubbles:Boolean, eventPhase:Number, time:Number, stop:Number ) 
	{
		super(type , target, context, bubbles, eventPhase, time , stop ) ;
		setCommand(co) ;
	}
	
	/**
	 * The name of the event invoqued to run a command.
	 */
	public static var RUN_COMMAND:String = "onRunCommand" ;
	
	/**
	 * Returns the Command reference.
	 * @return the Command reference.
	 */
	public function getCommand():Command
	{
		return _co ;
	}
	
	/**
	 * Sets the Command reference.
	 */
	public function setCommand( co:Command ):Void
	{
		_co = co ;
	}
		
	private var _co:Command ;

}