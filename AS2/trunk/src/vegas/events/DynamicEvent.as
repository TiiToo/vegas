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

import vegas.events.BasicEvent;

/**
 * {@code BasicEvent} is the dynamic event structure to work with {@link EventDispatcher} and {@link FastDispatcher}.
 * <p><b>Example</b></p>
 * {@code var e:BasicEvent = new DynamicEvent(type, target, context) ; } 
 * @author  eKameleon
 * @see     CoreObject	
 * @see     Event	
 */
dynamic class vegas.events.DynamicEvent extends BasicEvent 
{

	// ----o Constructor
	
	public function DynamicEvent( type:String, target, context, bubbles:Boolean, eventPhase:Number, time:Number, stop:Number) 
	{
		super(type, target, context, bubbles, eventPhase, time, stop) ;
	}

	// ----o Public Properties

	public function get bubbles():Boolean 
	{
		return getBubbles() ;	
	}

	public function set bubbles(b:Boolean):Void 
	{
		setBubbles(b) ;	
	}

	public function get context() 
	{
		return getContext() ;	
	}

	public function set context(o):Void 
	{
		setContext(o) ;	
	}

	public function get currentTarget() 
	{
		return getCurrentTarget() ;	
	}

	public function set currentTarget(o):Void 
	{
		setCurrentTarget(o) ;	
	}

	public function get eventPhase():Number 
	{
		return getEventPhase() ;	
	}

	public function set eventPhase(n:Number):Void 
	{
		setEventPhase(n) ;	
	}

	public function get target() 
	{
		return getTarget() ;	
	}

	public function set target(o):Void 
	{
		setTarget(o) ;	
	}
	
	public function get timeStamp():Number 
	{
		return getTimeStamp() ;	
	}

	public function get type():String 
	{
		return getType() ;	
	}

	public function set type(s:String):Void 
	{
		setType(s) ;	
	}

	// ----o Public Methods

	/*override*/ public function clone() 
	{
		return new DynamicEvent(getType(), getTarget(), getContext()) ;
	}

}
