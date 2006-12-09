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

import asgard.display.DisplayLoader;
import asgard.display.DisplayLoaderCollector;
import asgard.display.DisplayObjectCollector;
import asgard.net.ILoader;

import vegas.errors.IllegalArgumentError;
import vegas.errors.Warning;
import vegas.events.AbstractCoreEventDispatcher;
import vegas.util.factory.DisplayFactory;

/**
 * The DisplayObject class is the base class for all objects that can be displayed in the Flash Player.
 * <p><b>Example :</b></p>
 * {@code
 * import asgard.display.DisplayObject ;
 * import asgard.display.DisplayObjectCollector ;
 * 
 * var mc:MovieClip = createEmptyMovieClip("display", 1) ;
 * 
 * var UIList = {} ;
 * UIList.CANVAS = "canvas" ;
 * 
 * var dCanvas = new DisplayObject( "canvas", mc ) ;
 * 
 * trace("> DisplayObjectCollector contains canvas : " + DisplayObjectCollector.containsDisplay(canvas))  ;
 * 
 * var contains:Boolean = DisplayObjectCollector.contains(UIList.CANVAS) ;
 * trace("contains 'canvas' DisplayObject : " + contains) ;
 * 
 * var canvas = DisplayObjectCollector.get(UIList.CANVAS) ;
 * canvas.move(25, 25) ;
 * 
 * var square:MovieClip = canvas.view ;
 * square.lineStyle(3, 0xFF0000, 100, true, "none", "square" ) ;
 * square.beginFill(0xF2F10D, 100) ;
 * square.lineTo(150,0) ;
 * square.lineTo(150,150) ;
 * square.lineTo(0,150) ;
 * square.lineTo(0,0) ;
 * 
 * trace("canvas : " + canvas) ;
 * trace("canvas name : '" + canvas.getName() + "'" ) ;
 * trace("The root DisplayObject : " + canvas.root + " : " + canvas.root.view) ;
 * 
 * this.onKeyDown = function ()
 * {
 *     var code:Number = Key.getCode() ;
 *     switch (code)
 *     {
 *         case Key.UP :
 *         {
 *             canvas.hide() ;
 *             trace("canvas idHide : " + canvas.isVisible()) ;
 *             break ;
 *         }
 *         case Key.DOWN :
 *         {
 *             canvas.show() ;
 *             break ;
 *         }
 *         case Key.RIGHT :
 *         {
 *             canvas.rotation = 25 ;
 *             break ;
 *         }
 *         case Key.LEFT :
 *         {
 *             canvas.alpha = 30 ;
 *             break ;
 *         }
 *     }
 * }
 * 
 * Key.addListener(this) ;
 * }
 * @author eKameleon
 */
class asgard.display.DisplayObject extends AbstractCoreEventDispatcher 
{

	/**
	 * Creates a new DisplayObject instance.
	 * @param sName:String the name of the display.
	 * @param target:MovieClip the DisplayObject instance control this target.
	 */
    public function DisplayObject( sName:String , target ) 
    {
        
        super() ;
		
		if (target) 
		{
			view = target ;
		}
		else 
		{
			_loader = DisplayLoaderCollector.get( sName ) ;
			
			if ( _loader ) 
			{
				this.view = _loader.getView() ;
			}
			else 
			{
				throw new IllegalArgumentError("invalid arguments for " + this + " constructor.");
			}
		}
		
		_setName(sName) ;

    }
    
	/**
	 * [read-only] Indicates the alpha value of the display.
	 */
	public function get alpha():Number 
	{
		return view._alpha ;	
	}

	/**
	 * [read-only] Sets the alpha value of the display.
	 */
	public function set alpha( n:Number ):Void 
	{
		view._alpha = n ;	
	}

	/**
	 * (read-write) Returns 'true' if the display is enabled.
	 */
	public function get enabled():Boolean 
	{
		return getEnabled() ;	
	}

	/**
	 * (read-write) Sets the display enabled state.
	 */
	public function set enabled(b:Boolean):Void 
	{
		setEnabled(b) ;	
	}

	/**
	 * (read-write) Returns the height of the display's view.
	 */
	public function get height():Number 
	{
		return getHeight() ;	
	}

	/**
	 * (read-write) Sets the height of the display's view.
	 */
	public function set height(n:Number):Void 
	{
		setHeight(n) ;	
	}

	/**
	 * [read-only] Indicates the x coordinate of the mouse position, in pixels.
	 */
	public function get mouseX():String 
	{
		return view._xmouse ;	
	}

	/**
	 * [read-only] Indicates the y coordinate of the mouse position, in pixels.
	 */
	public function get mouseY():String 
	{
		return view._ymouse ;	
	}

	/**
	 * [read-write] Indicates the instance name of the DisplayObject.
	 */
	public function get name():String 
	{
		return _sName ;
	}

	/**
	 * [read-write] Set the instance name of the DisplayObject.
	 */
	public function set name( sName:String ):Void 
	{
		_setName( sName ) ;
	}

	/**
	 * [read-only] For a display object in a loaded SWF file, the root property is the top-most display object in the portion of the display list's tree structure represented by that SWF file.
	 */
	public function get root():DisplayObject
	{
		return __ROOT__ ;
	}

	
	/**
	 * [read-write] Indicates the rotation value of the DisplayObject.
	 */
	public function get rotation():Number
	{
		return view._rotation ;
	}
	
	/**
	 * [read-write] Sets the rotation value of the DisplayObject.
	 */
	public function set rotation(n:Number):Void
	{
		view._rotation = n ;
	}

	/**
	 * The view of the display.
	 */
	public var view ;
	
	/**
	 * (read-write) Sets the width of the display's view.
	 */
	public function get width():Number 
	{
		return getWidth() ;	
	}

	/**
	 * (read-write) Returns the width of the display's view.
	 */
	public function set width(n:Number):Void 
	{
		setWidth(n) ;	
	}

	/**
	 * (read-write) Returns the x position of the display's view.
	 */
	public function get x():Number 
	{
		return getX() ;	
	}

	/**
	 * (read-write) Sets the x position of the display's view.
	 */
	public function set x(n:Number):Void 
	{
		setX(n) ;	
	}
	
	/**
	 * (read-write) Returns the y position of the display's view.
	 */
	public function get y():Number 
	{
		return getY() ;	
	}

	/**
	 * (read-write) Sets the y position of the display's view.
	 */
	public function set y(n:Number):Void 
	{
		setY(n) ;	
	}

	/**
	 * Create a new child in the view of the display.
	 * @see DisplayFactory.createChild
	 */
	public function createChild( o , name:String , depth:Number , init ) 
	{
		return DisplayFactory.createChild( o , name , depth , view, init ) ;
	}
	
	/**
	 * Returns true if the display's view is enabled.
	 */
	public function getEnabled():Boolean 
	{ 
		return view.enabled ;
	} 
	
	/**
	 * Returns the height of the display's view.
	 */
	public function getHeight():Number 
	{ 
		return view._height ;
	}
	
	/**
	 * Returns the loader of the display.
	 */
	public function getLoader():ILoader 
	{
		return _loader ;	
	}
	
	/**
	 * Returns the name of the display.
	 */
	public function getName():String
	{
		return _sName;
	}

	/**
	 * Returns the width of the display's view.
	 */
	public function getWidth():Number 
	{ 
		return view._width ;
	}

	/**
	 * Return the x position of the display.
	 */
	public function getX():Number 
	{ 
		return view._x ;
	}

	/**
	 * Returns the y position of the display.
	 */
	public function getY():Number 
	{ 
		return view._y ;
	}

	/**
	 * Hide the display.
	 */
	public function hide():Void 
	{
		if (_loader != null) 
		{
			_loader.hide() ;
		}
		else 
		{
			view._visible = false ;	
		}
	}

	/**
	 * Returns 'true' if the display is visible.
	 */
	public function isVisible():Boolean 
	{
		return view._visible  ;	
	}

	/**
	 * Move the display in a new position.
	 * @param x:Number the new x position of the display.
	 * @param y:Number the new y position of the display.
	 */ 
	public function move( x:Number, y:Number ) : Void 
	{
		view._x = x ;
		view._y = y ;
	}

	/**
	 * Release the view of the display.
	 */
	public function release() : Void 
	{
		DisplayObjectCollector.remove( _sName );
		view.removeMovieClip() ;
		_loader.release() ;
		delete _sName ;
	}
	
	/**
	 * Sets the enabled state of the display.
	 */
	public function setEnabled(b:Boolean):Void 
	{
		view.enabled = (b == true) ; 
	}

	/**
	 * Sets the height of the display.
	 */
	public function setHeight( n:Number ) : Void 
	{
		view._height = n ; 
	}

	/**
	 * Sets the width of the display.
	 */
	public function setWidth( n:Number ) : Void 
	{
		view._width = n ; 
	}

	/**
	 * Sets the x position of the display.
	 */
	public function setX( n:Number ) : Void 
	{
		view._x = n ; 
	}
	
	/**
	 * Sets the y position of the display.
	 */
	public function setY( n:Number ) : Void 
	{
		view._y = n ; 
	}
	
	/**
	 * Returns an instance in a visual DisplayObject if exist else throws a Warning.
	 * @throws Warning
	 */
	public function resolve( name:String )
	{
		if ( view[name] )
		{
			return view[name] ;
		}
		else
		{
			throw new Warning( this + " resolve failed with the view : '" + name );
		}
	}
	
	/**
	 * Show the display instance.
	 */
	public function show():Void 
	{
		if (_loader != null) 
		{
			_loader.show() ;
		}
		else 
		{
			view._visible = true ;	
		}
	}
	
	/**
	 * The internal loader of the display.
	 */	
	private var _loader:DisplayLoader = null ; 
	
	/**
	 * The parent DisplayObject of this DisplayObject.
	 */
	private var _parent:DisplayObject ;
	
	/**
	 * Defined the root DisplayObject.
	 */
	static private var __ROOT__:DisplayObject = new DisplayObject( "root" , _root ) ;
	
	/**
	 * The internal name's property of the display.
	 */
	private var _sName:String = null ;
	
	/**
	 * Internal method to sets the name of the display and register this display in the DisplayObjectCollector.
	 * @see DisplayObjectCollector
	 */
	private function _setName( name:String ) : Void 
	{

		DisplayObjectCollector.remove( _sName ) ;
		
		_sName = name ;
		
		DisplayObjectCollector.insert ( _sName, this ) ;
		
	}
	
}
