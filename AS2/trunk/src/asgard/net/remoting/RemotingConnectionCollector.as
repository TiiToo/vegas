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
  Portions created by the Initial Developer are Copyright (C) 2004-2007
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

/** RemotingConnectionCollector

	AUTHOR

		Name : RemotingConnectionCollector
		Package : asgard.net.remoting
		Version : 1.0.0.0
		Date :  2006-05-26
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	METHOD SUMMARY
	
		- static clear():Void
	
		- static contains( sName:String ):Boolean
		
		- static get(sName:String):RemotingConnection
		
		- static insert(sName:String, rc:RemotingConnection):Boolean
		
		- static isEmpty():Boolean
		
		- static remove(sName:String):Void

**/

import asgard.net.remoting.RemotingConnection;

import vegas.data.map.HashMap;
import vegas.errors.Warning;

/**
 * @author eKameleon
 * @version 1.0.0.0
 */

class asgard.net.remoting.RemotingConnectionCollector {

	// ----o Constructor
	
    private function RemotingConnectionCollector() {
		//
    }

	// ----o Public Methods
	
	static public function clear():Void {
		_map.clear() ;	
	}
	
	static public function contains( sName:String ):Boolean {
		return _map.containsKey( sName ) ;	
	}
	
	static public function get(sName:String):RemotingConnection {
		try {
			if (!contains(sName) ) {
				throw new Warning("[RemotingConnectionCollector].get(\"" + sName + "\"). Can't find RemotingConnection instance." ) ;
			} ;
		} catch (e:Warning) {
			e.toString() ;
		}
		
		return RemotingConnection(_map.get(sName)) ;	
	}
	
	static public function insert(sName:String, rc:RemotingConnection):Boolean {
		try {
			if ( contains(sName) ) {
				throw new Warning("[RemotingConnectionCollector].insert(). A RemotingConnection instance is already registered with '" + sName + "' name." ) ;
			} ;
		} catch (e:Warning) {
			e.toString() ;
		}
		return Boolean(_map.put(sName, rc))   ;	
		
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
