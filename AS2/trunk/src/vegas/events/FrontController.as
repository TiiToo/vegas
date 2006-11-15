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

import vegas.core.CoreObject;
import vegas.data.Map;
import vegas.data.map.HashMap;
import vegas.events.Event;
import vegas.events.EventDispatcher;
import vegas.events.EventListener;

/**
 * @author eKameleon
 */
class vegas.events.FrontController extends CoreObject  
{
	
	/**
	 * FrontController - Constructor
	 * @usage var oC = new FrontController( [oE:EventDispatcher] ) ;
	 */
	function FrontController( oE:EventDispatcher , name) 
	{
		_map = new HashMap() ;
		_oE = oE || EventDispatcher.getInstance(name); 
	}
	
	// ----o Public Methods 

	/**
	 * Returns 'true' if the eventName is registered in the FrontController.
	 * @param eventName:String
	 */
	public function contains( eventName:String ):Boolean 
	{
		return _map.containsKey(eventName) ;	
	}

	/**
	 * Dispatch an event into the FrontController
	 * @param e:Event 
	 */
	public function fireEvent(e:Event):Void 
	{
		_oE.dispatchEvent(e) ;
	}

	/**
	 * Returns a EventListener
	 * @usage  myController.get( myEvent:String ) ;	
	 * @param  eventName:String
	 * @return an EventListener  
	 */
	public function getListener(eventName:String):EventListener 
	{
		return _map.get(eventName) ;
	}
	
	/**
	 * Add a new entry into the FrontController.
	 * @param eventName:String
	 * @param listener:EventListener
	 */
	public function insert(eventName:String, listener:EventListener):Void 
	{
		_map.put.apply( this, arguments ) ;
		_oE.addEventListener(eventName, listener) ;
	}
	
	/**
	 * Remove an entry into the FrontController.
	 * @param eventName:String
	 * @return  
	 */
	public function remove(eventName:String):Void 
	{
		var listener:EventListener = _map.remove.apply(this, arguments ) ;
		if (listener) _oE.removeEventListener(eventName, listener);
	}

	/**
	 * Internal HashMap instance.
	 */
	private var _map:Map ;
	
	/**
	 * Internal EventDispatcher instance.
	 */
	private var _oE:EventDispatcher ;

}