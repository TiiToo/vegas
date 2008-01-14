﻿/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is ASGard Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

import vegas.core.CoreObject;

/**
 * The dynamic Config singleton. This object is a global reference to register all external properties.
 * @author eKameleon
 */
dynamic class asgard.config.Config extends CoreObject 
{
	
	/**
	 * Creates a new Config instance.
	 */
	function Config() 
	{
		super();
	}
	
	/**
	 * Returns the singleton reference of this class.
	 * @return the singleton reference of this class.
	 */
	public static function getInstance():Config 
	{
		if( _instance == null )
		{
			_instance = new Config() ;
		}
		return _instance ;
	}
	
	/**
	 * Apply the current Config object over the specified object.
	 * @param o The object to fill with the current Config object.
	 * @param sID (optional) if this key is specified the method return the value of the specified key in the current Config object.
	 * @param callback (optional) The optional method to launch after the initialization over the specified object. 
	 */
	public function init( o:Object , sID:String , callback:Function ):Void
	{
		var init = sID == null ? this : this[ sID ] ;
		for (var prop:String in init)
		{
			o[prop] = init[prop] ;	
		}
		if ( callback != null )
		{
			callback.call(o) ;	
		}
	} 
	
	/**
	 * @private
	 */
	private static var _instance:Config ;

	/**
	 * @private
	 */
	private var prototype ;
	
}