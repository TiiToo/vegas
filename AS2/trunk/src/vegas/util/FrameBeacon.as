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

/* ---------- FrameBeacon

	AUTHOR

		Name : FrameBeacon
		Package : vegas.util
		Version : 1.0.0.0
		Date :  2004-10-19
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	DESCRIPTION
	
		static class

	 PROPERTY SUMMARY
	
		- static running:Boolean [R only]

	 METHOD SUMMARY
	
		- static addFrameListener ( o )
			Ajoute un objet à la liste des écouteurs de la classe MovieClip
			Paramètre : un objet	
		
		- static initialize()
		
		- static isEmpty()
		
		- static isPlaying()
		
		- static release()
		
		- static removeFrameListener ( o ) 
			
			supprime un objet à la liste des écouteurs de la classe MovieClip
			Si la list est vide alors la boucle infinie est détruite.
		
		- static size()
		
		- static start()
		
		- static stop()
		
		- static toString()
	
	EXAMPLE
	
		import vegas.util.FrameBeacon ;
		
		var i:Number = 0 ;
		var max:Number = 25 ;
		
		var o = {} ;
		o.onEnterFrame = function () {
			trace (i) ;
			i++ ;
			if (i == max) FrameBeacon.removeFrameListener(this) ;
		}
		
		FrameBeacon.addFrameListener(o) ;
		
		Key.addListener(this) ;
		onKeyDown = function () {
			FrameBeacon.running ? FrameBeacon.stop() : FrameBeacon.start() ;
		}
	
	
----------------*/

import vegas.data.iterator.ArrayIterator;
import vegas.data.iterator.Iterator;
import vegas.events.Delegate;

class vegas.util.FrameBeacon {

	// ----o Constructor

	private function FrameBeacon() {
		//
	}

	// ----o Mixin AsBroadcaster
	
	static private var __initBroadcaster = AsBroadcaster.initialize(FrameBeacon) ;	

	// ----o Initialize
	
	static private var __initConstructor = FrameBeacon.initialize() ;

	// ----o Virtual Properties
	
	static public function get running():Boolean {
		return FrameBeacon._mc.onEnterFrame == FrameBeacon._proxy ;
	}

	// ----o Public Methods

	static public function addFrameListener(listener):Void  {
		if (! FrameBeacon.running) FrameBeacon.start() ;
		FrameBeacon.addListener(listener) ;
	}

	static public function initialize():MovieClip {
		FrameBeacon._mc = _level0.createEmptyMovieClip ("__mcFBeacon__", -9998) ;
		return FrameBeacon._mc ;
	}

	static public function isEmpty():Boolean {
		return FrameBeacon._listeners.length == 0 ;
	}

	static public function iterator():Iterator {
		return new ArrayIterator(FrameBeacon._listeners) ;
	}

	static public function release(Void):Void {
		FrameBeacon.stop() ;
		FrameBeacon._mc.swapDepths(_level0.getNextHighestDepth()) ;
		FrameBeacon._mc.removeMovieClip () ;
	}

	static public function removeFrameListener(listener):Void {
		FrameBeacon.removeListener(listener);
		if (FrameBeacon.isEmpty()) FrameBeacon.stop();
	}
	
	static public function size():Number {
		return FrameBeacon._listeners.length ;
	}
	
	static public function start():Void {
		FrameBeacon._mc.onEnterFrame = FrameBeacon._proxy ;
	}
	
	static public function stop():Void {
		delete FrameBeacon._mc.onEnterFrame ;
	}

	static public function toString():String {
		return "[FrameBeacon]" ;
	}
	
	// ----o Private Properties
	
	static private var _listeners:Array = new Array ;
	static private var _mc:MovieClip ;
	static private var _proxy:Function = Delegate.create( FrameBeacon, FrameBeacon.broadcastMessage , "onEnterFrame" ) ; 
	static private var addListener:Function ;
	static private var broadcastMessage:Function;
	static private var removeListener:Function ;
	
}
