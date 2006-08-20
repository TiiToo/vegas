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

/** ConfigurableDisplayObject
 *
 *	AUTHOR
 *
 *		Name : ConfigurableDisplayObject
 *		Package : okdak.vesubie.display
 *		Version : 1.0.0.0
 *		Date :  2006-08-18
 *		Author : eKameleon
 *		URL : http://www.ekameleon.net
 *		Mail : vegas@ekameleon.net
 *
 *	PROPERTY SUMMARY
 *		
 *		- enabled:Boolean [R/W]
 *		
 *		- height:Number [R/W]
 *		
 *		- isConfigurable:Boolean [R/W]
 *		
 *		- view
 *
 *		- width:Number [R/W]
 *
 *	METHOD SUMMARY
 *
 *		- createChild( c:Function, name:String , depth:Number , init )
 *
 *		- getEnabled():Boolean
 *
 *		- getLoader():ILoader
 *
 *		- getName():String
 *
 *		- getWidth():Number
 *
 *		- getX():Number
 *
 *		- getY():Number
 *
 *		- hide():Void
 *
 *		- isVisible():Boolean
 *
 *		- move( x:Number, y:Number ) : Void
 *
 *		- release() : Void
 *
 *		- setEnabled(b:Boolean):Void
 *
 *		- setHeight( n:Number ) : Void
 *
 *		- setup():Void
 *		 
 *		- setWidth( n:Number ) : Void
 *
 *		- setX( n:Number ) : Void
 *
 *		- setY( n:Number ) : Void
 *
 *		- show():Void
 *
 *	INHERIT
 *		
 *		CoreObject → AbstractCoreEventDispatcher → DisplayObject → BackgroundDisplay
 *
 *
 *	IMPLEMENTS
 *	 
 *	  	IConfigurable
 *
 */

import asgard.config.ConfigCollector;
import asgard.config.IConfigurable;
import asgard.display.DisplayObject;

import vegas.errors.Warning;

/**
 * @author eKameleon
 */
class asgard.display.ConfigurableDisplayObject extends DisplayObject implements IConfigurable 
{
	
	/**
	 * Constructor
	 */
	
	public function ConfigurableDisplayObject(sName : String, target) 
	{
		
		super(sName, target);
		isConfigurable = true ;
		
	}

	/**
	 * Public Methods
	 */

	public function setup() : Void 
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