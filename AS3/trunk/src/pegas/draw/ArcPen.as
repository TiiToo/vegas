/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is PEGAS Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package pegas.draw 
{
	import flash.display.Graphics;
	
	import pegas.draw.Pen;
	import pegas.util.Trigo;	

	/**
	 * This pen draw a pie or chord arc shape in a MovieClip reference.
	 * @author eKameleon
	 */
	dynamic public class ArcPen extends Pen 
	{

		/**
		 * Creates a new ArcPen instance.
		 * @param graphic The Graphics reference to control with this helper.
	 	 */
		public function ArcPen( graphic:Graphics , radius:Number = 100 , angle:Number = 0 , startAngle:Number = 360 , x:Number = 0 , y:Number = 0 , yRadius:Number = NaN , align:uint = 10  , type:String = "pie" )
		{
			super( graphic ) ;
			setArc( radius, angle, startAngle, x, y, yRadius , align , type ) ;
		}
		
		/**
	 	 * (read-write) Returns the value of the angle used to draw an arc shape in the movieclip reference.
		 * @return the value of the angle used to draw an arc shape in the movieclip reference.
		 */
		public function get angle():Number 
		{
			return _angle ;
		}
		
		/**
		 * (read-write) Sets the value of the angle used to draw an arc shape in the movieclip reference.
		 */
		public function set angle(n:Number):void 
		{
			_angle = Trigo.fixAngle(n) ;
		}

		/**
		 * Defines the radius value of the arc shape.
		 */
		public var radius:Number = 100;

		/**
		 * Defines the type of the arc, can be a chord or a pie arc.
		 * @see ArcType
		 */
		public var type:String = ArcType.CHORD ;

		/**
		 * Defines the x origin position of the arc shape.
		 */
		public var x:Number = 0 ;
		
		/**
		 * Defines the y origin position of the arc shape.
		 */
		public var y:Number = 0 ;

		/**
		 * Defines the y origin position of the arc radius.
		 */
		public var yRadius:Number = NaN ;

		/**
		 * (read-write) Returns the value of the start angle to draw the arc in the movieclip reference.
		 * @return the value of the start angle to draw the arc in the movieclip reference.
		 */
		public function get startAngle():Number 
		{
			return _startAngle ;	
		}
	
		/**
		 * (read-write) Sets the value of the start angle to draw the arc in the movieclip reference.
		 */
		public function set startAngle(n:Number):void 
		{
			_startAngle = Trigo.degreesToRadians(n) ;
		}

		/**
		 * Draws the shape in the movieclip reference of this pen.
		 * @param angle (optional) The angle of the arc pen.
		 * @param startAngle (optional) The start angle of the pen.
		 * @param x (optional) The x position of the center of the arc.
		 * @param y (optional) The y position of the center of the arc.
		 * @param yRadius (optional) The y radius value of the pen.
		 * @param align (optional) The align value of the pen.
 		 * @param type (optional) The ArcType of the pen.
		 */
		public override function draw( ...arguments:Array ):void 
		{
			if (arguments.length > 0) 
			{
				setArc.apply(this, arguments) ;
			}
			super.draw() ;
		}
			
		/**
		 * This method contains the basic drawing shape algorithm.
		 */
		public override function drawShape():void
		{
			var nR:Number = isNaN( yRadius ) ? radius : yRadius ;

			var $x:Number = isNaN(x) ? 0 : x ; 
			var $y:Number = isNaN(y) ? 0 : y ;
			
			switch ( align ) 
			{
				case Align.TOP :
				{
					$y += nR ;
					break ;
				}
				case Align.BOTTOM :
				{
					$y -= nR ;
					break ;
				}
				case Align.LEFT :
				{
					$x += radius ;
					break ;
				}
				case Align.RIGHT :
				{
					$x -= radius ;
					break ;
				}
				case Align.TOP_LEFT :
				{
					$x += radius ;
					$y = nR ;
					break ;
				}
				case Align.TOP_RIGHT :
				{
					$x -= radius ;
					$y = nR ;
					break ;
				}
				case Align.BOTTOM_LEFT :
				{
					$x += radius ;
					$y -=  nR ;
					break ;
				}
				case Align.BOTTOM_RIGHT :
				{
					$x -= radius ;
					$y -= nR ;
					break ;
				}
			}
						
			graphics.moveTo( $x, $y ) ;
		
			var ax:Number ; var ay:Number ; 
			var bx:Number ; var by:Number ; 
			var cx:Number ; var cy:Number ;
			
			var angleMid:Number ;

			var segs:Number = Math.ceil ( Math.abs(_angle) / 45 ) ;
			var segAngle:Number = _angle / segs ;
			
			var theta:Number = - Trigo.degreesToRadians(segAngle) ;
			
			var a:Number = - _startAngle  ;
			
			if (segs>0) 
			{
				
				ax = $x + Math.cos (_startAngle) * radius ;
				ay = $y + Math.sin (-_startAngle) * nR ;
				if (_angle < 360 && _angle > -360 && type == ArcType.PIE) 
				{
					graphics.lineTo (ax, ay) ;
				}
				graphics.moveTo (ax, ay) ;
				
				for (var i:Number = 0 ; i<segs ; i++) 
				{
					a += theta ;
					angleMid = a - ( theta / 2 ) ;
					bx = $x + Math.cos ( a ) * radius ;
					by = $y + Math.sin ( a ) * nR ;
					cx = $x + Math.cos( angleMid ) * ( radius / Math.cos ( theta / 2 ) ) ;
					cy = $y + Math.sin( angleMid ) * ( nR / Math.cos( theta / 2 ) ) ;
					graphics.curveTo(cx, cy, bx, by) ;
				}
				
				if( type == ArcType.PIE ) 
				{
					if (_angle < 360 && _angle > -360) 
					{
						graphics.lineTo($x, $y);
					}
				}
				else 
				{ 
					graphics.lineTo(ax, ay); // CHORD or other value
				}
				
			}
			
			if (isEndFill) 
			{
				graphics.endFill() ;
			}	

		}

		/**
		 * Sets the arc options to defined all values to draw the arc shape in the movieclip reference of this pen.
		 * @param angle (optional) The angle of the arc pen.
		 * @param startAngle (optional) The start angle of the pen.
		 * @param x (optional) The x position of the center of the arc.
		 * @param y (optional) The y position of the center of the arc.
		 * @param yRadius (optional) The y radius value of the pen.
		 * @param align (optional) The align value of the pen.
 		 * @param type (optional) The ArcType of the pen.
		 */
		public function setArc( radius:Number = 100 , angle:Number = 0 , startAngle:Number = 360 , x:Number = 0 , y:Number = 0 , yRadius:Number = NaN , align:uint = 10  , type:String = "pie"  ):void 
		{
			this.radius = radius ;
			this.angle = angle ;
			this.startAngle = startAngle ;
			this.x = x ;
			this.y = y ;
			this.yRadius = yRadius ;
			this.align = align ;
			this.type = type ? ArcType.CHORD : ArcType.PIE ;
		}
		
		/**
		 * @private
		 */
		private var _angle:Number ;

		/**
		 * @private
		 */
		private var _startAngle:Number ;
		
	}

}
