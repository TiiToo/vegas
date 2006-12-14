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

/**	URLLoaderEvent

	AUTHOR

		Name : URLLoaderEvent
		Package : asgard.events
		Version : 1.0.0.0
		Date :  2006-05-18
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
	
	PROPERTY SUMMARY
	
		- code:Number
		
		- error:String
	
	METHOD SUMMARY
	
		- cancel():Void
		
		- clone():LoaderEvent
		
		- getBubbles():Boolean
		
		- getBytesLoaded():Number
		
		- getBytesTotal():Number
		
		- getContext()
		
		- getCurrentTarget()
		
		- getData()
		
		- getDataFormat():String
		
		- getEventPhase():Number
		
		- getLoader():ILoader
		
		- getName():String
		
		- getPercent():Number
		
		- getTarget()
		
		- getTimeStamp():Number
		
		- getType():String
		
		- hashCode():Number
		
		- initEvent(type:String, bubbles:Boolean, cancelable:Boolean)
		
		- isCancelled():Boolean
		
		- isQueued():Boolean
		
		- queueEvent():Void
		
		- setBubbles(b:Boolean):Void
		
		- setContext(context):Void
		
		- setCurrentTarget(target):Void
		
		- setEventPhase(n:Number):Void
		
		- setTarget(target):Void
		
		- setType(type:String):Void
		
		- stopImmediatePropagation():Void
		
		- toSource(indent : Number, indentor : String):String
		
		- toString():String

	EVENT SUMMARY

		- LoaderEventType.COMPLETE:String = "onLoadComplete"
		
		- LoaderEventType.IO_ERROR:String = "onLoadError"
		
		- LoaderEventType.FINISH:String = "onLoadFinished"
		
		- LoaderEventType.INIT:String = "onLoadInit"
		
		- LoaderEventType.PROGRESS:String = "onLoadProgress"
		
		- LoaderEventType.START:String = "onLoadStarted"
		
		- LoaderEventType.STOP:String = "onLoadStopped"
		
		- LoaderEventType.TIMEOUT:String = "onTimeOut"
		
		- LoaderEventType.RELEASE:String = "onRelease"
			
	INHERIT
	
		CoreObject → BasicEvent → DynamicEvent → LoaderEvent → URLLoaderEvent
		
	IMPLEMENTS
	
		Event, ICloneable, IFormattable, IHashable, ISerializable

**/


import asgard.events.LoaderEvent;
import asgard.net.URLLoader;

/**
 * @author eKameleon
 * @version 1.0.0.0
 */
 
class asgard.events.URLLoaderEvent extends LoaderEvent {

	// ----o Constructor
		
	public function URLLoaderEvent(
	
		type:String	, loader:URLLoader
		, nCode:Number
		, sError:String
		, context
		, bubbles:Boolean
		, eventPhase:Number
		, time:Number
		, stop:Number 
	) 
	
		{
		
		super(type, loader, nCode, sError, context, bubbles, eventPhase, time, stop) ; 
		
		}
	
	// ----o Public Methods
	
	public function clone() {
		return new URLLoaderEvent( getType(), URLLoader( getTarget() ) ) ;
	}
	
	public function getDataFormat():String {
		
		return URLLoader(getTarget()).getDataFormat() ;
		
	}

}