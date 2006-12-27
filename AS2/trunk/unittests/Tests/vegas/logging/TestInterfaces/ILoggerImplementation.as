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

import vegas.data.Set;
import vegas.events.Event;
import vegas.events.EventListener;
import vegas.events.EventListenerCollection;
import vegas.logging.ILogger;

/**
 * @author eKameleon
 */
class Tests.vegas.logging.TestInterfaces.ILoggerImplementation implements ILogger 
{
	
	public var isAddEventListener:Boolean = false ;
	public var isAddGlobalEventListener:Boolean = false ;
	public var isDispatchEvent:Boolean = false ;
	public var isDebug:Boolean = false ;
	public var isError:Boolean = false ;
	public var isFatal:Boolean = false ;
	public var isGetEventListeners:Boolean = false ;
	public var isGetGlobalEventListeners:Boolean = false ;
	public var isGetRegisteredEventNames:Boolean = false ;
	public var isHasEventListener:Boolean = false ;
	public var isInfo:Boolean = false ;
	public var isLog:Boolean = false ;
	public var isRemoveEventListener:Boolean = false ;
	public var isRemoveGlobalEventListener:Boolean = false ;
	public var isString:Boolean = false ;
	public var isWarn:Boolean = false ;
	
	public function addEventListener(eventName : String, listener : EventListener, useCapture : Boolean, priority : Number, autoRemove : Boolean) : Void 
	{
		isAddEventListener = true ;
	}
	
	public function addGlobalEventListener(listener:EventListener, priority:Number, autoRemove:Boolean):Void 
	{
		isAddGlobalEventListener = true ;
	}

	public function dispatchEvent(event, isQueue:Boolean, target, context):Event 
	{
		isDispatchEvent = true ;
		return new Event() ;
	}
	
	public function debug(context):Void 
	{
		isDebug = true ;
	}

	public function error(context):Void 
	{
		isError = true ;
	}

	public function fatal(context):Void 
	{
		isFatal = true ;
	}

	public function getEventListeners(eventName:String):EventListenerCollection 
	{
		isGetEventListeners = true ;
		return new EventListenerCollection() ;
	}

	public function getGlobalEventListeners():EventListenerCollection 
	{
		isGetGlobalEventListeners = true ;
		return new EventListenerCollection() ;
	}

	public function getRegisteredEventNames():Set 
	{
		isGetRegisteredEventNames = true ;
		return new Set();
	}

	public function hasEventListener(eventName:String):Boolean 
	{
		isHasEventListener = true ;
		return true;
	}

	public function info(context):Void 
	{
		isInfo = true ;
	}

	public function log(level:Number, context):Void 
	{
		isLog = true ;
	}

	public function removeEventListener(eventName:String, listener, useCapture:Boolean):EventListener 
	{
		isRemoveEventListener = true ;
		return new EventListener();
	}

	public function removeGlobalEventListener(listener):EventListener 
	{
		isRemoveGlobalEventListener = true ;
		return new EventListener() ;
	}

	public function toString():String 
	{
		isString = true ;
		return "toString" ;
	}

	public function warn(context):Void 
	{
		isWarn = true ;
	}

}