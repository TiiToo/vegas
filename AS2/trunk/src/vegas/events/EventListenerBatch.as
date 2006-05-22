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

/** EventListenerBatch

	AUTHOR

		Name : EventListenerBatch
		Package : vegas.events
		Version : 1.0.0.0
		Date :  2006-03-26
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
	
	DESCRIPTION
	
		Cette classe permet d'enregistrer plusieurs écouteurs qui seront invoqué en même temps lors de la notification
		 d'un ou plusieurs événements.
	
	USE
	
		import vegas.events.BasicEvent ;
		import vegas.events.Delegate ;
		import vegas.events.Event ;
		import vegas.events.EventDispatcher ;
		import vegas.events.EventListener ;
		import vegas.events.EventListenerBatch ;
		
		var EVENT_TYPE:String = "onTest" ;
		
		var action1:Function = function (e:Event):Void {
    		trace ("> action1 : " + e.getType()) ;
		}
		
		var action2:Function = function (e:Event):Void {
    		trace ("> action2 : " + e.getType()) ;
		}
		
		var oListener1:EventListener = new Delegate(this, action1) ;
		var oListener2:EventListener = new Delegate(this, action2) ;
		
		var batch:EventListenerBatch = new EventListenerBatch() ;
		batch.insert(oListener1) ;
		batch.insert(oListener2) ;
		
		var e:Event = new BasicEvent( EVENT_TYPE , this ) ;
		
		EventDispatcher.getInstance().addEventListener(EVENT_TYPE, batch) ;
		EventDispatcher.getInstance().dispatchEvent( e ) ;
	
	METHOD SUMMARY
	
		- clear():Void
		
		- clone()
		
		- contains(o):Boolean
		
		- get(id:Number):EventListener

 		- handleEvent(e:Event):Void

		- insert( oListener:EventListener ):Boolean
		
		- isEmpty():Boolean
		
		- iterator():Iterator
		
		- remove( oR:EventListener ):Boolean
		
		- size():Number
		
		- toArray():Array
	
	INHERIT
	
		CoreObject > AbstractTypeable > TypedCollection > BatchEventListener

	IMPLEMENTS 

		IFormattable, IHashable, IRunnable, ISerializable, Iterable, Typeable, Validator
	
**/	

import vegas.data.collections.SimpleCollection;
import vegas.data.collections.TypedCollection;
import vegas.data.iterator.Iterator;
import vegas.events.Event;
import vegas.events.EventListener;

class vegas.events.EventListenerBatch extends TypedCollection implements EventListener {

	// ----o Constructor
	
 	public function EventListenerBatch() {
		super(EventListener, new SimpleCollection()) ;
  	}

	// ----o Public Methods
	
	public function clone() {
		var b:EventListenerBatch = new EventListenerBatch() ;
		var it:Iterator = iterator() ;
		while (it.hasNext()) b.insert(it.next()) ;
		return b ;
	}
	
	public function handleEvent(e:Event) {
		var ar:Array = toArray() ;
		var i:Number = -1 ;
		var l:Number = ar.length ;
		if (l>0) while (++i < l) { 
			ar[i].handleEvent.apply(ar[i], arguments) ; 
		}
  	}
	
}