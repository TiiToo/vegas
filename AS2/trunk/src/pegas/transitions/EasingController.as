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
  Portions created by the Initial Developer are Copyright (C) 2004-2007
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

import vegas.core.CoreObject;
import vegas.data.Map;
import vegas.data.map.HashMap;

/**
 * The EasingController register all the Easing in an application.
 * @author eKameleon
 */
class pegas.transitions.EasingController extends CoreObject 
{
	
	/**
	 * Creates a new EasingController instance.
	 *  <p><b>Example :</b> {@code var ec:EasingController = new EasingController() ;}</p>
	 */	
	public function EasingController() 
	{
		_map = new HashMap() ;
	}

	/**
	 * Returns {@code true} if the {@code id} passed in argument is registered in the EasingController.
	 * @param id the {@code id} of the easing method mapped in the EasingController.
	 * @return {@code true} if the {@code id} passed in argument is registered in the EasingController.
	 */
	public function contains( id:String  ):Boolean 
	{
		return _map.containsKey( id ) ;	
	}
	
	/**
	 * Returns a easing method register in the EasingController with the specified {@code id} passed in argument.
	 * If the id isn't find in the controller, this method return a Regular.easeOut function.
	 * @param  id the {@code id} of the easing method mapped in the EasingController.
	 * @return the easing method mapped in the EasingController.  
	 */
	public function getEasing( id:String , defaultEasing:Function ):Function
	{
		return contains(id) ? _map.get( id ) : (defaultEasing || null) ;
	}
	
	/**
	 * Adds a new entry into the EasingController.
	 * @param id the {@code id} of the easing method mapped in the EasingController.
	 * @param easingMethod the function to register in the EasingController.
	 */
	public function insert( id:String, easingMethod:Function ):Void 
	{
		_map.put( id, easingMethod ) ;
	}
	
	/**
	 * Remove an entry into the EasingController.
	 * @param id the name of the easing method mapped in the EasingController.
	 */
	public function remove( id:String ):Void 
	{
		_map.remove(id) ;
	}

	/**
	 * Returns the number of elements in the EasingController.
	 * @return the number of elements in the EasingController.
	 */
	public function size():Number
	{
		return _map.size() ;
	}	

	/**
	 * Internal HashMap instance.
	 */
	private var _map:Map ;
}