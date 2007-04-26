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

import asgard.display.ConfigurableDisplayObject;

import pegas.draw.IPen;
import pegas.draw.RectanglePen;
import pegas.events.UIEvent;
import pegas.events.UIEventType;

import vegas.util.MathsUtil;

/**
 * This display is used to create a background in your application or in an other display of the application.
 * @author eKameleon
 */
class asgard.display.BackgroundDisplay extends ConfigurableDisplayObject 
{

	/**
	 * Creates a new BackgroundDisplay instance.
	 * @param sName:String the name of the display.
	 * @param target:MovieClip the DisplayObject instance control this target.
	 */
	public function BackgroundDisplay(sName : String, target) 
	{
		
		super(sName, target);
	
		background = view.createEmptyMovieClip( "background", 0 ) ;

		_bgDraw  = new RectanglePen(background) ;
		_eResize = new UIEvent( UIEventType.RESIZE , this) ;
		
	}
	
	/**
	 * The background reference of this display.
	 */
	public var background:MovieClip ;

	/**
	 * (read-only) Returns the virtual height value of this component.
	 * @return the virtual height value of this component.
	 */
	public function get h():Number 
	{
		return getH() ;	
	}

	/**
	 * (read-only) Sets the virtual width value of this component.
	 */
	public function set h( n:Number ):Void 
	{
		setH( n ) ;	
	}

	/**
	 * This property defined the mimimun height of this component.
	 */
	public var minHeight:Number ;

	/**
	 * This property defined the mimimun width of this component.
	 */
	public var minWidth:Number ;

	/**
	 * This property defined the maximum width of this component.
	 */
	public var maxWidth:Number ;
	
	/**
	 * This property defined the maximum height of this component.
	 */
	public var maxHeight:Number ;

	/**
	 * The alpha value of the screen.
	 */
	public var themeAlpha:Number = 100 ;

	/**
	 * The color value of the screen.
	 */
	public var themeColor:Number = 0x000000 ;

	/**
	 * (read-only) Returns the virtual width value of this component.
	 * @return the virtual width value of this component.
	 */
	public function get w():Number 
	{ 
		return getW() ;	
	}
	
	/**
	 * (read-only) Sets the virtual width value of this component.
	 */
	public function set w( n:Number ):Void 
	{
		setW( n ) ;	
	}

	 /**
	  * Draw the display.
	  */
	 public function draw():Void
	 {
	 	_bgDraw.clear() ;
		_bgDraw.beginFill( themeColor, themeAlpha) ;
		_bgDraw.draw( w, h ) ;
		_bgDraw.endFill() ;
	 }

	/**
	 * (read-only) Returns the virtual height value of this component.
	 * @return the virtual height value of this component.
	 */
	public function getH():Number 
	{ 
		return isNaN(_h) ? 0 : _h ;
	}

	/**
	 * (read-only) Returns the virtual width value of this component.
	 * @return the virtual width value of this component.
	 */
	public function getW():Number 
	{ 
		return isNaN(_w) ? 0 : _w ;
	}
	
	/**
	 * Notify an event when you resize the component.
	 */
	public function notifyResized():Void 
	{
		dispatchEvent(_eResize) ;
	}
	
	/**
	 * Sets the virtual height value of the component.
	 */
	public function setH( n:Number ) : Void 
	{
		_h = MathsUtil.clamp(n, minHeight, maxHeight) ;
		notifyResized() ;
		update() ;
	}


	/**
	 * Sets the virtual width and height values of the component.
	 */
	public function setSize( w:Number, n:Number ) : Void 
	{
		_w = MathsUtil.clamp(n, minWidth, maxWidth) ;
		_h = MathsUtil.clamp(n, minHeight, maxHeight) ;
		notifyResized() ;
		update() ;
	}
	
	/**
	 * Sets the virtual width value of the component.
	 */
	public function setW( n:Number ):Void 
	{
		_w = MathsUtil.clamp(n, minWidth, maxWidth) ; 
		notifyResized() ;
		update() ;
	}

	/**
	 * Update the display.
	 */	
	/*override*/ public function update():Void 
	{
		if ( isLocked() ) 
		{
			return ;
		}
		draw() ;
		viewChanged() ;
	}
	
	/**
	 * This method is invoqued after the draw() method in the update() method.
	 * Overrides this method.
	 */
	public function viewChanged():Void
	{
		// overrides
	}
	
	/**
	 * The internal pen to draw the background of the display.
	 */
	private var _bgDraw:IPen ;

	private var _eResize:UIEvent ;

	private var _h:Number ;
	
	private var _w:Number ;

}