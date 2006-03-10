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

/* ------- 	Node

	AUTHOR

		Name : Node
		Package : vegas.data.tree
		Version : 1.0.0.0
		Date :  2005-12-21
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	PROPERTY SUMMARY
	
		- data:Number
		
		- left:Node
		
		- right:Node
	
	METHOD SUMMARY
	
		- clone()
		
		- toSource():String
		
		- toString():String
	
	INHERIT
	
		CoreObject
			|
			Node
	
	IMPLEMENT
	
		ICloneable, IFormattable, IHashable, ISerializable
	
----------  */

import vegas.core.CoreObject;
import vegas.core.ICloneable;
import vegas.core.ISerializable;

class vegas.data.tree.Node extends CoreObject implements ICloneable, ISerializable {

	// ----o Construtor
	
	public function Node(d:Number) {
		left = null ;
		right = null ;
		data = d ;
	}
	
	// ----o Public Properties
	
	public var left:Node ;
	public var right:Node ;
	public var data:Number ;
	
	// ----o Public Methods
	
	public function clone() {
		return new Node(data) ;
	}

	public function toSource(indent:Number, indentor:String):String {
		return "new Node(" + data + ")" ;
	}

	public function toString():String {
		return "<Node data:" + data + " />" ;
	}

}