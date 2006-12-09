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

import asgard.events.MediaEvent;
import asgard.media.AbstractMediaLoader;
import asgard.net.NetStreamStatus;

import vegas.errors.IllegalArgumentError;
import vegas.errors.UnsupportedOperation;
import vegas.errors.Warning;
import vegas.events.BasicEvent;
import vegas.events.Delegate;
import vegas.events.EventType;
import vegas.events.TimerEventType;
import vegas.maths.Range;
import vegas.util.FrameTimer;
import vegas.util.Timer;

/**
 * This loader load an external FLV video in the application.
 * @author eKameleon
 */
class asgard.media.VideoLoader extends AbstractMediaLoader 
{
	
	/**
	 * Creates a new VideoLoader instance.
	 */
	function VideoLoader( mcTarget:MovieClip , video:Video , sName:String ) 
	{
		
		super(mcTarget, sName);
		
		_oVideo = video ? video : _mcTarget.video ;
		
		if (_oVideo == undefined) 
		{
			throw new IllegalArgumentError( toString() + " failed. Invalid video object was passed in the constructor.") ;
		}
		
		_oNC = new NetConnection() ;
		_oNC.onStatus = Delegate.create(this, _onStatus) ;
		_oNC.connect(null) ;
		
		_oNS = new NetStream( _oNC ) ;
		
		_oNS["onMetaData"] = Delegate.create(this, _onMetaData) ;
		_oNS.onStatus = Delegate.create(this, _onStatus) ;
		
		_oVideo.attachVideo(_oNS);
		_mcTarget.attachAudio(_oNS);
		
		setContent( _oNS );

		setAutoPlay( true ) ;
		setAutoSize( false ) ;
		setBufferTime( VideoLoader.BUFFER_TIME_DEFAULT );
		setPlaying ( false ) ;
		setVolume( VideoLoader.VOLUME_DEFAULT ) ;
		
		_timerHeadTime = new Timer(100, 1) ;
		_timerHeadTime.addEventListener(TimerEventType.TIMER, new Delegate(this, _onFrameUpdate)) ;
		
	}
	
	static public var BUFFER_TIME_DEFAULT:Number = 4 ;

	static public var VOLUME_DEFAULT:Number = 60 ;

	/**
	 * Clear the video.
	 */
	public function clear():Void
	{
		_oVideo.clear() ;
		notifyEvent(MediaEvent.MEDIA_CLEAR) ;
	}

	/**
	 * Returns the number of bytes loaded (streamed) for the specified 
	 */
	public function getBytesLoaded():Number 
	{
		var bytesLoaded:Number = _oNS.bytesLoaded ;
		return isNaN(bytesLoaded) ? 0 : bytesLoaded ;
	}

	/**
	 * Returns the size, in bytes, of the specified object.
	 */
	public function getBytesTotal():Number 
	{
		var bytesTotal:Number = _oNS.bytesTotal ;
		return isNaN(bytesTotal) ? 0 : bytesTotal ;
	}

	/**
	 * Returns the duration of the loader.
	 */
	/*override*/ public function getDuration():Number 
	{
		return isNaN(_duration) ? 0 : _duration ;
	}
	
	/**
	 * Rerturns the height of the loader.
	 */
	public function getHeight() : Number 
	{
		return _mcTarget._height ;
	}

	/**
	 * Returns the MedaData object.
	 */
	public function getMetaData() 
	{
		return _oMetaData ;	
	}

	/**
	 * Returns the current time of the loader.
	 */
	public function getTime():Number 
	{
		return getContent().time ;
	}

	/**
	 * Returns the current position of the loader.
	 */
	public function getPosition():Number 
	{
		return (duration > 0) ? Math.round(getTime() * 100 / getDuration()) : 0 ;
	}

	/**
	 * Returns the internal video reference.
	 */
	public function getVideo():Video 
	{
		return _oVideo ;	
	}

	/**
	 * Returns the width of the loader.
	 */
	public function getWidth():Number 
	{
		return _mcTarget._width ;
	}
	
	/**
	 * Returns 'true' if the loader auto size.
	 */
	public function isAutoSize():Boolean 
	{
		return _bAutoSize ;
	}

	/**
	 * Load the external video.
	 */
	public function load(sURL:String):Void 
	{
		setUrl(sURL) ;
	}
	
	/**
	 * Move the loader view.
	 */
	public function move( x : Number, y : Number):Void 
	{
		_mcTarget._x = x ;
		_mcTarget._y = y ;
	}

	/**
	 * Pause the loader.
	 */
	public function pause(noEvent:Boolean):Void 
	{
	
		if (!isResumed() || isPlaying()) 
		{
			
			setResumed(true) ;
			_oNS.pause(true) ;	
			stopProgress() ;
			if (noEvent != true) 
			{
				notifyEvent(MediaEvent.MEDIA_RESUME) ;
			}
		
		}
		else 
		{
			
			setResumed(false) ;
			_oNS.pause( false ) ;
			startProgress() ;
			
		}
	}

	/**
	 * Play the loader.
	 */
	public function play(n:Number, noEvent:Boolean):Void 
	{
		
		if (!isLoaded()) _load();
		
		if (!isNaN(n)) 
		{
			_oNS.seek(n) ;
		}
		else 
		{
			_oNS.seek(0) ;	
		}
		
		_oNS.pause(false) ;
		startProgress() ;
		if (noEvent != true) 
		{
			notifyEvent(MediaEvent.MEDIA_START) ;
		}
		
	}
	
	/**
	 * Release the loader.
	 */
	public function release():Void 
	{
		_oMetaData = null  ;
		_oNS.close() ;
		_oNC.close() ;
		_oVideo.clear() ;
		_duration = 0 ;
		super.release() ;
	}
	
	public function setAutoSize(b:Boolean):Void 
	{
		_bAutoSize = b ;
	}
	
	public function setBufferTime(n:Number):Void 
	{
		_nBufferTime = n ;
	}
	
	public function setDuration(n:Number):Void 
	{
		_duration = (n>0) ? n : 0 ;
	}

	/**
	 * Sets the current time of the loader.
	 */
	public function setTime(n:Number):Void 
	{
		_oNS.seek(n);
	}
	
	/**
	 * Sets the position of the loader.
	 */
	/*override*/ public function setPosition(n:Number):Void 
	{
		setTime(Math.ceil(Range.PERCENT_RANGE.clamp(n) * 100 / getDuration())) ;
	}

	/**
	 * Set the size of the loader (width and height)
	 */
	public function setSize(w:Number, h:Number):Void 
	{
		_mcTarget._width = w ;
		_mcTarget._height = h ;
		dispatchEvent( new BasicEvent(EventType.RESIZE, this) ) ;
	}

	/**
	 * Sets the url of the loader.
	 */
	public function setUrl( sURL:String ):Void 
	{
		try 
		{
			if (sURL) 
			{
				super.setUrl( sURL ) ;
				setLoaded(false) ;
				if (isPlaying()) 
				{
					this.play(0);
				}
				else 
				{
					_load() ;
				}
			}
			else 
			{
				throw new Warning( toString() + " got invalid url property, can't load." );
			}
		} 
		catch (e:Warning) 
		{
			trace("> " + this + " : " + e.toString()) ;	
		}
	}

	/**
	 * Stop the loader.
	 */
	public function stop():Void 
	{
		if (isResumed() || isPlaying()) 
		{
			_oNS.close() ;
			_oVideo.clear() ;
			setLoaded(false) ;
			if ( isResumed() ) 
			{
				setResumed(false) ;
			}
			stopProgress() ;
			notifyEvent(MediaEvent.MEDIA_PROGRESS) ;
			notifyEvent(MediaEvent.MEDIA_STOP) ;
		}
	}

	/**
	 * Internal load method.
	 */
	private function _load():Void 
	{
		try 
		{
			if ( this.getUrl() == undefined ) 
			{
				throw new UnsupportedOperation( toString() + " can't play without any valid url property, loading fails.");
			}
		} 
		catch (e:UnsupportedOperation) 
		{
			trace(e.toString()) ;
			// return ;
		}
		
		setLoaded(true) ;
		_oMetaData = null ;
		_oNS.setBufferTime( _nBufferTime ) ;
		_oNS.play( this.getUrl() );
		startProgress() ;
		if (!isAutoPlay() ) 
		{
			this.pause(true) ;
		} 
		super.load();
		
	}

	private var _bAutoSize : Boolean ;

	private var _duration:Number ;
	
	private var _nBufferTime : Number;	

	private var _oMetaData ;
	
	private var _oNC:NetConnection ;
	
	private var _oNS:NetStream ;
	
	private var _oVideo:Video ;
	
	private var _timer:FrameTimer ;
	
	private var _timerHeadTime:Timer ;
	
	/**
	 * Invoqued when the onMetaData changed.
	 */
	private function _onMetaData (info:Object):Void 
	{
		
		_oMetaData = info ;
		
		/*
		for (var props in info) 
		{
			trace(">>>> " + this + ".onMetaData -> " + props + " : " + info[props]) ;
		}
		*/
		setDuration( isNaN(info.duration) ? 0 : parseInt(info.duration) ) ;
		
		if (isAutoSize()) 
		{
			setSize( info.width , info.height) ;	
		}

	}
	
	/**
	 * Invoqued when the status of the stream change.
	 */
	private function _onStatus(info:Object):Void 
	{
		
		trace("> " + this + " : " + info.code) ;
		
		switch ( info.code ) {
			
			case NetStreamStatus.PLAY_START.toString() :
					
					trace( toString() + " stream starts playing.");
		
					
					break;
					
			case NetStreamStatus.PLAY_STOP.toString() :
					
					notifyEvent(MediaEvent.MEDIA_FINISH) ;
					
					trace(toString() + " stream stops playing.");
					
					if (isLoop()) 
					{
						this.play(0) ;
					}
					else 
					{
						this.stop() ;	
					}
					
					break;
			
			case NetStreamStatus.PLAY_STREAM_NOT_FOUND.toString() :
			
				trace(toString() + " stream not found.");
				stopProgress() ;
				break ;
			
			case NetStreamStatus.SEEK_INVALID_TIME.toString() :
				
				trace( toString() + " seeks invalid time in '" + this.getUrl() + "'.");
				break;
				
			case NetStreamStatus.BUFFER_FULL.toString() :
				
				trace( toString() + " stream buffer is full." );
				break;

			case 'NetConnection.Connect.Closed' : 
				stopProgress() ;
				trace(toString() + " local connection closed.");
				break ;
				
			case 'NetConnection.Connect.Success' : 
				
				trace(toString() + " local connection successful.");
				break ;
				
			case 'NetConnection.Connect.Failed' : 
				
				trace( toString() + " local connection failed");
				break ;
				
		}
	}

	/**
	 * Invoqued when the frame update.
	 */
	private function _onFrameUpdate():Void 
	{
		_oNS.pause(true) ;					
		stopProgress() ;				
	}
		

}