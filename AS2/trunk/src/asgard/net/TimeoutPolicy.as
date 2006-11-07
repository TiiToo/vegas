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

/**
	
	AUTHOR
	
		Name : TimeOutPolicy
		Package : asgard.net
		Version : 1.0.0.0
		Date :  3 nov. 06
		Author : eKameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

*/

import vegas.core.CoreObject;
import vegas.util.serialize.Serializer;

/**
 * @author eKameleon
 */
class asgard.net.TimeoutPolicy extends CoreObject 
{
	
	public function TimeoutPolicy( value:Number ) 
	{
		super();
		_value = value ;
	}

	// ----o Public Properties
	
	static public var INFINITY:TimeoutPolicy = new TimeoutPolicy(0) ;
			
	static public var LIMIT:TimeoutPolicy = new TimeoutPolicy(1) ;
	
	// -----o Public Methods
		
	/*override*/ public function toSource():String
	{
		return "new asgard.net.TimeoutPolicy(" + Serializer.toSource(_value) + ")" ;
	}
		
	/*override*/ public function toString():String
	{
		return String(_value) ;	
	}
	
	public function valueOf()
	{
		return _value ;
	}
		
	// ----o Private Properties
		
	private var _value:Number ;	

}