/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is ASGard Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
 */
import asgard.events.TextEvent;

import vegas.util.serialize.Serializer;

/**
 * The {@code DataEvent} to dispatch DataEvent objects when raw data has completed loading into Flash Player.
 * <p>There are two types of data event:</p>
 * <p>
 * <li>{@code DataEvent.DATA} : dispatched for data sent or received.</li>
 * <li>{@code DataEvent.UPLOAD_COMPLETE_DATA} : dispatched when data is sent and the server has responded.</li>
 * </p>
 * @author eKameleon
 */
class asgard.events.DataEvent extends TextEvent 
{

	/**
	 * Creates DataEvent that contains information about data events.
	 * @param type The type of the event. Event listeners can access this information through the inherited type property.
	 * @param data The raw data loaded into Flash Player. Event listeners can access this information through the data property.
	 * @param type Text to be displayed as an error message. Event listeners can access this information through the text property.
	 * @param target the target of the event.
	 * @param context the optional context object of the event.
	 * @param bubbles indicates if the event is a bubbling event.
	 * @param eventPhase the current EventPhase of the event.
	 * @param time this parameter is used in the Eden deserialization.
	 * @param stop this parameter is used in the Eden deserialization.
	 */
	public function DataEvent(type:String, data, text:String, target, context, bubbles:Boolean, eventPhase:Number, time:Number, stop:Number)
	{
		super(type, text, target, context, bubbles, eventPhase, time, stop) ;
		this.data = data ;
	}

	/**
	 * Defines the value of the type property of a data event object.
	 */
	public static var DATA:String = "data" ;

	/**
	 * Defines the value of the type property of an uploadCompleteData event object.
	 */
	public static var UPLOAD_COMPLETE_DATA:String = "uploadCompleteData" ;

	/**
	 * The data reference of this event.
	 */
	public var data ;

	/**
	 * Returns the shallow copy of this event.
	 * @return the shallow copy of this event.
	 */
	public function clone() 
	{
		return new DataEvent(getType(), data, text, getTarget(), getContext()) ;
	}

	/**
	 * @private
	 */
	/*protected*/ private function _getParams():Array 
	{
		var ar:Array = super._getParams() ;
		ar.splice(1, null, Serializer.toSource(data)) ;
		return ar ;
	}


}
