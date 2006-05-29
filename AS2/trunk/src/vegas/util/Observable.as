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

/** Observable

	AUTHOR

		Name : Observable
		Package : vegas.util
		Version : 1.0.0.0
		Date : 2005-04-17
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	METHODS
	
		- addObserver(obs)
		
		- clearChanged()
		
		- countObservers()
		
		- deleteObservers([obs])
			
			détruit tous les observers si obs n'est pas défini, sinon détruit l'observer passé en paramètre
		
		- hasChanged()
		
		- notifyObservers( arg )
		
		- setChanged()
	
**/

import vegas.data.iterator.Iterator;
import vegas.data.list.ArrayList;
import vegas.errors.NullPointerError;
import vegas.util.Observer;

class vegas.util.Observable {

	// ----o Constructor

	public function Observable() {
		_obs = new ArrayList() ;
	}

	// ----o Public Methods

	public function addObserver(o:Observer):Boolean {
		if (o == null) throw new NullPointerError() ;
		if (!_obs.contains(o)) {
			_obs.insert(o) ;
			return true ;
		}
		return false ;
	}

	public function clearChanged():Void {
		_changed = false ;
	}
	
	public function countObservers(Void):Number {
		return _obs.size() ;
	}

	public function deleteObservers(o:Observer):Void {
		if (o == undefined) {
			_obs.clear() ;
		} else {
			_obs.remove(o) ;
		}
	}
	
	public function hasChanged():Boolean {
		return _changed ;
	}

	public function notifyObservers( arg ):Void {
		if (arg == undefined) arg = null ;
		if (!_changed) return ;
		clearChanged() ;
		var _obsMemory:ArrayList = _obs.clone() ;
		var it:Iterator = _obsMemory.iterator() ;
		while(it.hasNext()) {
			it.next().update(this, arg) ;
		}
	}
	
	public function setChanged():Void {
		_changed = true ;
	}

	// ----o Private Properties
		
	private var _obs:ArrayList ;
	private var _changed:Boolean ;
	
}