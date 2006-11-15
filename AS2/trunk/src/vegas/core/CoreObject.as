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

import vegas.core.HashCode;
import vegas.core.IFormattable;
import vegas.core.IHashable;
import vegas.core.ISerializable;
import vegas.util.ConstructorUtil;

/**
 * @author eKameleon.
 */
class vegas.core.CoreObject implements IFormattable, IHashable, ISerializable 
{

	/**
	 * Creates a new CoreObject instance.
	 */
	public function CoreObject() 
	{
		//
	}
	
	/**
	 * Returns a hashcode value for the object.
	 */
	public function hashCode():Number 
	{
		return null ;
	}

	/**
	 * Returns a Eden reprensation of the object.
	 */
	public function toSource(indent : Number, indentor : String):String 
	{
		return "new " + ConstructorUtil.getPath(this) + "()" ;
	}
	
	/**
	 * Returns a string representation of the object.
	 */
	public function toString():String 
	{
		return "[" + ConstructorUtil.getName(this) + "]" ;
	}

	static private var _initHashCode:Boolean = HashCode.initialize(CoreObject.prototype) ;
	
}