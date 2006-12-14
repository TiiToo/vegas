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

/** Sequencer

	AUTHOR
	
		Name : Sequencer
		Package : asgard.process
		Version : 1.0.0.0
		Date :  2005-07-05
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
	
	DESCRIPTION 
	
		Permet de gérer via une queue un séquençage de plusieurs objets qui implémentent l'interface Action.
			
	PROPERTY SUMMARY
	
		- running:Boolean [Read Only]
		
	METHOD SUMMARY
	
		- addAction(action:Action, isClone:Boolean):Boolean
		
			ajoute une action dans la séquence et renvoi true si l'action est bien ajoutée.
	
		- clear()
		
			vider la séquence
		
		- clone():Sequencer
		
			renvoi une copie indépendante de l'instance.
		
		- getRunning():Boolean
		
			renvoi true si la séquence est en action.
		
		- notifyStarted():Void
			
			notifie le lancement de la séquence
		
		- notifyFinished():Void
		
			notifie la fin de la séquence
		
		- run():Void
		
			lancer la séquence sur le premier élément mi en queue dans la séquence
		
		- size():Number
		
			nombre d'éléments dans la séquence.
		
		- start():Void
			
			lancer la séquence
		
		- stop() : arrêter la séquence (n'arrête pas la dernière action en cours d'éxecution)

	EVENT SUMMARY
	
		- ActionEventType.FINISH
		
		- ActionEventType.PROGRESS
		
		- ActionEventType.START

	INHERIT
	
		CoreObject > AbstractCoreEventDispatcher > AbstractAction > Sequencer

	IMPLEMENTS
	
		Action, IEventDispatcher, ICloneable, IRunnable, ISerializable, IFormattable

*/

import asgard.events.ActionEventType;
import asgard.process.AbstractAction;
import asgard.process.Action;

import vegas.data.iterator.Iterator;
import vegas.data.queue.LinearQueue;
import vegas.data.queue.TypedQueue;
import vegas.events.Delegate;
import vegas.events.EventListener;
import vegas.util.serialize.Serializer;

class asgard.process.Sequencer extends AbstractAction {
	
	// ----o Constructor
	
	public function Sequencer( ar:Array ) {
		_queue = new TypedQueue(Action, new LinearQueue()) ; 
		_runner = new Delegate(this, run) ;
		var l:Number = ar.length ;
		if (l>0) {
			for (var i:Number = 0 ; i < l ; i++) {
				var a:Action = ar[i] ;
				if (a instanceof Action) addAction(ar[i]) ;		
			}
		}
	}

	// ----o Public Methods
	
	public function addAction(action:Action, isClone:Boolean):Boolean {
		var a:Action = isClone ? action.clone() : action ;
		var isEnqueue:Boolean = _queue.enqueue(a) ;
		if (isEnqueue){
			AbstractAction(a).addEventListener(ActionEventType.FINISH, _runner) ;
		}
		return isEnqueue ;
	}
	
	public function clear():Void {
		_queue.clear() ;
	}

	public function clone() {
		var s:Sequencer = new Sequencer() ;
		var it:Iterator = _queue.iterator() ;
		while (it.hasNext()) {
			s.addAction(it.next().clone()) ;
		}
		return s ;
	}

	public function run():Void {
		if (_queue.size() > 0) {
			if (!running) notifyStarted() ;
			else notifyProgress() ;
			_setRunning(true) ;
			_cur = _queue.poll() ;
			_cur.run() ;
		} else {
			if (running) {
				_setRunning(false) ;
				notifyFinished() ;
			}
		}
	}
	
	public function size():Number {
		return _queue.size() ;
	}

	public function start():Void {
		if (!running) {
			run() ;
		}
	}
	
	public function stop(noEvent:Boolean):Void {
		if (running) {
			_cur.removeEventListener(ActionEventType.FINISH, _runner) ;
			_setRunning(false) ;
			if (noEvent) return ;
			notifyStopped() ;
			notifyFinished() ;
		}
	}
	
	public function toArray():Array {
		return _queue.toArray() ;	
	}

	public function toSource():String {
		var sourceA:String = Serializer.toSource(toArray()) ;
		return Serializer.getSourceOf(this, [sourceA]) ;
	}

	// ----o Private Properties	
	
	private var _cur ;
	private var _queue:TypedQueue  ;
	private var _runner:EventListener ;
	
}