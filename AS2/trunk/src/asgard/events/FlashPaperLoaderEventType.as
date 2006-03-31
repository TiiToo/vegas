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

/** FlashPaperLoaderEventType

	AUTHOR

		Name : FlashPaperLoaderEventType
		Package : asgard.events
		Version : 1.0.0.0
		Date :  2006-03-31
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
	
	CONSTANT SUMMARY

		- const COMPLETE:String
		
		- const ENABLE_SCROLL:String
		
		- const FINISH:String
		
		- const INIT:String
		
		- const IO_ERROR:String
		
		- const PAGE_CHANGE:String
		
		- const PROGRESS:String
		
		- const RELEASE:String
				
		- const START:String
		
		- const STOP:String
		
		- const TIMEOUT:String
		
		- const TOOL_CHANGE:String
		
		- const ZOOM_CHANGE:String
		
		- const VISIBLE_AREA_CHANGE:String

----------  */

import asgard.events.LoaderEventType ;

class asgard.events.FlashPaperLoaderEventType {

	// ----o Constructor
	
	private function FlashPaperLoaderEventType() {
		//
	}

	// ----o Static Properties
	
	static public var COMPLETE:String = LoaderEventType.COMPLETE ;
	
	static public var ENABLE_SCROLL:String = "onEnableScrolling" ;
	
	static public var FINISH:String = LoaderEventType.FINISH ;
	
	static public var INIT:String = LoaderEventType.INIT ;
	
	static public var IO_ERROR:String = LoaderEventType.IO_ERROR ;
	
	static public var PROGRESS:String = LoaderEventType.PROGRESS ;
		
	static public var RELEASE:String = LoaderEventType.RELEASE ;

	static public var PAGE_CHANGE:String = "onPageChanged" ;

	static public var START:String = LoaderEventType.START ;
	
	static public var STOP:String = LoaderEventType.STOP ;
	
	static public var TIMEOUT:String = LoaderEventType.TIMEOUT ;

	static public var TOOL_CHANGE:String = "onToolChanged" ;

	static public var ZOOM_CHANGE:String = "onZoomChanged" ;

	static public var VISIBLE_AREA_CHANGE:String = "onVisibleAreaChanged" ;
	
	static private var __ASPF__ = _global.ASSetPropFlags(FlashPaperLoaderEventType, null , 7, 7) ;

}
