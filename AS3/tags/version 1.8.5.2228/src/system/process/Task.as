﻿/*
  Version: MPL 1.1/GPL 2.0/LGPL 2.1
 
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at
  http://www.mozilla.org/MPL/
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the
  License.
  
  The Original Code is [maashaack framework].
  
  The Initial Developers of the Original Code are
  Zwetan Kjukov <zwetan@gmail.com> and Marc Alcaraz <ekameleon@gmail.com>.
  Portions created by the Initial Developers are Copyright (C) 2006-2011
  the Initial Developers. All Rights Reserved.
  
  Contributor(s):
  
  Alternatively, the contents of this file may be used under the terms of
  either the GNU General Public License Version 2 or later (the "GPL"), or
  the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
  in which case the provisions of the GPL or the LGPL are applicable instead
  of those above. If you wish to allow use of your version of this file only
  under the terms of either the GPL or the LGPL, and not to allow others to
  use your version of this file under the terms of the MPL, indicate your
  decision by deleting the provisions above and replace them with the notice
  and other provisions required by the LGPL or the GPL. If you do not delete
  the provisions above, a recipient may use your version of this file under
  the terms of any one of the MPL, the GPL or the LGPL.
*/

package system.process 
{
    import core.reflect.getClassPath;

    import system.events.ActionEvent;
    import system.logging.Log;
    import system.logging.Loggable;
    import system.logging.Logger;
    import system.signals.Signal;
    import system.signals.Signaler;

    import flash.events.EventDispatcher;
    
    /**
     * Dispatched when a process is finished.
     * @eventType system.events.ActionEvent.FINISH
     * @see #notifyFinished
     */
    [Event(name="finish", type="system.events.ActionEvent")]
    
    /**
     * Dispatched when a process is started.
     * @eventType system.events.ActionEvent.START
     * @see #notifyStarted
     */
    [Event(name="start", type="system.events.ActionEvent")]
    
    /**
     * A simple representation of the <code class="prettyprint">Action</code> interface.
     */
    public dynamic class Task extends EventDispatcher implements Action, Loggable
    {
        /**
         * Creates a new Task instance.
         */
        public function Task() 
        {
            _phase  = TaskPhase.INACTIVE ;
            _logger = Log.getLogger( getClassPath(this, true) ) ;
        }
        
        /**
         * This signal emit when the notifyFinished method is invoked.
         */
        public function get finishIt():Signaler
        {
            return _finishIt ;
        }
        
        /**
         * @private
         */
        public function set finishIt( signal:Signaler ):void
        {
            _finishIt = signal || new Signal() ;
        }
        
        /**
         * Determinates the internal <code class="prettyprint">Logger</code> reference of this <code class="prettyprint">Loggable</code> object.
         */
        public function get logger():Logger
        {
            return _logger ;
        }
        
        /**
         * @private
         */
        public function set logger( log:Logger ):void
        {
            _logger = log || Log.getLogger( getClassPath(this, true) ) ;
        }
        
        /**
         * The current phase of the action.
         * @see system.process.TaskPhase
         */
        public function get phase():String
        {
            return _phase ;
        }
        
        /**
         * Indicates <code class="prettyprint">true</code> if the process is in progress.
         */
        public function get running():Boolean 
        {
            return _isRunning ;
        }
        
        /**
         * This signal emit when the notifyStarted method is invoked. 
         */
        public function get startIt():Signaler
        {
            return _startIt || new Signal() ;
        }
        
        /**
         * @private
         */
        public function set startIt( signal:Signaler ):void
        {
            _startIt = signal ;
        }
        
        /**
         * Returns a shallow copy of this object.
         * @return a shallow copy of this object.
         */
        public function clone():*
        {
            return new Task() ;
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if the object is locked.
         * @return <code class="prettyprint">true</code> if the object is locked.
         */
        public function isLocked():Boolean 
        {
            return ___isLock___ ;
        }
        
        /**
         * Locks the object.
         */
        public function lock():void 
        {
            ___isLock___ = true ;
        }
        
        /**
         * Notify an ActionEvent when the process is finished.
         */
        public function notifyFinished():void 
        {
            setRunning( false ) ;
            _phase = TaskPhase.FINISHED ;
            if ( hasEventListener( _sTypeFinish ) )
            {
                dispatchEvent( new ActionEvent( _sTypeFinish , this ) ) ;
            }
            _finishIt.emit( this ) ;
            _phase = TaskPhase.INACTIVE ;
        }
        
        /**
         * Notify an ActionEvent when the process is started.
         */
        public function notifyStarted():void
        {
            setRunning( true ) ;
            _phase  = TaskPhase.RUNNING ;
            _startIt.emit( this ) ;
            if ( hasEventListener( _sTypeStart ) )
            {
                dispatchEvent( new ActionEvent( _sTypeStart , this ) ) ;
            }
        }
        
        /**
         * Run the process.
         * You can overrides this method in your iherited class. 
         */
        public function run( ...arguments:Array ):void 
        {
            // overrides this method.
        }
        
        /**
         * Unlocks the display.
         */
        public function unlock():void 
        {
            ___isLock___ = false ;
        }
        
        /**
         * Changes the running property value.
         */
        protected function setRunning( b:Boolean ):void
        {
            _isRunning = b ;
        }
        
        /**
         * @private
         */
        private var _finishIt:Signaler = new Signal() ;
        
        /**
         * The internal flag to indicates if the display is locked or not.
         * @private
         */ 
        protected var ___isLock___:Boolean ;
        
        /**
         * @private
         */
        protected var _isRunning:Boolean ;
        
        /**
         * @private
         */
        private var _logger:Logger ;
        
        /**
         * @private
         */
        protected var _phase:String ;
        
        /**
         * @private
         */
        private var _startIt:Signaler = new Signal() ;
        
        /**
         * @private
         */
        protected var _sTypeFinish:String = ActionEvent.FINISH ;
        
        /**
         * @private
         */
        protected var _sTypeStart:String = ActionEvent.START ;
    }
}