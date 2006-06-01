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

/** JSONError

	AUTHOR

		Name : JSONError
		Package : vegas.string.errors
		Version : 1.0.0.0
		Date : 2006-01-23
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	PROPERTY SUMMARY
	
		- errorElement:ErrorElement
		
		- message:String
		
		- name:String [Read Only]
	
	METHOD SUMMARY
	
		- getCategory():String
		
			get internal logger's category.
		
		- getLogger():ILogger 
		
			get internal Logger.
		
		- getName():String
		
			return the name of the Error.
		
		- toString():String

	INHERIT
	
		Object → Error → AbstractError → FatalError → ArgumentsError
	
	IMPLEMENT
	
		IFormattable, IHashable
	
**/

import vegas.errors.ErrorFormat;
import vegas.errors.FatalError;

class vegas.string.errors.JSONError extends FatalError {

	// ----o Constructor
	
	public function JSONError(message:String, at:Number, source:String) {
		super(message) ;
		this.at = at ;
		this.source = source ;
	}

	// ----o Public Properties
	
	public var at:Number ;
	public var source:String ;
	
	// ----o Public Methods
	
	public function toString():String {
		var ret:String = (new ErrorFormat()).formatToString(this) ;
		if (!isNaN(at)) ret += ", at:" + at ;
		if (source) ret += " in \"" + source + "\"";
		getLogger().fatal( ret ) ;
		return ret ;
	}
  
}
