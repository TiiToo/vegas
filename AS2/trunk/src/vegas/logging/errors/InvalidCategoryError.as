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

/** InvalidCategoryError

	AUTHOR

		Name : InvalidCategoryError
		Package : vegas.logging.errors
		Version : 1.0.0.0
		Date : 2005-12-16
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
	
	DESCRIPTION
	
		This error is thrown when a category specified for a logger contains invalid characters or is malformed.

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
	
		Object > Error > AbstractError > FatalError > InvalidCategoryError
	
	IMPLEMENT
	
		IFormattable

**/

import vegas.errors.ErrorElement;
import vegas.errors.FatalError;

class vegas.logging.errors.InvalidCategoryError extends FatalError {

	// ----o Constructor
	
	public function InvalidCategoryError(msg:String, errorElement:ErrorElement) {
		super(msg, errorElement) ;
	}
  
}
