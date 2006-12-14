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
  Portions created by the Initial Developer are Copyright (C) 2004-2007
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

/** ConfigurableObject
 *
 *	AUTHOR
 *
 *		Name : ConfigurableObject
 *		Package : asgard.config
 *		Version : 1.0.0.0
 *		Date :  2006-08-18
 *		Author : ekameleon
 *		URL : http://www.ekameleon.net
 *		Mail : vegas@ekameleon.net
 *
 *	DESCRIPTION
 *	
 *		Cette classe abstraite permet de créer ou de définir le modèle à implémenter pour créer un objet de type IConfigurable.
 *		Les objets IConfigurable sont stockés dans le ConfigCollector pour lancer une mise à jour massive de tous les objets 
 *		une fois la configuration générale de l'applicatif chargé.
 *		
 *	PROPERTY
 *	
 *		- isConfigurable:Boolean [R/W]
 *		
 *	INHERIT
 * 
 *		CoreObject → AbstractConfigurable
 *		
 * 	IMPLEMENTS
 * 	
 * 		IConfigurable, IFormattable, IHashable, ISerializable
 * 
 *  SEE ALSO
 *  
 *  	InitApplication, IConfigurable, ConfigDisplay...
 *  	
 */	

import asgard.config.ConfigCollector;
import asgard.config.IConfigurable;

import vegas.core.CoreObject;
import vegas.errors.Warning;

/**
 * @author eKameleon
 */
class asgard.config.ConfigurableObject extends CoreObject implements IConfigurable
{

	/**
	 * Constructor
	 * 
	 */
	
	public function ConfigurableObject() 
	{
		
		super();
		
		isConfigurable = true ;
		
	}
	
	/**
	 * Public Methods
	 */
	 
	 public function setup():Void
	 {
	 	throw new Warning("> " + this + ".setup(), you must override this method !") ;
	 }
	
	/**
	 * Virtual Properties
	 */

	public function get isConfigurable():Boolean
	{
		
		return _isConfigurable ;
			
	}
	
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
	 * Private Properties
	 */
	 
	 private var _isConfigurable:Boolean ;
	 
}