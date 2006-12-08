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

import vegas.errors.AbstractError;
import vegas.errors.ErrorElement;
import vegas.errors.ErrorFormat;

/**
 * The error throws when a fatal method or action is detected in the code.
 * This error notify a fatal level message in the vegas.errors.* logging category.
 * @author eKameleon
 */
class vegas.errors.FatalError extends AbstractError 
{
    
	/**
	 * Creates a new FatalError instance.
	 */
	public function FatalError(message:String, errorElement:ErrorElement) 
	{
		super(message, errorElement) ;
	}

	/**
	 * Returns the string representation of this instance.
	 * @return the string representation of this instance
	 */
	/*override*/ public function toString():String 
	{
		var msg:String = (new ErrorFormat()).formatToString(this) ;
		getLogger().fatal( msg ) ;
		return msg ;
	}
	
}
