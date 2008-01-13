/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is LunAS Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package lunas.display.bar 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import lunas.core.AbstractScrollbar;
	import lunas.core.Direction;
	import lunas.core.EdgeMetrics;
	
	import pegas.draw.FillStyle;
	import pegas.draw.IFillStyle;
	import pegas.draw.ILineStyle;
	import pegas.draw.LineStyle;
	import pegas.draw.RectanglePen;	

	/**
	 * The SimpleScrollbar component.
	 * <p><b>Example :</b></p>
	 * {@code
	 * import flash.display.StageScaleMode ;
	 * 
	 * import pegas.draw.FillStyle ;
	 * import pegas.draw.LineStyle ;
	 * 
	 * import lunas.core.Direction ;
	 * import lunas.core.EdgeMetrics ;
	 * import lunas.display.bar.SimpleScrollbar ;
	 * import lunas.events.ButtonEvent ;
	 * import lunas.events.ComponentEvent ;
	 * 
	 * stage.scaleMode = StageScaleMode.NO_SCALE ;
	 * 
	 * var change:Function = function( e:ComponentEvent ):void
	 * {
	 *     trace( e.type + " : " + bar.position ) ;
	 * }
	 * 
	 * var bar:SimpleScrollbar = new SimpleScrollbar() ;
	 * 
	 * addChild(bar) ;
	 * 
	 * // behaviours of the scrollbar
	 * 
	 * bar.addEventListener( ComponentEvent.CHANGE , change ) ;
	 * bar.thumbSize = 30 ;
	 * bar.position  = 50 ;
	 * bar.x = 50 ;
	 * bar.y = 50 ;
	 * 
	 * // initialize style of the scrollbar
	 * 
	 * bar.barFillStyle    = new FillStyle( 0x921085 , 1 ) ;
	 * bar.barLineStyle    = new LineStyle( 1 , 0x6A9195, 1 ) ;
	 * bar.thumbFillStyle  = new FillStyle( 0xB5C7CA , 1 ) ;
	 * bar.thumbLineStyle  = new LineStyle( 2 , 0xFFFFFF , 1 ) ;
	 * 
	 * var shadow:DropShadowFilter = new DropShadowFilter( 1, 45, 0x000000, 0.6, 6, 6, 1, 6) ;
	 * bar.filters = [ shadow  ] ;
	 * bar.thumb.filters = [ shadow ] ;
	 * 
	 * var keyDown:Function = function( e:KeyboardEvent ):void
	 * {
	 *     var code:uint = e.keyCode ;
	 *     switch( code )
	 *     {
	 *         case Keyboard.LEFT :
	 *         {
	 *             bar.position -= 10 ;
	 *             break ;
	 *         }
	 *         case Keyboard.RIGHT :
	 *         {
	 *             bar.position += 10 ;
	 *             break ;
	 *         }
	 *         case Keyboard.UP :
	 *         {
	 *             bar.position = bar.minimum ;
	 *             break ;
	 *         }
	 *         case Keyboard.DOWN :
	 *         {
	 *             bar.position = bar.maximum ;
	 *             break ;
	 *          }
	 *          case Keyboard.SPACE :
	 *          {
	 *              bar.direction = ( bar.direction == Direction.VERTICAL ) ? Direction.HORIZONTAL : Direction.VERTICAL ;
	 *              if ( bar.direction == Direction.VERTICAL )
	 *              {
	 *                  bar.setSize( 8, 200 ) ;
	 *              }
	 *              else
	 *              {
	 *                  bar.setSize( 200, 8 ) ;
	 *              }
	 *          }
	 *          default :
	 *          {
	 *              bar.minimum = 20 ; // change the minimum value of the bar
	 *              bar.maximum = 80 ; // change the maximum value of the bar
	 *              bar.invert = !bar.invert ; // invert the positive direction of the bar scroll.
	 *          }
	 *     }
	 * }
	 * 
	 * stage.addEventListener( KeyboardEvent.KEY_DOWN , keyDown ) ;
	 * }
	 * @author eKameleon
	 */
	public class SimpleScrollbar extends AbstractScrollbar 
	{

		/**
		 * Creates a new AbstractProgressbar instance.
		 * @param id Indicates the id of the object.
		 * @param isConfigurable This flag indicates if the IConfigurable object is register in the ConfigCollector.
		 * @param name Indicates the instance name of the object.
		 */
		public function SimpleScrollbar(id:* = null, isConfigurable:Boolean = false, name:String = null)
		{
			super( id, isConfigurable, name );
			
			bar   = new Sprite() ;
			
			thumb = new Sprite() ;
			thumb.addEventListener( MouseEvent.MOUSE_DOWN , startDragging ) ;
			thumb.buttonMode = true;
			thumb.useHandCursor = true;
					
			addChild(bar) ;
			addChild(thumb) ;
			
			_barPen   = new RectanglePen( bar )   ;
			_thumbPen = new RectanglePen( thumb ) ;
			
			lock() ;
			
			barFillStyle = new FillStyle( 0xFF0000, 1 ) ;
			barLineStyle = null ;

			thumbFillStyle = new FillStyle( 0xFFFFFF, 1 ) ;
			thumbLineStyle = new LineStyle( 1, 0xA2A2A2 , 1) ;
			
			unlock() ;
			
			setSize(150, 6) ;
			
		}
		
        /**
         * Determinates the fill style object of the bar.
         */
        public function get barFillStyle():IFillStyle
        {
            return _barPen.fillStyle ;
        }
        
        /**
         * @private
         */        
        public function set barFillStyle( style:IFillStyle ):void
        {
            _barPen.fillStyle = style ;
            update() ;
        }
        
        /**
         * Determinates the line style object of the bar.
         */
        public function get barLineStyle():ILineStyle
        {
            return _barPen.lineStyle ;
        }
        
        /**
         * @private
         */        
        public function set barLineStyle( style:ILineStyle ):void
        {
            _barPen.lineStyle = style ;
            update() ;
        }

        /**
         * Determinates the fill style object of the thumb.
         */
        public function get thumbFillStyle():IFillStyle
        {
            return _thumbPen.fillStyle ;
        }
        
        /**
         * @private
         */        
        public function set thumbFillStyle( style:IFillStyle ):void
        {
            _thumbPen.fillStyle = style ;
            update() ;
        }
        
        /**
         * Determinates the line style object of the thumb.
         */
        public function get thumbLineStyle():ILineStyle
        {
            return _thumbPen.lineStyle ;
        }
        
        /**
         * @private
         */        
        public function set thumbLineStyle( style:ILineStyle ):void
        {
            _thumbPen.lineStyle = style ;
            update() ;
        }
        
		/**
		 * Draw the view of the component.
		 */
		public override function draw( ...arguments:Array ):void
		{
			
			_barPen.draw( 0, 0, w, h ) ;
			
			var hBorder:Number = EdgeMetrics.filterNaNValue( border.top ) + EdgeMetrics.filterNaNValue( border.bottom ) ;
			var wBorder:Number = EdgeMetrics.filterNaNValue( border.left ) + EdgeMetrics.filterNaNValue( border.right ) ;

			var s:Number = thumbSize ;

			thumb.x = EdgeMetrics.filterNaNValue( border.top ) ;
			thumb.y = EdgeMetrics.filterNaNValue( border.left ) ;
			
			if ( direction == Direction.HORIZONTAL )
			{
				_thumbPen.draw( 0, 0, s, h - hBorder ) ;
			}
			else
			{
				_thumbPen.draw( EdgeMetrics.filterNaNValue( border.top ), EdgeMetrics.filterNaNValue( border.left ), w - wBorder , s ) ;
			}
			
		}
		
		/**
		 * @private
		 */
		private var _barPen:RectanglePen ;

		/**
		 * @private
		 */
		private var _thumbPen:RectanglePen ;
		
	}
}
