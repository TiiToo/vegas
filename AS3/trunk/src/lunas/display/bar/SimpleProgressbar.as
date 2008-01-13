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

// TODO finish alignment of the bar with the align property.

package lunas.display.bar 
{
	import flash.display.Shape;
	
	import lunas.core.AbstractProgressbar;
	import lunas.core.Direction;
	import lunas.core.EdgeMetrics;
	
	import pegas.draw.FillStyle;
	import pegas.draw.IFillStyle;
	import pegas.draw.ILineStyle;
	import pegas.draw.LineStyle;
	import pegas.draw.RectanglePen;	

	/**
	 * The SimpleProgressbar component.
	 * <p><b>Example :</b></p>
	 * {@code
	 * import flash.display.StageScaleMode ;
	 * 
	 * import pegas.draw.FillStyle ;
	 * import pegas.draw.LineStyle ;
	 * 
	 * import lunas.core.Direction ;
	 * import lunas.core.EdgeMetrics ;
	 * import lunas.display.bar.SimpleProgressbar ;
	 * import lunas.events.ComponentEvent ;
	 * 
	 * stage.scaleMode = StageScaleMode.NO_SCALE ;
	 * 
	 * var change:Function = function( e:ComponentEvent ):void
	 * {
	 *     trace( e.type + " : " + bar.position ) ;
	 * }
	 * 
	 * var bar:SimpleProgressbar = new SimpleProgressbar() ;
	 * bar.addEventListener( ComponentEvent.CHANGE , change ) ;
	 * bar.x = 50 ;
	 * bar.y = 50 ;
	 * bar.position = 50 ;
	 * 
	 * addChild(bar) ;
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
	 *         case Keyboard.SPACE :
	 *         {
	 *             bar.lock() ;
	 *             bar.backgroundFillStyle = new FillStyle( 0xB5C7CA , 1 ) ;
	 *             bar.backgroundLineStyle = new LineStyle( 2 , 0xFFFFFF , 1 ) ;
	 *             bar.barFillStyle        = new FillStyle( 0x921085 , 1 ) ;
	 *             bar.barLineStyle        = new LineStyle( 1 , 0x6A9195, 1 ) ;
	 *             bar.border              = new EdgeMetrics(2, 2, 2, 2) ;
	 *             bar.unlock() ;
	 *             bar.setSize( 200, 8 ) ;
	 *             break ;
	 *         }
	 *         default :
	 *         {
	 *             bar.direction = ( bar.direction == Direction.VERTICAL ) ? Direction.HORIZONTAL : Direction.VERTICAL ;
	 *             if ( bar.direction == Direction.VERTICAL )
	 *             {
	 *                 bar.setSize( 8, 200 ) ;
	 *             }
	 *             else
	 *             {
	 *                 bar.setSize( 200, 8 ) ;
	 *             }
	 *         }
	 *     }
	 * }
	 * 
	 * stage.addEventListener( KeyboardEvent.KEY_DOWN , keyDown ) ;
	 * 
	 * trace("Press Keyboard.LEFT or Keyboard.RIGHT or Keyboard.SPACE or other keyboard touch to test this example.") ;
	 * }
	 * @author eKameleon
	 */
	public class SimpleProgressbar extends AbstractProgressbar 
	{

		/**
		 * Creates a new SimpleProgressbar instance.
		 * @param id Indicates the id of the object.
		 * @param isConfigurable This flag indicates if the IConfigurable object is register in the ConfigCollector.
		 * @param name Indicates the instance name of the object.
		 */
		public function SimpleProgressbar(id:* = null, isConfigurable:Boolean = false, name:String = null)
		{
			
			super( id, isConfigurable, name );
			
			background = new Shape() ;
			bar        = new Shape() ;
			
			_backgroundPen = new RectanglePen( background ) ;
			_barPen        = new RectanglePen( bar ) ;
			
			addChild( background ) ;
			addChild( bar ) ;
			
			lock() ;
			
			backgroundFillStyle = new FillStyle( 0xFFFFFF, 1 ) ;
			backgroundLineStyle = new LineStyle( 1, 0xA2A2A2 , 1) ;
			
			barFillStyle = new FillStyle( 0xFF0000, 1 ) ;
			barLineStyle = null ;
			
			unlock() ;
			
			setSize(150, 6) ;
			
		}
		
		/**
		 * The background reference of this component.
		 */
		public var background:Shape ;
	
        /**
         * (read-write) Indicates the align value of the bar.
         * @see Align
         */
		public function get align():uint
		{
			return _barPen.align ;	
		}
	
        /**
         * @private
         */
		public function set align( align:uint ):void
		{
			_barPen.align = align ;	
		}

        /**
         * Determinates the fill style object of the background.
         */
        public function get backgroundFillStyle():IFillStyle
        {
            return _backgroundPen.fillStyle ;
        }
        
        /**
         * @private
         */        
        public function set backgroundFillStyle( style:IFillStyle ):void
        {
            _backgroundPen.fillStyle = style ;
            update() ;
        }
        
        /**
         * Determinates the line style object of the background.
         */
        public function get backgroundLineStyle():ILineStyle
        {
            return _backgroundPen.lineStyle ;
        }
        
        /**
         * @private
         */        
        public function set backgroundLineStyle( style:ILineStyle ):void
        {
            _backgroundPen.lineStyle = style ;
            update() ;
        }
	
		/**
		 * The thumb reference of this bar.
		 */
		public var bar:Shape ;
		
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
		 * Indicates the thickness, in pixels, of the four edge regions around a visual component.
		 */
		public function get border():EdgeMetrics
		{
			return _border ;
		}
		
		/**
		 * @private
		 */
		public function set border( em:EdgeMetrics ):void
		{
			_border = em ||  EdgeMetrics.EMPTY ;
			update() ;
		}
		
		/**
		 * Draw the view of the component.
		 */
		public override function draw( ...arguments:Array ):void
		{
			_backgroundPen.draw( 0, 0, w, h ) ;
		}		
		
		/**
		 * Resize the bar.
		 */
		public function resize():void 
		{
			var nW:Number = EdgeMetrics.filterNaNValue( border.left ) + EdgeMetrics.filterNaNValue( border.right ) ;
			var nH:Number = EdgeMetrics.filterNaNValue( border.top  ) + EdgeMetrics.filterNaNValue( border.bottom ) ;
			
			var margin:Number = (direction == Direction.VERTICAL) ? nH : nW ;
			var max:Number    = (direction == Direction.VERTICAL) ? h : w ;
			var size:Number   =  Math.floor( position * (max - margin) / 100 ) ;
					
			var $w:Number = (direction == Direction.VERTICAL) ? ( w - nW ) : size  ;
			var $h:Number = (direction == Direction.VERTICAL) ? size : ( h - nH ) ;
			
			_barPen.draw( EdgeMetrics.filterNaNValue( border.left ), EdgeMetrics.filterNaNValue( border.top ), $w, $h) ;
		
		}
		
		/**
	 	 * Invoked when the position of the bar is changed.
	 	 * @param flag (optional) An optional boolean. By default this flag is passed-in the setPosition method.
	 	 */
		public override function viewPositionChanged( flag:Boolean = false ):void 
		{
			resize() ;
		}
	
		/**
		 * @private
		 */
		private var _backgroundPen:RectanglePen ;
		
		/**
		 * @private
		 */
		private var _barPen:RectanglePen ;

		/**
		 * @private
		 */
		private var _border:EdgeMetrics = EdgeMetrics.EMPTY ;

	}

}
