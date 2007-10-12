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

import pegas.events.ActionEventType;

/**
 * @author eKameleon
 */
class asgard.events.RemotingEventType 
{

	public static var ERROR:String = "onError" ;	
	
	public static var FAULT:String = "onFault" ;
	
	public static var FINISHED:String = ActionEventType.FINISH ;
	
	public static var PROGRESS:String = ActionEventType.PROGRESS ;
	
	public static var RESULT:String = "onResult" ;
	
	public static var STARTED:String = ActionEventType.START ;
	
	private static var __ASPF__ = _global.ASSetPropFlags(RemotingEventType, null , 7, 7) ;
	
}
