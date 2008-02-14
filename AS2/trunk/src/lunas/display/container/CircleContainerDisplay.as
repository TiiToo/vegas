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
import lunas.display.container.SimpleContainerDisplay;
import lunas.model.ContainerModel;

import pegas.draw.Align;
import pegas.geom.Trigo;

/**
 * This container display all this child elements with a circle trigonometric algorithm. 
 * @author eKameleon
 */
class lunas.display.container.CircleContainerDisplay extends SimpleContainerDisplay 
{

	/**
	 * Creates a new CircleContainerDisplay instance.
	 * <p><b>Example :</b></p>
	 * {@code
	 * import lunas.display.container.CircleContainerDisplay ;
	 * 
	 * import pegas.draw.Align;
	 * 
	 * var container:CircleContainerDisplay = new CircleContainerDisplay(null, createEmptyMovieClip("container_mc",10)) ;
	 * 
	 * container.align      = Align.CENTER ;
	 * container.childCount = 10 ;
	 * container.radius     = 20 ;
	 * container.x          = 360 ;
	 * container.y          = 230 ;
	 * 
	 * var colors:Array =
	 * [
	 *     0x7A1D05 , 0xFF0000 , 0xF5532C , 0xECC671 , 0xF3E469 ,
	 *     0xCFE478 , 0x72871B , 0x287968 , 0x1E5184 , 0x0E273F
	 * ] ;
	 * 
	 * var n:Number = colors.length ;
	 * for (var i:Number = 0 ; i<n ; i++ )
	 * {
	 *     var mc:MovieClip = container.addChild( "particle" ) ; // "particle" the link id of the symbol in the library
	 *     var co:Color = new Color( mc ) ;
	 *     co.setRGB( colors[i] ) ; // Math.random() * 0xFFFFFF ) ;
	 * }
	 * 
	 * var onKeyDown:Function = function():Void
	 * {
	 *     var code:Number = Key.getCode() ;
	 *     switch( code )
	 *     {
	 *         case Key.UP :
	 *         {
	 *             container.childCount ++ ;
	 *             container.radius += 10 ;
	 *             break ;
	 *         }
	 *         case Key.DOWN :
	 *         {
	 *             container.childCount -- ;
	 *             container.radius -= 10 ;
	 *             break ;
	 *         }
	 *         case Key.SPACE :
	 *         {
	 *             var mc:MovieClip = container.addChild( "particle" ) ;
	 *             var co:Color = new Color( mc ) ;
	 *             co.setRGB( Math.random() * 0xFFFFFF ) ;
	 *             break ;
	 *         }
	 *         case Key.LEFT :
	 *         {
	 *             container.startAngle -= 10 ;
	 *             // container.align = Align.LEFT ;
	 *             break ;
	 *         }
	 *         case Key.RIGHT :
	 *         {
	 *             container.startAngle += 10 ;
	 *             // container.align = Align.RIGHT ;
	 *             break ;
	 *         }
	 *     }
	 * }
	 * Key.addListener( this ) ;
	 * }
	 * @param sName:String the name of the display.
	 * @param target:MovieClip the DisplayObject instance control this target.
	 * @param id (optional) the id of the model.
	 * @param bGlobal (optional) the flag to use a global event flow or a local event flow.
	 * @param sChannel (optional) the name of the global event flow if the {@code bGlobal} argument is {@code true}.
	 * @param childs (optional) An Array of items to insert in the model.
	 */
	public function CircleContainerDisplay( sName:String, target:MovieClip , id , bGlobal:Boolean , sChannel:String , childs:Array ) 
	{ 
		super( sName, target, id, bGlobal, sChannel, childs ) ;
		_align = Align.TOP_LEFT ;
	}
	
	/**
	 * The theta value of this pen.
	 */
	public static var THETA:Number = Math.PI/4 ;	
	
	/**
	 * (read-write) Determinates the align value of the container.
	 */
	public function get align():Number 
	{
		return _align ;	
	}
	
	/**
	 * @private
	 */
	public function set align(nAlign:Number):Void 
	{
		_align = (Align.validate(nAlign)) ? nAlign : Align.TOP_LEFT ;
		update() ;
	}	
	
	/**
	 * Indicates the number of childs visible in this container (minimal value is 1).
	 */
	public function get childCount():Number 
	{
		return _childCount ; 
	}
	
	/**
	 * @private
	 */
	public function set childCount(n:Number):Void 
	{
		_childCount = n > 1 ? n : 1 ;
		update() ;
	}	
	
	/**
	 * The x property name use in the container to layout all items.
	 */
	public var propX:String = "_x" ;
	
	/**
	 * The y property name use in the container to layout all items.
	 */
	public var propY:String = "_y" ;	
	
	/**
	 * (read-write) Indicates the radius of the circle container.
	 */
	public function get radius():Number 
	{
		return _radius ;
	}
	
	/**
	 * @private
	 */
	public function set radius(n:Number):Void 
	{
		_radius = isNaN(n) ? 0 : n ;
		update() ;
	}

	/**
	 * Indicates the value of the start angle to display all childs in the container (in degrees).
	 */
	public function get startAngle():Number 
	{
		return Trigo.radiansToDegrees(_startAngle) ;
	}	

	/**
	 * @private
	 */
	public function set startAngle(n:Number):Void 
	{
		_startAngle = Trigo.degreesToRadians( isNaN(n) ? 0 : n%360 ) ;
		update() ;
	}	

	/**
	 * Draw the component display.
	 */
	public function draw():Void 
	{
		
		container._x = 0 ;
		container._y = 0 ;
		
		if ( getModel().size() > 0 ) 
		{
			changeChildsPosition() ;
			
			var a:Number = align ;
			
			if (a == Align.CENTER) 
			{
				// default
			}
			else if (a == Align.BOTTOM) 
			{
				container._y -= container._height / 2 ;
			}
			else if (a == Align.BOTTOM_LEFT) 
			{
				container._x += container._width / 2 ;
				container._y -= container._height / 2 ;
			}
			else if (a == Align.BOTTOM_RIGHT) 
			{
				container._x -= container._width / 2 ;
				container._y -= container._height / 2 ;
			}
			else if (a == Align.LEFT) 
			{
				container._x += container._width / 2 ;
			}
			else if (a ==  Align.RIGHT) 
			{
				container._x -= container._width / 2 ;
			}
			else if (a == Align.TOP) 
			{
				container._y += container._height / 2 ;
			}
			else if (a == Align.TOP_RIGHT) 
			{
				container._x -= container._width / 2 ;
				container._y += container._height / 2 ;
			}
			else // TOP_LEFT
			{
				container._x += container._width / 2 ;
				container._y += container._height / 2 ;
			}		
		}		
	}	
	
	/**
	 * Refreshs and changes the child position of all childs in the container.
	 */
	public function changeChildsPosition():Void 
	{

		var child ;
		var model:ContainerModel = getModel() ;
		var a:Array  = model.toArray() ;
		var l:Number = a.length ;
		for (var i:Number = 0 ; i<l ; i++) 
		{
			child        = a[i] ;
			child[propX] = radius * Math.cos( _startAngle - Math.PI / 2 + i * 2 * Math.PI / childCount  )  ;
			child[propY] = radius * Math.sin( _startAngle - Math.PI / 2 + i * 2 * Math.PI / childCount  )  ;
		}
	}
	
	/**
	 * Invoked if the enabled property of this container is changed.
	 */
	public function viewEnabled():Void 
	{
		var l:Number = getModel().size() ;
		while (--l > -1) 
		{
			getModel().getChildAt(l).enabled = enabled ;
		}
	}	
	
	/**
	 * @private
	 */
	private var _align:Number ;	
	
	/**
	 * @private
	 */
	private var _childCount:Number = 10 ;	
	
	/**
	 * @private
	 */
	private var _radius:Number ;
	
	/**
	 * @private
	 */
	private var _startAngle:Number = 0 ;	
	
}
