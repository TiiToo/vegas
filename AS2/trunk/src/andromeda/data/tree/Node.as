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

import vegas.core.CoreObject;
import vegas.core.ICloneable;
import vegas.core.ISerializable;

class andromeda.data.tree.Node extends CoreObject implements ICloneable, ISerializable 
{

	public function Node( data:Number ) 
	{
		this.left  = null ;
		this.right = null ;
		this.data  = data ;
	}
	
	/**
	 * The left Node of this Node.
	 */
	public var left:Node ;
	
	/**
	 * The right Node of this Node.
	 */
	public var right:Node ;
	
	/**
	 * The data of this Node.
	 */
	public var data:Number ;
	
	/**
	 * Returns a shallow copy of this object.
	 * @return a shallow copy of this object.
	 */
	public function clone() 
	{
		return new Node(data) ;
	}

	/**
	 * Returns a Eden reprensation of the object.
	 * @return a string representing the source code of the object.
	 */
	public function toSource(indent:Number, indentor:String):String 
	{
		return "new andromeda.data.tree.Node(" + data + ")" ;
	}

	/**
	 * Returns the string representation of this instance.
	 * @return the string representation of this instance.
	 */
	public function toString():String 
	{
		return "[Node data:" + data + "]" ;
	}

}