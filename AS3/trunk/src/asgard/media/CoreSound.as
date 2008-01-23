/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is ASGard Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package asgard.media 
{
	
	// TODO implement the Action.PROGRESS event with FrameTimer or Timer interval.
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundLoaderContext;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	
	import asgard.config.Config;
	import asgard.config.ConfigCollector;
	import asgard.events.SoundEvent;
	
	import pegas.events.ActionEvent;
	import pegas.maths.Range;
	import pegas.process.IAction;
	import pegas.process.IStoppable;
	
	import system.Reflection;
	
	import vegas.core.HashCode;
	import vegas.logging.ILogger;
	import vegas.logging.Log;
	import vegas.util.Serializer;	

	/**
	 * The CoreSound class extends the flash.media.Sound class and implements the IConfigurable, Identifiable, ILockable and ILogable interfaces.
	 * @author eKameleon
	 */
	public class CoreSound extends Sound implements IAction, ISound, IStoppable
	{

		/**
		 * Creates a new CoreSound instance.
		 * @param stream The URL that points to an external MP3 file.
		 * @param context The SoundLoaderContext Minimum number of milliseconds of MP3 data to hold in the Sound object's buffer. The Sound object waits until it has at least this much data before beginning playback and before resuming playback after a network stall. The default value is 1000 (one second). 
		 * @param id Indicates the id of the object.
		 * @param isConfigurable This flag indicates if the IConfigurable object is register in the ConfigCollector.
		 */
		public function CoreSound( id:*=null, stream:URLRequest = null, context:SoundLoaderContext = null , isConfigurable:Boolean=false )
		{
			addEventListener( IOErrorEvent.IO_ERROR  , _onIOError );
			super( stream, context );
			if ( id != null )
			{
				this.id = id ;
			}
			this.soundTransform = null ;
			this.isConfigurable = isConfigurable ;
			setLogger() ;
		}

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
	 	 * Returns the {@code String} representation of this object.
	 	 * @return the {@code String} representation of this object.
	 	 */
		public function set id( id:* ):void
		{
			_setID( id ) ;
		}

		/**
		 * Indicates if the display is configurable.
		 */
		public function get isConfigurable():Boolean
		{
			return _isConfigurable ;
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
    	 * The flag to determinate if the Action object is looped.
    	 */
		public var looping:Boolean = false ;
		
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
			_soundTransform.pan = Range.UNITY_RANGE.clamp( isNaN(value) ? 0 : value ) ; 
			if ( channel != null )
			{
				channel.soundTransform = _soundTransform ;
			}
			dispatchEvent( new SoundEvent( SoundEvent.SOUND_UPDATE, this , _soundTransform ) ) ; 
		}		

		/**
		 * The current position of the playhead within the sound. 
		 * If the value is NaN, the internal SoundChannel is 'null'.
		 */
		public function get position():Number
		{
			if ( channel != null )
			{
				return channel.position ;
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
	     * (read-only) Returns {@code true} if the process is in progress.
	     * @return {@code true} if the process is in progress.
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
			_soundTransform.volume = Range.UNITY_RANGE.clamp( isNaN(value) ? 0 : value ) ; 
			if ( channel != null )
			{
				channel.soundTransform = _soundTransform ;
			}
			dispatchEvent( new SoundEvent( SoundEvent.SOUND_UPDATE, this , _soundTransform ) ) ; 
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
		 * Returns a hashcode value for the object.
		 * @return a hashcode value for the object.
		 */
		public function hashCode():uint 
		{
			if ( isNaN( __hashcode__ ) ) 
			{
				__hashcode__ = HashCode.next() ;
			}
			return __hashcode__ ;
		}

		/**
		 * Returns the internal {@code ILogger} reference of this {@code ILogable} object.
		 * @return the internal {@code ILogger} reference of this {@code ILogable} object.
		 */
		public function getLogger():ILogger
		{
			return _logger ; 	
		}
		
		/**
		 * @private
		 */
		public function set isConfigurable( b:Boolean ):void
		{
			_isConfigurable = (b == true) ;
			if (_isConfigurable)
			{
				ConfigCollector.insert(this) ;	
			}
			else
			{
				ConfigCollector.remove(this) ;
			}
		}

    	/**
	     * Returns {@code true} if the object is locked.
	     * @return {@code true} if the object is locked.
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
		public override function load(stream : URLRequest, context : SoundLoaderContext = null) : void
		{
			notifyStarted() ;
			try
			{
				super.load(stream, context) ;
			}
			catch( e:Error )
			{
				getLogger().error( this + " load failed : " + e.toString()) ;
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
			dispatchEvent( new ActionEvent( ActionEvent.FINISH, this ) ) ;
		}
		
	    /**
	     * Notify an ActionEvent when the process is looped.
	     */
		protected function notifyLooped():void 
		{
			dispatchEvent( new ActionEvent( ActionEvent.LOOP , this ) ) ;
		}

	    /**
	     * Notify an ActionEvent when the process is resumed.
	     */
		protected function notifyResumed():void
		{
			_isRunning = true ;
			dispatchEvent( new ActionEvent( ActionEvent.RESUME, this ) ) ;
		}

    	/**
	     * Notify an ActionEvent when the process is started.
	     */
		public function notifyStarted():void
		{
			_isRunning = true ;
			dispatchEvent( new ActionEvent( ActionEvent.START, this ) ) ;
		}

	    /**
	     * Notify an ActionEvent when the process is stopped.
	     */
		protected function notifyStopped():void
		{
			_isRunning = false ;
			dispatchEvent( new ActionEvent( ActionEvent.STOP, this ) ) ;
		}

    	/**
	     * Run the process.
	     */
		public function run( ...arguments:Array ):void 
		{
		    play( isNaN(_currentPosition) ? _currentPosition : 0 ) ;
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
			_currentPosition = startTime ;
			return _registerChannel( super.play( startTime, loops, sndTransform ) , sndTransform ) ;
		}    	
		
		/**
		 * Resumes the sound if the stop() method is invoked.
		 * @return {@code true}
		 */
		public function resume():Boolean
		{
			if( !isNaN(_currentPosition) )
			{
				_registerChannel( super.play( _currentPosition ) ) ;
				notifyResumed() ;
				return true ;	
			}
			else
			{
				return false ;	
			}
		}
		
		/**
		 * Sets the internal {@code ILogger} reference of this {@code ILogable} object.
		 */
		public function setLogger( log:ILogger=null ):void 
		{
			_logger = ( log == null ) ? Log.getLogger( Reflection.getClassPath(this) ) : log ;
		}
		
		/**
         * Setup the IConfigurable object.
         */
        public function setup():void
        {
			var config:Object = Config.getInstance()[ id ] ; 
			if ( config != null ) 
			{
				for (var prop:String in config)
				{
					this[prop] = config[prop] ; 
				}
			}
			update() ;	
        }
        
		/**
		 * Stops the sound playing in the channel.
		 * @return {@code true} if the stop method can be use (the internal SoundChannel of this Sound object is not null).
		 */	
		public function stop():Boolean
		{
			if ( channel != null )
			{
				_currentPosition = position ;
				channel.stop() ;
				notifyStopped() ;
				return true ;	
			}
			else
			{
				return false ;
			}
		}
		
		/**
	 	 * Returns the {@code String} source representation of this object.
	 	 * @return the {@code String} source representation of this object.
	 	 */
		public function toSource(indent:int = 0):String
		{
			var params:Array = [ null ] ;
			if ( url != null )
			{
				params.push( new URLRequest(url) ) ;
			}
			var source:String = Serializer.getSourceOf(this, params) ;
			return source ;
		}

        
		/**
	 	 * Returns the {@code String} representation of this object.
	 	 * @return the {@code String} representation of this object.
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
		 * Update the Sound object.
		 * You must override this method. This method is launch by the setup() method when the Config is checked.
		 */	
		public function update():void
		{
			// overrides this method.
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
		 * @private
		 */
		private var __hashcode__:Number = NaN ;

		/**
		 * The internal id of this object.
		 * @private
		 */
		private var _id:* = null ;

		/**
		 * @private
		 */
		private var _isConfigurable:Boolean ;

	    /**
	     * The internal flag to indicates if the display is locked or not.
	     * @private
	     */ 
	    private var ___isLock___:Boolean = false ;

		/**
		 * @private
		 */
	    private var _isRunning:Boolean ;
	    
		/**
		 * The internal ILogger reference of this object.
		 */
		private var _logger:ILogger ;
		
		/**
		 * @private
		 */
		private var _soundTransform:SoundTransform ;

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
			_currentPosition = NaN ;
			dispatchEvent( e ) ;
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
			    SoundCollector.insert ( this._id, this ) ;
			}
		}
	}
}

