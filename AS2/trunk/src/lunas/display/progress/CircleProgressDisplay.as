/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is LunAS Library.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
 */
import flash.filters.DropShadowFilter;

import asgard.display.CapStyle;
import asgard.display.JoinStyle;
import asgard.display.LineScaleMode;

import lunas.display.abstract.AbstractProgressDisplay;
import lunas.display.progress.CircleProgressDisplayStyle;

import pegas.draw.Align;
import pegas.draw.ArcPen;
import pegas.draw.ArcType;
import pegas.geom.Trigo;

/**
 * This component defines a circle progress display.
 * @author eKameleon
 */
class lunas.display.progress.CircleProgressDisplay extends AbstractProgressDisplay 
{

	/**
	 * Creates a new CircleProgressDisplay instance. 
	 * @param sName the name of the display.
	 * @param target the DisplayObject instance control this target.
	 * @param bGlobal the flag to use a global event flow or a local event flow.
	 * @param sChannel the name of the global event flow if the {@code bGlobal} argument is {@code true}.
	 */
	public function CircleProgressDisplay( sName:String, target:MovieClip, bGlobal:Boolean , sChannel:String )
	{
		super( sName , target , bGlobal , sChannel ) ;
		try
		{
			_background = resolve(DEFAULT_BACKGROUND_NAME, DEFAULT_BACKGROUND_DEPTH) ;
		}
		catch( e:Error )
		{
			//
		}
		_arc = view.createEmptyMovieClip( DEFAULT_ARC_NAME , DEFAULT_ARC_DEPTH ) ;
		_arcPen = new ArcPen(_arc) ;
		_arcPen.type = ArcType.PIE ;
		position = 0 ;
		
	}

	/**
	 * The default background movieclip depth value.
	 */
	public static var DEFAULT_BACKGROUND_DEPTH:Number = 1 ;

	/**
	 * The default background movieclip name value.
	 */
	public static var DEFAULT_BACKGROUND_NAME:String = "background" ;
	
	/**
	 * The default arc movieclip depth value.
	 */
	public static var DEFAULT_ARC_DEPTH:Number = 100 ;

	/**
	 * The default arc movieclip name value.
	 */
	public static var DEFAULT_ARC_NAME:String = "arc" ;
	
	/**
	 * Returns the constructor of the IStyle of this instance.
	 * @return the constructor of the IStyle of this instance.
	 */
	public function getStyleRenderer():Function
	{
		return CircleProgressDisplayStyle ;	
	}	

	/**
	 * Invoked when the position of the bar is changed.
	 * @param flag (optional) An optional boolean.
	 */
	public function viewPositionChanged(flag:Boolean):Void 
	{
		
		var s:CircleProgressDisplayStyle = CircleProgressDisplayStyle(getStyle()) ;
		
		if ( position >= 100 )
		{
			position = 99.9 ;
		}
		
		var angle:Number = getPosition() * 360 / 100 ;
		angle = Trigo.fixAngle(angle) ;
		
		trace( angle ) ;
		
		_arcPen.radius = _background._width / 2 ;
		_arcPen.clear() ;
		
		if ( s.arcBorderAlpha != null )
		{		
			_arcPen.lineStyle( s.arcBorderThickness, s.arcBorderColor, s.arcBorderAlpha, true, LineScaleMode.NONE, CapStyle.SQUARE , JoinStyle.MITER ) ;
		}		
		
		if ( s.arcAlpha != null )
		{			
			_arcPen.beginFill( s.arcColor, s.arcAlpha ) ;
		}

		_arcPen.draw( angle , 0 , _background._x + _background._width / 2  , _background._y + _background._height / 2 , Align.CENTER	) ;
		
		_arc.filters = [ new DropShadowFilter( 3, 45, 0x000000, 0.8, 8, 8, 0.8, 2 , true )  ] ;	
	}
	
	/**
	 * @private
	 */
	private var _arc:MovieClip ;
	
	/**
	 * @private
	 */
	private var _arcPen:ArcPen ;

	/**
	 * @private
	 */
	private var _background:MovieClip ;
	
}
