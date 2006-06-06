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

/** FlashPaperLoader

	AUTHOR

		Name : FlashPaperLoaderEvent
		Package : asgard.events
		Version : 1.0.0.0
		Date :  2006-03-31
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
		
		- getEventPhase():Number
		
		- getLoader():DisplayLoader
		
		- getName():String
		
		- getPercent():Number
		
		- getTarget()
		
		- getTimeStamp():Number
		
		- getType():String
		
		- getView():MovieClip
		
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

	EVENT TYPE SUMMARY

		- const COMPLETE:String
		
		- const ENABLE_SCROLL:String
		
		- const FINISH:String
		
		- const INIT:String
		
		- const IO_ERROR:String
		
		- const PAGE_CHANGE:String
		
		- const PROGRESS:String
		
		- const RELEASE:String
				
		- const START:String
		
		- const STOP:String
		
		- const TIMEOUT:String
		
		- const TOOL_CHANGE:String
		
		- const ZOOM_CHANGE:String
		
		- const VISIBLE_AREA_CHANGE:String

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
	
		CoreObject → BasicEvent → DynamicEvent → LoaderEvent → DisplayLoaderEvent
		
	IMPLEMENTS
	
		Event, ICloneable, IFormattable, IHashable, ISerializable

*/

import asgard.display.FlashPaperLoader;
import asgard.events.DisplayLoaderEvent;

import vegas.util.serialize.Serializer;

/**
 * @author eKameleon
 * @version 1.0.0.0
 * @date 2006-03-31
 */
 
class asgard.events.FlashPaperLoaderEvent extends DisplayLoaderEvent {

	// ----o Constructor
		
	public function FlashPaperLoaderEvent(
		type : String, fpLoader:FlashPaperLoader
		, p_currentZoom:Number, p_isEnabledScrolling:Boolean, p_newPageNumber:Number, p_newVisibleArea 
		, p_code:Number, p_error:String, context
		, bubbles:Boolean, eventPhase:Number, time:Number, stop:Number
	) 
	{
		super(type, fpLoader, p_code, p_error, context, bubbles, eventPhase, time, stop);
		currentZoom = isNaN(p_currentZoom) ? null : p_currentZoom ;
		isEnabledScrolling = p_isEnabledScrolling || null ;
		newPageNumber = isNaN(p_newPageNumber) ? null : p_newPageNumber ;
		newVisibleArea = p_newVisibleArea || null ;
	}
	
	// ----o Public Properties
	
	public var currentZoom:Number ;
	public var isEnabledScrolling:Boolean ;
	public var newPageNumber:Number ;
	public var newVisibleArea ; 
	
	// ----o Public Methods
	
	public function clone() {
		return new FlashPaperLoaderEvent( getType(), getLoader()) ;
	}

	public function getLoader():FlashPaperLoader {
		return FlashPaperLoader(_oLoader) ;
	}

	// ----o Protected Methods

	/*protected*/ private function _getParams():Array {
		var ar:Array = super._getParams() ;
		ar.splice(2, null, Serializer.toSource(currentZoom)) ;
		ar.splice(3, null, Serializer.toSource(isEnabledScrolling)) ;
		ar.splice(4, null, Serializer.toSource(newPageNumber)) ;
		ar.splice(5, null, Serializer.toSource(newVisibleArea)) ;
		return ar ;
	}

}