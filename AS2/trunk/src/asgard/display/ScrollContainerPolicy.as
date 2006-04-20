/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is Vegas Library.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2005
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

/** ScrollContainerPolicy
	
	AUTHOR
	
		Name : ScrollContainerPolicy
		Package : asgard.display
		Version : 1.0.0.0
		Date :  2006-02-22
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	CONSTANT SUMMARY
		
		- AUTO:ScrollContainerPolicy
			auto scroll

		- FULL:ScrollContainerPolicy

			auto scroll + scroll when user select an item

		- NONE:ScrollContainerPolicy
			no auto scroll
		
		- SCROLL_ON_CLICK:Number
			scroll when user select an item.

	METHOD SUMMARY

		- static validate(o):Boolean
	
**/

class asgard.display.ScrollContainerPolicy extends Number {

	// ----o Constructor

    private function ScrollContainerPolicy(n:Number, sName:String) {
		super(n) ;
		_sName = sName ;
	}

	// ----o Constants

	static public var NONE:ScrollContainerPolicy = new ScrollContainerPolicy(0, "none") ;
	
	static public var AUTO:ScrollContainerPolicy = new ScrollContainerPolicy(1, "auto") ;
	
	static public var SCROLL_ON_CLICK:ScrollContainerPolicy = new ScrollContainerPolicy(2, "scroll_on_click") ;
	
	static public var FULL:ScrollContainerPolicy = new ScrollContainerPolicy(AUTO | SCROLL_ON_CLICK, "full") ; ;

	static private var __ASPF__ = _global.ASSetPropFlags(ScrollContainerPolicy, null , 7, 7) ;

	// ----o Public Methods

	static public function validate(o):Boolean {
		switch(o) {
			case NONE :
			case AUTO : 
			case SCROLL_ON_CLICK :
			case FULL : 
				return true ;
			default :
				return false ;
		}
	}

	// ----o Private Properties
	
	private var _sName:String ;

}