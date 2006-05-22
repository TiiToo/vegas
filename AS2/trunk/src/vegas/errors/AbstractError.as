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

/** AbstractError

	AUTHOR

		Name : AbstractError
		Package : vegas.errors
		Version : 1.0.0.0
		Date : 2006-01-22
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
	
	PROPERTY SUMMMARY
	
		- errorElement:ErrorElement
		
		- message:String
		
		- name:String [Read Only]
	
	METHOD SUMMARY
	
		- getCategory():String
		
			get internal logger's category.
		
		- getLogger():ILogger 
		
			get internal Logger.
		
		- getMessage():String
		
			return the message of the Error.
		
		- getName():String
		
			return the name of the Error.
		
		- toString():String

	INHERIT
	
		Object → Error → AbstractError
	
	IMPLEMENT
	
		IFormattable, IHashable

	TODO 2006-01-22 injecter le ErrorElement dans le ErrorFormat.

**/

import vegas.core.HashCode;
import vegas.core.IFormattable;
import vegas.core.IHashable;
import vegas.errors.ErrorElement;
import vegas.errors.ErrorFormat;
import vegas.logging.ILogger;
import vegas.logging.Log;
import vegas.util.ConstructorUtil;
import vegas.util.factory.PropertyFactory;

class vegas.errors.AbstractError extends Error implements IFormattable, IHashable {
    
	// ----o Constructor
	
	private function AbstractError(message:String, e:ErrorElement) {
		super(message) ;
		errorElement = e ;
		_logger = Log.getLogger(ConstructorUtil.getPath(this)) ;
	}

	// ----o Init HashCode
	
	static private var _initHashCode:Boolean = HashCode.initialize(AbstractError.prototype) ;

	// ----o Public Properties

	public var errorElement:ErrorElement ;
	
	// ----o Public Methods
	
	public function getCategory():String {
		return _logger["category"] ;
	}
	
	public function getLogger():ILogger {
		return _logger ;
	}
	
	public function getMessage():String {
		return message ;
	}
	
	public function getName():String {
		return ConstructorUtil.getName(this) ;
	}

	public function hashCode():Number {
		return null ;
	}
	
	public function toString():String {
		return (new ErrorFormat()).formatToString(this) ;
	}
	
	// ----o Virtual Properties
	
	static private var __NAME__:Boolean = PropertyFactory.create(AbstractError, "name", true, true) ;
	
	// ----o Private Properties
	
	private var _logger:ILogger ;
	private var name:String ;
	private var message:String ;
	
}
