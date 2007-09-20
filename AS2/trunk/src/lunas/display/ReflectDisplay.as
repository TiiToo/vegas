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
import asgard.display.GradientType;
import asgard.display.SpreadMethod;

import flash.display.BitmapData;
import flash.geom.Matrix;

import lunas.core.Iconifiable;

import pegas.draw.RectanglePen;
import pegas.events.UIEvent;
import pegas.geom.Dimension;

import vegas.util.ConstructorUtil;

/**
 * This display contains an icon and this reflection view.
 * @author eKameleon
 */
class lunas.display.ReflectDisplay extends ConfigurableDisplayObject implements Iconifiable
{
	
	/**
	 * Creates a new ReflectDisplay instance.
	 * @param sName the name of the display.
	 * @param target the DisplayObject instance control this target.
	 */
	public function ReflectDisplay( target , sName:String ) 
	{
		super( sName == null ? (ConstructorUtil.getName(this) + "_" + hashCode()) : sName , target ) ;
		_dimension = new Dimension(0,0) ;
		_mcMask = view.createEmptyMovieClip( DEFAULT_MASK_NAME ,  DEFAULT_MASK_DEPTH ) ;
		_penMask = new RectanglePen( _mcMask ) ;
	}
	
	/**
	 * The default icon depth of this display. 
	 */
	static public var DEFAULT_ICON_DEPTH:Number = 100 ;

	/**
	 * The default mask depth of this display. 
	 */
	static public var DEFAULT_MASK_DEPTH:Number = 9999 ;

	/**
	 * The default reflect depth of this display. 
	 */
	static public var DEFAULT_REFLECT_NAME:String = "mcReflect" ;

	/**
	 * The default reflect depth of this display. 
	 */
	static public var DEFAULT_REFLECT_DEPTH:Number = 9000 ;

	/**
	 * The default mask depth of this display. 
	 */
	static public var DEFAULT_MASK_NAME:String = "mcMask" ;
	
	/**
	 * The alpha value of this display.
	 */
	public var alpha:Number = 90 ;

	public function get distance():Number 
	{
		return _distance ;	
	}

	public function set distance( n:Number ):Void 
	{
		_distance = n ;	
		update() ;
	}

	/**
	 * (read-write) Returns a string that specifies the linkage identifier of a symbol in the library to be used as an icon for a button instance.
	 * To create a custom icon, create a movie clip or graphic symbol. 
	 * Select the symbol on the Stage in symbol-editing mode and enter 0 in both the X and Y boxes in the Property inspector. 
	 * In the Library panel, select the movie clip and select Linkage from the Library pop-up menu. 
	 * Select Export for ActionScript, and enter an identifier in the Identifier text box.
	 * The default value is an empty string, which indicates that there is no icon.
	 */
	public function get icon():String 
	{
		return getIcon() ;	
	}

	/**
	 * (read-write) Sets a string that specifies the linkage identifier of a symbol in the library to be used as an icon for a button instance.
	 * To create a custom icon, create a movie clip or graphic symbol. 
	 * Select the symbol on the Stage in symbol-editing mode and enter 0 in both the X and Y boxes in the Property inspector. 
	 * In the Library panel, select the movie clip and select Linkage from the Library pop-up menu. 
	 * Select Export for ActionScript, and enter an identifier in the Identifier text box.
	 * The default value is an empty string, which indicates that there is no icon.
	 */
	public function set icon(sIcon:String):Void 
	{
		setIcon(sIcon) ;	
	}

	/**
	 * The ratio value of this display.
	 */
	public var ratio:Number = 50 ;
	
	/**
	 * Attach and returns a new Icon in the component.
	 * @param depth (optional) the depth of the icon (default value is the constant DEFAULT_ICON_DETH)
	 * @param target (optional) the other scope parent reference of the icon.
	 * @param name (optional) the name of the view icon reference.
	 * @return a new Icon MovieClip reference attached in the view or the specified scope.
	 */
	public function attachIcon( depth:Number, target:MovieClip , name:String ):MovieClip 
	{
		
		if (getIconTarget() != null) 
		{
			getIconTarget().removeMovieClip() ;
		}
		
		if (getIcon() != undefined) 
		{
		
			if (target == null)
			{
				target = view ;
			}
			
			depth = isNaN(depth) ? DEFAULT_ICON_DEPTH : depth ;
			
			if (name == null)
			{
				name = "icon" + depth ;	
			}
			
			return target.attachMovie( getIcon(), name, depth ) || null ;
		
		} 
		else 
		{
			return null ;
		}
	}
	
	/**
	 * (read-write) Returns a string that specifies the linkage identifier of a symbol in the library to be used as an icon for a button instance.
	 * To create a custom icon, create a movie clip or graphic symbol. 
	 * Select the symbol on the Stage in symbol-editing mode and enter 0 in both the X and Y boxes in the Property inspector. 
	 * In the Library panel, select the movie clip and select Linkage from the Library pop-up menu. 
	 * Select Export for ActionScript, and enter an identifier in the Identifier text box.
	 * The default value is an empty string, which indicates that there is no icon.
	 * @return a string that specifies the linkage identifier of a symbol in the library to be used as an icon for a button instance.
	 */
	public function getIcon():String 
	{
		return _sIcon ;
	}
	
	/**
	 * Returns the depth value of the icon.
	 * @return the depth value of the icon.
	 */
	public function getIconDepth():Number 
	{
		return getIconTarget().getDepth() ;
	}
	
	/**
	 * Returns the scope reference of the icon.
	 * @return the scope reference of the icon.
	 */
	public function getIconTarget():MovieClip 
	{
		return _mcIcon ;
	}
	
	/**
	 * Draw the reflect BitmapData reference.  
	 */
	public function draw( target:MovieClip ):Void 
	{
		
		_bmpReflect.dispose();
		_bmpReflect = new BitmapData( _dimension.width, _dimension.height, true, 0xFFFFFF);
		_bmpReflect.draw( target ) ;
		
		if ( _mcReflect != null )
		{
			_mcReflect.removeMovieClip() ;
		}
		_mcReflect = view.createEmptyMovieClip( DEFAULT_REFLECT_NAME , DEFAULT_REFLECT_DEPTH ) ;
		_mcReflect.attachBitmap( _bmpReflect , 1 ) ;
		_mcReflect._yScale = -100 ;
		_mcReflect._x = getIconTarget()._x ;
		_mcReflect._y = (_dimension.height * 2 ) + _distance ;
		
		var reflectionDropoff:Number ;
		var matrix:Matrix = new Matrix();
		
		var matrixHeight:Number = _dimension.height   ;
		if ( reflectionDropoff<=0 ) 
		{
			matrixHeight /= reflectionDropoff ;
		} 
		matrix.createGradientBox( _dimension.width, _dimension.height / 0.6 , (90/180)* Math.PI , 0, 0 );

		var fillType:String = GradientType.LINEAR ;
		var colors:Array = [0xFFFFFF, 0xFFFFFF];
		var alphas:Array = [alpha, 0];
		var ratios:Array = [0, ratio];
		var spreadMethod:String = SpreadMethod.PAD ;
	
		_penMask.clear() ;
		_penMask.beginGradientFill(fillType, colors, alphas, ratios, matrix, spreadMethod);
		_penMask.draw( _dimension.width , _dimension.height ) ;
		_penMask.endFill() ;
		
		_mcMask._x = _mcReflect._x ;
		_mcMask._y = _mcReflect._y - _mcReflect._height ;
		
		_mcMask.cacheAsBitmap = true ;
		_mcReflect.cacheAsBitmap = true ;
		
		_mcReflect.setMask(_mcMask) ;

	}
	
	/**
	 * Release the reflect.
	 */
	public function release():Void
	{
		_mcIcon.removeMovieClip() ;
		_mcReflect.removeMovieClip() ;
		_mcIcon    = null ;
		_mcReflect = null;
		_bmpReflect.dispose();
		_penMask.clear() ;
	}
	
	/**
	 * Sets the bounds of the reflect effect.
	 */
	public function setBounds(w:Number,h:Number):Void
	{
		_dimension.width = w ;
		_dimension.height = h;
		draw( _mcIcon );
	}
	
	/**
	 * Sets a string that specifies the linkage identifier of a symbol in the library to be used as an icon for a button instance.
	 */
	public function setIcon( str:String ):Void 
	{
		_sIcon = str ;
		viewIconChanged() ;
		dispatchEvent(new UIEvent( UIEvent.CHANGE )) ;
	}
	
	/**
	 * Sets the icon reference of the display.
	 */
	public function setIconTarget( target:MovieClip ):Void 
	{
		release() ;
		_mcIcon = target ;
		update() ;
	}
	
	/**
	 * Update the display.
	 */
	public function update():Void
	{
		if ( isLocked() )
		{
			return ;
		}
		var i:MovieClip = getIconTarget() ;
		if ( i._width > 0 && i._height > 0 )
		{
			setBounds( i._width , i._height ) ;
		}
		else
		{
			release() ;
		}
		dispatchEvent( new UIEvent( UIEvent.CHANGE , this ) ) ;
	}
	
	/**
	 * Invoqued when the icon property is changed.
	 */
	public function viewIconChanged():Void 
	{	
		if ( _sIcon != null )
		{
			setIconTarget( attachIcon() ) ;
		}
		else
		{
			release() ;
		}
	}


	private var _bmpReflect:BitmapData ;
	
	private var _dimension:Dimension ;
		
	private var _mcIcon:MovieClip ;

	private var _mcMask:MovieClip ;
	
	private var _penMask:RectanglePen ;
	
	private var _distance:Number = 4 ;

	private var _mcReflect:MovieClip ;

	private var _sIcon:String ;
		
}