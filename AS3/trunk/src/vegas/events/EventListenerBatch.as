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
		Package : vegas.events.dom
		Version : 1.0.0.0
		Date :  2006-07-09
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
	
	DESCRIPTION
	
		Cette classe permet d'enregistrer plusieurs écouteurs qui seront invoqué en même temps lors de la notification
		 d'un ou plusieurs événements.
	
	USAGE
	
		import flash.events.Event ;
		import vegas.events.Delegate ;
		import vegas.events.EventBroadcaster ;
		import vegas.events.EventListener ;
		import vegas.events.EventListenerBatch ;
				
		var EVENT_TYPE:String = "onTest" ;
				
		var action1:Function = function (e:Event):void {
			trace ("> action1 : " + e.type) ;
		}
				
		var action2:Function = function (e:Event):void {
			trace ("> action2 : " + e.type) ;
		}
				
		var oListener1:EventListener = new Delegate(this, action1) ;
		var oListener2:EventListener = new Delegate(this, action2) ;
				
		var batch:EventListenerBatch = new EventListenerBatch() ;
		batch.insert(oListener1) ;
		batch.insert(oListener2) ;
				
		var e:Event = new Event( EVENT_TYPE , this ) ;
				
		EventBroadcaster.getInstance().addListener(EVENT_TYPE, batch) ;
		EventBroadcaster.getInstance().dispatchEvent( e ) ;
	
	 METHOD SUMMARY
	
		- clear():void
		
		- clone()
		
		- contains(o):Boolean
		
		- get(id:Number):EventListener

 		- handleEvent(e:Event):*

		- insert( oListener:EventListener ):Boolean
		
		- isEmpty():Boolean
		
		- iterator():Iterator
		
		- remove( oR:EventListener ):Boolean
		
		- size():Number
		
		- toArray():Array
	
	INHERIT
	
		CoreObject → AbstractTypeable → TypedCollection → EventListenerBatch

	IMPLEMENTS 

		IFormattable, IHashable, IRunnable, ISerializable, Iterable, Typeable, Validator
	
*/	

package vegas.events
{
	
	import flash.events.Event;
	import vegas.data.Collection;
	import vegas.data.collections.SimpleCollection;
	import vegas.data.collections.TypedCollection;
	import vegas.data.iterator.Iterator;
	import vegas.util.Copier ;
	
	public class EventListenerBatch extends TypedCollection implements EventListener
	{
		
		// ----o Constructor
		
		public function EventListenerBatch()
		{
			super(EventListener, new SimpleCollection());
		}

		// ----o Public Methods

		override public function clone():* {
			var b:EventListenerBatch = new EventListenerBatch() ;
			var it:Iterator = iterator() ;
			while (it.hasNext()) 
			{
				b.insert(it.next()) ;
			}
			return b ;
		}

		override public function copy():* {
			var b:EventListenerBatch = new EventListenerBatch() ;
			var it:Iterator = iterator() ;
			while (it.hasNext()) 
			{
				b.insert( Copier.copy(it.next())) ;
			}
			return b ;
		}
		
		public function handleEvent(e:Event):*
		{
			var ar:Array = toArray() ;
			var i:int = -1 ;
			var l:uint = ar.length ;
			if (l>0)
			{
				while (++i < l) 
				{ 
					ar[i].handleEvent.call(ar[i], e) ; 
				}
			}
		}
		
	}
}