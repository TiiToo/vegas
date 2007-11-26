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

import andromeda.util.mvc.AbstractModel;

import asgard.config.ConfigCollector;
import asgard.config.IConfigurable;

import vegas.errors.Warning;

/**
 * This core class extend the AbstractModel class and implement the IConfigurable interface.
 * A IConfigurable object handle a notification of the ConfigCollector class with the method setup(), you must override this method in your concrete class.
 * The IConfigurable objects are registered in the ConfigCollector to launch the setup of all IConfigurable object one time with the {@code ConfigCollector.run()} method when the Config is loaded for example. 
 * @author eKameleon
 */
class asgard.config.ConfigurableModel extends AbstractModel implements IConfigurable
{
	
	/**
	 * Creates a new ConfigurableModel instance.
	 */
	function ConfigurableModel() 
	{
		isConfigurable = true ;
	}
	
	/**
	 * (read-write) Returns {@code true} if the object is configurable and receive the notification of the ConfigCollector in the setup() method.
	 * @return {@code true} if the object is configurable and receive the notification of the ConfigCollector.
	 */
	public function get isConfigurable():Boolean
	{
		
		return _isConfigurable ;
			
	}

	/**
	 * (read-write) Sets if the object is configurable and receive the notification of the ConfigCollector in the setup() method.
	 * @param b the flag boolean value to define if the object is configurable.
	 */
	public function set isConfigurable(b:Boolean):Void
	{
		_isConfigurable = (b == true) ;
		if (_isConfigurable)
		{
			ConfigCollector.insert(this) ;	
		}
		else
		{
			ConfigCollector.remove(this) ;
		}
	}

	/**
	 * Invoqued when this object when the ConfigCollector is run.
	 * Overrides this method.
	 */
	 public function setup():Void
	 {
	 	throw new Warning(this + " setup() method can't be invoqued, you must override this method !") ;
	 }
	
	/**
	 * Determinates if the object is configurable.
	 */
	 private var _isConfigurable:Boolean ;
}