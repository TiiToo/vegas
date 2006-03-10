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

/* ------- 	BinaryTree

	!!! EN CONSTRUCTION !!!

	AUTHOR

		Name : BinaryTree
		Package : vegas.data.tree
		Version : 0.0.0.0
		Date :  2005-12-21
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	PROPERTY SUMMARY
	

	
	METHOD SUMMARY
	
		- clone()
		
		- contains(data:Number):Boolean
		
		- insert(data:Number):Void
		
		- max():Number
		
		- maxDepth():Number
		
		- min():Number
		
		- size():Number
		
		- toSource():String
		
		- toString():String
	
	IMPLEMENT
	
			ICloneable, ISerializable, IFormattable, IHashable
	
	INHERIT
	
		CoreObject
			|
			BinaryTree
	
	SEE ALSO
	
		Node
	
	!!! EN CONSTRUCTION !!!
	
----------  */

import vegas.core.CoreObject;
import vegas.core.ICloneable;
import vegas.core.ISerializable;
import vegas.data.tree.Node;

class vegas.data.tree.BinaryTree extends CoreObject implements ICloneable, ISerializable {

	// ----o Construtor
	
	public function BinaryTree() {
		root = null ;
	}

	// ----o Public Properties
	
	public var root:Node ;
	
	// ----o Public Methods
	
	public function clone() {
		return new BinaryTree() ;
	}

	public function contains(data:Number):Boolean {
        return _contains(root, data) ;
    }

	public function insert(data:Number):Void {
		root = _insert(root, data) ;
	}

	public function max():Number {
        return _max(root);
    }

	public function maxDepth():Number {
        return _maxDepth(root);
    }

	public function min():Number {
        return _min(root);
    }
	
	public function size():Number {
		return _size(root) ;
	}

	public function toSource(indent:Number, indentor:String):String {
		return "new BinaryTree()" ;
	}

	public function toString():String {
		var txt:String = "[BinaryTree]" ;
		txt += "\r" + _toString(root) ;
		return txt ;
	}

	// ----o Private Methods

	private function _contains(node:Node, data:Number):Boolean {
        if (node == null) return false ;
        if (data == node.data) return true ;
        else if (data < node.data ) return _contains(node.left, data) ;
        else return _contains( node.right, data) ;
    }

	private function _insert(node:Node, data:Number):Node {
		if (node == null) node = new Node(data) ;
        else {
            if ( data <= node.data) node.left = _insert(node.left, data) ;
            else node.right = _insert(node.right, data) ;
        }
        return node ;
    }
	
	private function _maxDepth(node:Node):Number {
        if (node == null) return 0 ;
        else {
            var l:Number = _maxDepth(node.left);
            var r:Number = _maxDepth(node.right);
            return Math.max(l, r) + 1 ;
        }
    }

	private function _max(node:Node):Number {
        var cur:Node = node ;
		while (cur.right !=null ) cur = cur.right ;
        return cur.data ;
    }

	private function _min(node:Node):Number {
        var cur:Node = node ;
		while (cur.left !=null ) cur = cur.left ;
        return cur.data ;
    }
	
	private function _size(node:Node):Number {
		if (node == null) return 0 ;
		else return _size(node.left) + _size(node.right) ;
	}
	
	private function _toString(node:Node):String {
		if (node==null) return "" ;
        // left, node itself, right
		var txt:String = "" ;
        txt += "L --- " + _toString(node.left) + " : " + node.data + "\r" ; 
        txt += "R --- " + _toString(node.right) ;
		return txt ;
    }
	

}