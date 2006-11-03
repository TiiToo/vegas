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

/**	ActionEvent

	AUTHOR

		Name : ActionEvent
		Package : asgard.events
		Version : 1.0.0.0
		Date :  2005-11-22
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
	
	EVENT SUMMARY

		- ActionEventType.CHANGED : "changed"
		
		- ActionEventType.CLEARED : "cleared"
		
		- ActionEventType.FINISHED  : "finished"
		
		- ActionEventType.LOOPED : "looped"
		
		- ActionEventType.PROGRESS : "progress"
		
		- ActionEventType.RESUMED  : "resumed"
		
		- ActionEventType.STARTED   : "started"
		
		- ActionEventType.STOPPED   : "stopped"

	METHOD SUMMARY

		- cancel():Void
		
		- clone():BasicEvent
		
		- getBubbles():Boolean
		
		- getContext():Object
		
		- getCurrentTarget():Object
		
		- getEventPhase():Number
		
		- getInfo()
		
		- getTarget():Object
		
		- getTimeStamp():Number
		
		- getType():String
		
		- isCancelled():Boolean
		
		- isQueued():Boolean
		
		- queueEvent():Void
		
		- setBubbles(b:Boolean):Void
		
		- setContext(context:Object):Void
		
		- setCurrentTarget(target):Void
		
		- setEventPhase(n:Number):Void
		
		- setInfo(oInfo):Void
		
		- setTarget(target:Object):Void
		
		- setType(type:String):Void
		
		- stopImmediatePropagation()
		
		- toSource(indent : Number, indentor : String):String
		
		- toString():String
		
	INHERIT
	
		CoreObject → BasicEvent → DynamicEvent → ActionEvent
		
	IMPLEMENTS 
		
		Event, ICloneable, IFormattable, IHashable, ISerializable

	SEE ALSO
	
		ActionEventType

*/

import vegas.events.DynamicEvent;
import vegas.util.serialize.Serializer;

class asgard.events.ActionEvent extends DynamicEvent {

	// ----o Constructor
	
	public function ActionEvent
	(
		type:String, target:Object, info, context,
			bubbles:Boolean, eventPhase:Number, time:Number, stop:Number
	)
	{
		super(type, target, context, bubbles, eventPhase, time, stop) ;
		_oInfo = info  ;
	}

	// ----o Constants

	static public var CHANGE:String = "onChanged" ;
	
	static public var CLEAR:String = "onCleared" ;
	
	static public var FINISH:String = "onFinished" ;
	
	static public var INFO:String = "onInfo" ;
	
	static public var LOOP:String = "onLooped" ;
	
	static public var PROGRESS:String = "onProgress" ;
	
	static public var RESUME:String = "onResumed" ;
	
	static public var START:String = "onStarted" ;
	
	static public var STOP:String = "onStopped" ;	

	// ----o Public Methods

	public function getInfo() 
	{
		return _oInfo ;
	}

	public function clone() 
	{
		return new ActionEvent(getType(), getTarget()) ;
	}
	
	public function setInfo( oInfo ):Void 
	{
		_oInfo = oInfo ;	
	}

	// ----o Private Properties
	
	private var _oInfo ;

	// ----o Protected Methods
	
	/*protected*/ private function _getParams():Array 
	{
		var ar:Array = super._getParams() ;
		ar.splice(2, null, Serializer.toSource(_oInfo)) ;
		return ar ;
	}

}
