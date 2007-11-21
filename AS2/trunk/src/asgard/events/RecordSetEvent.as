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

import andromeda.events.ModelChangedEvent;

import asgard.data.remoting.RecordSet;

/**
 * The event invoqued in the RecordSet class.
 */
class asgard.events.RecordSetEvent extends ModelChangedEvent 
{

	/**
	 * Creates a new RecordSetEvent instance.
	 */
	public function RecordSetEvent( type:String, rs:RecordSet, context, bubbles:Boolean, eventPhase:Number, time:Number, stop:Number, data, fieldName:String, firstItem:Number, index:Number, lastItem:Number, removedIDs:Array, removedItems:Array)
	{
		super( 	type || RecordSetEvent.MODEL_CHANGED, rs, context, bubbles, eventPhase, time, stop, data, fieldName, firstItem, index, lastItem, removedIDs, removedItems ) ;
	}

	public static var ADD_ITEMS:String = "addItems" ; 
	
	public static var CLEAR_ITEMS:String = "clear" ;
	
	public static var MODEL_CHANGED:String = "modelChanged" ;
	
	public static var REMOVE_ITEMS:String = "removeItems" ;
	
	public static var SORT_ITEMS:String = "sortItems" ;
	
	public static var UPDATE_ALL:String = "updateAll" ;
	
	public static var UPDATE_FIELD:String = "updateField" ;
	
	public static var UPDATE_ITEMS:String = "updateItems" ;
	
	public static var UPDATE_ROWS:String = "updateRows" ;

	/**
	 * @private
	 */
	private static var __ASPF__ = _global.ASSetPropFlags(RecordSetEvent, null , 7, 7) ;
	
	/**
	 * Returns a shallow copy of the object.
	 * @return a shallow copy of the object.
	 */
	public function clone() 
	{
		return new RecordSetEvent(getType(), getTarget()) ;
	}

}
