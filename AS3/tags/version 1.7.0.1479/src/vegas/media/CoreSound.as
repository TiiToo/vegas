﻿/*

  Version: MPL 1.1/GPL 2.0/LGPL 2.1
 
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is VEGAS Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2010
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
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

package vegas.media 
{
    import system.Reflection;
    import system.events.ActionEvent;
    import system.events.EventListener;
    import system.logging.Log;
    import system.logging.Logger;
    import system.numeric.Range;
    import system.process.Action;
    import system.process.Stoppable;
    
    import vegas.events.SoundEvent;
    
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.events.TimerEvent;
    import flash.media.Sound;
    import flash.media.SoundChannel;
    import flash.media.SoundLoaderContext;
    import flash.media.SoundTransform;
    import flash.net.URLRequest;
    import flash.utils.Timer;
    
    /**
     * The CoreSound class extends the flash.media.Sound class and implements the IConfigurable, Identifiable, Lockable and ILogable interfaces.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * // See in the library of this fla file the BipSound Sound symbol and this linkage class id.
     * 
     * import system.events.ActionEvent ;
     * 
     * import kronos.date.Time ;
     * 
     * import vegas.events.SoundEvent ;
     * import vegas.media.CoreSound   ;
     * 
     * import flash.media.SoundChannel ;
     * 
     * var debug:Function = function( e:ActionEvent ):void
     * {
     *     trace(e) ;
     * }
     * 
     * var soundComplete:Function = function( e:Event ):void
     * {
     *     var time:Time = new Time( (e.target as CoreSound).length ) ;
     *     trace( e.type + " duration " + time.getMilliseconds(2) + " ms" ) ;
     * }
     * 
     * var soundUpdate:Function = function( e:SoundEvent ):void
     * {
     *     trace( e.type + " volume:" + e.soundTransform.volume ) ;
     * }
     * 
     * var sound:CoreSound = new BipSound() ;
     * 
     * sound.addEventListener( Event.SOUND_COMPLETE    , soundComplete ) ;
     * sound.addEventListener( SoundEvent.SOUND_UPDATE , soundUpdate   ) ;
     * 
     * sound.addEventListener( ActionEvent.FINISH , debug ) ;
     * sound.addEventListener( ActionEvent.LOOP   , debug ) ;
     * sound.addEventListener( ActionEvent.STOP   , debug ) ;
     * sound.addEventListener( ActionEvent.START  , debug ) ;
     * 
     * sound.volume = 0.6 ;
     * 
     * // sound.looping = true ;
     * 
     * sound.play() ;
     * </pre>
     */
    public class CoreSound extends Sound implements Action, ISound, Stoppable
    {
        /**
         * Creates a new CoreSound instance.
         * @param stream The URL request that points to an external MP3 file.
         * @param context The SoundLoaderContext Minimum number of milliseconds of MP3 data to hold in the Sound object's buffer. The Sound object waits until it has at least this much data before beginning playback and before resuming playback after a network stall. The default value is 1000 (one second). 
         * @param id Indicates the id of the object.
         */
        public function CoreSound( stream:URLRequest = null, context:SoundLoaderContext = null , id:*=null )
        {
            _timer = new Timer( DEFAULT_DELAY ) ;
            _timer.addEventListener( TimerEvent.TIMER , _onTimer ) ;
            addEventListener( IOErrorEvent.IO_ERROR  , _onIOError );
            super( stream, context );
            if ( id != null )
            {
                this.id = id ;
            }
            this.logger         = null ;
            this.soundTransform = null ;
        }
        
        /**
         * The default delay value of the internal timer of the CoreSound objects in milliseconds.
         */
        public static var DEFAULT_DELAY:uint = 150 ;
        
        /**
         * The SoundChannel object of this CoreSound object.
         */
        public function get channel():SoundChannel
        {
            return _channel ;
        }
        
        /**
         * Returns the id of this object.
         * @return the id of this object.
         */
        public function get id():*
        {
            return _id ;
        }
        
        /**
          * Returns the <code class="prettyprint">String</code> representation of this object.
          * @return the <code class="prettyprint">String</code> representation of this object.
          */
        public function set id( id:* ):void
        {
            _setID( id ) ;
        }
        
        /**
         * The current amplitude (volume) of the left channel, from 0 (silent) to 1 (full amplitude). 
         * If the value is NaN, the internal SoundChannel is 'null'.
         */
        public function get leftPeak():Number
        {
            if ( channel != null )
            {
                return channel.leftPeak ;
            }    
            else
            {
                return NaN ;
            }
        }
        
        /**
         * Determinates the internal <code class="prettyprint">ILogger</code> reference of this <code class="prettyprint">Logable</code> object.
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
            _logger = ( log == null ) ? Log.getLogger( Reflection.getClassPath(this) ):log ;
        }
        
        /**
         * The flag to determinate if the Action object is looped.
         */
        public var looping:Boolean ;
        
        /**
         * The left-to-right panning of the sound, ranging from -1 (full pan left) to 1 (full pan right). 
         * A value of 0 represents no panning (balanced center between right and left). 
         */
        public function get pan():Number
        {
            return _soundTransform.pan ;
        }
        
        /**
         * @private
         */
        public function set pan( value:Number ):void
        {
            _soundTransform.pan = Range.UNITY.clamp( isNaN(value) ? 0 : value ) ; 
            if ( channel != null )
            {
                channel.soundTransform = _soundTransform ;
            }
            _fireSoundEvent( SoundEvent.SOUND_UPDATE ) ;
        }
        
        /**
         * Determinates the parent Action reference of the current Action.
         */
        public function get parent():Action 
        {
            return _parent ;
        }
        
        /**
         * @private
         */
        public function set parent( action:Action ):void 
        {
            _parent = action ;
        }
        
        /**
         * (read-only) Returns <code class="prettyprint">true</code> if the process is in pause.
         * @return <code class="prettyprint">true</code> if the process is in pause.
         */
        public function get pausing():Boolean 
        {
            return _isPausing ;
        }
        
        /**
         * The current position of the playhead within the sound. 
         * If the value is NaN, the internal SoundChannel is 'null'.
         */
        public function get position():Number
        {
            if ( channel != null )
            {
                return _currentPosition ;
            }    
            else
            {
                return NaN ;
            }
        }
        
        /**
         * The current amplitude (volume) of the right channel, from 0 (silent) to 1 (full amplitude). 
         * If the value is NaN, the internal SoundChannel is 'null'.
         */
        public function get rightPeak():Number
        {
            if ( channel != null )
            {
                return channel.rightPeak ;
            }    
            else
            {
                return NaN ;
            }
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if the process is in progress.
         */
        public function get running():Boolean 
        {
            return _isRunning ;
        }
        
        /**
         * The SoundTransform object assigned to the sound channel. 
         * A SoundTransform object includes properties for setting volume, panning, left speaker assignment, and right speaker assignment. 
         */
        public function get soundTransform():SoundTransform
        {
            return _soundTransform ;
        }
        
        /**
         * @private 
         */
        public function set soundTransform( soundTransform:SoundTransform ):void
        {
            _soundTransform = soundTransform || new SoundTransform() ;
            if ( channel != null )
            {
                channel.soundTransform = _soundTransform ;
            }
        }
        
        /**
         * The volume, ranging from 0 (silent) to 1 (full volume). 
         */
        public function get volume():Number
        {
            return _soundTransform.volume ;
        }
        
        /**
         * @private
         */
        public function set volume( value:Number ):void
        {
            _soundTransform.volume = Range.UNITY.clamp( isNaN(value) ? 0 : value ) ; 
            if ( channel != null )
            {
                channel.soundTransform = _soundTransform ;
            }
            _fireSoundEvent( SoundEvent.SOUND_UPDATE ) ;
        }
        
        /**
         * Returns the shallow copy of the object.
         * @return the shallow copy of the object.
         */
        public function clone():*
        {
            return new CoreSound() ;
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
         * Initiates loading of an external MP3 file from the specified URL. 
         * If you provide a valid URLRequest object to the Sound constructor, the constructor calls Sound.load() for you. 
         * You only need to call Sound.load() yourself if you don't pass a valid URLRequest object to the Sound constructor or you pass a null value. 
         */
        public override function load( stream:URLRequest, context:SoundLoaderContext = null ) : void
        {
            stop() ;
            notifyStarted() ;
            try
            {
                super.load(stream, context) ;
            }
            catch( e:Error )
            {
                logger.error( this + " load failed : " + e.toString()) ;
                notifyFinished() ;
            }
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
            _isRunning = false ;
            _timer.stop() ;
            _fireActionEvent( ActionEvent.FINISH ) ;
        }
        
        /**
         * Notify an ActionEvent when the process is started.
         */
        public function notifyStarted():void
        {
            _isRunning = true ;
            _timer.start() ;
            _fireActionEvent( ActionEvent.START ) ;
        }
        
        /**
         * Run the process.
         */
        public function run( ...arguments:Array ):void 
        {
            play( isNaN(_currentPosition) ? _currentPosition : 0 ) ;
        }
        
        /**
         * Pauses playback of the Sound.
         * @return <code class="prettyprint">true</code> if the pause method can be use (the internal SoundChannel of this Sound object is not null and not is "pausing").
         */    
        public function pause():Boolean
        {
            if ( channel != null && !_isPausing )
            {
                _isPausing       = true ;
                _currentPosition = position ;
                channel.stop() ;
                notifyPaused() ;
                return true ;    
            }
            else
            {
                return false ;
            }
        }
        
        /**
         * Generates a new SoundChannel object to play back the sound.
         * @param startTime The initial position in milliseconds at which playback should start. 
         * @param loops Defines the number of times a sound loops back to the startTime value before the sound channel stops playback. 
         * @param sndTransform Defines the number of times a sound loops back to the startTime value before the sound channel stops playback. 
         * @return A SoundChannel object, which you use to control the sound. 
         * This method returns null if you have no sound card or if you run out of available sound channels. 
         * The maximum number of sound channels available at once is 32. 
         */
        public override function play( startTime:Number = 0 , loops:int = 0 , sndTransform:SoundTransform=null ):SoundChannel
        {
            notifyStarted() ;
            _isPausing = false ;
            _currentPosition = startTime > 0 ? startTime : 0 ;
            return _registerChannel( super.play( startTime, loops, sndTransform ) , sndTransform ) ;
        }
        
        /**
         * Registers an <code class="prettyprint">system.events.EventListener</code> object with an <code class="prettyprint">system.events.EventDispatcher</code> object so that the listener receives notification of an event.
         */
        public function registerEventListener(type:String, listener:*, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
        {
            var func:Function ;
            if ( listener is Function )
            {
                func = listener ;
            }
            else if ( listener is EventListener ) 
            {
                func = EventListener(listener).handleEvent ;
            }
            super.addEventListener(type, func, useCapture, priority, useWeakReference) ;
        }
        
        /**
         * Resumes playback of the sound that is paused (if the <code class="prettyprint">pausing</code> property is <code class="prettyprint">true</code>).
         * @return <code class="prettyprint">true</code> if the resume method is success.
         */
        public function resume():Boolean
        {
            if( !isNaN(_currentPosition) && _isPausing )
            {
                _isPausing = false ;
                _registerChannel( super.play( _currentPosition ) ) ;
                _timer.start() ;
                notifyResumed() ;
                return true ;    
            }
            else
            {
                return false ;
            }
        }
        
        /**
         * Stops the sound playing in the channel.
         * @return <code class="prettyprint">true</code> if the stop method can be use (the internal SoundChannel of this Sound object is not null).
         */    
        public function stop():void
        {
            if ( channel != null )
            {
                _isPausing       = false ;
                _currentPosition = 0 ;
                channel.stop() ;
                notifyStopped() ;
            }
        }
        
        /**
         * Pauses or resumes playback of the sound.
         * You could use this method to let users pause or resume playback by pressing a single button. 
         */
        public function togglePause():void
        {
            if ( pausing )
            {
                resume() ;
            }    
            else
            {
                pause() ;
            }
        }
        
        /**
          * Returns the <code class="prettyprint">String</code> source representation of this object.
          * @return the <code class="prettyprint">String</code> source representation of this object.
          */
        public function toSource(indent:int = 0):String
        {
            return "new " + Reflection.getClassPath(this) + "()" ;
        }
        
        /**
          * Returns the <code class="prettyprint">String</code> representation of this object.
          * @return the <code class="prettyprint">String</code> representation of this object.
          */
        public override function toString():String
        {
            var str:String = "[" + Reflection.getClassName(this) ;
            if ( this.id != null )
            {
                str += " " + this.id ;
            } 
            str += "]" ;
            return str ;
        }
        
        /**
         * Unlocks the display.
         */
        public function unlock():void 
        {
            ___isLock___ = false ;
        }
        
        /**
         * Removes an <code class="prettyprint">system.events.EventListener</code> from the <code class="prettyprint">system.events.EventDispatcher</code> object.
         */
        public function unregisterEventListener(type:String, listener:*, useCapture:Boolean = false):void
        {
            var func:Function ;
            if ( listener is Function )
            {
                func = listener ;
            }
            else if ( listener is EventListener ) 
            {
                func = (listener as EventListener).handleEvent ;
            }
            super.removeEventListener(type, func, useCapture) ;
        }
        
        /**
         * 
         * Notify an ActionEvent when the process of the sound is changed.
         */
        protected function notifyChange():void
        {
            _fireActionEvent( ActionEvent.CHANGE ) ;
        }
        
        /**
         * Notify an ActionEvent when the process is looped.
         */
        protected function notifyLooped():void 
        {
            _fireActionEvent( ActionEvent.LOOP ) ;
        }
        
        /**
         * Notify an ActionEvent when the process is stopped.
         */
        protected function notifyPaused():void
        {
            _isRunning = false ;
            _timer.stop() ;
            _fireActionEvent( ActionEvent.PAUSE ) ;
        }
        
        
        /**
         * Notify an ActionEvent when the process is resumed.
         */
        protected function notifyResumed():void
        {
            _isRunning = true ;
            _fireActionEvent( ActionEvent.RESUME ) ;
        }
        
        /**
         * Notify an ActionEvent when the process is stopped.
         */
        protected function notifyStopped():void
        {
            _isRunning = false ;
            _timer.stop() ;
            _fireActionEvent( ActionEvent.STOP ) ;
        }
        
        /**
         * @private
         */
        private var _channel:SoundChannel ;
        
        /**
         * @private
         */
        private var _currentPosition:Number = 0 ;
        
        /**
         * The internal id of this object.
         * @private
         */
        private var _id:* ;
        
        /**
         * The internal flag to indicates if the display is locked or not.
         * @private
         */ 
        private var ___isLock___:Boolean ;

        /**
         * @private
         */
        private var _isPausing:Boolean ;

        /**
         * @private
         */
        private var _isRunning:Boolean ;
        
        /**
         * @private
         */
        private var _logger:Logger ;
        
        /**
         * @private
         */
        private var _parent:Action ;
        
        /**
         * @private
         */
        private var _soundTransform:SoundTransform ;
        
        /**
         * @private
         */
        private var _timer:Timer ;
        
        /**
         * @private
         */
        private function _fireActionEvent( type:String ):void
        {
            if ( isLocked() )
            {
                return ;
            }
            dispatchEvent( new ActionEvent( type, this ) ) ;
        }
        
        /**
         * @private
         */
        private function _fireSoundEvent( type:String ):void
        {
            if ( isLocked() )
            {
                return ;
            }
            dispatchEvent( new SoundEvent( type, this , _soundTransform ) ) ; 
        }
        
        /**
         * @private
         */
        private function _onIOError( e:IOErrorEvent ):void
        {
            notifyFinished() ;
        }
        
        /**
         * @private
         */
        private function _onSoundComplete( e:Event ):void
        {
            _currentPosition = length ;
            dispatchEvent( e ) ;
            notifyChange() ;
            if ( looping )
            {
                _registerChannel( super.play( 0 ) ) ;
                notifyLooped() ;
            }
            else
            {
                notifyFinished() ;
            }
        }
        
        /**
         * @private
         */
        private function _onTimer( e:TimerEvent ):void
        {
            _currentPosition = channel != null ? channel.position : 0 ;
            notifyChange() ;
        }
        
        /**
         * @private
         */
        protected function _registerChannel( channel:SoundChannel=null , sndTransform:SoundTransform=null ):SoundChannel
        {
            if ( sndTransform != null )
            {
                soundTransform = sndTransform ;
            }
            if ( _channel != null )
            {
                _channel.removeEventListener( Event.SOUND_COMPLETE, _onSoundComplete , false ) ;    
            }
            _channel = channel ;
            if ( _channel != null )
            {
                _channel.addEventListener( Event.SOUND_COMPLETE, _onSoundComplete , false, 0, true ) ;
                _channel.soundTransform = soundTransform ;
            }
            return _channel ;
        }
        
        /**
         * @private
         */
        private function _setID( id:* ):void 
        {
            if ( SoundCollector.contains( this._id ) )
            {
                SoundCollector.remove( this._id ) ;
            }
            this._id = id ;
            if ( this._id != null )
            {
                SoundCollector.add( this._id, this ) ;
            }
        }
    }
}
