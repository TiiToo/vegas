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

/**	MediaEvent

	AUTHOR

		Name : MediaEvent
		Package : asgard.events
		Version : 1.0.0.0
		Date :  2006-06-20
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
	
	METHOD SUMMARY
	
		- cancel():Void
		
		- clone():LoaderEvent
		
		- getBubbles():Boolean
		
		- getBytesLoaded():Number
		
		- getBytesTotal():Number
		
		- getContext()
		
		- getCurrentTarget()
		
		- getData()
		
		- getDuration():Numbe
		
		- getEventPhase():Number
		
		- getLoader():IMediaLoader
		
		- getName():String
		
		- getPercent():Number
		
		- getPosition():Number
		
		- getTarget()
		
		- getTimeStamp():Number
		
		- getType():String
		
		-  getVolume():Number
		
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

		- MediaEventType.MEDIA_FINISH:String
		
		- MediaEventType.MEDIA_PROGRESS:String
		
		- MediaEventType.MEDIA_RESUME:String
		
		- MediaEventType.MEDIA_START:String
		
		- MediaEventType.MEDIA_STOP:String
		
	INHERIT
	
		CoreObject → BasicEvent → DynamicEvent → LoaderEvent → MediaEvent
		
	IMPLEMENTS
	
		Event, IFormattable, IHashable, ISerializable

**/

import asgard.events.LoaderEvent;
import asgard.media.IMediaLoader;

class asgard.events.MediaEvent extends LoaderEvent 
{

	// ----o Constructor
	
	public function MediaEvent(type:String, loader:IMediaLoader, p_code:Number, p_error:String, context, bubbles:Boolean, eventPhase:Number, time:Number, stop:Number) 
	{
		super(type, loader, p_code, p_error, context, bubbles, eventPhase, time, stop) ;
	}
	
	// ----o Constants

	static public var MEDIA_CLEAR:String = "onMediaClear" ;

	static public var MEDIA_FINISH:String = "onMediaFinished" ;
	
	static public var MEDIA_PROGRESS:String = "onMediaProgress" ;
	
	static public var MEDIA_RESUME:String = "onMediaResumed" ;
	
	static public var MEDIA_START:String = "onMediaStarted" ;
	
	static public var MEDIA_STOP:String = "onMediaStopped" ;

	// ----o Public Methods

	public function clone() 
	{
		return new MediaEvent(getType(), getTarget()) ;
	}

	public function getDuration():Number 
	{
		return getLoader().getDuration() ;	
	}

	public function getLoader():IMediaLoader 
	{
		return _oLoader ;
	}

	public function getPosition():Number 
	{
		return getLoader().getPosition() ;	
	}
	
	public function getVolume():Number 
	{
		return getLoader().getVolume() ;	
	}

	// ----o Private Properties
	
	private var _oLoader:IMediaLoader ;

}
