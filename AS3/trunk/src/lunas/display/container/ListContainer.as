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
package lunas.display.container 
{
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
	import lunas.core.AbstractComponent;
	import lunas.core.Direction;
	import lunas.core.EdgeMetrics;
	import lunas.core.IDirectionable;
	
	import pegas.geom.Dimension;	

	/**
	 * The ListContainer class is a list container component. 
	 * @author eKameleon
	 */
	public class ListContainer extends Container implements IDirectionable
	{

		/**
		 * Creates a new ListContainer instance.
		 * @param id Indicates the id of the object.
		 * @param isConfigurable This flag indicates if the IConfigurable object is register in the ConfigCollector.
		 * @param name Indicates the instance name of the object.
		 */
		public function ListContainer(id:* = null, isConfigurable:Boolean = false, name:String = null)
		{

			super( id, isConfigurable, name );
			
			_mask       = new Shape() ;			
			_bound      = new Dimension() ;
			
			registerView( new Sprite() ) ;
			
			
			addChild( view ) ;

		}

		/**
		 * Returns the number of childs in this container.
		 * @return the number of childs in this container.
		 */
		public function get childCount():int 
		{
			return (_childCount > numChildren) ? numChildren : _childCount ;
		}
	
		/**
		 * Sets the number of childs visible in this container. 
		 * If this value is -1 no mask effect is apply over the list container, all the childs are visible.
		 * @param value The number of childs visible in the container.
		 */
		public function set childCount( value:int ):void 
		{
			_childCount   = ( value > -1 ) ? value : -1 ; // -1 no mask effect
			_maskIsActive = _childCount > 0 ;
			update() ;
		}

		/**
		 * Indicates the direction value of this object.
		 * @see Direction
		 */
		public function get direction():String
		{
			return _direction ;
		}

		/**
		 * @private
		 */
		public function set direction(value:String):void
		{
			_direction = (value == Direction.HORIZONTAL) ? Direction.HORIZONTAL : Direction.VERTICAL ;
		}
		
		/**
		 * The height property name use in the container to layout all items.
		 */
		public var propHeight:String = "height" ;
		
		/**
		 * The x property name use in the container to layout all items.
		 */
		public var propX:String = "x" ;
		
		/**
		 * The y property name use in the container to layout all items.
		 */
		public var propY:String = "y" ;
		
		/**
	 	 * The width property name use in the container to layout all items.
	 	 */
		public var propWidth:String = "width" ;

		/**
		 * (read-write) Indicates if the mask is active or not over this container.
		 */
		public function get maskIsActive():Boolean 
		{	
			return _maskIsActive ;
		}
		
		/**
	 	 * @private
	 	 */
		public function set maskIsActive( b:Boolean ):void 
		{
			_maskIsActive = b ;
			update() ;
		}
		
			
		/**
		 * (read-only) Determinates the mask reference of this container.
		 */
		public function get maskView():Shape 
		{	
			return _mask ;
		}
		
		
		/**
	 	 * Indicates the space value (in pixel) between 2 childs in the list.
	 	 */
		public function get space():Number
		{
			return _space ;	
		}
		
		/**
	 	 * Sets the space value (in pixel) between 2 childs in the list.
	 	 */
		public function set space(n:Number):void 
		{
			_space = isNaN(n) ? 0 : n ; 
			if ( numChildren > 0 )
			{
				update() ;
			}
		}
		
		/**
		 * (read-write) Indicates if this container use a scrollRect reference to mask the content.
		 */
		public function get useScrollRect():Boolean
		{
			return _useScrollRect ;
		}

		/**
		 * @private
		 */
		public function set useScrollRect( b :Boolean ):void
		{
			_useScrollRect = b ;
			update() ;
		}
		
		/**
		 * Refreshs and changes the child position of all childs in the container.
	 	 */
		public function changeChildsPosition():void 
		{
		
			var child:DisplayObject ;
			var prev:DisplayObject ;
					
			var pro:String = getCoordinateProperty() ;
			var inv:String = (pro == propY) ? propX : propY ;
			var spa:Number = space ;
				
			var s:String = getSizeProperty() ;
			
			var l:Number = numChildren ;
				
			for (var i:Number = 0 ; i<l ; i++) 
			{
				child      = getChildAt(i) ;
				prev       = getChildAt(i-1) ;
				child[pro] = (i == 0) ? 0 : ( prev[pro] + prev[s] + spa ) ;
				child[inv] = 0 ;
			}
		}
		
		/**
		 * Draw the view of the component.
		 */
		public override function draw( ...arguments:Array ):void 
		{
			if ( numChildren > 0 ) 
			{
				changeChildsPosition() ;
			}
			resize() ;
			refreshMask() ;
		}
		
		/**
		 * Returns the internal Dimension object of this display.
		 * @return the internal Dimension object of this display.
		 */	
		public function getDimension():Dimension 
		{ 
			return _bound ;
		}
		
		/**
		 * Returns the string representation of the coordinate attribute used in this display with the current direction value.
		 * @return the string representation of the coordinate attribute used in this display with the current direction value.
		 */
		public function getCoordinateProperty():String 
		{
			return (direction == Direction.VERTICAL) ? propY : propX ;
		}

		/**
		 * Returns the child position with the specified index and the current direction of this display.
		 * @return the child position with the specified index and the current direction of this display.
		 */
		public function getChildPositionAt(n:Number):Number 
		{
			var o:DisplayObject = getChildAt(n-1) ;
			var p:String        = getCoordinateProperty() ;
			var s:String        = getSizeProperty() ;
			return (o != null) ? (o[p] + o[s] + _space) : 0 ;
		}
		
		/**
		 * Returns the string representation of the size attribute with the current direction.
		 * @return the string representation of the size attribute with the current direction.
		 */
		public function getSizeProperty():String 
		{
			return (direction == Direction.VERTICAL) ? propHeight : propWidth ;
		}
		
		/**
	 	 * Use the mask protection.
	 	 */
		public function lockMask():void
		{
			_lockMask = true;	
		}
		
		/**
		 * Refresh the mask view of the display.
	 	*/
		protected function refreshMask():void 
		{
			
			_mask.graphics.clear() ;
			view.scrollRect = null ;
			view.mask       = null ;
			if ( maskIsActive && _lockMask == false ) 
			{
				
				_mask.graphics.beginFill( 0xFF0000 , 60 ) ;
				_mask.graphics.drawRect( 0, 0, _bound.width , _bound.height ) ;
				_mask.graphics.endFill() ;
									
				if ( useScrollRect )
				{
					view.scrollRect = new Rectangle(0, 0, _bound.width , _bound.height ) ;	
				}
				else
				{

					if ( view != this )
					{
						view.mask = _mask ;
					}
				}
			}	

		}
		
		/**
		 * Invoked when the container size change.
		 */
		public function resize():void 
		{
			
			if ( childCount > 0) 
			{
            	var nW:Number = EdgeMetrics.filterNaNValue( border.left ) + EdgeMetrics.filterNaNValue( border.right ) ;
            	var nH:Number = EdgeMetrics.filterNaNValue( border.top  ) + EdgeMetrics.filterNaNValue( border.bottom ) ;
				var isHorizontal:Boolean = direction == Direction.HORIZONTAL ;
				var n:Number = childCount ;
				var n1:Number = 0 ;
				var n2:Number = 0 ;
				var d:DisplayObject ;
				var p:String = isHorizontal ? propWidth  : propHeight ;
				var f:String = isHorizontal ? propHeight : propWidth  ;
				var s:Number = space ;
				for (var i:uint = 0 ; i<n ; i++) 
				{
					d = getChildAt(i) ;
					n1 += s + d[p] ;
					n2 = Math.max(d[f], n2) ;
				}
				n1 -= s || 0 ;
				_bound.width  = (isHorizontal ? n1 : n2) + nW ; 
				_bound.height = (isHorizontal ? n2 : n1) + nH ; 
				break ;
			}
			else if ( maskIsActive ) 
			{
				_bound.width  = _w ;
				_bound.height = _h ; 
			}
			else 
			{
				_bound.width  = width ;
				_bound.height = height ;
			}
			_w = _bound.width ; 
			_h = _bound.height ;
		}
		

		/**
		 * Unlock the mask protection.
		 */
		public function unlockMask():void
		{
			_lockMask = false;	
		}
		
		/**
		 * @private
		 */
		private var _bound:Dimension ;
				
		/**
		 * @private
		 */
		private var _childCount:int = -1 ;
		
		/**
		 * @private
		 */
		private var _direction:String = Direction.VERTICAL ;

		/**
		 * @private
		 */
		private var _lockMask:Boolean = false ;

		/**
		 * @private
		 */
		private var _mask:Shape ;

		/**
		 * @private
		 */
		private var _maskIsActive:Boolean = false;
		
		/**
		 * @private
		 */
		private var _space:Number = 0 ;		
		
		/**
		 * @private
		 */
		private var _useScrollRect:Boolean = false ;
		
	}	

}
