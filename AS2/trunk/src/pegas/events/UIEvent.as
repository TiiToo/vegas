/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is PEGAS Library.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2007
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

import vegas.events.DynamicEvent;
import vegas.util.serialize.Serializer;

/**
 * The UIEvent class.
 * @author eKameleon
 */
class pegas.events.UIEvent extends DynamicEvent 
{

	/**
	 * Creates a new UIEvent instance.
	 */
	public function UIEvent( type:String, target, p_child, p_index:Number, context, bubbles:Boolean, eventPhase:Number, time:Number, stop:Number) 
	{
		super(type, target, context, bubbles, eventPhase, time, stop) ;
		child = p_child || null ;
		index = isNaN(p_index) ? null : p_index ;
	}

	public var child ;

	public var index:Number ;

	public function clone() 
	{
		return new UIEvent(getType(), getTarget()) ;
	}
	
	/*protected*/ private function _getParams():Array 
	{
		var ar:Array = super._getParams() ;
		ar.splice(2, null, Serializer.toSource(child)) ;
		ar.splice(3, null, Serializer.toSource(index)) ;
		return ar ;
	}
	
}
