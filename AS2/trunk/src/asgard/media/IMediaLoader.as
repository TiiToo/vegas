
/**	IMediaLoader

	AUTHOR

		Name : IMediaLoader
		Package : asgard.media
		Version : 1.0.0.0
		Date :  2006-06-23
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : contact@ekameleon.net
	
	METHOD SUMMARY

	 	- getContent() ;
	
		- getBytesLoaded():Number ;

		- getBytesTotal():Number ;

		- getData() ;

		- getName():String ;

		- getPercent():Number ;

		- getTimeOut():Number ;

		- getUrl():String ;
	
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
				
	INHERIT

		ILoader → IMediaLoader
	
**/

import asgard.net.ILoader;

/**
 * @author eKameleon
 */
interface asgard.media.IMediaLoader extends ILoader {
	
	public function getDuration():Number ;
	
	public function getPosition():Number ;

	public function getVolume():Number ;

	public function isAutoPlay():Boolean ;
	
	public function isPlaying():Boolean ;

	public function pause():Void ;

	public function play():Void ;
	
	public function setAutoPlay(b:Boolean):Void ;
	
	public function setPlaying(b:Boolean):Void ;

	public function setPosition(time:Number):Void ;
	
	public function setVolume(n:Number):Void ;
	
	public function stop():Void ;

}