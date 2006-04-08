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

/** DisplayObject

	AUTHOR

		Name : DisplayObject
		Package : asgard.display
		Version : 1.0.0.0
		Date :  2006-03-21
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	PROPERTY SUMMARY
	
		- enabled:Boolean [R/W]
		
		- height:Number [R/W]
		
		- view
		
		- width:Number [R/W]

	METHOD SUMMARY
	
		- createChild( c:Function, name:String , depth:Number , init )
		
		- getEnabled():Boolean
		
		- getLoader():ILoader
		
		- getName():String
		
		- getWidth():Number
		
		- getX():Number
		
		- getY():Number
		
		- hide():Void
		
		- isVisible():Boolean
		
		- move( x:Number, y:Number ) : Void 
		
		- release() : Void
		
		- setEnabled(b:Boolean):Void
		
		- setHeight( n:Number ) : Void
		
		- setWidth( n:Number ) : Void
		
		- setX( n:Number ) : Void
		
		- setY( n:Number ) : Void
		
		- show():Void
	
	INHERIT
	
		CoreObject
			|
			AbstractCoreEventDispatcher
				|
				DisplayObject
					|
					SpeedDisplay

**/

import asgard.display.DisplayLoader;
import asgard.display.DisplayLoaderCollector;
import asgard.display.DisplayObjectCollector;
import asgard.net.ILoader;

import vegas.errors.IllegalArgumentError;
import vegas.events.AbstractCoreEventDispatcher;
import vegas.util.factory.DisplayFactory;
import vegas.util.factory.PropertyFactory;


/**
 * @author eKameleon
 * @version 1.0.0.0
 */

class asgard.display.DisplayObject extends AbstractCoreEventDispatcher {

	// ----o Constructor

    public function DisplayObject( sName:String , target ) {
		
        super() ;

		if (target) {
			
			view = target ;
		
		} else {
			
			_loader = DisplayLoaderCollector.get( sName ) ;
			
			if ( _loader ) {
				
				this.view = _loader.getView() ;
				
			} else {
				
				throw new IllegalArgumentError("invalid arguments for " + this + " constructor.");
				
			}
			
		}
		
		_setName(sName) ;

    }

	// ----o Public Properties

	public var enabled:Boolean ; // [R/W]
	public var height:Boolean ; // [R/W]
	public var view ;
	public var width:Boolean ; // [R/W]

	// ----o Public Methods

	public function createChild( c:Function, name:String , depth:Number , init ) {
		return DisplayFactory.createChild( c , name , depth , view, init ) ;
	}
	
	public function getEnabled():Boolean { 
		return view.enabled ;
	} 
	
	public function getHeight():Number { 
		return view._height ;
	}
	
	public function getLoader():ILoader {
		return _loader ;	
	}
	
	public function getName():String 	{
		return _sName;
	}
	
	public function getWidth():Number { 
		return view._width ;
	}

	public function getX():Number { 
		return view._x ;
	}
	
	public function getY():Number { 
		return view._y ;
	}

	public function hide():Void {
		if (_loader != null) {
			_loader.hide() ;
		} else {
			view._visible = false ;	
		}
	}

	public function isVisible():Boolean {
		return (view._visible = true) ;	
	}

	public function move( x:Number, y:Number ) : Void {
		view._x = x ;
		view._y = y ;
	}

	public function release() : Void {
		DisplayObjectCollector.remove( _sName );
		view.removeMovieClip() ;
		_loader.release() ;
		delete _sName ;
	}
	
	public function setEnabled(b:Boolean):Void {
		view.enabled = (b == true) ; 
	}

	public function setHeight( n:Number ) : Void {
		view._height = n ; 
	}

	public function setWidth( n:Number ) : Void {
		view._width = n ; 
	}

	public function setX( n:Number ) : Void {
		view._x = n ; 
	}
	
	public function setY( n:Number ) : Void {
		view._y = n ; 
	}
	
	public function show():Void {
		if (_loader != null) {
			_loader.show() ;
		} else {
			view._visible = true ;	
		}
	}
	
	// ----o Virtual Properties
	
	static private var __ENABLED__:Boolean = PropertyFactory.create(DisplayObject, "enabled", true) ;
	static private var __HEIGHT__:Boolean = PropertyFactory.create(DisplayObject, "height", true) ;
	static private var __WIDTH__:Boolean = PropertyFactory.create(DisplayObject, "width", true) ;	
	static private var __X__:Boolean = PropertyFactory.create(DisplayObject, "x", true) ;
	static private var __Y__:Boolean = PropertyFactory.create(DisplayObject, "y", true) ;	
	
	// ----o Private Properties
	
	private var _loader:DisplayLoader = null ; 
	private var _sName:String = null ;
	
	// ----o Private Methods
	
	private function _setName( name:String ) : Void {

		DisplayObjectCollector.remove( _sName ) ;
		
		_sName = name ;
		
		DisplayObjectCollector.insert ( _sName, this ) ;
		
	}
	
}
