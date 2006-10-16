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

/** TextInputGroup

	AUTHOR
	
		Name : TextInputGroup
		Package :com.optisio.components.group
		Version : 1.0.0.0
		Date :  2006-05-16
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : contact@ekameleon.net
	
	DESCRIPTION
	
		Use this Singleton with TextInput.
	
	CONSTRUCTOR
	
		Private.
	
	METHOD SUMMARY
	
		- clear():Void
			clear all groups.
			
		- static getInstance():TextInputGroup
		
		- insert(name:String, o):Boolean
		
		- iterator( [key] ):Iterator
		
		- remove( key, [value])
		
		- setEnabled( name:String , bool:Boolean ):Void
	
		- setGroupName ( name:String , o ):Void
	
**/

// TODO Penser à typer les paramètres o dans les méthodes.

import vegas.core.CoreObject;
import vegas.data.Collection;
import vegas.data.iterator.Iterable;
import vegas.data.iterator.Iterator;
import vegas.data.map.HashMap;
import vegas.data.map.MultiHashMap;

/**
 * @author eKameleon
 */
class lunas.display.group.TextInputGroup extends CoreObject implements Iterable {
	
	// ----o Constructor
	
	private function TextInputGroup() {
		super();
		_inputMap = new HashMap() ;
		_map = new MultiHashMap() ;
		
	}

	// ----o Private Properties

	public function clear():Void {
		_map.clear() ;
		_inputMap.clear() ;
	}

	static public function getInstance():TextInputGroup {
		if (_instance == undefined) _instance = new TextInputGroup () ;
		return _instance ;
	}

	public function insert( name:String, o ):Boolean {
		if (name == undefined || name == "" || o == undefined ) {
			return false ;
		}
		var b:Boolean = (_map.put(name, o) != null) ;
		_inputMap.put(o, name) ;
		return b ;
	}

	public function iterator( /*key*/ ):Iterator {
		return _map.iterator.call(_map, arguments[0]) ;  
	}
	
	public function remove(key /*, value*/ ) {
		if (arguments.length > 1) {
			_inputMap.remove(arguments[1]) ;
		} else {
			var co:Collection = _map.get(key) ;
			var it:Iterator = co.iterator() ;
			while(it.hasNext()) {
				_inputMap ;
			}	
		}
		return _map.remove.apply(_map, [].concat(arguments)) ;
	}

	public function setEnabled( name:String , bool:Boolean ):Void {
		var group:Collection = _map.get(name) ;	
		if (group.size() > 0) {
			var it:Iterator = group.iterator() ;
			while (it.hasNext()) {
				it.next().enabled = bool ;
			}
		}
	}
	
	public function setGroupName ( name:String , o ):Void {
		var oldGroupName:String = _inputMap.get(o) ;
		if (oldGroupName) {
			remove(oldGroupName, o) ;
		}
		insert(name , o) ;
	}

	// ----o Private Properties
	
	static private var _instance:TextInputGroup ;
	private var _map:MultiHashMap ;
	private var _inputMap:HashMap ;
	
}