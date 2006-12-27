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
  Portions created by the Initial Developer are Copyright (C) 2004-2007
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

import vegas.logging.ILogger;
import vegas.logging.ITarget;

/**
 * @author eKameleon
 */
class Tests.vegas.logging.TestInterfaces.ITargetImplementation implements ITarget 
{
	
	
	public var isAddLogger:Boolean = false ;
	
	public var isRemoveLogger:Boolean = false ;
	
	public function addLogger( logger:ILogger ):Void 
	{
		isAddLogger = true ;
	}

	public function removeLogger( logger:ILogger ):Void 
	{
		isRemoveLogger = true ;
	}

}