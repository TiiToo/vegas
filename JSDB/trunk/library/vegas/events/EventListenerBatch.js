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

/**
 * It handles several {@code EventListener} as one {@code EventListener}.
 * <p><b>Example : </b></p>
 * {@code
 * 	
 * BasicEvent         = vegas.events.BasicEvent ;
 * Delegate           = vegas.events.Delegate ;
 * EventDispatcher    = vegas.events.EventDispatcher ;
 * EventListenerBatch = vegas.events.EventListenerBatch ;
 * 
 * var EVENT_TYPE:String = "onTest" ;
 * 
 * var action1:Function = function (e:Event):Void 
 * {
 *    trace ("> action1 : " + e.getType()) ;
 * }
 * 
 * var action2:Function = function (e:Event):Void 
 * {
 *     trace ("> action2 : " + e.getType()) ;
 * }
 * 
 * var oListener1:EventListener = new Delegate(this, action1) ;
 * var oListener2:EventListener = new Delegate(this, action2) ;
 * 
 * var batch:EventListenerBatch = new EventListenerBatch() ;
 * batch.insert(oListener1) ;
 * batch.insert(oListener2) ;
 * 	
 * var e:Event = new BasicEvent( EVENT_TYPE , this ) ;
 * 	
 * EventDispatcher.getInstance().addEventListener(EVENT_TYPE, batch) ;
 * EventDispatcher.getInstance().dispatchEvent( e ) ;
 * }
 */
if (vegas.events.EventListenerBatch == undefined) 
{

	/**
	 * Creates a new EventListenerBatch instance.
	 */
	vegas.events.EventListenerBatch = function () 
	{ 
		var type = vegas.events.EventListener ;
		vegas.data.collections.TypedCollection.call
		(
			this , vegas.events.EventListener , new vegas.data.collections.SimpleCollection()
		) ;
	}

	/**
	 * @extends vegas.data.collections.TypedCollection
	 */
	vegas.events.EventListenerBatch.extend(vegas.data.collections.TypedCollection) ;
	
	/**
	 * Handles the event.
	 */
	vegas.events.EventListenerBatch.prototype.handleEvent = function (e /*Event*/ ) 
	{
		var ar /*Array*/ = this.toArray() ;
		var i /*Number*/ = -1 ;
		var l /*Number*/ = ar.length ;
		if (l>0) 
		{
			while (++i < l) 
			{ 
				ar[i].handleEvent.apply(ar[i], Array.fromArguments(arguments)) ; 
			}
		}
		
	}
	
}