/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is ASGard Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
 */

import asgard.data.map.BasicMapEntry;
import asgard.data.map.TreeMap;

/**
 * Class to represent an entry in a TreeMap. 
 * Holds a single key-value pair, plus pointers to parent and child nodes.
 * @author eKameleon
 */
class asgard.data.map.TreeMapNode extends BasicMapEntry 
{
	
	/**
	 * Creates a new TreeMapNode instance.
	 */
	public function TreeMapNode( key, value , color) 
	{
		super(key, value) ;
		left   = TreeMap.NIL ;
		parent = TreeMap.NIL ;
		right  = TreeMap.NIL ;
		this.color = color ;
	}

	/**
	 * The color of this node.
	 */
	public var color:Number ;

	/**
	 * The left child node.
	 */
	public var left:TreeMapNode ;
	
	/**
	 * The parent node of this node.
	 */
	public var parent:TreeMapNode ;
	
	/**
	 * The right child node.
	 */
	public var right:TreeMapNode ;
	
	/**
	 * Returns the string representation of this object.
	 * @return the string representation of this object.
	 */
	public function toString():String
	{
		return "[TreeMapNode " + key + " - " + value + "]" ;
	} 
	

}