/*

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
import asgard.display.ConfigurableDisplayObject;

import pegas.draw.FillType;
import pegas.draw.IPen;
import pegas.draw.RectanglePen;
import pegas.events.UIEvent;
import pegas.geom.Dimension;
import pegas.geom.TransformMatrix;

import vegas.util.MathsUtil;

/**
 * This display is used to create a background in your application or in an other display of the application.
 * @author eKameleon
 */
class asgard.display.BackgroundDisplay extends ConfigurableDisplayObject 
{

	/**
	 * Creates a new BackgroundDisplay instance.
	 * @param sName the name of the display.
	 * @param target the DisplayObject instance control this target.
	 * @param bGlobal the flag to use a global event flow or a local event flow.
	 * @param sChannel the name of the global event flow if the {@code bGlobal} argument is {@code true}.
	 */
	public function BackgroundDisplay( sName:String , target , bGlobal:Boolean , sChannel:String ) 
	{
		super( sName, target, bGlobal, sChannel );
		background = view.createEmptyMovieClip( DEFAULT_BACKGROUND_NAME , DEFAULT_BACKGROUND_DEPTH ) ;
		initEvent() ;
		_bgDraw  = initBackgroundPen() ;
	}
	
	/**
	 * The depth of the canvas MovieClip reference.
	 */
	public static var DEFAULT_BACKGROUND_DEPTH:Number = 0 ;

	/**
	 * The name of the canvas MovieClip reference.
	 */
	public static var DEFAULT_BACKGROUND_NAME:String = "background" ;
	
	/**
	 * The array of alphas value to draw the background.
	 */	
	public var alphas:Array = [ 100, 100 ] ;
	
	/**
	 * The background reference of this display.
	 */
	public var background:MovieClip ;
	
	/**
	 * (read-only) Returns the real bounds Dimension value of this background.
	 * This Dimension object contains the real width and height value of the background 
	 * (important if the user use the {@code isFull} property for example).
	 * @return the real bounds Dimension value of this background.
	 */
	public function get bounds():Dimension
	{
		return _real ;	
	}
	
	/**
	 * The array of colors value to draw the background.
	 */
	public var colors:Array = [ 0 , 0 ] ;
	
	/**
	 * The rotation value to draw the linearGradientFill when draw the background.
	 */
	public var gradientRotation:Number = 90  ;

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
	 * (read-write) Returns {@code true} if the background use full size (Stage.width and Stage.height).
	 * @return {@code true} if the background use full size (Stage.width and Stage.height).
	 */
	public function get isFull():Boolean
	{
		return getIsFull() ;
	}

	/**
	 * Sets if the background use full size (Stage.width and Stage.height).
	 * @param b A boolean flag to indicates if the display use full size or not.
	 */
	public function set isFull(b:Boolean):Void
	{
		setIsFull(b) ;
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
	 * The array of ratios value to draw the background.
	 */
	public var ratios:Array = [ 0 , 100 ] ;
	
	/**
	 * The alpha value of the screen.
	 */
	public var themeAlpha:Number = 100 ;

	/**
	 * The alpha value of the border of this display.
	 */
	public var themeBorderAlpha:Number = null ;

	/**
	 * The color value of the border of this display.
	 */
	public var themeBorderColor:Number = null ;

	/**
	 * The thickness of the border of this display.
	 */
	public var themeBorderThickness:Number = null ;

	/**
	 * The color value of the screen.
	 */
	public var themeColor:Number = 0x000000 ;

	/**
	 * Returns {@code true} if the background use a gradient.
	 * @return {@code true} if the background use a gradient.
	 */
	public function get useGradient():Boolean
	{
		return _useGradient ;
	}

	/**
	 * Sets the background use a gradient flag.
	 */
	public function set useGradient( b:Boolean ) :Void
	{
		_useGradient = b ;
		update() ;
	}

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
	  * @return the Dimension object who defines the width and the height use in the method to draw the background.
	  */
	 public function draw( w:Number , h:Number , offsetX:Number , offsetY:Number ):Dimension
	 {

	 	var $w:Number = isNaN(w) ? getW() : w ;
	 	var $h:Number = isNaN(h) ? getH() : h ;
		
		_bgDraw.clear() ;
		
		if ( !isNaN( themeBorderAlpha ) ) // hack fix MAC FlashPlayer bug
		{
	 		_bgDraw.lineStyle( themeBorderThickness, themeBorderColor, themeBorderAlpha ) ;
		}
		
	 	if( _useGradient )
		{
			var matrix:TransformMatrix = new TransformMatrix() ;
       		matrix.createGradientBox( $w, $h );
        	matrix.rotateD( gradientRotation ) ;
			_bgDraw.beginGradientFill( FillType.LINEAR, colors, alphas, ratios, matrix ) ;
		}
		else
		{
			if ( !isNaN(themeAlpha ) ) // hack fix MAC FlashPlayer bug
			{
				_bgDraw.beginFill( ( isNaN(themeColor) ? 0x000000 : themeColor)  , themeAlpha ) ;
			}
		}
		
		offsetX = isNaN(offsetX) ? 0 : offsetX ;
		offsetY = isNaN(offsetY) ? 0 : offsetY ;
		
		RectanglePen(_bgDraw).draw( $w, $h , offsetX , offsetY ) ;
		_bgDraw.endFill() ;
		
		_real = new Dimension( $w, $h ) ;

		return _real ;

	 }

	/**
	 * Returns the {@code IPen} reference used to draw the background of this display.
	 * @return the {@code IPen} reference used to draw the background of this display.
	 */
	public function getBackgroundPen():IPen
	{
		return _bgDraw ;	
	}
	
	/**
	 * Returns the event name use when the background is resized.
	 * @return the event name use when the background is resized.
	 */
	public function getEventTypeRESIZE():String
	{
		return _eResize.getType() ;	
	}

	/**
	 * Returns {@code true} if the background use full size (Stage.width and Stage.height).
	 * @return {@code true} if the background use full size (Stage.width and Stage.height).
	 */
	public function getIsFull():Boolean
	{
		return _isFull ;
	}

	/**
	 * (read-only) Returns the virtual height value of this component.
	 * @return the virtual height value of this component.
	 */
	public function getH():Number 
	{ 
		return isFull ? Stage.height : _h ;
	}

	/**
	 * (read-only) Returns the virtual width value of this component.
	 * @return the virtual width value of this component.
	 */
	public function getW():Number 
	{ 
		return isFull ? Stage.width : _w ;
	}
	
	/**
	 * Init the pen to draw the background of this display.
	 * This method is invoked in the constructor of the class.
	 * You can override this method to change the shape of the background.
	 * @return the IPen reference to draw the background of the display.
	 */
	public function initBackgroundPen():IPen
	{
		return new RectanglePen(background) ;	
	}

	/**
	 * Init the events of this display.
	 */
	public function initEvent():Void
	{
		_eResize = new UIEvent( UIEvent.RESIZE , this) ;
	}

	/**
	 * Notify an event when you resize the component.
	 */
	public function notifyResized():Void 
	{
		dispatchEvent(_eResize) ;
	}
	
	/**
	 * Sets the event name use when the background is resized.
	 */
	public function setEventTypeRESIZE( type:String ):Void
	{
		_eResize.setType( type ) ;	
	}
	
	/**
	 * Sets if the background use full size (Stage.width and Stage.height).
	 * @param b A boolean flag to indicates if the display use full size or not.
	 */
	public function setIsFull(b:Boolean):Void
	{
		_isFull = b ;
		update() ;
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
	public function setSize( w:Number, h:Number ) : Void 
	{
		_w = MathsUtil.clamp( w , minWidth, maxWidth) ;
		_h = MathsUtil.clamp( h , minHeight, maxHeight) ;
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
	 * This method is invoked after the draw() method in the update() method.
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

	private var _isFull:Boolean = false ;

	private var _real:Dimension ;

	private var _useGradient:Boolean = false ;
	
	private var _w:Number ;
	

}