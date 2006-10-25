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

/**	LinearQueue

	AUTHOR

		Name : LinearQueue
		Package : vegas.data.queue
		Version : 1.0.0.1
		Date :  2005-04-24
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	CONSTRUCTOR
	
		var q:LinearQueue = new LinearQueue( [ar:Array] ) 

	METHODS
	
		- dequeue() : Retrieves and removes the head of this queue.
		
		- element() : Retrieves, but does not remove, the head of this queue.
		
		- enqueue(o) : Inserts the specified element into this queue, if possible.
		
		- peek() : Retrieves, but does not remove, the head of this queue, returning null if this queue is empty.
		
		- poll() : Retrieves and removes the head of this queue.
		
		- toArray():Array
		
		- toSource():String
		
		- toString():String

	INHERIT 
	
		CoreObject → AbstractCollection → LinearQueue
		
	IMPLEMENTS
	
		ICloneable, Collection, Iterable, Queue, ISerializable, IFormattable

	TODO [2006-01-05] add toSource method et implement ISerializable in AbstractCollection class
	TODO [2006-01-12] Vérifier le constructeur de AbstractCollection ! utilise super ?
	
**/

import vegas.core.ICloneable;
import vegas.data.Collection;
import vegas.data.collections.AbstractCollection;
import vegas.data.Queue;

class vegas.data.queue.LinearQueue extends AbstractCollection implements Collection, ICloneable, Queue {

	// ----o Constructor
	
	public function LinearQueue( ar:Array ) {
		_a = (ar.length > 0) ? [].concat(ar)  : [] ;
	}

	// ----o Public Methods
	
	public function clone() {
		return new LinearQueue(_a) ;
	}

	public function dequeue():Boolean 
	{
		return poll() != null  ;
	}
	
	public function element() {
		return _a[0] ;
	}

	public function enqueue(o):Boolean {
		if (o == undefined) return false ;
		_a.push(o) ;
		return true ;
	}

	public function peek() {
		if (isEmpty()) return null ;
		return _a[0] ;
	}

	public function poll() {
		if (isEmpty()) return null ;
		return _a.shift() ;
	}	

}