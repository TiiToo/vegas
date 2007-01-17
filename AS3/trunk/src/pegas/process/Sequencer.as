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
  Portions created by the Initial Developer are Copyright (C) 2004-20057
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

// TODO : ajouter un Timer pour les action "next" en cas de besoin pour laisser le temps d'initialiser l'action courante avant de passer à la suivante.

package pegas.process
{
	
	import asgard.events.ActionEvent;
	
	import vegas.data.iterator.Iterator;
	import vegas.data.queue.LinearQueue;
	import vegas.data.queue.TypedQueue;
	import vegas.util.Serializer;
	
	/**
	 * @author eKameleon
	 */
	public class Sequencer extends AbstractAction
	{
		
		/**
		 * Creates a new Sequencer instance.
		 */
		public function Sequencer( ar:Array=null )
		{
		
			super();
			
			_queue = new TypedQueue(IAction, new LinearQueue()) ; 
			
			if (ar != null)
			{
				var l:uint = ar.length ;
				if (l>0) 
				{
					for (var i:Number = 0 ; i < l ; i++) 
					{
						var a:IAction = ar[i] ;
						if (a is IAction)
						{
							addAction(a) ;		
						} 
					}
				}
			}
			
		}
		
		public function addAction(action:IAction, isClone:Boolean=false):Boolean 
		{
			var a:IAction = action ;
			var isEnqueue:Boolean = _queue.enqueue(a) ;
			if (isEnqueue)
			{
				a.addEventListener(ActionEvent.FINISH, run) ;
			}
			return isEnqueue ;
		}
		
		public function clear():void 
		{
			_queue.clear() ;
		}
		
		override public function clone():*
		{
			var s:Sequencer = new Sequencer() ;
			var it:Iterator = _queue.iterator() ;
			while (it.hasNext()) 
			{
				s.addAction(it.next().clone()) ;
			}
			return s ;
		}
		
		override public function run(...arguments:Array):void 
		{
			
			if (_queue.size() > 0) 
			{
				
				if (!running) 
				{
					notifyStarted() ;
					setRunning(true) ;
				}
				
				notifyProgress() ;
				
				_cur = _queue.poll() ;
				_cur.run() ;
				
			}
			else 
			{
				if ( getRunning() ) 
				{
					setRunning(false) ;
					notifyFinished() ;
				}
			}
			
		}	
		
		public function size():uint
		{
			return _queue.size() ;
		}
		
		public function start():void 
		{
			if ( !getRunning() ) 
			{
				run() ;
			}
		}
		
		public function stop(noEvent:Boolean):void 
		{
			if ( getRunning() ) 
			{
				_cur.removeEventListener(ActionEvent.FINISH, run) ;
				setRunning(false) ;
				if (noEvent) return ;
				notifyStopped() ;
				notifyFinished() ;
			}
		}
		
		public function toArray():Array 
		{
			return _queue.toArray() ;	
		}
		
		override public function toSource(...arguments:Array):String 
		{
			return Serializer.getSourceOf(this, [toArray()]) ;
		}
		
		// ----o Private Properties	
		
		private var _cur:* ;
		private var _queue:TypedQueue  ;
		
	}
}