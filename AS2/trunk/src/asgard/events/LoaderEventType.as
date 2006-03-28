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

/** LoaderEventType

	AUTHOR

		Name : LoaderEventType
		Package : asgard.events
		Version : 1.0.0.0
		Date :  2006-03-25
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
	
	CONSTANT SUMMARY



----------  */

class asgard.events.LoaderEventType {

	// ----o Constructor
	
	private function LoaderEventType() {
		//
	}

	// ----o Static Properties
	
	static public var COMPLETE:String = "onLoadComplete" ;
	static public var IO_ERROR:String = "onLoadError" ;
	static public var FINISH:String = "onLoadFinished" ;
	static public var INIT:String = "onLoadInit" ;
	static public var PROGRESS:String = "onLoadProgress" ;
	static public var START:String = "onLoadStart" ;
	static public var STOP:String = "onLoadStopped" ;
	static public var TIMEOUT:String = "onTimeOut" ;
	static public var RELEASE:String = "onRelease" ;

	static private var __ASPF__ = _global.ASSetPropFlags(LoaderEventType, null , 7, 7) ;
	
}
