/**	VideoLoader

	AUTHOR

		Name : VideoLoader
		Package : asgard.media
		Version : 1.0.0.0
		Date :  2006-05-18
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : contact@ekameleon.net
	
	PROPERTY SUMMARY

		- bytesLoaded:Number [Read Only]
		
		- bytesTotal:Number [Read Only]
		
		- data [R/W]

		- duration:Number [Read Only]
	
		- name:String [R/W]
		
		- percent:Number [Read Only]
	
		- position:Number [R/W]

		- running:Boolean [Read Only]
		
		- timeOut:Number [R/W]
		
		- volume:Number [R/W]
	
	METHOD SUMMARY

	 	- getContent() ;

		- getBytesLoaded():Number ;

		- getBytesTotal():Number ;

		- getData() ;
		
		- getDuration():Number
		
		- getHeight():Number
		
		- getName():String ;

		- getPercent():Number ;
		
		- getTime():Number
		
			Returns playhead position.
		
		- getPosition():Number
		
			Returns playhead position in %.
		
		- getMetaData()
						
		- getURL():String
		
		- getVolume():Number
		
		- getWidth():Number
		
		- isAutoPlay():Boolean
		
			Checks "autoplay" is enable or not.
		
		- isAutoSize():Boolean
		
			Checks "autosize" mode.
		
		- isLoop():Boolean
		
		- isPlaying():Boolean
		
			Indicates playing video state.
		
		- load(url:String):Void
		
			Loads passed-in url video file.
		
		- move(x:Number, y:Number):Void
		
			Changes video object position.
		
		- pause():Void	
		
		- play(n:Number):Void
		
			Plays video.
			If video is loaded, play it at passed-in n (seek)
			If video is not already loaded, loads it.
		
		- release():Void
		
			Deletes and stops all VideoDisplay activity.
		
		- setAutoPlay (b:Boolean) : Void
		
			Defines "autoplay" mode.
		
		- setAutoSize(b:Boolean):Void
		
			Defines "autosize" mode.
		
		- setBufferTime(n:Number):Void
		
		- setLoop(b:Boolean):Void
		
		- setPosition(n:Number):Void
		
		- setURL(url:String):Void
		
		- setVolume(n:Number):Void
		
		- setSize(w:Number, h:Number):Void
		
			Defines video playback size.
		
		- setTime(n:Number):Void
		
		- stop():Void
		
		- toString():String
	
	EVENT SUMMARY
	
		MediaEvent
	
	EVENT SUMMARY
	
		- LoadEventType.onLoadInitEVENT:String
		
		- LoadEventType.onLoadProgressEVENT:String
		
		- LoadEventType.onTimeOutEVENT:String

		- MediaEventType.onMediaFinishedEVENT:String
		
		- MediaEventType.onMediaProgressEVENT:String
		
		- MediaEventType.onMediaResumedEVENT:String
		
		- MediaEventType.onMediaStartedEVENT:String
		
		- MediaEventType.onMediaStoppedEVENT:String
	
	INHERIT

		CoreObject → AbstractCoreEventDispatcher → AbstractLoader → VideoLoader
	
	IMPLEMENTS
	
		EventTarget, IFormattable, IHashable, ILoader, IEventDispatcher
	
**/

import asgard.events.MediaEventType;
import asgard.media.AbstractMediaLoader;

import vegas.errors.IllegalArgumentError;
import vegas.errors.UnsupportedOperation;
import vegas.events.Delegate;
import vegas.events.TimerEventType;
import vegas.maths.Range;
import vegas.util.FrameTimer;
import vegas.util.Timer;
import vegas.errors.Warning;
import asgard.net.NetStreamStatus;

/**
 * @author eKameleon
 */
class asgard.media.VideoLoader extends AbstractMediaLoader {
	
	// ----o Constructor
	
	function VideoLoader( mcTarget:MovieClip , video:Video , sName:String ) {
		
		super(mcTarget, sName);
		
		_oVideo = video ? video : _mcTarget.video ;
		
		if (_oVideo == undefined) {
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
		setVolume(VideoLoader.VOLUME_DEFAULT) ;
		
		_timerHeadTime = new Timer(100, 1) ;
		_timerHeadTime.addEventListener(TimerEventType.TIMER, new Delegate(this, _onFrameUpdate)) ;
		
	}
	
	// ----o Constant
	
	static public var BUFFER_TIME_DEFAULT:Number = 4 ;
	static public var VOLUME_DEFAULT:Number = 60 ;

	// ----o Public Methods

	public function getBytesLoaded():Number {
		var bytesLoaded:Number = _oNS.bytesLoaded ;
		return isNaN(bytesLoaded) ? 0 : bytesLoaded ;
	}

	public function getBytesTotal():Number {
		var bytesTotal:Number = _oNS.bytesTotal ;
		return isNaN(bytesTotal) ? 0 : bytesTotal ;
	}

	/*override*/ public function getDuration():Number {
		return isNaN(_duration) ? 0 : _duration ;
	}

	public function getHeight() : Number {
		return _mcTarget._height ;
	}

	public function getMetaData() {
		return _oMetaData ;	
	}

	public function getTime():Number {
		return getContent().time ;
	}

	public function getPosition():Number {
		return (duration > 0) ? Math.round(getTime() * 100 / getDuration()) : 0 ;
	}

	public function getVideo():Video {
		return _oVideo ;	
	}

	public function getWidth():Number {
		return _mcTarget._width ;
	}
	
	public function isAutoSize():Boolean {
		return _bAutoSize ;
	}

	public function load(sURL:String):Void {
		setUrl(sURL) ;
	}
	
	public function move( x : Number, y : Number):Void {
		_mcTarget._x = x ;
		_mcTarget._y = y ;
	}

	public function pause(noEvent:Boolean):Void {
	
		if (!isResumed() || isPlaying()) {
			
			setResumed(true) ;
			_oNS.pause(true) ;	
			stopProgress() ;
			if (noEvent != true) notifyEvent(MediaEventType.MEDIA_RESUME) ;
		
		} else {
			
			setResumed(false) ;
			_oNS.pause( false ) ;
			startProgress() ;
			
		}
	}

	public function play(n:Number, noEvent:Boolean):Void {
		
		if (!isLoaded()) _load();
		
		if (!isNaN(n)) {
			_oNS.seek(n) ;
		} else {
			_oNS.seek(0) ;	
		}
		
		_oNS.pause(false) ;
		startProgress() ;
		if (noEvent != true) {
			notifyEvent(MediaEventType.MEDIA_START) ;
		}
		
	}
	
	public function release():Void {
		_oMetaData = null  ;
		_oNS.close() ;
		_oNC.close() ;
		_oVideo.clear() ;
		_duration = 0 ;
		super.release() ;
	}
	
	public function setAutoSize(b:Boolean):Void 	{
		_bAutoSize = b ;
	}
	
	public function setBufferTime(n:Number):Void {
		_nBufferTime = n ;
	}
	
	public function setDuration(n:Number):Void {
		_duration = (n>0) ? n : 0 ;
	}

	public function setTime(n:Number):Void {
		_oNS.seek(n);
	}
	
	/*override*/ public function setPosition(n:Number):Void {
		setTime(Math.ceil(Range.PERCENT_RANGE.clamp(n) * 100 / getDuration())) ;
	}

	public function setSize(w:Number, h:Number):Void {
		_mcTarget._width = w ;
		_mcTarget._height = h ;
	}

	public function setUrl( sURL:String ) : Void {
		try {
			if (sURL) {
				super.setUrl( sURL ) ;
				setLoaded(false) ;
				if (isPlaying()) {
					this.play(0);
				} else {
					_load() ;
				}
			} else {
				throw new Warning( toString() + " got invalid url property, can't load." );
			}
		} catch (e:Warning) {
			trace(e.toString()) ;	
		}
	}

	public function stop():Void {
		if (isResumed() || isPlaying()) {
			_oNS.close() ;
			_oVideo.clear() ;
			setLoaded(false) ;
			if ( isResumed() ) setResumed(false) ;
			stopProgress() ;
			notifyEvent(MediaEventType.MEDIA_PROGRESS) ;
			notifyEvent(MediaEventType.MEDIA_STOP) ;
		}
	}

	// ----o Protected Methods
	
	private function _load():Void {
		
		try {
			if ( this.getUrl() == undefined ) {
				throw new UnsupportedOperation( toString() + " can't play without any valid url property, loading fails.");
			}
			
		} catch (e:UnsupportedOperation) {
			
			trace(e.toString()) ;
			// return ;
				
		}
		
		setLoaded(true) ;
		_oMetaData = null ;
		_oNS.setBufferTime( _nBufferTime ) ;
		_oNS.play( this.getUrl() );
		startProgress() ;
		if (!isAutoPlay() ) {
			this.pause(true) ;
		} 
		super.load();
		
	}

	// ----o Private Properties

	private var _bAutoSize : Boolean ;

	private var _duration:Number ;
	
	private var _nBufferTime : Number;	

	private var _oMetaData ;
	private var _oNC:NetConnection ;
	private var _oNS:NetStream ;
	private var _oVideo:Video ;
	
	private var _timer:FrameTimer ;
	private var _timerHeadTime:Timer ;
	
	// ----o Private Methods

	private function _onMetaData (info:Object):Void {
		
		_oMetaData = info ;
		
		for (var props in info) trace(this + ".onMetaData -> " + props + " : " + info[props]) ;
		
		setDuration( isNaN(info.duration) ? 0 : parseInt(info.duration) ) ;
		
		if (isAutoSize()) {
		
			setSize( info.width , info.height) ;	
			
		}

	}
		
	private function _onStatus(info:Object):Void {
		
		trace("> " + this + " : " + info.code) ;
		
		switch ( info.code ) {
			
			case NetStreamStatus.PLAY_START.toString() :
					
					trace( toString() + " stream starts playing.");
		
					
					break;
					
			case NetStreamStatus.PLAY_STOP.toString() :
					
					notifyEvent(MediaEventType.MEDIA_FINISH) ;
					
					trace(toString() + " stream stops playing.");
					
					if (isLoop()) {
						this.play(0) ;
					} else {
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

	private function _onFrameUpdate():Void {
		_oNS.pause(true) ;					
		stopProgress() ;				
	}
		

}