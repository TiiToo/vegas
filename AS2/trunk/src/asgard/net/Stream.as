﻿/*

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

import asgard.events.CuePointEvent;
import asgard.media.FLVMetaData;
import asgard.net.NetStreamStatus;
import asgard.net.StreamCollector;

import pegas.maths.Range;

import vegas.core.IHashable;
import vegas.data.Set;
import vegas.events.Delegate;
import vegas.events.Event;
import vegas.events.EventDispatcher;
import vegas.events.EventListener;
import vegas.events.EventListenerCollection;
import vegas.events.IEventDispatcher;
import vegas.logging.ILogable;
import vegas.logging.ILogger;
import vegas.util.ConstructorUtil;

/**
 * The Stream class opens a one-way streaming connection between Flash Player and RTMP server through a connection made available by a NetConnection object.
 * A Stream object is like a channel inside a NetConnection object; this channel can either publish audio 
 * and/or video data, using NetStream.publish(), or subscribe to a published stream and receive data, 
 * using NetStream.play(). You can publish or play live (real-time) data and previously recorded data.
 * @author eKameleon
 */
class asgard.net.Stream extends NetStream implements IEventDispatcher, IHashable, ILogable
{
	
	/**
	 * Creates the Stream singleton.
	 * @param nc the NetConnection of this Stream Object.
	 * @param id the id of this Stream object.
	 */
	public function Stream( nc:NetConnection , id:String ) 
	{
		super(nc) ;
		setID( id ) ;
		initEvent() ;
		this.onStatus = Delegate.create(this, _onStreamStatus) ; 
	}

	/**
	 * Returns the percentage of the buffer that is filled.
	 * @return the percentage of the buffer that is filled.
	 */
	public function get bufferPercent():Number
	{
		return Math.min(Math.round( bufferLength / bufferTime * 100 ), 100) ;
	}

	/**
	 * Returns the percentage progress value of the stream. Using duration and time properties.
	 * @return the percentage progress value of the stream.
	 */
	public function get progress():Number
	{
		var percent:Number = Math.round( this.time * 100 / getDuration() ) ;
		return Range.PERCENT_RANGE.clamp( ( isNaN(percent) || !isFinite(percent) ) ? 0 : percent ) ;
	}

	/**
	 * (read-only) Returns the duration of the media.
	 * @return the duration of the media.
	 */
	public function get duration():Number 
	{
		return getDuration() ;	
	}

	/**
	 * (read-only) Returns the value of the isGlobal flag of this model. Use the {@code setGlobal} method to modify this value.
	 * @return {@code true} if the model use a global EventDispatcher to dispatch this events.
	 */
	public function get isGlobal():Boolean 
	{
		return getIsGlobal() ;
	}

	/**
	 * Allows the registration of event listeners on the event target.
	 * @param eventName A string representing the event type to listen for. If eventName value is "ALL" addEventListener use addGlobalListener
	 * @param listener The object that receives a notification when an event of the specified type occurs. This must be an object implementing the {@code EventListener} interface.
	 * @param useCapture Determinates if the event flow use capture or not.
	 * @param priority Determines the priority level of the event listener.
	 * @param autoRemove Apply a removeEventListener after the first trigger
	 */
	public function addEventListener( eventName:String, listener:EventListener, useCapture:Boolean, priority:Number, autoRemove:Boolean):Void 
	{
		_dispatcher.addEventListener.apply(_dispatcher, arguments);
	}

	/**
	 * Allows the registration of global event listeners on the event target.
	 * 
	 * @param listener The object that receives a notification when an event of the specified type occurs. This must be an object implementing the <b>EventListener</b> interface.
	 * @param priority Determines the priority level of the event listener.
	 * @param autoRemove Apply a removeEventListener after the first trigger
	 */
	public function addGlobalEventListener(listener:EventListener, priority:Number, autoRemove:Boolean):Void 
	{
		_dispatcher.addGlobalEventListener(listener, priority, autoRemove) ;
	}

	/**
	 * Dispatches an event into the event flow.
	 * @param event The Event object that is dispatched into the event flow.
	 * @param isQueue if the EventDispatcher isn't register to the event type the event is bufferized.
	 * @param target the target of the event.
	 * @param contect the context of the event.
	 * @return the reference of the event dispatched in the event flow.
	 */
	public function dispatchEvent(event, isQueue:Boolean, target, context):Event 
	{
		return _dispatcher.dispatchEvent(event, isQueue, target, context) ;
	}

	/**
	 * Returns the internal {@code EventDispatcher} reference.
	 * @return the internal {@code EventDispatcher} reference.
	 */
	public function getEventDispatcher():EventDispatcher 
	{
		return _dispatcher ;
	}

	/**
	 * Returns the {@code EventListenerCollection} of the specified event name.
	 * @return the {@code EventListenerCollection} of the specified event name.
	 */
	public function getEventListeners(eventName:String):EventListenerCollection 
	{
		return _dispatcher.getEventListeners(eventName) ;
	}

	/**
	 * Returns the duration of the loader.
	 * @return the duration of the loader.
	 */
	public function getDuration():Number 
	{
		return isNaN(_duration) ? 0 : _duration ;
	}

	/**
	 * Returns the {@code EventListenerCollection} of this EventDispatcher.
	 * @return the {@code EventListenerCollection} of this EventDispatcher.
	 */
	public function getGlobalEventListeners():EventListenerCollection 
	{
		return _dispatcher.getGlobalEventListeners() ;
	}

	/**
	 * Returns the {@code id} of this object.
	 * @return the {@code id} of this object.
	 */
	public function getID() 
	{
		return _id ;
	}
	
	/**
	 * Returns the value of the isGlobal flag of this model.
	 * @return {@code true} if the model use a global EventDispatcher to dispatch this events.
	 */
	public function getIsGlobal():Boolean 
	{
		return _isGlobal ;
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
	 * Returns the {@code FLVMetaData} of the current FLV video.
	 * @return the {@code FLVMetaData} of the current FLV video.
	 */
	public function getMetaData():FLVMetaData 
	{
		return _oMetaData ;	
	}

	/**
	 * Returns the EventDispatcher parent reference of this instance.
	 * @return the EventDispatcher parent reference of this instance.
	 */
	public function getParent():EventDispatcher 
	{
		return _dispatcher.parent ;
	}

	/**
	 * Returns a {@code Set} of all register event's name in this EventListener.
	 * @return a {@code Set} of all register event's name in this EventListener.
	 */	
	public function getRegisteredEventNames():Set 
	{
		return _dispatcher.getRegisteredEventNames() ;
	}

	/**
	 * Checks whether the EventDispatcher object has any listeners registered for a specific type of event.
	 * This allows you to determine where altered handling of an event type has been introduced in the event flow heirarchy by an EventDispatcher object.
	 */ 
	public function hasEventListener(eventName:String):Boolean 
	{
		return _dispatcher.hasEventListener(eventName) ;
	}	

	/**
	 * Returns a hash code value for the object.
	 * @return a hash code value for the object.
	 */
	public function hashCode():Number 
	{
		return null ;
	}
	
	/**
	 * This method is invoqued in the constructor of the class to initialize all events.
	 * Overrides this method.
	 */
	public function initEvent():Void
	{

	}
	
	/**
	 * Creates and returns the internal {@code EventDispatcher} reference (this method is invoqued in the constructor).
	 * You can overrides this method if you wan use a global {@code EventDispatcher} singleton.
	 * @return the internal {@code EventDispatcher} reference.
	 */
	public function initEventDispatcher():EventDispatcher 
	{
		return new EventDispatcher(this) ;
	}

	/**
	 * Notify an CuePointEvent object with the specified info object in argument.
	 * @param info the primitive CuePoint information object.
	 * @see CuePoint
	 * @see CuePointEvent
	 */
	public function notifyCuePoint( info:Object ):Void
	{
		dispatchEvent( new CuePointEvent( CuePointEvent.INFO, this, info ) ) ;	
	}

	/** 
	 * Removes a listener from the EventDispatcher object.
	 * If there is no matching listener registered with the {@code EventDispatcher} object, then calling this method has no effect.
	 * @param Specifies the type of event.
	 * @param the class name(string) or a {@code EventListener} object.
	 */
	public function removeEventListener(eventName:String, listener, useCapture:Boolean):EventListener 
	{
		return _dispatcher.removeEventListener(eventName, listener, useCapture) ;
	}

	/** 
	 * Removes a global listener from the EventDispatcher object.
	 * If there is no matching listener registered with the EventDispatcher object, then calling this method has no effect.
	 * @param the string representation of the class name of the EventListener or a EventListener object.
	 */
	public function removeGlobalEventListener( listener ):EventListener 
	{
		return _dispatcher.removeGlobalEventListener(listener) ;
	}
	

	/**
	 * Sets the duration property.
	 */
	public function setDuration(n:Number):Void 
	{
		_duration = (n>0) ? n : 0 ;
	}

	/**
	 * Sets the internal {@code EventDispatcher} reference.
	 */
	public function setEventDispatcher( e:EventDispatcher ):Void 
	{
		_dispatcher = e || initEventDispatcher() ;
	}

	/**
	 * Sets if the model use a global {@code EventDispatcher} to dispatch this events, if the {@code flag} value is {@code false} the model use a local EventDispatcher.
	 * @param flag the flag to use a global event flow or a local event flow.
	 * @param channel the name of the global event flow if the {@code flag} argument is {@code true}.  
	 */
	public function setGlobal( flag:Boolean , channel:String ):Void 
	{
		_isGlobal = flag ;
		setEventDispatcher( flag ? EventDispatcher.getInstance( channel ) : null ) ;
	}

	/**
	 * Sets the {@code id} of this Stream object.
	 */
	public function setID( id ):Void 
	{
		_setID( id ) ;
	}

	/**
	 * Sets the internal {@code ILogger} reference of this {@code ILogable} object.
	 */
	public function setLogger( log:ILogger ):Void 
	{
		_logger = log ;
	}
	
	/**
	 * Sets the parent EventDispatcher reference of this instance.
	 */
	public function setParent(parent:EventDispatcher):Void 
	{
		_dispatcher.parent = parent ;
	}
	
	/**
	 * Sets the play activity of the loader.
	 */
	public function setPlaying(b:Boolean):Void 
	{
		_isPlaying = b ;
	}

	/**
	 * Stops the currently playing and returns to the begining of the stream. 
	 */
	public function stop():Void
	{
		this.pause( true ) ;
		this.seek( 0 ) ;
	}

	/**
	 * Returns the string representation of the object.
	 * @return the string representation of the object.
	 */
	public function toString():String
	{
		return "[" + ConstructorUtil.getName(this) + "]" ;	
	}
	
	private var _dispatcher:EventDispatcher ;
	
	private var _duration:Number ;
	private var _id ;
	private var _isGlobal:Boolean ;
	private var _isPlaying:Boolean = false ;
	private var _logger:ILogger ;
	private var _oMetaData:FLVMetaData ;

	/**
	 * Invoked when an embedded cue point is reached while playing an FLV file.
	 */
	private function onCuePoint( info:Object ):Void
	{
		notifyCuePoint( info ) ;
	}

	/**
	 * Invoqued when the onMetaData changed.
	 */
	private function onMetaData( info:Object ):Void 
	{

		for (var props in info) 
		{
			getLogger().info( this + " onMetaData, " + props + " : " + info[props]) ;
		}
		
		_oMetaData = new FLVMetaData(info) ;
		
		setDuration( isNaN(info.duration) ? 0 : parseInt(info.duration) ) ;
		
	}

	/**
	 * Invoked when a NetStream object has completely played a stream.
	 */
	private function onPlayStatus( oInfo:Object ):Void
	{
		getLogger().info( this + " play status code:" + oInfo.code + " , level:" + oInfo.level ) ;
	}

	/**
	 * Invoqued when the stream status change.
	 */
	private function _onStreamStatus( oInfo:Object ):Void
	{
		
		getLogger().info( this + " status code: " + oInfo.code + " , level:" + oInfo.level ) ;
		
		switch ( oInfo.code )
		{
			
			case NetStreamStatus.PLAY_PUBLISH.toString() :
			{
				break ;
			}
			case NetStreamStatus.PLAY_RESET.toString() :
			{
				break ;
			}
			case NetStreamStatus.PLAY_START.toString() : 
			{
				break ;
			}
			case NetStreamStatus.PLAY_STOP.toString() : 
			{
				break ;
			}
			case NetStreamStatus.PLAY_STREAM_NOT_FOUND.toString() :
			{
				break ;	
			}
			case NetStreamStatus.PLAY_UNPUBLISH.toString() :
			{
				break ;	
			}
			case NetStreamStatus.UNPUBLISH_SUCCESS.toString() :
			{
				break ;
			}	

		}

	}
	
	/**
	 * Internal method to register the Stream in the StreamCollector with the specified id in argument.
	 * @see StreamCollector.
	 */
	private function _setID( id ):Void 
	{
		if ( StreamCollector.contains( this._id ) )
		{
			StreamCollector.remove( this._id ) ;
		}
		this._id = id ;
		if (this._id != null)
		{
			StreamCollector.insert ( this._id, this ) ;
		}
	}

}