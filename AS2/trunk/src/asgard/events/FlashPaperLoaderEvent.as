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

/** FlashPaperLoader

	AUTHOR

		Name : FlashPaperLoaderEvent
		Package : asgard.events
		Version : 1.0.0.0
		Date :  2006-03-31
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
	
	METHOD SUMMARY
	

	EVENT SUMMARY
	
		FlashPaperLoaderEvent

	EVENT TYPE SUMMARY

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

*/

import asgard.display.FlashPaperLoader;
import asgard.events.DisplayLoaderEvent;


/**
 * @author eKameleon
 * @version 1.0.0.0
 * @date 2006-03-31
 */
 
class asgard.events.FlashPaperLoaderEvent extends DisplayLoaderEvent {

	// ----o Constructor
		
	public function FlashPaperLoaderEvent(type : String, fpLoader:FlashPaperLoader ) {
		super(type, fpLoader);
	}
	
	// ----o Public Properties
	
	public var currentZoom:Number ;
	public var isEnabledScrolling:Boolean ;
	public var newPageNumber:Number ;
	public var newVisibleArea ; 
	
	
	// ----o Public Methods
	
	public function clone() {
		return new FlashPaperLoaderEvent( getType(), getLoader()) ;
	}

	public function getLoader():FlashPaperLoader {
		return FlashPaperLoader(_oLoader) ;
	}

}