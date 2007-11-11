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
  
 */

import asgard.events.LoaderEvent;
import asgard.net.ParserLoader;

/**
 * This event is used in the ConfigLoader class.
 * @author eKameleon
 * @version 1.0.0.0
 */
 class asgard.events.ConfigLoaderEvent extends LoaderEvent 
 {

	/**
	 * Creates a new ConfigLoaderEvent instance.
	 */
	public function ConfigLoaderEvent( type : String, loader:ParserLoader, p_code:Number, p_error:String, context, bubbles:Boolean, eventPhase:Number, time:Number, stop:Number ) 
	{
		super(type, loader, p_code, p_error, context, bubbles, eventPhase, time, stop);
	}
	
	/**
	 * The type name of this event when notify a change.
	 */
	public static var CHANGE:String = "change" ;
	
	/**
	 * Returns a shallow copy of this object.
	 * @return a shallow copy of this object.
	 */
	public function clone() 
	{
		return new ConfigLoaderEvent( getType(), ParserLoader(getLoader())) ;
	}
	
	/**
	 * Returns the config reference of this event.
	 * @return the config reference of this event.
	 */
	public function getConfig() 
	{
		return getTarget()["getConfig"]() ;	
	}
	
}