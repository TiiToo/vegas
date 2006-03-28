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

/** DisplayObjectCollector

	AUTHOR

		Name : DisplayObjectCollector
		Package : asgard.display
		Version : 1.0.0.0
		Date :  2006-03-21
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : contact@ekameleon.net

	METHOD SUMMARY
	
		- static clear():Void
	
		- static contains( sName:String ):Boolean
		
		- static get(sName:String):DisplayObject
		
		- static insert(sName:String, dObject:DisplayObject):Boolean
		
		- static isEmpty():Boolean
		
		- static remove(sName:String):Void

------------*/

/**
 * @author eKameleon
 * @version 1.0.0.0
 */

import asgard.display.DisplayObject ;

import vegas.data.map.HashMap ;
import vegas.errors.Warning ;

class asgard.display.DisplayObjectCollector {

	// ----o Constructor
	
    private function DisplayObjectCollector() {
		//
    }

	// ----o Public Methods
	
	static public function clear():Void {
		_map.clear() ;	
	}
	
	static public function contains( sName:String ):Boolean {
		return _map.containsKey( sName ) ;	
	}
	
	static public function get(sName:String):DisplayObject {
		
		try {
			if (contains(sName) ) {
				throw new Warning("[DisplayObjectCollector].get(" + sName + "). Can't find DisplayObject instance." ) ;
			} ;
		} catch (e:Warning) {
			e.toString() ;
		}
		
		return DisplayObject(_map.get(sName)) ;	
	}
	
	static public function insert(sName:String, dObject:DisplayObject):Boolean {
		
		try {
			if (contains(sName) ) {
				throw new Warning("[DisplayObjectCollector].insert(). A DisplayObject instance is already registered with '" + sName + "' name." ) ;
			} ;
		} catch (e:Warning) {
			e.toString() ;
		}
		
		return (_map.put(sName, dObject) != null) ;
	}
	
	static public function isEmpty():Boolean {
		return _map.isEmpty() ;	
	}
	
	static public function remove(sName:String):Void {
		_map.remove(sName) ;
	}
	
	// ----o Private Properties
	
	static private var _map:HashMap = new HashMap() ;
	
}
