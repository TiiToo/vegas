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
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
 */
import pegas.process.SimpleAction;

import vegas.events.EventDispatcher;

/**
 * A process who dispatch events in the global event flow with a singleton reference of the EventDispatcher class with a specified channel.
 * @author eKameleon
 */
class pegas.process.EventDispatcherProcess extends SimpleAction 
{

	/**
	 * Creates a new EventDispatcherProcess instance.
	 */
	public function EventDispatcherProcess( event , channel:String , bGlobal:Boolean, sChannel:String)
	{
		super( bGlobal, sChannel );
		this.event   = event   || null ;
		this.channel = channel || null ;
	}
	
	/**
	 * The channel of the global event dispatcher used in this process.
	 */
	public var channel:String = null ;
	
	/**
	 * The event to dispatch in this process.
	 */
	public var event ;

	/**
	 * Returns a shallow copy of this object.
	 * @return a shallow copy of this object.
	 */
	public function clone()
	{
		return new EventDispatcherProcess( event , channel ) ;
	}

    /**
	 * Run the process.
	 */
	public function run():Void 
	{
		notifyStarted() ;
		_setRunning(true) ;
		EventDispatcher.getInstance( channel ).dispatchEvent( event ) ;
		_setRunning(false) ;
		notifyFinished() ;
	}

}
