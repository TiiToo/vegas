﻿/*

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
package lunas.core 
{
    import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import lunas.events.ButtonEvent;	

	/**
	 * This class provides a skeletal implementation of all the {@code IScrollbar} display components, to minimize the effort required to implement this interface.
	 * @author eKameleon
	 */
	public class AbstractScrollbar extends AbstractProgressbar implements IScrollbar
	{
		
		/**
		 * Creates a new AbstractProgressbar instance.
		 * @param id Indicates the id of the object.
		 * @param isConfigurable This flag indicates if the IConfigurable object is register in the ConfigCollector.
		 * @param name Indicates the instance name of the object.
		 */
		public function AbstractScrollbar(id:* = null, isConfigurable:Boolean = false, name:String = null)
		{
			super( id, isConfigurable, name ) ;
		}

		/**
		 * The bar display of the scrollbar.
		 */
		public function get bar():Sprite
		{
			return _bar ;	
		}
		
		/**
		 * @private
		 */
		public function set bar( bar:Sprite ):void
		{
			_bar = bar ;	
		}

		/**
		 * Indicates if the layout direction of the thumb is invert.
		 */
		public function get invert():Boolean
		{
			return _invert ;	
		}
		
		/**
		 * @private
		 */
		public function set invert( b:Boolean ):void
		{
			_invert = b ;
			update() ;	
		}
			
		/**
		 * (read-only) Indicates if the bar is dragging.
		 */
		public function get isDragging():Boolean 
		{
			return _isDragging ;
		}

		/**
		 * (Read-write) The maximum value of this scrollbar.
		 */
		public function get maximum():Number
		{
			return _max;
		}

		/**
		 * @private
		 */
		public function set maximum(m:Number):void
		{
			_max = m;
			viewPositionChanged() ;
		}

		/**
		 * (Read-write) The minimum value of this scrollbar.
		 */
		public function get minimum():Number
		{
			return _min;
		}
		
		/**
		 * @private
		 */
		public function set minimum(m:Number):void
		{
			_min = m;
			viewPositionChanged() ;
		}

		/**
		 * The thumb display of the scrollbar.
		 */
		public function get thumb():Sprite
		{
			return _thumb ;	
		}
		
		/**
		 * @private
		 */
		public function set thumb( thumb:Sprite ):void
		{
			_thumb = thumb ;
		}		
		
        /**
         * Determinates the size of the thumb.
         */
        public function get thumbSize():Number
        {
			var hBorder:Number = EdgeMetrics.filterNaNValue( border.top ) + EdgeMetrics.filterNaNValue( border.bottom ) ;
			var wBorder:Number = EdgeMetrics.filterNaNValue( border.left ) + EdgeMetrics.filterNaNValue( border.right ) ;
            if( isNaN(_thumbSize) )
            {
            	return ( direction == Direction.HORIZONTAL ) ? h - hBorder : w - wBorder ;
            }
            else
            {
            	return ( direction == Direction.HORIZONTAL ) ? Math.min( _thumbSize , w ) : Math.min( _thumbSize , h ) ;
            }
        }
        
        /**
         * @private
         */        
        public function set thumbSize( value:Number ):void
        {
            _thumbSize = value ;
            update() ;
        }		
		
		/**
		 * Invoked when the bar is dragging.
		 */
		public function dragging( ...args:Array ):void 
		{
			var ts:Number          = thumbSize ;
			var oldPosition:Number = position ;
			var newPosition:Number ;
			if( direction == Direction.HORIZONTAL )
			{
				newPosition = thumb.x / (w - ts) * (_max - _min) + _min ;
				if ( _invert )
				{
					newPosition = (_max + _min) - newPosition ;
				}
			}
			else
			{
				var range:Number = h - ts ;
				newPosition = _min + ( range - thumb.y ) / range * (_max - _min) ;
				if ( _invert == false )
				{
					newPosition = (_max + _min) - newPosition ;
				}
			}
			if(newPosition != oldPosition)
			{
				notifyDrag() ;
			}
			setPosition( newPosition ) ;
		}
		
		/**
		 * Dispatchs an event when the user drag the bar.
		 */
		public function notifyDrag():void 
		{
			_fireButtonEvent( ButtonEvent.DRAG ) ;
		}
		
		/**
		 * Dispatchs an event when the user start to drag the bar.
		 */
		public function notifyStartDrag():void
		{
			_fireButtonEvent( ButtonEvent.START_DRAG ) ;	
		}
		
		/**
		 * Dispatchs an event when the user stop to drag the bar.
		 */
		public function notifyStopDrag():void
		{
			_fireButtonEvent( ButtonEvent.STOP_DRAG ) ;
		}
		
		/**
		 * Invoked when the user start to drag the bar.
		 */
		public function startDragging( e:Event=null ):void 
		{
			notifyStartDrag() ;
			_isDragging = true ;
			stage.addEventListener( MouseEvent.MOUSE_UP   , stopDragging ) ;
			stage.addEventListener( MouseEvent.MOUSE_MOVE , dragging     ) ;
			if( direction == Direction.HORIZONTAL )
			{
				thumb.startDrag(false, new Rectangle(0 , 0 , w - thumbSize , 0 ) ) ;
			}
			else
			{
				thumb.startDrag(false, new Rectangle(0 , 0 , 0 , h - thumbSize ) ) ;
			}
		}

		/**
		 * Invoked when the user stop to drag the bar.
		 */
		public function stopDragging( e:Event=null ):void 
		{
			_isDragging = false ;
			stage.removeEventListener(MouseEvent.MOUSE_UP   , stopDragging) ;
			stage.removeEventListener(MouseEvent.MOUSE_MOVE , dragging ) ;
			thumb.stopDrag();
			notifyStopDrag() ;
		}
		
		/**
		 * Invoked when the position value of the bar is changed.
		 */
		public override function viewPositionChanged( flag:Boolean=false ):void 
		{
			_fixPosition() ;
			if ( !isDragging )
			{
				var range:Number ;
				var ts:Number = thumbSize ;
				if(direction == Direction.HORIZONTAL)
				{
					range = w - ts ;
					thumb.x = (_position - _min) / (_max - _min) * range ;
					thumb.y = 0 ;
					if ( _invert )
					{
						thumb.x = range - thumb.x ;
					}
				}
				else
				{
					range = h - ts ;
					thumb.x = 0 ;
					thumb.y = (_position - _min) / (_max - _min) * range ;
					if ( _invert )
					{
						thumb.y = range - thumb.y ;
					}
				}
			}
		}
		
		/**
		 * The max value of the scrollbar.
		 */
		protected var _max:Number = 100 ;

		/**
		 * The min value of the scrollbar.
		 */
		protected var _min:Number = 0 ;		
		
		/**
		 * Dispatchs a ButtonEvent with the specified type.
		 */
		protected function _fireButtonEvent( type:String ):void
		{
			dispatchEvent( new ButtonEvent( type , this , bubbles )  ) ;
		}

		/**
		 * @private
		 */
		private var _bar:Sprite ;

		/**
		 * @private
		 */
		private var _invert:Boolean = false ;
		
		/**
		 * @private
		 */
		private var _isDragging:Boolean ;
		
		/**
		 * @private
		 */
		private var _thumb:Sprite ;
		
		/**
		 * @private
		 */
		private var _thumbSize:Number ;
		
		/**
		 * Fix the position of the bar to be within minimum and maximum.
		 */
		private function _fixPosition():void
		{
			if(_max > _min)
			{
				_position = Math.min(_position, _max) ;
				_position = Math.max(_position, _min) ;
			}
			else
			{
				_position = Math.max(_position, _max) ;
				_position = Math.min(_position, _min) ;
			}
		}

	}

}
