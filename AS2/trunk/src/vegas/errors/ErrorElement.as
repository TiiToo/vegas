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

/* ---- ErrorElement

	AUTHOR

		Name : ErrorElement
		Package : vegas.errors
		Version : 1.0.0.0
		Date : 2006-01-22
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
	
	CONSTRUCTOR
	
		new ErrorElement(thrower, methodName:String, args:Array, fileName:String, lineNumber:Number, isNative:Boolean)
	
	METHOD SUMMARY
	
		- equals(o):Boolean
		
			Returns true if the given object is also a ErrorElement and all attributes, except the native flag, are equal.
		
		- getArguments():Array
		
			Returns an array with parameters of the thrower method.
		
		- getConstructorName():String
		
			Returns the fully qualified name of the class containing the execution point represented by this stack trace element.
		
		- getFileName():String
		
			Returns the name of the source file containing the execution point represented by this stack trace element.
		
		- getLineNumber():Number
		
			Returns the line number of the source line containing the execution point represented by this stack trace element.
		
		- getMethodName():String
		
			Returns the name of the method containing the execution point represented by this stack trace element.
		
		- isNativeMethod():Boolean
		
			Returns true if the method containing the execution point represented by this stack trace element is a native method.
		
		- toString():String
		
			Returns a string representation of this stack trace element.
	
	INHERIT
	
		Object > ErrorElement
	
	IMPLEMENTS
	
		IFormattable
	
----------  */

import vegas.core.IEquality;
import vegas.core.IFormattable;
import vegas.util.ConstructorUtil;

class vegas.errors.ErrorElement implements IEquality, IFormattable {
    
	// ----o Constructor
	
	public function ErrorElement(thrower, methodName:String, args:Array, fileName:String, lineNumber:Number, isNative:Boolean) {
		_args = args || null ;
		_fileName = fileName || null ;
		_lineNumber = lineNumber || null ;
		_isNative = isNative || null ;
		_methodName = methodName || null ;
		_thrower = thrower || null ;
	}
	
	// ----o Public Methods
	
	public function equals(o):Boolean {
		if (!o instanceof ErrorElement) return false ;
		return (
			o.getConstructorName() == getConstructorName() 
			&& o.getConstructorPath() == getConstructorPath()
			&& o.getFileName() == getFileName()
			&& o.getLineNumber() == getLineNumber()
			&& o.getMethodName()== getMethodName()
			&& o.getThrower() == getThrower()
		) ;
	}
	
	public function getArguments():Array {
		return _args ;
	}
	
	public function getConstructorName():String {
		return ConstructorUtil.getName(_thrower) ;
	}

	public function getConstructorPath():String {
		return ConstructorUtil.getPath(_thrower) ;
	}
	
	public function getFileName():String {
		return _fileName ;
	}
	
	public function getLineNumber():Number {
		return _lineNumber ;
	}
	
	public function getMethodName():String {
		return _methodName ;
	}
	
	public function getThrower() {
		return _thrower ;
	}

	public function isNativeMethod():Boolean {
		return _isNative ;
	}
	
	public function toString():String {
		return "[ErrorElement]" ;
	}
	
	// ----o Private Properties
	
	private var _args:Array ;
	private var _fileName:String ;
	private var _lineNumber ;
	private var _isNative:Boolean ;
	private var _methodName:String ;
	private var _thrower ;
	
}
