﻿/*

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

import vegas.errors.ErrorElement;
import vegas.errors.FatalError;

/**
 * The error throws when an argument in a function is out of specified bounds.
 * @author eKameleon
 */
class vegas.errors.ArgumentOutOfBoundsError extends FatalError 
{

	/**
	 * Creates a new ArgumentOutOfBoundsError instance.
	 */
	public function ArgumentOutOfBoundsError(message:String, errorElement:ErrorElement) 
	{
		super(message, errorElement) ;
	}

}
