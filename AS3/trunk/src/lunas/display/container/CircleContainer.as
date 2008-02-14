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
	
	import asgard.display.CoreSprite;
	
	import lunas.display.container.Container;
	
	import pegas.draw.Align;
	import pegas.util.Trigo;	

	/**
	 * This container display all this child elements with a circle trigonometric algorithm. 
	 * @author eKameleon
	 */
	public class CircleContainer extends Container 
	{

		/**
		 * Creates a new CircleContainerDisplay instance.
		 */
		public function CircleContainer(id:* = null, isConfigurable:Boolean = false, name:String = null)
		{
			super( id, isConfigurable, name );
			
			_container = new CoreSprite( null , false , "container" ) ;
			
			lock() ;
			
			addChild( _container ) ;
			
			unlock() ;
			
			registerView( _container ) ;
			
			update() ;
			
		}
		
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
		public function set align(nAlign:Number):void 
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
		public function set childCount(n:Number):void 
		{
			_childCount = n > 1 ? n : 1 ;
			update() ;
		}	
		
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
		public function set radius(n:Number):void 
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
		public function set startAngle(n:Number):void 
		{
			_startAngle = Trigo.degreesToRadians( isNaN(n) ? 0 : n%360 ) ;
			update() ;
		}	
		
		/**
		 * Draw the component display.
		 */
		public override function draw( ...arguments:Array ):void
		{
			
			_container.x = 0 ;
			_container.y = 0 ;
			
			if ( numChildren > 0 ) 
			{
				changeChildsPosition() ;
				
				var a:Number = align ;
							
			if (a == Align.CENTER) 
			{
				// default
			}
			else if (a == Align.BOTTOM) 
			{
				_container.y -= _container.height / 2 ;
			}
			else if (a == Align.BOTTOM_LEFT) 
			{
				_container.x += _container.width / 2 ;
				_container.y -= _container.height / 2 ;
			}
			else if (a == Align.BOTTOM_RIGHT) 
			{
				_container.x -= _container.width / 2 ;
				_container.y -= _container.height / 2 ;
			}
			else if (a == Align.LEFT) 
			{
				_container.x += _container.width / 2 ;
			}
			else if (a ==  Align.RIGHT) 
			{
				_container.x -= _container.width / 2 ;
			}
			else if (a == Align.TOP) 
			{
				_container.y += _container.height / 2 ;
			}
			else if (a == Align.TOP_RIGHT) 
			{
				_container.x -= _container.width / 2 ;
				_container.y += _container.height / 2 ;
			}
			else // TOP_LEFT
			{
				_container.x += _container.width / 2 ;
				_container.y += _container.height / 2 ;
			}		
		}		
	}	
	
		/**
		 * Refreshs and changes the child position of all childs in the _container.
		 */
		public function changeChildsPosition():void 
		{
			var child:DisplayObject ;
			var l:Number = numChildren ;
			for (var i:Number = 0 ; i<l ; i++) 
			{
				child         = getChildAt(i) ;
				child.x       = radius * Math.cos( _startAngle - Math.PI / 2 + i * 2 * Math.PI / childCount  )  ;
				child.y       = radius * Math.sin( _startAngle - Math.PI / 2 + i * 2 * Math.PI / childCount  )  ;
			}
		}
	
		/**
		 * @private
	 	 */
		private var _align:Number = Align.TOP_LEFT ;
		
		/**
		 * @private
		 */
		private var _childCount:Number = 10 ;	
		
		/**
		 * This CoreSprite reference defines a container display.
		 */
		protected var _container:CoreSprite ;		
		
		/**
		 * @private
		 */
		private var _radius:Number = 100 ;
			
		/**
		 * @private
		 */
		private var _startAngle:Number = 0 ;	
		
	}
}
