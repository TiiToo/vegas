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

/* ---------- ConstructorUtil

	AUTHOR
	
		Name : ConstructorUtil
		Package : vegas.util
		Version : 1.0.0.0
		Date : 2005-10-12
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
	
	DESCRIPTION
	
		Constructor tools.
	
	METHODS
	
		- createBasicInstance(class:Function)
		
		- createInterface(class:Function, args:Array)
		
		- createVisualInstance(class:Function, oVisual, oInit)

		- getName(instance)
		
		- getPackage(instance)
		
		- getPath(instance)
		
		- isImplementationOf(constructor:Function, interface:Function)
		
		- isSubConstructorOf (subConstructor, superConstructor) ;
	
---------  */

class vegas.util.ConstructorUtil {
	
	// ----o Constructor
	
	private function ConstructorUtil() {
		//
	}
	
	// ----o Static 

	static public function createBasicInstance(c:Function) {
		var i = {} ;
		i.__proto__ = c.prototype ;
		i.__constructor__ = c ;
		return i ;
	}
	
	static public function createInstance(c:Function, args:Array) {
		if (!c) return null ;
		var i = ConstructorUtil.createBasicInstance(c) ;
		c.apply(i, args) ;
		return i ;
	}

    static public function createVisualInstance(c:Function, oVisual, oInit) {
    	oVisual.__proto__ = c.prototype ;
		if (oInit) for (var each:String in oInit) oVisual[each] = oInit[each] ;	
		c.apply(oVisual) ;   
		return oVisual ;
    }

	static public function getName(instance, scope):String {
		var path:String = getPath(instance, scope) ;
		if (path == null) return null ;
		var p:Array = path.split(".") ;
		return p.pop() || null ;
	}

	static public function getPackage(instance, scope):String {
		var path:String = getPath(instance, scope) ;
		if (path == null) return null ;
		var package:Array = path.split(".") ;
		package.pop() ;
		return package.join(".") ;
	}
	
	static public function getPath(instance, scope):String {
		if (instance.__path__) {
			return instance.__path__ ;
		} else {
			var o = (typeof(instance)=="function") ? Function(instance).prototype : instance.__proto__ ;
			var callee:Function ;
			var find:Function = function( s:String, target ) {
				for ( var prop:String in target )  {
					var current:Function = target[prop] ;
					if ( current.__constructor__ === Object ) {
							prop = callee( s + prop + ".", current );
							if ( prop ) return prop ;
					} else if ( current.prototype === o ) {
						return s + prop ;
					}
				}
			};
			callee = find ;
			instance["__path__"] = find( "", scope || _global ) || null ;
			_global.ASSetPropFlags(instance, ["__path__"], 7, 7) ;
			return instance["__path__"] || null ;
		}
	}
	
	static public function isImplementationOf(c:Function, i:Function):Boolean {
		if (ConstructorUtil.isSubConstructorOf(c, i)) return false;
		return ConstructorUtil.createBasicInstance(c) instanceof i ;
	}

	static public function isSubConstructorOf( c:Function, sc:Function):Boolean {
		var p = c.prototype ;
		while(p) {
			p = p.__proto__;
			if(p === sc.prototype) return true ;
		}
		return false;
	}


}
