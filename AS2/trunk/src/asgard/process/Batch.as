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

/* Batch

	AUTHOR

		Name : Batch
		Package : asgard.process
		Version : 1.0.0.0
		Date :  2004-12-21
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
	
	METHOD SUMMARY
	
		- clear():Void
		
		- clone()
		
		- contains(o):Boolean
		
		- get(id:Number):IRunnable
		
		- insert( oR:IRunnable ):Boolean
		
		- isEmpty():Boolean
		
		- iterator():Iterator
		
		- remove( oR:IRunnable ):Boolean
		
		- run():Void
		
		- size():Number
		
		- toArray():Array
	
	INHERIT
	
		CoreObject > AbstractTypeable > TypedCollection > Batch

	IMPLEMENTS 

		IFormattable, IHashable, IRunnable, ISerializable, Iterable, Typeable, Validator, 	
	
*/	

import vegas.core.IRunnable;
import vegas.data.collections.SimpleCollection;
import vegas.data.collections.TypedCollection;
import vegas.data.iterator.Iterator;

class asgard.process.Batch extends TypedCollection implements IRunnable {

	// ----o Constructor
	
 	public function Batch() {
		super(IRunnable, new SimpleCollection()) ;
  	}

	// ----o Public Methods
	
	public function clone() {
		var b:Batch = new Batch() ;
		var it:Iterator = iterator() ;
		while (it.hasNext()) b.insert(it.next()) ;
		return b ;
	}
	
 	public function run():Void {
		var ar:Array = toArray() ;
		var i:Number = -1 ;
		var l:Number = ar.length ;
		if (l>0) while (++i < l) { 
			ar[i].run() ; 
		}
  	}
	
}