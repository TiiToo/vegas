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

import vegas.data.iterator.ArrayIterator;
import vegas.data.iterator.Iterator;
import vegas.events.Delegate;
import vegas.util.ArrayUtil;

/**
 * This singleton create a virtual Frame interval with a onEnterFrame event. 
 * The use can register object listeners to receive onEnterFrame event.
 * <p><b>Example :</b></p>
 * {@code
 * import vegas.util.FrameBeacon ;
 * 
 * var i:Number = 0 ;
 * var max:Number = 25 ;
 * 
 * var o = {} ;
 * o.onEnterFrame = function () 
 * {
 *     trace (i) ;
 *     i++ ;
 *     if (i == max) 
 *     {
 *         FrameBeacon.removeFrameListener(this) ;
 *     }
 * }
 * 
 * FrameBeacon.addFrameListener(o) ;
 * 
 * this.onKeyDown = function () 
 * {
 *     if (FrameBeacon.running)
 *     {
 *         FrameBeacon.stop() ;
 *     }
 *     else
 *     {
 *         FrameBeacon.start() ;
 *     }
 * }
 * Key.addListener(this) ;
 * }  
 * @author eKameleon
 */
class vegas.util.FrameBeacon 
{

	private static var __initBroadcaster = AsBroadcaster.initialize(FrameBeacon) ;	

	private static var __initConstructor = FrameBeacon.initialize() ;

	/**
	 * Returns {@code true} if the {@code FrameBeacon} is in progress (read only property).
	 * <p><b>Example :</b></p>
	 * {@code
	 * import vegas.util.FrameBeacon ;
	 * FrameBeacon.start() ;
	 * trace(FrameBeacon.running) ; // true
	 * } 
	 * @return {@code true} if the {@code FrameBeacon} is in progress.
	 */
	public static function get running():Boolean 
	{
		return FrameBeacon._mc.onEnterFrame == FrameBeacon._proxy ;
	}

	/**
	 * Registers a listener to receive the onEnterFrame event.
	 */
	public static function addFrameListener(listener):Void  
	{
		if (!FrameBeacon.running) 
		{
			FrameBeacon.start() ;
		}
		FrameBeacon.addListener(listener) ;
	}

	/**
	 * Returns {@code true} if the listener is registered in the FrameBeacon tool.
	 * @return {@code true} if the listener is registered in the FrameBeacon tool.
	 */
	public static function containsListener(listener):Boolean
	{
		return ArrayUtil.contains( FrameBeacon._listeners, listener ) ;
	}

	/**
	 * Initialize the protected MovieClip who notify the onEnterFrame event.
	 * @return the internal reference of the movieclip used by the FrameBeacon tool class.
	 */
	public static function initialize():MovieClip 
	{
		FrameBeacon._mc = _level0.createEmptyMovieClip ("__mcFBeacon__", -9998) ;
		return FrameBeacon._mc ;
	}

	/**
	 * Returns {@code true} if this instance is empty of listeners.
	 * @return {@code true} if this instance is empty of listeners.
	 */
	public static function isEmpty():Boolean 
	{
		return FrameBeacon._listeners.length == 0 ;
	}

	/**
	 * Returns the iterator of this FrameBeacon singleton.
	 * @return the iterator of this FrameBeacon singleton.
	 */
	public static function iterator():Iterator 
	{
		return new ArrayIterator(FrameBeacon._listeners) ;
	}

	/**
	 * Release the {@code FrameBeacon} singleton.
	 */
	public static function release():Void 
	{
		FrameBeacon.stop() ;
		FrameBeacon._mc.swapDepths(_level0.getNextHighestDepth()) ;
		FrameBeacon._mc.removeMovieClip () ;
		FrameBeacon._mc = undefined ;
	}

	/**
	 * Removes a listener who receive the onEnterFrame event.
	 * If the {@code FrameBeacon} is empty the event broadcast is stopped.
	 */
	public static function removeFrameListener(listener):Void 
	{
		FrameBeacon.removeListener(listener) ;
		if (FrameBeacon.isEmpty())
		{
			FrameBeacon.stop();
		}
	}
	
	/**
	 * Returns the number of listeners in the tool.
	 * @return the number of listeners in the tool.
	 */
	public static function size():Number 
	{
		return FrameBeacon._listeners.length ;
	}
	
	/**
	 * Start the onEnterFrame broadcast.
	 */
	public static function start():Void 
	{
		FrameBeacon._mc.onEnterFrame = FrameBeacon._proxy ;
	}

	/**
	 * Stop the onEnterFrame broadcast.
	 */
	public static function stop():Void 
	{
		delete FrameBeacon._mc.onEnterFrame ;
	}

	/**
	 * Returns the string representation of this singleton.
	 * @return the string representation of this singleton.
	 */
	public static function toString():String 
	{
		return "[FrameBeacon]" ;
	}

	private static var addListener:Function ;

	private static var broadcastMessage:Function;

	private static var _listeners:Array = new Array() ;

	private static var _mc:MovieClip ;

	private static var _proxy:Function = Delegate.create( FrameBeacon, FrameBeacon.broadcastMessage , "onEnterFrame" ) ; 

	private static var removeListener:Function ;
	
}
