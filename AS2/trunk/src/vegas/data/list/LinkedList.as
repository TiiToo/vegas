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

/* ----------  LinkedList

	AUTHOR

		Name : LinkedList
		Package :  vegas.data.list
		Version : 1.0.0.0
		Date : 2005-04-25
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
		
	METHOD SUMMARY
	
		- clone()
		
		- dequeue() : Retrieves and removes the head of this queue.
		
		- element() : Retrieves, but does not remove, the head of this queue.
		
		- enqueue(o) : Inserts the specified element into this queue, if possible.
		
		- insertFirst()
		
		- insertLast()
		
		- getFirst()
		
		- getLast()
		
		- peek() : Retrieves, but does not remove, the head of this queue, returning null if this queue is empty.
		
		- poll() : Retrieves and removes the head of this queue.
		
		- removeFirst()
		
		- removeLast()
	
	INHERIT
	
		AbstratCollection
			|
			SimpleCollection
				|
				AbstractList
					|
					AbstractCollection

----------  */

import vegas.core.ICloneable;
import vegas.data.Collection;
import vegas.data.collections.SimpleCollection;
import vegas.data.list.AbstractList;
import vegas.data.Queue;
import vegas.errors.NoSuchElementError;
import vegas.util.serialize.Serializer;

class vegas.data.list.LinkedList extends AbstractList implements ICloneable, Queue {

	// ----o Constructor

	public function LinkedList(c:Collection) { 
		super() ;
		if (c) insertAll(c) ;
	}

	// ----o Public Methods

	public function clone() {
		return new LinkedList(this) ;
	}

	public function insertFirst(o):Void {
		insertAt(0, o) ;
	}
	
	public function insertLast(o):Void {
		insertAt(size(), o) ;
	}
		
	public function getFirst() {
		if (size == 0) {
			throw new NoSuchElementError() ;
		}
		return this.get(0) ;
	}
	
	public function getLast() {
		if (size == 0) throw new NoSuchElementError();
		return this.get(size() - 1) ;
	}
	
	public function removeFirst() {
		return removeAt(0) ;
	}
	
	public function removeLast() {
		return removeAt(size() - 1) ;
	}
	
	/*override*/ public function toSource(indent:Number, indentor:String):String {
		return Serializer.getSourceOf(this, [ Serializer.toSource(new SimpleCollection(toArray())) ] ) ;
	}
	
	// ---- Queue Implements

	public function dequeue():Boolean {
		if (isEmpty()) return false ;
		return (removeFirst() != undefined) ;
	}
	
	public function element() {
		return getFirst() ;
	}
	
	public function enqueue(o):Boolean {
		if (o == undefined) return false ;
		insertLast(o) ;
		return true ;
	}

	public function peek() {
		if (isEmpty()) return null ;
		return getFirst() ;
	}

	public function poll() {
		if (isEmpty()) return null ;
		return removeFirst() ;
	}	
	
}
