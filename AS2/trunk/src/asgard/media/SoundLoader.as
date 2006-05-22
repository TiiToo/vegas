/**	SoundLoader

	AUTHOR

		Name : SoundLoader
		Package : asgard.media
		Version : 1.0.0.0
		Date :  2006-06-22
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : contact@ekameleon.net
	
	PROPERTY SUMMARY

		- duration:Number [Read Only]
		
		- position:Number [R/W]
		
		- volume:Number [R/W]
	
	METHOD SUMMARY
	
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

		CoreObject → AbstractCoreEventDispatcher → AbstractLoader → SoundLoader
	
	IMPLEMENTS
	
		EventTarget, IFormattable, IHashable, ILoader, IEventDispatcher 
	
**/

// TODO TESTER !!! 

import asgard.events.MediaEvent;
import asgard.events.MediaEventType;
import asgard.net.AbstractLoader;

import vegas.errors.IllegalArgumentError;
import vegas.errors.UnsupportedOperation;
import vegas.errors.Warning;
import vegas.events.Delegate;
import vegas.events.TimerEvent;
import vegas.events.TimerEventType;
import vegas.util.FrameTimer;
import vegas.util.MathsUtil;

/**
 * @author eKameleon
 */
class asgard.media.SoundLoader extends AbstractLoader {
	
	// ----o Constructor
	
	function SoundLoader( mc:MovieClip ) {
		super();
		
		if (!mc) {
			throw new IllegalArgumentError(this + " 'mc' argument in constructor is undefined.") ;
		}
		
		_mcTarget = mc ;
		
		_oSound = new Sound(mc) ;
		_oSound.onLoad = function (success):Void {
			
			trace("sound onLoad :: " + success) ;
			
		} ;
		_oSound.onSoundComplete = Delegate.create(this, _onSoundComplete) ;
		
		_timer = new FrameTimer(24) ;
		_timer.addEventListener(TimerEventType.TIMER, new Delegate(this, _onTimer)) ;
		
	}

	// ----o Public Properties
	
	// public var duration:Number ; // [Read Only]
	// public var position:Number ; // [R/W]
	// public var volume:Number ; // [R/W]

	// ----o Public Methods

	public function getDuration():Number {
		return isNaN(_oSound.duration) ? 0 : _oSound.duration ;
	}
	
	public function getPosition():Number {
		return _oSound.position ;	
	}

	public function getTime():Number {
		return (getPosition() / 1000) ;
	}
	
	public function getPercentPosition():Number {
		return MathsUtil.getPercent(getPosition(), getDuration()) ;	
	}

	public function getVolume():Number {
		return _oSound.getVolume() ;
	}
		
	public function initEventSource():Void {
		_e = new MediaEvent(null, this) ;
	}

	public function isAutoPlay() : Boolean {
		return _isAutoPlay ;
	}
	
	public function isPlaying() :Boolean {
		return _isPlaying ;
	}

	public function load(sURL:String):Void {
		sURL = sURL || this.getUrl() ;
		this.stop(true) ;
		try {
			if( sURL ) {
				super.setUrl( sURL ) ;
				_isLoaded = false ;
				_load() ;
			} else {
				throw new Warning ( toString() + " got invalid url property, can't load." ) ; 
			}
		} catch(e:Warning) {
			
			trace(e.toString()) ;
			
		}
	}

	public function pause(noEvent:Boolean):Void {
		if (_isPlaying) {
			_timer.stop() ;
			_currentPos = _oSound.position ;
			_oSound.stop() ;
			setPlaying(false) ;
			if (noEvent != true) {
				notifyEvent(MediaEventType.onMediaResumedEVENT) ;
			}
		}
	}

	public function play(noEvent):Void {
		if (!_isLoaded) _load() ;
		if (isPlaying()) return ;
		//trace("play :: " + _currentPos) ;
		if (isNaN(_currentPos)) _currentPos = 0 ;
		_oSound.start(_currentPos) ;
		setPlaying(true) ;
		_timer.start() ;
		if (noEvent != true) {
			notifyEvent(MediaEventType.onMediaStartedEVENT) ;
		}
	}
	
	public function release():Void {
		this.stop(true) ;
		super.release() ;
	}
	
	public function setAutoPlay(b:Boolean):Void {
		_isAutoPlay = b ;
	}
	
	public function setPlaying(b:Boolean):Void {
		_isPlaying = b;
	}

	public function setUrl(sURL:String):Void {
		if (sURL) super.setUrl( sURL ) ;
	}
	
	public function setPosition(time:Number):Void {
		if (_isPlaying) {
			this.play(0) ;
		} else {
			_currentPos = (isNaN(time)) ? 0 : time ;
			
		}
	}
	
	public function setVolume(n:Number):Void {
		_oSound.setVolume(n) ;
	}


	public function stop(noEvent:Boolean):Void {
		if (_isPlaying) {
			_currentPos = 0 ;
			setPlaying(false) ;
			_oSound.stop() ;
			_timer.stop() ;
			if (!noEvent) notifyEvent(MediaEventType.onMediaStoppedEVENT) ;
		}
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

	// ----o Private Properties
	
	private var _currentPos:Number ;
	
	private var _e:MediaEvent ;
	
	private var _isAutoPlay : Boolean;
	private var _isLoaded : Boolean ;
	private var _isLoop : Boolean ;

	private var _mcTarget:MovieClip ;
	private var _oSound:Sound ;
	
	private var _timer:FrameTimer ;

	private var _isPlaying:Boolean ;

	// ----o Private Methods

	private function _load():Void {
		
		try {
			if ( this.getUrl() == undefined ) {
				throw new UnsupportedOperation( toString() + " can't play without any valid url property, loading fails.");
			}
			
		} catch (e:UnsupportedOperation) {
			
			trace(e.toString()) ;
			return ;
				
		}
		
		_oSound.loadSound( this.getUrl() , isAutoPlay() ) ;
		if (isAutoPlay()) {
			setPlaying(true) ;
			_timer.start() ;
			notifyEvent(MediaEventType.onMediaStartedEVENT) ;
		}
		_isLoaded = true;
		super.load();
	}

	private function _onSoundComplete():Void {
		notifyEvent(MediaEventType.onMediaFinishedEVENT) ;
		if (_isLoop) _oSound.start() ; 
	}

	private function _onTimer(ev:TimerEvent):Void {
		notifyEvent(MediaEventType.onMediaProgressEVENT) ;
	}

}