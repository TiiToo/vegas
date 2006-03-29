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

/** DisplayLoaderCollector

	AUTHOR

		Name : DisplayLoaderCollector
		Package : asgard.display
		Version : 1.0.0.0
		Date :  2006-03-20
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

*/

/**
 * @author eKameleon
 * @version 1.0.0.0
 **/

import asgard.display.DisplayLoader;

import vegas.data.map.HashMap;

class asgard.display.DisplayLoaderCollector {

	// ----o Constructor
	
	/**
	 * @author
	 */
    private function DisplayLoaderCollector() {
		//
    }

	// ----o Public Methods
	
	static public function contains( sName:String ):Boolean {
		return _map.containsKey( sName ) ;	
	}
	
	static public function get(sName:String):DisplayLoader {
		return DisplayLoader(_map.get(sName)) ;	
	}
	
	static public function insert(sName:String, dObject:DisplayLoader):Boolean {
		return (_map.put(sName, dObject) != null) ;
	}
	
	static public function remove(sName:String):Void {
		_map.remove(sName) ;
	}
	
	// ----o Private Properties
	
	static private var _map:HashMap = new HashMap() ;
	
}
