/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is PEGAS Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2007
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

import pegas.process.Pause;

import vegas.util.serialize.Serializer;

/**
 * This Action create a pause and notify an message in a process.
 */
class pegas.process.Message extends Pause 
{

	/**
	 * Creates a new Message instance.
	 */
	public function Message(p_msg:String, p_face:String, p_duration:Number, p_to:Number, seconds:Boolean ) 
	{
		super(p_duration || 1500, seconds) ;
		message = p_msg ;
		face = p_face ;
		to = p_to ;
	}
	
	static public var ME:Number = 0 ;

	static public var ALL:Number = 1 ;
	
	static private var __ASPF__ = _global.ASSetPropFlags(Message, null , 7, 7) ;
	
	public var message:String ;

	public var face:String ;

	public var to:Number ;
	
	public function clone() 
	{
		return new Message(message, face, _duration, to, useSeconds) ;
	}

	/*override*/ public function toSource(indent:Number, indentor:String):String 
	{
		return Serializer.getSourceOf(this, [message, face, duration, to, Serializer.toSource(useSeconds) ]) ;
	}
	
	public function toString(Void):String 
	{
		return "[Message : " + message + "]" ;
	}

}

