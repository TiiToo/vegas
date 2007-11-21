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

/**
 * The static enumeration of all event types of the SharedDatas objects.
 * @author eKameleon
 * @version 1.0.0.0
 */	
class asgard.events.SharedDataEventType extends String 
{

	/**
	 * Creates a new SharedDataEventType instance.
	 */
	public function SharedDataEventType(s:String) 
	{
		super(s) ;
	}

	/**
	 * The SharedData event type when is changed.
	 */
	public static var CHANGE:SharedDataEventType = new SharedDataEventType("onChanged") ;

	/**
	 * The SharedData event type when is cleared.
	 */
	public static var CLEAR:SharedDataEventType = new SharedDataEventType("onClear") ;
	
	/**
	 * The SharedData event type when is closed.
	 */
	public static var CLOSE:SharedDataEventType = new SharedDataEventType("onClosed") ;

	/**
	 * The SharedData event type when is deleted.
	 */
	public static var DELETE:SharedDataEventType = new SharedDataEventType("onDeleted") ;

	/**
	 * The SharedData event type when is fired.
	 */
	public static var FIRE:SharedDataEventType = new SharedDataEventType("onFired") ;
	
	/**
	 * The SharedData event type when is rejected.
	 */
	public static var REJECT:SharedDataEventType = new SharedDataEventType("onRejected") ;

	/**
	 * The SharedData event type when is succes.
	 */
	public static var SUCCESS:SharedDataEventType = new SharedDataEventType("onSuccess") ;

	/**
	 * The SharedData event type when is synchronised.
	 */
	public static var SYNCHRONISED:SharedDataEventType = new SharedDataEventType("onSynchronised") ;

	/**
	 * @private
	 */
	private static var __ASPF__ = _global.ASSetPropFlags(SharedDataEventType, null , 7, 7) ;
	
}
