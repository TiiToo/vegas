/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is LunAS Library.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

import vegas.events.BasicEvent;

/**
 * This event is invoked by a panel.
 * @author eKameleon
 */
class lunas.events.PanelEvent extends BasicEvent 
{
    
    /**
     * Creates a new PanelEvent instance.
     */
	public function PanelEvent(type:String, k, i, target) 
	{
		super(type, target) ;
		key = k ;
		item = i ;
	}

	public static var CREATE:String  = "onCreate" ;
	
	public static var DESTROY:String = "onDestroy" ;

	public static var HIDE:String    = "onHide" ;
	
	public static var SHOW:String    = "onShow" ;

	public var item ;

	public var key:Number ;
	
	/**
	 * Returns a shallow copy of this object.
	 * @return a shallow copy of this object.
	 */
	public function clone() 
	{
		return new PanelEvent(getType(), key, item, getTarget()) ;
	}
	
}
