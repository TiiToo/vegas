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

import asgard.events.MediaEventType;
import asgard.media.AbstractMediaLoader;

import vegas.errors.UnsupportedOperation;
import vegas.errors.Warning;
import vegas.events.Delegate;
import vegas.util.MathsUtil;

/**
 * @author eKameleon
 */
class asgard.media.SoundLoader extends AbstractMediaLoader {
	
	// ----o Constructor
	
	function SoundLoader( mcTarget:MovieClip , sName:String ) {

		super(mcTarget, sName) ;
		
		getSound().onLoad = function (success:Boolean):Void {
			
			trace("> sound onLoad :: " + success) ;
			
		} ;
		
		_currentPos = 0 ;
		
		getSound().onSoundComplete = Delegate.create(this, _onSoundComplete) ;
		
		setContent(_oSound) ;
		
		setAutoPlay(true) ;
		
	}

	// ----o Constants
	
	static public var VOLUME_DEFAULT:Number = 60 ;

	// ----o Public Methods

	/*override*/ public function getDuration():Number {
		return isNaN(_oSound.duration) ? 0 : _oSound.duration ;
	}
	
	/*override*/ public function getPosition():Number {
		return getSound().position ;	
	}

	public function getTime():Number {
		return (getPosition() / 1000) ;
	}
	
	public function getPercentPosition():Number {
		return MathsUtil.getPercent(getPosition(), getDuration()) ;	
	}

	/*override*/ public function load(sURL:String):Void {
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

	/*override*/ public function pause(noEvent:Boolean):Void {
		trace(isPlaying()) ;
		if (isPlaying()) {
			
			stopProgress() ;
			getSound().stop() ;
			
			_currentPos = getSound().position ;

			if (noEvent != true) {
				notifyEvent(MediaEventType.MEDIA_RESUME) ;
			}
		} else {
			
			this.play(_currentPos) ;
			
		}
	}

	/*override*/ public function play( pos:Number, noEvent:Boolean):Void {

		trace(!_isLoaded) ;

		if (!_isLoaded) {
			_load() ;
		}
		
		_currentPos = (pos > 0) ? pos : 0 ;
		
		getSound().start( _currentPos / 1000 ) ;
		
		if (noEvent != true) {
			notifyEvent(MediaEventType.MEDIA_START) ;
		}
		startProgress() ;
	}
	
	/*override*/ public function release():Void {
		this.stop(true) ;
		super.release() ;
	}
	
	/*override*/ public function setPosition(time:Number):Void {
		if (isPlaying()) {
			this.play(time) ;
		} else {
			_currentPos = (isNaN(time)) ? 0 : time ;
		}
	}
	
	/*override*/ public function stop(noEvent:Boolean):Void {
		if (isPlaying()) {
			stopProgress() ;
			getSound().stop() ;
			_currentPos = 0 ;
			if ( noEvent != true ) {
				notifyEvent(MediaEventType.MEDIA_STOP) ;
			}
		}
	}

	// ----o Private Properties
	
	private var _currentPos:Number ;

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
			startProgress() ;
			_currentPos = 0 ;
			getSound().start(_currentPos) ;
			notifyEvent(MediaEventType.MEDIA_START) ;
		}
		_isLoaded = true ;
		
		super.load();
	}

	private function _onSoundComplete():Void {
		notifyEvent(MediaEventType.MEDIA_FINISH) ;
		if ( isLoop() ) {
			getSound().start() ;
		} 
	}

}