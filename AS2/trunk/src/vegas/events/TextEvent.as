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

import vegas.events.DynamicEvent;
import vegas.util.serialize.Serializer;

/**
 * The {@code TextEvent} to dispatch an event with a string text.
 * @author eKameleon
 */
class vegas.events.TextEvent extends DynamicEvent 
{

	/**
	 * Creates a new TextEvent instance.
	 */
	public function TextEvent(type:String, txt:String, target, context, bubbles:Boolean, eventPhase:Number, time:Number, stop:Number)
	{
		super(type, target, context, bubbles, eventPhase, time, stop) ;
		text = txt ;
	}

	/**
	 * The string text reference.
	 */
	public var text:String ;

	/**
	 * Returns the shallow copy of this event.
	 * @return the shallow copy of this event.
	 */
	public function clone() 
	{
		return new TextEvent(getType(), text, getTarget(), getContext()) ;
	}

	/*protected*/ private function _getParams():Array 
	{
		var ar:Array = super._getParams() ;
		ar.splice(1, null, Serializer.toSource(text)) ;
		return ar ;
	}


}
