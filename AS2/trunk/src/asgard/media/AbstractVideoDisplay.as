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
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
 */import asgard.display.BackgroundDisplay;

import pegas.maths.Range;

import vegas.errors.IllegalArgumentError;
import vegas.events.NumberEvent;
import vegas.util.factory.DisplayFactory;

/**
 * This display control a Video object and this attached Sound object.
 * @author eKameleon
 */
class asgard.media.AbstractVideoDisplay extends BackgroundDisplay
{
	
	/**
	 * Creates a new AbstractVideoDisplay instance.
	 * If the target reference contains a {@ode Video} instance with the name "video", this object is used in the display.
	 * @param sName the name of the display.
	 * @param target the target of this display.
	 * @param (optional) the {@code Video} object of this display. 
	 */	
	public function AbstractVideoDisplay( sName:String, target:MovieClip, video:Video) 
	{
		
		super(sName, target);

		_oVideo = video ? video : view.video ;
		
		DisplayFactory.swapDepths( _oVideo, DEFAULT_VIDEO_DEPTH ) ;
		
		setSize( view._width , view._height ) ;
		
		_oVideo.toString = function():String
		{
			return "[Video]" ;	
		} ;
		
		_oSound = new Sound( view ) ;
		_oSound.setVolume( DEFAULT_VOLUME ) ;
		_oSound.toString = function()
		{
			return "[Sound]" ;	
		} ;

		if ( !_oVideo ) 
		{
			throw new IllegalArgumentError( this + " constructor failed. Invalid video object was passed in the constructor.");
		}
		
	}

	/**
	 * The depth of the video reference.
	 */
	public static var DEFAULT_VIDEO_DEPTH:Number = 1 ;

	/**
	 * The default value of the volume in the display.
	 */
	public static var DEFAULT_VOLUME:Number = 80 ;

	/**
	 * const Defined the event name of the event 
	 */
	public static var SOUND_VOLUME_CHANGE:String = "onVolumeChange" ;

	/**
	 * The alpha value of the screen.
	 */
	public var themeAlpha:Number = null ;
	
	/**
	 * The color value of the screen.
	 */
	public var themeColor:Number = null ;

	/**
	 * The view reference of this display.
	 */
	public var view:MovieClip ;
	
	/**
	 * Returns the sound's volume value of the UI.
	 * @return the sound's volume value of the UI.
	 */
	public function get volume():Number
	{
		return _oSound.getVolume() ;	
	}
	
	/**
	 * Sets the sound's volume value of the display.
	 * This property dispatch a {@code NumberEvent} object with the volume value returns by the getNumber() method of the event.
	 * To handle this event you can use the {@code SOUND_VOLUME_CHANGE} static property.
	 * @param value the Number value of the volume of this display.
	 */
	public function set volume( value:Number ):Void
	{
		var n:Number = Range.PERCENT_RANGE.clamp(value) ;
		_oSound.setVolume( n ) ;
		dispatchEvent( new NumberEvent( SOUND_VOLUME_CHANGE , _oSound.getVolume() , this ) ) ;
	}

	/**
	 * Attaching an audio NetStream or a Microphone source to play.
	 * @param oSource the audio source.  
	 */
	public function attachAudio( oSource ):Void
	{
		view.attachAudio( oSource ) ;	
	}
	
	/**
	 * Attaching the client camera
	 * @param cam The specified {@code Camera} object.
	 */
	public function attachCamera( cam:Camera ):Void
	{
		_oVideo.attachVideo( cam ) ;	
	}
	
	/**
	 * Attaching a NetStream object.
	 * @param stream The specified {@code NetStream} object.
	 */
	public function attachStream( stream:NetStream ):Void
	{
		_oVideo.attachVideo( stream ) ;	
	}
	
	/**
	 * Clear the video in the display.
	 */
	public function clear():Void
	{
		view.attachAudio(null) ;
		_oVideo.attachVideo(null) ;
		_oVideo.clear() ;
	}

	/**
	 * Returns the sound reference of this display.
	 * @return the sound reference of this display.
	 */
	public function getSound():Sound
	{
		return _oSound ;	
	}
	
	/**
	 * Returns the video reference of this display.
	 * @return the video reference of this display.
	 */
	public function getVideo():Video
	{
		return _oVideo ;
	}

	/**
	 * Sets the virtual height value of the component.
	 */
	public function setH( n:Number ) : Void 
	{
		view._height = n ;
		super.setH(n) ;
	}

	/**
	 * Sets the virtual width and height values of the component.
	 */
	public function setSize( w:Number, h:Number ) : Void 
	{
		
		_oVideo._width  = w;
		_oVideo._height = h ;
		_oVideo.width  = w;
		_oVideo.height = h ;
		
		super.setSize( w, h ) ;
	}

	/**
	 * Sets the virtual width value of the component.
	 */
	public function setW( n:Number ):Void 
	{
		view._width = n ;
		super.setW(n) ;
	}

	/**
	 * Internal sound object.
	 */
	private var _oSound : Sound;
	
	/**
	 * Internal video object.
	 */
	private var _oVideo : Video;


}