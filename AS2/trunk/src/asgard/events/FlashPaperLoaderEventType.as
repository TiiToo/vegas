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

import asgard.events.LoaderEvent;

/**
 * Enumeration of all event type of the FlashPaperLoaderEvent class.
 * @author eKameleon
 */
class asgard.events.FlashPaperLoaderEventType 
{

	public static var COMPLETE:String = LoaderEvent.COMPLETE ;
	
	public static var ENABLE_SCROLL:String = "onEnableScrolling" ;
	
	public static var FINISH:String = LoaderEvent.FINISH ;
	
	public static var INIT:String = LoaderEvent.INIT ;
	
	public static var IO_ERROR:String = "onLoadError" ;
	
	public static var PROGRESS:String = LoaderEvent.PROGRESS ;
		
	public static var RELEASE:String = LoaderEvent.RELEASE ;

	public static var PAGE_CHANGE:String = "onPageChanged" ;

	public static var START:String = LoaderEvent.START ;
	
	public static var STOP:String = LoaderEvent.STOP ;
	
	public static var TIMEOUT:String = LoaderEvent.TIMEOUT ;

	public static var TOOL_CHANGE:String = "onToolChanged" ;

	public static var ZOOM_CHANGE:String = "onZoomChanged" ;

	public static var VISIBLE_AREA_CHANGE:String = "onVisibleAreaChanged" ;
	
}
