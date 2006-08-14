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

/* EventPhase

	AUTHOR

		Name : EventPhase
		Package : vegas.events.dom
		Version : 1.0.0.0
		Date :  2006-07-16
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
	
	CONSTANT SUMMARY

		static const AT_TARGET:Number
			
			The target phase(2).
			
		static const BUBBLING_PHASE:Number
			
			The bubbling phase(3).
			
		static const CAPTURING_PHASE:Number
			
			The capturing phase(1).
		
		static const NONE:Number
			
			The default phase(0)
		
		static const STOP:Number
		
			Stop the phase(4). Use only by the Event and EventDispatcher class.
		
		static const STOP_IMMEDIATE:Number
		
			Stop the phase immediately (4). Use only by the Event and EventDispatcher class.
	
*/

package vegas.events.dom
{
	public class EventPhase
	{
		
		static public const AT_TARGET:uint = 2 ;
	
		static public const BUBBLING_PHASE:uint = 3 ;
	
		static public const CAPTURING_PHASE:uint = 1 ;
	
		static public const NONE:uint = 0 ;
	
		static public const STOP:uint = 8 ;
	
		static public const STOP_IMMEDIATE:uint = 10 ;
		
	}
}