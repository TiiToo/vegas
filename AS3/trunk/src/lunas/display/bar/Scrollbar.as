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
	
	// TODO scroll with the button down event...
	
	import flash.geom.Rectangle;
	
	import lunas.core.Direction;
	import lunas.core.EdgeMetrics;
	import lunas.display.button.FrameLabelButton;	

	/**
	 * The Scrollbar component.
	 * @author eKameleon
	 */
	public class Scrollbar extends SimpleScrollbar 
	{

		/**
		 * Creates a new Scrollbar instance.
		 * @param id Indicates the id of the object.
		 * @param isConfigurable This flag indicates if the IConfigurable object is register in the ConfigCollector.
		 * @param name Indicates the instance name of the object.
		 */
		public function Scrollbar(id:* = null, isConfigurable:Boolean = false, name:String = null)
		{
			super( id, isConfigurable, name );
		}
		
		/**
		 * (read-write) Indicates the bottom button used when the bar direction is Direction.VERTICAL.
		 */
		public function get bottomButton():FrameLabelButton
		{
			return _bottomButton ;	
		}
		
		/**
		 * @private
		 */
		public function set bottomButton( button:FrameLabelButton ):void
		{
			if ( _bottomButton != null )
			{
				if ( contains( _bottomButton ) )
				{
					removeChild( _bottomButton ) ;
				}
				// _bottomButton.removeEventListener
				_bottomButton = null ;
			}			
			if ( button != null )
			{
				_bottomButton = button ;
				// _bottomButton.addEventListener
			}	
			update() ;
		}
		
		/**
		 * (read-write) Indicates the top button used when the bar direction is Direction.VERTICAL.
		 */
		public function get leftButton():FrameLabelButton
		{
			return _leftButton ;	
		}
		
		/**
		 * @private
		 */
		public function set leftButton( button:FrameLabelButton ):void
		{
			if ( _leftButton != null )
			{
				if ( contains( _leftButton ) )
				{
					removeChild( _leftButton ) ;
				}
				// _leftButton.removeEventListener
				_leftButton = null ;
			}			
			if ( button != null )
			{
				_leftButton = button ;
				// _leftButton.addEventListener
			}	
			update() ;
		}
		
        /**
         * Indicates the padding between the buttons and the bar.
         */
        public function get padding():EdgeMetrics
        {
            return _padding ;
        }
        
        /**
         * @private
         */
        public function set padding( em:EdgeMetrics ):void
        {
            _padding = em ||  EdgeMetrics.EMPTY ;
            update() ;
        }		
		
		/**
		 * (read-write) Indicates the top button used when the bar direction is Direction.VERTICAL.
		 */
		public function get rightButton():FrameLabelButton
		{
			return _rightButton ;	
		}
		
		/**
		 * @private
		 */
		public function set rightButton( button:FrameLabelButton ):void
		{
			if ( _rightButton != null )
			{
				if ( contains( _rightButton ) )
				{
					removeChild( _rightButton ) ;
				}
				// _rightButton.removeEventListener
				_rightButton = null ;
			}			
			if ( button != null )
			{
				_rightButton = button ;
				// _rightButton.addEventListener
			}	
			update() ;
		}			
		
		/**
		 * (read-write) Indicates the top button used when the bar direction is Direction.VERTICAL.
		 */
		public function get topButton():FrameLabelButton
		{
			return _topButton ;	
		}
		
		/**
		 * @private
		 */
		public function set topButton( button:FrameLabelButton ):void
		{
			if ( _topButton != null )
			{
				if ( contains( _topButton ) )
				{
					removeChild( _topButton ) ;
				}
				// _topButton.removeEventListener
				_topButton = null ;
			}			
			if ( button != null )
			{
				_topButton = button ;
				// _topButton.addEventListener
			}	
			update() ;
		}		
		
		/**
		 * Draw the view of the component.
		 */
		public override function draw( ...arguments:Array ):void
		{
			_reset() ;
			if ( direction == Direction.HORIZONTAL )
			{
				if ( leftButton != null )
				{
					addChild( leftButton ) ;
				}
				if ( rightButton != null )
				{
					addChild( rightButton ) ;
					rightButton.x = w - rightButton.width ;
				}
			}
			else
			{
				
				if ( topButton != null )
				{
					addChild( topButton ) ;
				}
				if ( bottomButton != null )
				{
					addChild( bottomButton ) ;
					bottomButton.y = h - bottomButton.height ;	
				}
			}
			
			var $x:Number, $y:Number, $w:Number, $h:Number ;
			
			var pb:Number = EdgeMetrics.filterNaNValue( padding.bottom ) ;
			var pl:Number = EdgeMetrics.filterNaNValue( padding.left ) ;
			var pr:Number = EdgeMetrics.filterNaNValue( padding.right ) ;
			var pt:Number = EdgeMetrics.filterNaNValue( padding.top ) ;
			
			if ( direction == Direction.HORIZONTAL )
			{
				$x = ( (leftButton != null) ? leftButton.x + leftButton.width : 0 ) + pl ;
				$y = 0 ;
				$w = w - $x - ( (rightButton != null) ? rightButton.width : 0 ) - pl - pr ;
				$h = h ;
			}
			else
			{
				$x = 0 ;
				$y = ( topButton != null ? ( topButton.y + topButton.height ) : 0 ) + pt ;	
				$w = w ;
				$h = h - $y - ( (bottomButton != null) ? bottomButton.height : 0 ) - pb - pt ;			
			}
			
			container.x = $x ;
			container.y = $y ;
			
			super.draw( new Rectangle( 0, 0, $w, $h ) ) ;

		}

		/**
		 * @private
		 */
		private var _bottomButton:FrameLabelButton ;

		/**
		 * @private
		 */
		private var _leftButton:FrameLabelButton ;

		/**
		 * @private
		 */
		private var _padding:EdgeMetrics = new EdgeMetrics(1,1,1,1) ;

		/**
		 * @private
		 */
		private var _rightButton:FrameLabelButton ;
		
		/**
		 * @private
		 */
		private var _topButton:FrameLabelButton ;
		
		/**
		 * @private
		 */
		private function _reset():void
		{
			bar.x = 0 ;
			bar.y = 0 ;
			if ( bottomButton != null && contains( bottomButton ) ) removeChild( bottomButton ) ;
			if ( leftButton   != null && contains( leftButton )   ) removeChild( leftButton ) ;
			if ( rightButton  != null && contains( rightButton )  ) removeChild( rightButton ) ;
			if ( topButton    != null && contains( topButton )    ) removeChild( topButton ) ;
		}
	}
}
