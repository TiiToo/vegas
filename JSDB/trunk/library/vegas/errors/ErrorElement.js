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
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

/**
 * Base object for representing an errors.
 * @author eKameleon
 */
if (vegas.errors.ErrorElement == undefined) 
{
	
	/**
	 * Creates a new ErrorElement instance.
	 */
	vegas.errors.ErrorElement = function(thrower, methodName/*String*/, args/*Array*/, fileName/*String*/, lineNumber/*Number*/, isNative/*Boolean*/) 
	{
		this._args = args || null ;
		this._fileName = fileName || null ;
		this._lineNumber = isNaN(lineNumber) ? null : lineNumber ;
		this._isNative = isNative || null ;
		this._methodName = methodName || null ;
		this._thrower = thrower || null ;
	}
	
	/**
	 * @extends vegas.core.CoreObject
	 */
 	vegas.errors.ErrorElement.extend( vegas.core.CoreObject ) ;

	/**
	 * Indicates whether some other object is "equal to" this one.
	 */
	vegas.errors.ErrorElement.prototype.equals = function (o)/*Boolean*/ 
	{
		if (!o instanceof vegas.errors.ErrorElement) 
		{
			return false ;
		}
		return 
		(
			o.getConstructorName() == this.getConstructorName() 
			&& o.getConstructorPath() == this.getConstructorPath()
			&& o.getFileName() == this.getFileName()
			&& o.getLineNumber() == this.getLineNumber()
			&& o.getMethodName()== this.getMethodName()
			&& o.getThrower() == this.getThrower()
		) ;
	}
	
	/**
	 * Returns an array with parameters of the thrower method.
	 */
	vegas.errors.ErrorElement.prototype.getArguments = function ()/*Array*/ 
	{
		return this._args ;
	}
	
	/**
	 * Returns the fully qualified name of the class containing the execution point represented by this stack trace element.
	 */	
	vegas.errors.ErrorElement.prototype.getConstructorName = function ()/*String*/ 
	{
		return this._thrower.getConstructorName() ;
	}

	/**
	 * Returns the fully qualified path of the class containing the execution point represented by this stack trace element.
	 */
	vegas.errors.ErrorElement.prototype.getConstructorPath = function ()/*String*/ 
	{
		return this._thrower.getConstructorPath() ;
	}

	/**
	 * Returns the name of the source file containing the execution point represented by this stack trace element.
	 */
	vegas.errors.ErrorElement.prototype.getFileName = function ()/*String*/ 
	{
		return this._fileName ;
	}

	/**
	 * Returns the line number of the source line containing the execution point represented by this stack trace element.
	 */
	vegas.errors.ErrorElement.prototype.getLineNumber = function ()/*Number*/
	{
		return this._lineNumber ;
	}

	/**
	 * Returns the name of the method containing the execution point represented by this stack trace element.
	 */
	vegas.errors.ErrorElement.prototype.getMethodName = function ()/*String*/ 
	{
		return this._methodName ;
	}

	/**
	 * Return the thrower object reference.
	 */
	vegas.errors.ErrorElement.prototype.getThrower = function () 
	{
		return this._thrower ;
	}

	/**
	 * Returns true if the method containing the execution point represented by this stack trace element is a native method.
	 */
	vegas.errors.ErrorElement.prototype.isNativeMethod = function ()/*Boolean*/ 
	{
		return this._isNative ;
	}
	
	/**
	 * Internal array parameters of the thrower method.
	 */
	vegas.errors.ErrorElement.prototype._args /*Array*/ ;

	/**
	 * Internal file name.
	 */
	vegas.errors.ErrorElement.prototype._fileName /*String*/ ;

	/**
	 * Internal line number.
	 */
	vegas.errors.ErrorElement.prototype._lineNumber /*Number*/ ;

	/**
	 * Internal value to represented is the trace is a native method.
	 */
	vegas.errors.ErrorElement.prototype._isNative /*Boolean*/ ;

	/**
	 * The name of the method.
	 */
	vegas.errors.ErrorElement.prototype._methodName /*String*/ ;

	/**
	 * The internal thrower.
	 */
	vegas.errors.ErrorElement.prototype._thrower ;

}
