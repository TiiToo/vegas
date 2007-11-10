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

import vegas.events.DynamicEvent;
import vegas.util.serialize.Serializer;

/**
 * The ActionEvent is notify by all the objects who implements the Action interface.
 * @author eKameleon
 */
class pegas.events.ActionEvent extends DynamicEvent 
{

	/**
	 * Creates a new ActionEvent instance.
	 * @param type the string type of the instance. 
	 * @param target the target of the event.
	 * @param info The information object of this event.
	 * @param context the optional context object of the event.
	 * @param bubbles indicates if the event is a bubbling event.
	 * @param eventPhase the current EventPhase of the event.
	 * @param time this parameter is used in the Eden deserialization.
	 * @param stop this parameter is used in the Eden deserialization.
	 */
	public function ActionEvent( type:String, target:Object, info, context, bubbles:Boolean, eventPhase:Number, time:Number, stop:Number )
	{
		super(type, target, context, bubbles, eventPhase, time, stop) ;
		_oInfo = info  ;
	}
	
	/**
	 * The event type when the event notify a change.
	 */
	public static var CHANGE:String = "onChanged" ;

	/**
	 * The event type when the event notify a cleanup process.
	 */
	public static var CLEAR:String = "onCleared" ;

	/**
	 * The event type when the event notify the end of the process.
	 */
	public static var FINISH:String = "onFinished" ;

	/**
	 * The event type when the event notify an info process.
	 */
	public static var INFO:String = "onInfo" ;

	/**
	 * The event type when the process is looped.
	 */
	public static var LOOP:String = "onLooped" ;

	/**
	 * The event type when the event notify a process in progress.
	 */
	public static var PROGRESS:String = "onProgress" ;

	/**
	 * The event type when the process is resumed.
	 */
	public static var RESUME:String = "onResumed" ;
	
	/**
	 * The event type when the process is started.
	 */
	public static var START:String = "onStarted" ;
	
	/**
	 * The event type when the process is stopped.
	 */
	public static var STOP:String = "onStopped" ;	

	/**
	 * The event type when the process is out of time.
	 */
	public static var TIMEOUT:String = "onTimeOut" ;

	/**
	 * Returns the shallow copy of this object.
	 * @return the shallow copy of this object.
	 */
	public function clone() 
	{
		return new ActionEvent(getType(), getTarget()) ;
	}

	/**
	 * Returns the info object of this event.
	 * @return the info object of this event.
	 */
	public function getInfo() 
	{
		return _oInfo ;
	}

	/**
	 * Sets the info object of this event.
	 */
	public function setInfo( oInfo ):Void 
	{
		_oInfo = oInfo ;	
	}
	
	/**
	 * @private
	 */
	private var _oInfo ;

	/**
	 * @private
	 */
	private /*protected*/ function _getParams():Array 
	{
		var ar:Array = super._getParams() ;
		ar.splice(2, null, Serializer.toSource(_oInfo)) ;
		return ar ;
	}

}
