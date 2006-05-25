/**	AbstractMediaLoader

	AUTHOR

		Name : AbstractMediaLoader
		Package : asgard.media
		Version : 1.0.0.0
		Date :  2006-06-23
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

		- getName():String ;

		- getPercent():Number ;

		- getTimeOut():Number ;

		- getUrl():String ;
	
		- hashCode():Number
	
		- initEvent():Void ;

		- load():Void ;

		- notifyError(sError:String, nCode:Number) : Void ;
	
		- notifyEvent(eventType:String):Void ;

		- onLoadInit():Void ;
	
		- release():Void ;

		- setContent(o):Void ;

		- setData( o ):Void ;

		- setName(sName:String):Void ;

		- setTimeOut( n : Number ):Void ;

		- setUrl(sURL:String):Void ;
		
		- getDuration():Number
		
		- getPosition():Number
		
		- getVolume():Number
		
		- isAutoPlay():Boolean
		
		- isPlaying():Boolean
		
		- pause():Void
		
		- play():Void
		
		- setAutoPlay(b:Boolean):Void
		
		- setPosition(time:Number):Void
		
		- setVolume(n:Number):Void
		
		- stop():Void
		
		- toString():Void
	
	INHERIT

		CoreObject → AbstractCoreEventDispatcher → AbstractLoader → AbstractMediaLoader
	
	IMPLEMENTS
	
		EventTarget, IFormattable, IHashable, ILoader, IEventDispatcher 
	
**/

import asgard.events.MediaEvent;
import asgard.events.MediaEventType;
import asgard.media.IMediaLoader;
import asgard.net.AbstractLoader;

import vegas.errors.IllegalArgumentError;
import vegas.events.Delegate;
import vegas.events.TimerEvent;
import vegas.events.TimerEventType;
import vegas.util.FrameTimer;

/**
 * @author eKameleon
 */
class asgard.media.AbstractMediaLoader extends AbstractLoader implements IMediaLoader {
	
	// ----o Constructor
	
	private function AbstractMediaLoader( mcTarget:MovieClip , sName:String) {
		
		super();
		
		if (!mcTarget) {
			throw new IllegalArgumentError(this + " 'mcTarget' argument in constructor is undefined.") ;
		}
		
		_mcTarget = mcTarget ;
		
		setName(sName) ;
		
		_oSound = new Sound(_mcTarget) ;
		
		_timer = new FrameTimer(24) ;
		_timer.addEventListener(TimerEventType.TIMER, new Delegate(this, onProgress));
		
	}

	// ----o Public Methods

	/**
	 * override this method 
	 */
	public function getDuration():Number {
		return null ;
	}
	
	/**
	 * override this method.
	 */
	public function getPosition():Number {
		return null ;
	}

	/**
	 * Return the sound's media reference.
	 */
	public function getSound():Sound {
		return _oSound ;
	}

	/**
	 * Return Sound volume
	 */
	public function getVolume():Number {
		return getSound().getVolume() ;
	}
		
	public function initEvent():Void {
		_e = new MediaEvent(null, this) ;
	}

	public function isAutoPlay() : Boolean {
		return _isAutoPlay ;
	}

	public function isLoaded():Boolean {
		return _isLoaded ;	
	}

	public function isLoop():Boolean {
		return _isLoop ;	
	}
	
	public function isPlaying() :Boolean {
		return _isPlaying ;
	}

	public function isResumed():Boolean {
		return _isResumed ;	
	}

	public function onProgress(ev:TimerEvent):Void {
		notifyEvent(MediaEventType.MEDIA_PROGRESS) ;
	}

	/**
	 * override this method 
	 */
	public function pause():Void {
		//
	}

	/**
	 * override this method 
	 */
	public function play():Void {
		//
	}
	
	public function setAutoPlay(b:Boolean):Void {
		_isAutoPlay = b ;
	}

	public function setLoaded(b:Boolean):Void {
		_isLoaded = b ;	
	}

	public function setLoop(b:Boolean):Void {
		_isLoop = b ;	
	}

	public function setPlaying(b:Boolean):Void {
		_isPlaying = b ;
	}

	/**
	 * override this method 
	 */
	public function setPosition(time:Number):Void {
		// 
	}
	
	public function setResumed(b:Boolean):Void {
		_isResumed = b ;
	}
	
	public function setVolume(n:Number):Void {
		getSound().setVolume(n) ;
	}

	public function startProgress():Void {
		_timer.start() ;
		setPlaying(true) ;
	}
	
	/**
	 * override this method 
	 */
	public function stop():Void {
		
	}

	public function stopProgress():Void {
		_timer.stop() ;
		setPlaying(false) ;
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
	
	private var _e:MediaEvent ;
	
	private var _isAutoPlay : Boolean ;
	private var _isLoaded : Boolean ;
	private var _isLoop : Boolean ;
	private var _isPlaying:Boolean ;
	private var _isResumed:Boolean ;

	private var _mcTarget:MovieClip ;

	private var _oSound:Sound ;

	private var _timer:FrameTimer ;

}