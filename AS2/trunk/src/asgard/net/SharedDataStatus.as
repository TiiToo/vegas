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

/** SharedDataStatus

	AUTHOR

		Name : SharedDataStatus
		Package : asgard.net
		Version : 1.0.0.0
		Date :  2006-05-04
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	CONSTANT SUMMARY
	
		- CHANGE:SharedDataStatus ("change")
		
		- CLEAR:SharedDataStatus ("clear")
		
		- DELETE:SharedDataStatus ("delete")
		
		- REJECT:SharedDataStatus ("reject")
		
		- SUCCESS:SharedDataStatus ("success")

	METHOD SUMMARY
	
		- static format(code:String):String
		
		- static validate(o):Boolean

**/

import vegas.util.ArrayUtil;

/**
 * @author eKameleon
 * @version 1.0.0.0
 **/	
class asgard.net.SharedDataStatus extends String {
	
	// ----o Constructor
	
	private function SharedDataStatus( s:String ) {
		super(s) ;
	}

	// ----o Constants
	
	static public var CHANGE:SharedDataStatus = new SharedDataStatus("change") ;
	
	static public var CLEAR:SharedDataStatus = new SharedDataStatus("clear") ;

	static public var DELETE:SharedDataStatus = new SharedDataStatus("delete") ;

	static public var REJECT:SharedDataStatus = new SharedDataStatus("reject") ;
	
	static public var SUCCESS:SharedDataStatus = new SharedDataStatus("success") ;

	static private var __ASPF__ = _global.ASSetPropFlags(SharedDataStatus, null , 7, 7) ;

	// ----o Public Methods

	/**
	 * Convert onSync code value in SharedData.onSync.
	 */
	static public function format(code:String):String {
		return code.toLowerCase() ;
	}

	static public function validate( o ):Boolean {
		var status:Array = [CHANGE, CLEAR, DELETE, REJECT, SUCCESS] ;
		return ArrayUtil.contains(status, o) ;	
	}

}