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

/** Bitmap
	
	AUTHOR
	
		Name : Bitmap
		Package : asgard.display
		Version : 1.0.0.0
		Date :  2006-08-25
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	PROPERTY SUMMARY
	
		- bitmapData:BitmapData [R/W]

		- container:MovieClip [Read Only]
	
		- enabled:Boolean [R/W]
		
		- height:Number [R/W]
			
		- pixelSnapping:String [R/W]
	
		- smoothing:Boolean [R/W]
		
		- view
		
		- width:Number [R/W]

	METHOD SUMMARY

	 	- clear():Void
	
 		- createChild( c:Function, name:String , depth:Number , init )
		
		- dispose():Void
	
		- getBitmapData():BitmapData()
	
		- getEnabled():Boolean
		
		- getLoader():ILoader
		
		- getName():String
			
		- getPixelSnapping():String
	
		- getSmoothing():Boolean
		
		- getWidth():Number
		
		- getX():Number
		
		- getY():Number
		
		- hide():Void
		
		- isVisible():Boolean
		
		- move( x:Number, y:Number ) : Void 
		
		- release() : Void

		- setBitmapData(bmp:BitmapData):Void
	
		- setPixelSnapping( snapping:String, noUpdate:Boolean ):Void
	
		- setSmoothing(b:Boolean, noUpdate:Boolean):Void
	
		- setEnabled(b:Boolean):Void
		
		- setHeight( n:Number ) : Void
		
		- setWidth( n:Number ) : Void
		
		- setX( n:Number ) : Void
		
		- setY( n:Number ) : Void
		
		- show():Void
	
		- update():Void
	
	INHERIT
	
		CoreObject → AbstractCoreEventDispatcher → DisplayObject → Bitmap

 	IMPLEMENTS
 
		EventTarget, IEventDispatcher, IFormattable, IHashable, ISerializable

*/

import asgard.display.DisplayObject;
import asgard.display.PixelSnapping;

import flash.display.BitmapData;

/**
 * @author eKameleon
 */
class asgard.display.Bitmap extends DisplayObject 
{
	
	// ----o Constructor
	
	public function Bitmap( sName:String, target:MovieClip, bmp:BitmapData, pixelSnapping:String, smoothing:Boolean ) 
	{
		
		super( sName, target ) ;
		
		_container = view.createEmptyMovieClip("__container__", __CONTAINER_DEPTH__) ;
		
		setPixelSnapping(pixelSnapping, true) ;
		setSmoothing(smoothing, true) ;
		
		setBitmapData(bmp) ;
		
	}
	
	// ----o Public Methods
	
	public function clear():Void
	{
		_container = view.createEmptyMovieClip("__container__", 1000) ;
	}
	
	public function dispose():Void
	{
		_bmp.dispose() ;	
	}
	
	public function getBitmapData():BitmapData
	{
		return _bmp ;	
	}

	public function getPixelSnapping():String
	{
		return _pixelSnapping ; 	
	} 

	public function getSmoothing():Boolean
	{
		return _smoothing ; 	
	} 

	/*override*/ public function release():Void
	{
		super.release() ;
		_container.removeMovieClip() ;	
	}

	public function setBitmapData(bmp:BitmapData):Void
	{
		_bmp = bmp ;
		update() ;	
	}

	public function setPixelSnapping( snapping:String, noUpdate:Boolean ):Void
	{
		_pixelSnapping = snapping ;
		if (noUpdate()) return ;
		update() ;
	} 

	public function setSmoothing(b:Boolean, noUpdate:Boolean):Void
	{
		_smoothing = b ;
		if (noUpdate()) return ;
		update() ; 	
	} 
	
	public function update():Void
	{
		clear() ;
		_container.attachBitmap(_bmp, 1, getPixelSnapping(), getSmoothing()) ;
	}
	
	// ----o Virtual Properties
	
	/**
	 * The BitmapData object being referenced.
	 */
	public function get bitmapData():BitmapData
	{
		return getBitmapData() ;	
	}
	
	public function set bitmapData(bmp:BitmapData):Void
	{
		setBitmapData(bmp) ;	
	}
	
	/**
	 * [Read Only] Returns the bitmap container reference. 
	 */
	public function get container():MovieClip
	{
		return _container ;	
	}
	
	/**
	 * Controls whether or not the Bitmap object is snapped to the nearest pixel. The PixelSnapping class includes possible values :
	 * 
	 *   - PixelSnapping.NEVER — No pixel snapping occurs.
	 *   - PixelSnapping.ALWAYS — The image is always snapped to the nearest pixel, independent of transformation.
	 *   - PixelSnapping.AUTO — The image is snapped to the nearest pixel if it is drawn with no rotation or skew and it is drawn at a scale factor of 99.9% to 100.1%. If these conditions are satisfied, the bitmap image is drawn at 100% scale, snapped to the nearest pixel. Internally, this value allows the image to be drawn as fast as possible using the vector renderer.
	 * 
	 * NB : Only in FP9 & FP8.5
	 */
	public function get pixelSnapping():String
	{
		return getPixelSnapping() ;	
	}

	public function set pixelSnapping( snapping:String ):Void
	{
		setPixelSnapping( snapping ) ;	
	}
	
	/**
	 * Controls whether or not the bitmap is smoothed when scaled. 
	 * If true, the bitmap is smoothed when scaled. If false, the bitmap is not smoothed when scaled. 
	 */ 
	public function get smoothing():Boolean
	{
		return getSmoothing() ;	
	}

	public function set smoothing(b:Boolean):Void
	{
		setSmoothing(b) ;	
	}
		
	// ----o Private Properties
	
	private var _bmp:BitmapData ;
	private var _container:MovieClip ;
	private var _pixelSnapping:String = "auto" ; 
	private var _smoothing:Boolean = false ;
	
	static private var __CONTAINER_DEPTH__:Number = 1000 ;

}