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

import asgard.media.SoundModel;

import vegas.events.ModelChangedEvent;

/**
 * The SoundModelEvent class.
 * @author eKameleon
 * @version 1.0.0.0
 */
class asgard.events.SoundModelEvent extends ModelChangedEvent
{

	/**
	 * Creates a new SoundModelEvent instance.
	 */	
	public function SoundModelEvent(type:String, model:SoundModel, id:String, sound:Sound) 
	{
		super(type);
		_id    = id ;
		_model = model ;
		_sound = sound ;
	}

	/**
	 * The name of the SoundModelEvent when a new Sound is added in a SoundModel instance.
	 */
	static public var ADD_SOUND:String = "onAddSound" ;

	/**
	 * The name of the SoundModelEvent when all the sounds in the SoundModel are removed.
	 */
	static public var CLEAR_SOUND:String = "onClearSound" ;

	/**
	 * The name of the SoundModelEvent when a Sound is removed in a SoundModel instance.
	 */
	static public var REMOVE_SOUND:String = "onRemoveSound" ; 

	/**
	 * Returns the id of the sound reference.
	 */
	public function getID():String
	{
		return _id ;	
	}

	/**
	 * Returns the model reference of this event.
	 */
	public function getModel():SoundModel
	{
		return _model ;	
	}
	
	/**
	 * Returns the sound reference.
	 */
	public function getSound():Sound
	{
		return _sound ;	
	}

	/**
	 * Sets the id of the sound reference.
	 */
	public function setID( sID:String ):Void
	{
		_id = sID ;	
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

}