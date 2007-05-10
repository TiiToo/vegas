/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is ASGard Framework based on VEGAS.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2007
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

import asgard.events.ProgressEvent;
import asgard.net.Stream;
import asgard.net.StreamCollector;

import vegas.data.map.HashMap;
import vegas.events.AbstractCoreEventDispatcher;
import vegas.events.Delegate;
import vegas.events.Event;
import vegas.events.StringEvent;
import vegas.events.TimerEvent;
import vegas.util.ConstructorUtil;
import vegas.util.Timer;

/**
 * This singleton controls a Stream instance.
 * @author eKameleon
 */
class asgard.net.StreamExpert extends AbstractCoreEventDispatcher 
{
	
	/**
	 * Creates a new StreamExpert instance.
	 * @param streamID the id of the stream to control with this object.
	 */
	private function StreamExpert( streamID:String ) 
	{
		
		initEvent() ;

		_streamID = streamID ;		
		
		_tProgress = new Timer( DEFAULT_DELAY ) ;
		_tProgress.addEventListener( TimerEvent.TIMER , new Delegate(this, _onProgress) ) ;
		
	}
	
	/**
	 * The default delay of the internal timer of this object.
	 */
	static public var DEFAULT_DELAY:Number = 150  ;

	/**
	 * The name of the event when the stream is finished.
	 */
	static public var STREAM_PLAY_FINISH:String = "onStreamPlayFinish" ;

	/**
	 * The name of the event when the stream is looped.
	 */
	static public var STREAM_PLAY_LOOP:String = "onStreamPlayLooped" ;

	/**
	 * The name of the event when the stream is paused.
	 */
	static public var STREAM_PLAY_PAUSE:String = "onStreamPlayPause" ;
	
	/**
	 * The name of the event when the stream is in progress.
	 */
	static public var STREAM_PLAY_PROGRESS:String = "onStreamPlayProgress" ;

	/**
	 * The name of the event when the stream is resumed.
	 */
	static public var STREAM_PLAY_RESUME:String = "onStreamPlayResume" ;

	/**
	 * The name of the event when the stream is started.
	 */
	static public var STREAM_PLAY_START:String = "onStreamPlayStart" ;
	
	/**
	 * The name of the event when the stream is stopped.
	 */
	static public var STREAM_PLAY_STOP:String = "onStreamPlayStop" ;

	/**
	 * Returns {@code true} if the stream is loop when the stream is finished.
	 * @return {@code true} if the stream is loop when the stream is finished.
	 */
	public function get isLoop():Boolean
	{
		return _isLoop ; 	
	}

	/**
	 * Sets if the stream is loop when the stream is finished.
	 */
	public function set isLoop(b:Boolean):Void
	{
		_isLoop = b ; 	
	}

	/**
	 * Returns the event name when the stream play is finished.
	 * @return the event name when the stream play is finished.
	 */
	public function getEventTypePLAY_FINISH():String
	{
		return _ePlayFinish.getType() ;	
	}
	
	/**
	 * Returns the event name when the stream play is looped.
	 * @return the event name when the stream play is looped.
	 */
	public function getEventTypePLAY_LOOP():String
	{
		return _ePlayLoop.getType() ;	
	}
	
	/**
	 * Returns the event name when the stream play is paused.
	 * @return the event name when the stream play is paused.
	 */
	public function getEventTypePLAY_PAUSE():String
	{
		return _ePlayPause.getType() ;	
	}
	
	/**
	 * Returns the event name when the stream play is in progress.
	 * @return the event name when the stream play is in progress.
	 */
	public function getEventTypePLAY_PROGRESS():String
	{
		return _ePlayProgress.getType() ;	
	}
	
	/**
	 * Returns the event name when the stream play is resumed.
	 * @return the event name when the stream play is resumed.
	 */
	public function getEventTypePLAY_RESUME():String
	{
		return _ePlayResume.getType() ;	
	}

	/**
	 * Returns the event name when the stream play is started.
	 * @return the event name when the stream play is started.
	 */
	public function getEventTypePLAY_START():String
	{
		return _ePlayStart.getType() ;	
	}
	
	/**
	 * Returns the event name when the stream play is stopped.
	 * @return the event name when the stream play is stopped.
	 */
	public function getEventTypePLAY_STOP():String
	{
		return _ePlayStop.getType() ;	
	}

	/**
	 * Returns a StreamExpert singleton.
	 * @param streamID the stream id of the StreamExpert singleton.
	 * @return a StreamExpert singleton or null .
	 */
	static public function getInstance( streamID:String ):StreamExpert
	{
		if ( _map == null)
		{
			_map = new HashMap() ;	
		}
		if ( !_map.containsKey( streamID ) )
		{
			_map.put( streamID, new StreamExpert( streamID ) ) ;
		}
		return _map.get( streamID ) ;
	}
	
	/**
	 * Returns the delay of the internal timer to notify the progress of the Stream.
	 * @return the delay of the internal timer to notify the progress of the Stream.
	 */
	public function getProgressDelay():Number
	{
		return _tProgress.getDelay() ;	
	}
	
	/**
	 * Returns the Stream reference to control.
	 * @return the Stream reference to control.
	 */
	public function getStream():Stream
	{
		return StreamCollector.get( getStreamID() ) ;	
	}
	
	/**
	 * Returns the id of the Stream to control.
	 * @return the id of the Stream to control.
	 */
	public function getStreamID():String
	{
		return _streamID ;	
	}

	/**
	 * This method is invoqued in the constructor of the class to initialize all events.
	 * Overrides this method.
	 */
	public function initEvent():Void
	{
		_ePlayFinish   = new StringEvent   ( STREAM_PLAY_FINISH , getStreamID() ) ;
		_ePlayLoop     = new StringEvent   ( STREAM_PLAY_LOOP , getStreamID() ) ;
		_ePlayPause    = new StringEvent   ( STREAM_PLAY_PAUSE , getStreamID() ) ;
		_ePlayProgress = new ProgressEvent ( STREAM_PLAY_PROGRESS ) ;
		_ePlayResume   = new StringEvent   ( STREAM_PLAY_RESUME , getStreamID() ) ;
		_ePlayStart    = new StringEvent   ( STREAM_PLAY_START , getStreamID() ) ;
		_ePlayStop     = new StringEvent   ( STREAM_PLAY_STOP , getStreamID() ) ;
	}

	/**
	 * Close the Stream.
	 */	
	public function close():Void
	{
		if ( StreamCollector.contains( getStreamID() ) )
		{
			var s:Stream = getStream() ;
			s.close() ;
		}
		else
		{
			getLogger().warn( this + " start play failed with an unknow Stream id : " + getStreamID() ) ;	
		}
	}

	/**
	 * Pause the Stream.
	 */
	public function pause():Void
	{
		if ( StreamCollector.contains( getStreamID() ) )
		{
			getStream().pause( true ) ;
			dispatchEvent( _ePlayPause ) ;	
			_tProgress.stop() ;
		}
		else
		{
			getLogger().warn( this + " start play failed with an unknow Stream id : " + getStreamID() ) ;	
		}
	}

	/**
	 * This method start the stream.
	 */
	public function play( name:Object, start:Number, len:Number, reset:Object ):Void
	{
		
		if ( StreamCollector.contains( getStreamID() ) )
		{
			var s:Stream = getStream() ;
			s.play.apply( getStream(), arguments ) ;
			dispatchEvent( _ePlayStart ) ;	
			_tProgress.start() ;
		}
		else
		{
			getLogger().warn( this + " start play failed with an unknow Stream id : " + getStreamID() ) ;	
		}
	}

	/**
	 * Specifies whether incoming audio plays on the specified stream. 
	 * This method is available only to clients subscribed to the specified stream, not to the stream's publisher.
	 * @param flag A Boolean value that specifies whether incoming audio plays on the specified stream (true) or not (false). The default value is true.
	 */
	public function receiveAudio( flag:Boolean ):Void
	{
		if ( StreamCollector.contains( getStreamID() ) )
		{
			getStream().receiveAudio( flag ) ;
		}
		else
		{
			getLogger().warn( this + " start play failed with an unknow Stream id : " + getStreamID() ) ;	
		}
	}

	/**
	 * Specifies whether incoming video will play on the specified stream, or specifies the frame rate of the video. 
	 * This method is available only to clients subscribed to the specified stream, not to the stream's publisher.
	 * @param value A Boolean value that specifies whether incoming video plays on the specified stream (true) or not (false). 
	 * The default value is true.
	 * Or a number that specifies the frame rate per second of the incoming video. 
	 * The default rate is the frame rate of the FLV file or live stream being played.
	 */
	public function receiveVideo( value ):Void
	{
		if ( StreamCollector.contains( getStreamID() ) )
		{
			getStream().receiveVideo( value ) ;
		}
		else
		{
			getLogger().warn( this + " start play failed with an unknow Stream id : " + getStreamID() ) ;	
		}
	}

	/**
	 * Release the specified StreamExpert singleton.
	 * @param streamID the stream id of the StreamExpert singleton.
	 * @return the removed StreamExpert singleton or null .
	 */
	static public function release( streamID:String ):StreamExpert
	{
		return _map.remove( streamID ) ;
	}

	/**
	 * Resume the Stream.
	 */
	public function resume():Void
	{
		if ( StreamCollector.contains( getStreamID() ) )
		{
			getStream().pause( false ) ;
			dispatchEvent( _ePlayResume ) ;
			_tProgress.start() ;
		}
		else
		{
			getLogger().warn( this + " start play failed with an unknow Stream id : " + getStreamID() ) ;	
		}
	}

	/**
	 * Sets the event name when the stream play is finished.
	 */
	public function setEventTypePLAY_FINISH( type:String ):Void
	{
		_ePlayFinish.setType( type ) ;	
	}
	
	/**
	 * Sets the event name when the stream play is looped.
	 */
	public function setEventTypePLAY_LOOP( type:String ):Void
	{
		_ePlayLoop.setType( type ) ;		
	}
	
	/**
	 * Sets the event name when the stream play is paused.
	 */
	public function setEventTypePLAY_PAUSE( type:String ):Void
	{
		_ePlayPause.setType( type ) ;
	}
	
	/**
	 * Sets the event name when the stream play is in progress.
	 */
	public function setEventTypePLAY_PROGRESS( type:String ):Void
	{
		_ePlayProgress.setType( type ) ;		
	}
	
	/**
	 * Sets the event name when the stream play is resumed.
	 */
	public function setEventTypePLAY_RESUME( type:String ):Void
	{
		_ePlayResume.setType( type ) ;		
	}

	/**
	 * Sets the event name when the stream play is started.
	 */
	public function setEventTypePLAY_START( type:String ):Void
	{
		_ePlayStart.setType( type ) ;	
	}
	
	/**
	 * Sets the event name when the stream play is stopped.
	 */
	public function setEventTypePLAY_STOP( type:String ):Void
	{
		_ePlayStop.setType( type ) ;	
	}

	/**
	 * Sets the delay of the internal timer to notify the progress of the Stream.
	 * @param n the delay of the internal Timer of this object.
	 */
	public function setProgressDelay( n:Number ):Void
	{
		_tProgress.setDelay( n ) ;	
	}
	
	/**
	 * This method stop stream.
	 */
	public function stop():Void
	{
		if ( StreamCollector.contains( getStreamID() ) )
		{
			getStream().stop() ;
			_tProgress.stop() ;
			dispatchEvent( _ePlayStop ) ;
		}
		else
		{
			getLogger().warn( this + " stop play failed with an unknow Stream id : " + getStreamID() ) ;	
		}	
	}
	
	/**
	 * Returns the String representation of the object.
	 * @return the String representation of the object.
	 */
	public function toString():String
	{
		return "[" + ConstructorUtil.getName(this) + ( getStreamID() != null ? (":" + getStreamID()) : "" ) + "]" ;	
	}

	private var _ePlayFinish:Event ;
	
	private var _ePlayLoop:Event ;
	
	private var _ePlayPause:Event ;
	
	private var _ePlayProgress:Event ;
	
	private var _ePlayResume:Event ;
	
	private var _ePlayStart:Event ;
	
	private var _ePlayStop:Event ;
	
	private var _isLoop:Boolean = false ;
	
	static private var _map:HashMap  ;
	
	private var _streamID:String ;
	
	private var _tProgress:Timer ;
	
	/**
	 * Invoqued when the stream is in progress.
	 */
	private function _onProgress( e:TimerEvent ):Void
	{
		
		var progress:Number = getStream().progress ;
		
		if (progress == 100)
		{
			dispatchEvent( _ePlayFinish ) ;
			if (_isLoop)
			{
				dispatchEvent( _ePlayLoop ) ;
				getStream().seek(0) ;
			}
			else
			{
				_tProgress.stop() ;
			}	
		}
		else
		{
			_ePlayProgress.setContext( getStreamID ) ;
			ProgressEvent(_ePlayProgress).percent = progress ;
			dispatchEvent( _ePlayProgress ) ;
		}

	}

}