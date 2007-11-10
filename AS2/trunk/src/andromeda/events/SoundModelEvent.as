﻿/*

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
  
*/

import andromeda.media.SoundModel;

import vegas.core.Identifiable;
import vegas.events.BasicEvent;

/**
 * The SoundModelEvent class.
 * @author eKameleon
 */
class andromeda.events.SoundModelEvent extends BasicEvent implements Identifiable
{

	/**
	 * Creates a new SoundModelEvent instance.
	 * @param type the string type of the instance. 
	 * @param model The SoundModel reference of this event.
	 * @param id The sound id of this event.
	 * @param sound The {@code Sound} reference of this event.
	 * @param url th 
	 * @param context the optional context object of the event.
	 * @param bubbles indicates if the event is a bubbling event.
	 * @param eventPhase the current EventPhase of the event.
	 * @param time this parameter is used in the Eden deserialization.
	 * @param stop this parameter is used in the Eden deserialization.
	 * 
	 */	
	public function SoundModelEvent(type:String, model:SoundModel, id:String, sound:Sound, url:String, context, bubbles:Boolean, eventPhase:Number, time:Number, stop:Number) 
	{
		super(type, model ,context, bubbles, eventPhase, time, stop );
		_id    = id ;
		_model = model ;
		_sound = sound ;
		_url   = url ; 
	}

	/**
	 * The name of the SoundModelEvent when a new Sound is added in a SoundModel instance.
	 */
	public static var ADD_SOUND:String = "onAddSound" ;

	/**
	 * The name of the SoundModelEvent when all the sounds in the SoundModel are removed.
	 */
	public static var CLEAR_SOUND:String = "onClearSound" ;

	/**
	 * The type of the event when the sound is complete.
	 */
	public static var COMPLETE_SOUND:String = "onCompleteSound" ;

	/**
	 * The type of the event when all sounds are enabled in the model.
	 */
	public static var ENABLE_SOUNDS:String = "onEnabledSounds" ;

	/**
	 * The type of the event when all sounds are disabled in the model.
	 */
	public static var DISABLE_SOUNDS:String = "onDisabledSounds" ;
	
	/**
	 * The type of the event when a sound id3 is notify.
	 */
	public static var ID3_SOUND:String = "onID3Sound" ; 
	
	/**
	 * The type of the event when a sound is loading.
	 */
	public static var LOAD_SOUND:String = "onLoadSound" ; 

	/**
	 * The name of the SoundModelEvent when a Sound is removed in a SoundModel instance.
	 */
	public static var REMOVE_SOUND:String = "onRemoveSound" ; 

	/**
	 * The success boolean value if the SoundModelEvent type is 'LOAD_SOUND'.
	 */
	public var success:Boolean = null ;

	/**
	 * Returns the id of the sound reference in the model.
	 * @return the id of the sound reference in the model.
	 */
	public function getID()
	{
		return _id ;	
	}

	/**
	 * Returns the model reference of this event.
	 * @return the model reference of this event.
	 */
	public function getModel():SoundModel
	{
		return _model ;	
	}
	
	/**
	 * Returns the sound reference.
	 * @return the sound reference.
	 */
	public function getSound():Sound
	{
		return _sound ;	
	}
	
	/**
	 * Returns the url of the sound reference if this sound is an external sound.
	 * @return the url of the sound reference if this sound is an external sound.
	 */
	public function getUrl():String
	{
		return _url ;	
	}

	/**
	 * Sets the id of the sound reference.
	 */
	public function setID( id ):Void
	{
		_id = id ;	
	}

	/**
	 * Sets the model reference of this event.
	 */
	public function setModel( model:SoundModel ):Void
	{
		_model = model ;	
	}

	/**
	 * Sets the sound reference.
	 */
	public function setSound( s:Sound ):Void
	{
		_sound = s ;	
	}

	/**
	 * Sets the url of the sound reference if this sound is an external sound.
	 */
	public function setUrl(sURL:String):Void
	{
		_url = sURL ;	
	}

	/**
	 * Id of the sound in the model.
	 */
	private var _id:String ;
	
	/**
	 * The model reference of this event.
	 */
	private var _model:SoundModel ;
	
	/**
	 * Internal Sound reference.
	 */
	private var _sound:Sound ;
	
	/**
	 * Internal url of the Sound reference.
	 */
	private var _url:String ;

}