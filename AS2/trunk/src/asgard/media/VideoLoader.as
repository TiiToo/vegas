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

		- duration:Number [Read Only]
		
		- position:Number [R/W]
		
		- volume:Number [R/W]
	
	METHOD SUMMARY
	
		- getDuration():Number
		
		- getHeight():Number
		
		- getPlayheadTime():Number
		
			Returns playhead position.
		
		- getPosition():Number
		
			Returns playhead position in %.
				
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

		CoreObject → AbstractCoreEventDispatcher → AbstractLoader
	
	IMPLEMENTS
	
		ILoader, IEventDispatcher, EventTarget
	
**/

import asgard.events.MediaEvent;
import asgard.net.AbstractLoader;

import vegas.events.Delegate;
import vegas.events.TimerEvent;
import vegas.events.TimerEventType;
import vegas.util.FrameTimer;

/**
 * @author eKameleon
 */
class asgard.media.VideoLoader extends AbstractLoader {
	
	// ----o Constructor
	
	function VideoLoader( mcTarget:MovieClip , video:Video ) {
		super();
		
		_mcTarget = mcTarget ;
		_oVideo = video ? video : mcTarget.video ;
		
		if (_oVideo == undefined) {
			// trace ("**Error** " + toString() + " failed. Invalid video object was passed in the constructor.") ;
		}
		
		setAutoPlay( true );
		setAutoSize( false );
		
		setBufferTime( BUFFER_TIME_DEFAULT );
		
		setPlaying(false) ;
		_bIsLoaded = false ;
		
		_oSound = new Sound( _mcTarget ) ;
		_oSound.setVolume(VOLUME_DEFAULT) ;
		
		_timer = new FrameTimer(24) ;
		_timer.addEventListener(TimerEventType.TIMER, new Delegate(this, _onTimer)) ;
		
	}
	
	// ----o Constant
	
	static public var BUFFER_TIME_DEFAULT:Number = 86400 ;
	static public var VOLUME_DEFAULT:Number = 60 ;

	// ----o Public Properties
	
	// public var duration:Number ; // [Read Only]
	// public var position:Number ; // [Read Only]
	// public var volume:Number ; // [R/W]

	// ----o Public Methods

	public function getBytesLoaded():Number {
		return _oNS.bytesLoaded ;
	}
	
	public function getBytesTotal():Number {
		return _oNS.bytesTotal ;
	}

	public function getDuration():Number {
		return isNaN(_duration) ? 0 : _duration ;
	}

	public function getHeight() : Number {
		return _mcTarget._height ;
	}

	public function getPlayheadTime():Number {
		return _oNS.time ;
	}

	public function getPosition():Number {
		return (duration > 0) ? Math.round(getPlayheadTime() * 100 / getDuration()) : 0 ;
	}

	public function getVolume():Number {
		return _oSound.getVolume();
	}

	public function getWidth():Number {
		return _mcTarget._width ;
	}
	
	public function initEvent():Void {
		_e = new MediaEvent(null, this) ;
	}
	
	public function isAutoPlay():Boolean {
		return _bAutoPlay ;
	}
	
	public function isAutoSize():Boolean {
		return _bAutoSize ;
	}

	public function isLoop():Boolean {
		return _bIsLoop ;	
	}

	public function isPlaying():Boolean {
		return _bIsPlaying ;
	}
	
	public function load(sURL:String):Void {
		sURL = sURL || this.getUrl() ;
		if( sURL ) {
			super.setUrl( sURL ) ;
			_bIsLoaded = false ;
			if ( isPlaying() ) {
				this.play(0) ;
			} else {
				_load() ;
			}
		} else {
			// Logger.LOG( toString() + " got invalid url property, can't load.", LogLevel.WARN, Debug.channel );
		}
	}
	
	public function move( x : Number, y : Number):Void {
		_mcTarget._x = x ;
		_mcTarget._y = y ;
	}

	public function pause(noEvent:Boolean):Void {
		if (isPlaying()) {
			_oNS.pause( true ) ;
			setPlaying(false) ;
			_timer.stop() ;
			// if (noEvent != true) fireEventType(MediaEventType.onMediaResumedEVENT) ;
		} else {
			_oNS.pause( false ) ;
			setPlaying(true) ;
			_timer.start() ;
		}
	}

	public function play(n:Number):Void {
		if (!_bIsLoaded) _load();
		if (!isNaN(n)) _oNS.seek(n);
		// fireEventType(MediaEventType.onMediaStartedEVENT) ;
		_oNS.pause(false) ;
		setPlaying(true) ;
		_timer.start() ;
	}
	
	public function release():Void {
		_oNS.close() ;
		_oNC.close() ;
		_oVideo.clear() ;
		super.release() ;
	}
	
	public function setAutoPlay(b:Boolean):Void {
		_bAutoPlay = b ;
	}
	
	public function setAutoSize(b:Boolean):Void 	{
		_bAutoSize = b ;
	}
	
	public function setBufferTime(n:Number):Void {
		_nBufferTime = n ;
	}
	
	public function setLoop(b:Boolean):Void {
		_bIsLoop = b ;	
	}
	
	public function setPlayheadTime(n:Number):Void {
		_oNS.seek(n);
		if (!isPlaying()) {
			_oNS.pause(false);
			// CommandManagerMS.getInstance().delay( new Delegate(this, _onFrameUpdate), 100);
		}
	}
	
	public function setPlaying(b:Boolean):Void {
		_bIsPlaying = b;
	}
	
	public function setPosition(n:Number):Void {
		var t:Number = Math.ceil(n * 100 / getDuration()) ;
		setPlayheadTime(t) ;
	}

	public function setSize(w:Number, h:Number):Void {
		_mcTarget._width = w ;
		_mcTarget._height = h ;
	}

	public function setURL(sURL:String):Void {
		if (sURL) super.setUrl( sURL ) ;
	}

	public function setVolume(n:Number):Void {
		_oSound.setVolume(n) ;
	}

	public function stop():Void {
		pause(true) ;
		setPlayheadTime(0) ;
		// fireEventType(MediaEventType.onMediaStoppedEVENT) ;
	}

	// ----o Virtual Properties
	
	public function get duration():Number {
		return getDuration() ;	
	}

	public function get position():Number {
		return getPosition() ;	
	}
	
	public function set position(n:Number):Void {
		setPosition(n) ;	
	}

	public function get volume():Number {
		return getVolume() ;	
	}
	
	public function set volume(n:Number):Void {
		setVolume(n) ;	
	}

	// ----o Protected Methods
	
	private function _load():Void {
		
		if ( this.getUrl() == undefined ) {
			// Logger.LOG( "**Error** " + toString() + " can't play without any valid url property, loading fails.", LogLevel.ERROR, Debug.channel);
			return ;
		}
		
		_oNC = new NetConnection();
		_oNC.connect(null);
		
		_oNS = new NetStream(_oNC);
		setContent( _oNS );
		_oNS.setBufferTime( _nBufferTime );

		_oNS.onStatus = Delegate.create(this, _onStatus) ;
		_oNS["onMetaData"] = Delegate.create(this, _onMetaData) ;

		_oVideo.attachVideo(_oNS);
		_mcTarget.attachAudio(_oNS);
		
		_timer.start() ;
		
		_oNS.play( this.getUrl() );
		
		if ( !isAutoPlay() ) _oNS.pause(true);
	
		_bIsLoaded = true;

		this.__proto__.__proto__.load.apply(this);
	}


	// ----o Private Properties

	private var _bAutoPlay : Boolean;
	private var _bAutoSize : Boolean;
	private var _bIsLoaded : Boolean;
	private var _bIsLoop : Boolean = true ; // default value is 'true'
	private var _bIsPlaying : Boolean;

	private var _duration:Number ;
	
	private var _e:MediaEvent ;	
	
	private var _mcTarget:MovieClip ;

	private var _nBufferTime : Number;	

	private var _oNC:NetConnection ;
	private var _oNS:NetStream ;
	private var _oSound:Sound ;
	private var _oVideo:Video ;
	
	private var _timer:FrameTimer ;
	
	// ----o Private Methods

	private function _onMetaData (info:Object):Void {
		
		_duration = isNaN(info.duration) ? 0 : info.duration ;
		
	}
		
	private function _onStatus(info:Object):Void {
		
		// trace(info.code) ;
		
		switch ( info.code ) {
			
			case 'NetStream.Play.Start' :
					
					// Logger.LOG( toString() + " stream starts playing.", LogLevel.DEBUG, Debug.channel );
					
					break;
					
			case 'NetStream.Play.Stop' :
					
					// fireEventType(MediaEventType.onMediaFinishedEVENT) ;
					// Logger.LOG( toString() + " stream stops playing.", LogLevel.DEBUG, Debug.channel );
					if (isLoop()) {
						this.play(0) ;
					}
					break;
					
			case 'NetStream.Seek.InvalidTime' :
				// Logger.LOG( toString() + " seeks invalid time in '" + this.getURL() + "'.", LogLevel.WARN, Debug.channel );
				break;
				
			case 'NetStream.Buffer.Full' :
				if ( isAutoSize() ) setSize(_oVideo.width, _oVideo.height);
				// Logger.LOG( toString() + " stream buffer is full.", LogLevel.DEBUG, Debug.channel );
				break;
				
			case 'NetConnection.Connect.Success' : 
				// Logger.LOG( toString() + " local connection successful.", LogLevel.DEBUG, Debug.channel );
				break;
				
			case 'NetConnection.Connect.Failed' : 
				// Logger.LOG( toString() + " local connection failed", LogLevel.DEBUG, Debug.channel );
				break;
		}
	}

	private function _onFrameUpdate():Void {
		_oNS.pause(true) ;
	}
		
	private function _onTimer(ev:TimerEvent):Void {
		// fireEventType(MediaEventType.onMediaProgressEVENT) ;
	}
	

}