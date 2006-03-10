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

/* ------- 	TypedArray

	AUTHOR

		Name : TypedArray
		Package : vegas.data.array
		Version : 1.0.0.0
		Date :  2005-10-29
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	CONSTRUCTOR
	
		var ta:TypedArray = new TypedArray( type:Function, ar:Array ) 

	METHOD SUMMARY
	
		- concat() : return a TypedArray
		
		- getType()
		
		- hashCode():Number
		
		- iterator()
		
		- push(value)
		
		- setType(type:Function) : set the type and clear TypedArray
		
		- supports(value)
		
		- toString():String
		
		- unshift(value):Number
		
		- validate(value):Void
	
	INHERIT 
	
		Object > Array > TypedArray

	IMPLEMENTS 

		ICloneable, ISerializable, Typeable, Validator

	EXAMPLE
	
		import vegas.data.array.TypedArray ;
		
		var ta:TypedArray = new TypedArray(String, ["item1", "item2", "item3"]) ;
		trace ("ta : " + ta) ;
		ta.push(2) ;
		
		// Output
		// ta : item1,item2,item3
		// [TypeMismatchError] TypedArray.validate('value':2) is mismatch
	
----------  */

import vegas.core.HashCode;
import vegas.core.ICloneable;
import vegas.core.IFormattable;
import vegas.core.ISerializable;
import vegas.core.ITypeable;
import vegas.core.IValidator;
import vegas.data.iterator.ArrayIterator;
import vegas.data.iterator.Iterator;
import vegas.errors.IllegalArgumentError;
import vegas.errors.TypeMismatchError;
import vegas.util.serialize.Serializer;
import vegas.util.TypeUtil;

class vegas.data.array.TypedArray extends Array implements ICloneable, IFormattable, ISerializable, ITypeable, IValidator {

	// ----o Construtor
	
	public function TypedArray(type:Function, ar:Array) {
		if (!type) throw new IllegalArgumentError("Argument 'type' must not be 'null' nor 'undefined'.") ;
		_type = type ;
		var l:Number = ar.length ;
		if (l > 0) {
			for (var i:Number = 0 ; i<l ; i++) {
				var value = ar[i] ;
				if (supports(value)) this[i] = value ;
			}
		}
	}
	
	// ----o Init HashCode
	
	static private var _initHashCode:Boolean = HashCode.initialize(TypedArray.prototype) ;
	
	// ----o Public Methods	
	
	public function clone() {
		return new TypedArray(_type, this.slice()) ;
	}
	
	public function concat():TypedArray {
		var r:TypedArray = new TypedArray(_type) ;
		var i, j, k, l1, l2:Number ;
		i = length ;
		while(--i>-1) r[i] = this[i];
		l1 = arguments.length ;
		j = -1 ;
		while(++j < l1) {
			var cur = arguments[j] ;
			if (cur instanceof Array) {
				l2 = cur.length ;
				k = -1 ;
				while (++k < l2) r.push(cur[k]);
			} else {
				r.push(cur);
			}
		}
		return r ;
	}
	
	public function getType():Function {
		return _type;
	}

	public function hashCode():Number {
		return null ;
	}

	public function iterator():Iterator {
		return new ArrayIterator(this) ;
	}
	
	public function push(value):Number {
		if (arguments.length > 1) {
			var l:Number = arguments.length;
			var i:Number = 0 ;
			while (++i < l) validate(arguments[i]) ;
		} else {
			validate(value) ;
		}
		return Number(super.push.apply(this, arguments)) ;
	}

	public function setType(type:Function):Void {
		_type = type ;
		length = 0 ;
	}

	public function supports(value):Boolean {
		return TypeUtil.typesMatch(value, _type) ;
	}
	
	public function toSource(indent:Number, indentor:String):String {
		var sourceA:String = TypeUtil.toString(_type) ;
		var sourceB:String = Serializer.toSource([].concat(this)) ;
		return Serializer.getSourceOf(this, [sourceA, sourceB]) ;
	}

	public function unshift(value):Number {
		if (arguments.length > 1) {
			var l:Number = arguments.length ;
			var i:Number = -1 ;
			while (++i < l )  validate(arguments[i]);
		} else {
			validate(value) ;
		}
		return Number(super.unshift.apply(this, arguments)) ;
	}

	public function validate(value):Void {
		if (!supports(value)) throw new TypeMismatchError("TypedArray.validate('value':" + value + ") is mismatch") ;
	}
	
	// -----o Private Properties
	
	private var _type:Function ;

	
}