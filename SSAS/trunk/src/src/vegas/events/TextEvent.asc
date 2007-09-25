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
 
/**
 * The TextEvent class.
 */
if (vegas.events.TextEvent == undefined) 
{
	
	/**
	 * Creates a new TextEvent instance.
	 */
	vegas.events.TextEvent = function(type/*String*/, txt /*String*/, target/*Object*/, context/*Object*/) 
	{
		vegas.events.DynamicEvent.call(this, type, target, context) ;
		this.text = txt || null ;
	}
	
	/**
	 * @extends vegas.events.DynamicEvent
	 */
	proto = vegas.events.TextEvent.extend( vegas.events.DynamicEvent ) ;
 
	/**
	 * The text value of this event.
	 */
	proto.text = null ;
 
	/**
	 * Returns a shallow copy of the object.
	 * @return a shallow copy of the object.
	 */
	proto.clone = function () 
	{
		return new vegas.events.TextEvent(this.getType() , this.text, this.getTarget(), this.getContext()) ;
	}
	
	delete proto ;

}
