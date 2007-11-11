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
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

import asgard.events.SharedDataEventType;
import asgard.net.SharedData;

import vegas.events.DynamicEvent;
import vegas.util.serialize.Serializer;

/**
 * A SharedDateEvent dispatch events in the SharedData instance.
 * @author eKameleon
 * @version 1.0.0.0
 */	
class asgard.events.SharedDataEvent extends DynamicEvent 
{

	/**
	 * Creates a new SharedDataEvent instance.
	 */	
	public function SharedDataEvent ( type:SharedDataEventType, sharedData:SharedData , p_id:String, p_value , context, bubbles:Boolean, eventPhase:Number, time:Number, stop:Number )
	{
		super(type, sharedData, context, bubbles, eventPhase, time, stop) ;
 		this.setProperty(p_id, p_value) ;
	}
	
	/**
	 * The id of the event.
	 */
	public var id:String ;

	/**
	 * The value of the event.
	 */
	public var value ;

	/**
	 * Returns a shallow copy of the object.
	 * @return a shallow copy of the object.
	 */	
	public function clone() 
	{
		return new SharedDataEvent(SharedDataEventType(getType()), getTarget()) ;
	}
	
	/**
	 * Sets the entry (id/value) of the property stored in a SharedDate object.
	 */
	public function setProperty(p_id:String, p_value):Void 
	{
			
		id = p_id || null ;
		value = p_value || null ;
		
		}

	/**
	 * @private
	 */
	/*protected*/ private function _getParams():Array 
		{
		
		var ar:Array = super._getParams() ;
		ar.splice(2, null, Serializer.toSource(id)) ;
		ar.splice(3, null, Serializer.toSource(value)) ;
		return ar ;
		
		}
	
}
