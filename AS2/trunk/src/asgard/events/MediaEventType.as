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

/** MediaEventType

	AUTHOR

		Name : MediaEventType
		Package : asgard.events
		Version : 1.0.0.0
		Date :  2006-05-18
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
	
	CONSTANT SUMMARY

		- static MEDIA_FINISH:String = "onMediaFinished"
		
		- static MEDIA_PROGRESS:String = "onMediaProgress"
		
		- static MEDIA_RESUME:String = "onMediaResumed"
		
		- static MEDIA_START:String = "onMediaStarted"
		
		- static MEDIA_STOP:String = "onMediaStopped"

**/

class asgard.events.MediaEventType {

	// ----o Constructor
	
	private function MediaEventType() {
		//
	}

	// ----o Constants

	static public var MEDIA_FINISH:String = "onMediaFinished" ;
	
	static public var MEDIA_PROGRESS:String = "onMediaProgress" ;
	
	static public var MEDIA_RESUME:String = "onMediaResumed" ;
	
	static public var MEDIA_START:String = "onMediaStarted" ;
	
	static public var MEDIA_STOP:String = "onMediaStopped" ;
	
	static private var __ASPF__ = _global.ASSetPropFlags(MediaEventType, null , 7, 7) ;
	
}
