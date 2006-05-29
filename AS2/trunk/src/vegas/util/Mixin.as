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

/** Mixin

	AUTHOR

		Name : Mixin
		Package : vegas.util
		Version : 1.0.0.0
		Date :  2005-10-10
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	DESCRIPTION 
	
		Fabrique du pattern Decorator basé sur l'injection dans le prototype d'une fonction constructor (Mixin)

	CONSTRUCTOR
	
		var mix:Mixin = new Mixin(constructor[Function], target|Object], attributes[Array])

	METHOD SUMMARY
	
		- getAttributes()
		
		- getConetructor()
		
		- getTarget()
		
		- run()
		
		- setAttributes(ar:Array)
		
		- setContructor(f:Function)
		
		- setTarget(o)
	
	IMPLEMENTS
	
		IRunnable

**/

import vegas.core.CoreObject;
import vegas.core.IRunnable;

class vegas.util.Mixin extends CoreObject implements IRunnable {

	// ----o Construtor
	
	public function Mixin( fConstructor:Function, target, attributes:Array) {
		setAttributes(attributes) ;
		setConstructor(fConstructor);
		setTarget(target) ;
	}

	// ----o Public Methods

	public function getAttributes():Array {
		return _ar ;
	}

	public function getConstructor():Function {
		return _c ;
	}	
	
	public function getTarget() {
		return _target ;
	}

	public function run():Void {
		if ( !_ar || !_c || !_target ) return ;
		var instance = new _c() ;
		var l:Number = _ar.length ;
		while(--l > -1) {
			var prop:String = _ar[l] ;
			_target[prop] = instance[prop] ; 
		}
		_global.ASSetPropFlags(_target, _ar, 1, 1) ;
	}

	public function setAttributes(ar:Array):Void {
		_ar = ar ;
	}

	public function setConstructor(f:Function):Void {
		_c = f ;
	}

	public function setTarget(o):Void {
		_target = o ;
	}
	
	// ----o Private Properties
	
	private var _ar:Array ;
	private var _c:Function ;
	private var _target ;
	
	
}