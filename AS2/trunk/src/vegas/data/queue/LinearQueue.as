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

// TODO [2006-01-05] add toSource method et implement ISerializable in AbstractCollection class
// TODO [2006-01-12] Vérifier le constructeur de AbstractCollection ! utilise super ?

import vegas.core.ICloneable;
import vegas.data.Collection;
import vegas.data.collections.AbstractCollection;
import vegas.data.Queue;

/**
 * LinearQueue stores values in a 'first-in, first-out' manner.
 * @author eKameleon
 */
class vegas.data.queue.LinearQueue extends AbstractCollection implements Collection, ICloneable, Queue 
{

	/**
	 * Creates a new LinearQueue instance.
	 */
	public function LinearQueue( ar:Array ) 
	{
		_a = (ar.length > 0) ? [].concat(ar) : [] ;
	}

	/**
	 * Returns a shallow copy of this object.
	 * @return a shallow copy of this object.
	 */	
	public function clone() 
	{
		return new LinearQueue(_a) ;
	}

	/**
	 * Retrieves and removes the head of this queue.
	 */
	public function dequeue():Boolean 
	{
		return poll() != null  ;
	}
	
	/**
	 * Retrieves, but does not remove, the head of this queue.
	 */
	public function element() 
	{
		return _a[0] ;
	}

	/**
	 * Inserts the specified element into this queue, if possible.
	 */
	public function enqueue(o):Boolean 
	{
		if (o == undefined) return false ;
		_a.push(o) ;
		return true ;
	}

	/**
	 * Retrieves, but does not remove, the head of this queue, returning null if this queue is empty.
	 */
	public function peek() 
	{
		if (isEmpty()) 
		{
			return null ;
		}
		return _a[0] ;
	}

	/**
	 * Retrieves and removes the head of this queue.
	 */
	public function poll() 
	{
		if (isEmpty()) 
		{
			return null ;
		}
		return _a.shift() ;
	}	

}