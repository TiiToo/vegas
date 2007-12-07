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
	import pegas.geom.Rectangle;	

	/**
	 * This pen draw a rectangle shape with a Graphics object.
	 * @author eKameleon
	 */
	public class RectanglePen extends Pen 
	{

		/**
		 * Creates a new ArcPen instance.
		 * @param graphic The Graphics reference to control with this helper.
		 * @param x (optional) The x position of the pen. (default 0)
		 * @param y (optional) The y position of the pen. (default 0)
		 * @param width (optional) The width of the pen. (default 0)
		 * @param height (optional) The height of the pen. (default 0)
 		 * @param align (optional) The align value of the pen. (default Align.TOP_LEFT)
	 	 */
		public function RectanglePen( graphic:Graphics , x:Number = 0 , y:Number = 0 , width:Number = 0 , height:Number = 0 , align:uint = 10 )
		{
			super( graphic );
			setPen( x, y, width, height , align ) ;
		}
	
		/**
		 * Defines the height of the shape rectangle. 
		 */
		public var height:Number ;

		/**
		 * Returns the Rectangle reference of this pen.
		 * @return the Rectangle reference of this pen.
	 	*/
		public function get rectangle():Rectangle 
		{
			return new Rectangle( x, y, width, height ) ;
		}

		/**
		 * Defines the width of the shape rectangle. 
		 */
		public var width:Number ;

		/**
		 * Defines the x position of the shape rectangle. 
		 */
		public var x:Number ;
		
		/**
		 * Defines the y position of the shape rectangle. 
		 */
		public var y:Number ;
		
		/**
		 * Draws the shape in the movieclip reference of this pen.
		 * @param x (optional) The x position of the pen.
		 * @param y (optional) The y position of the pen.
		 * @param width (optional) The width of the pen.
		 * @param height (optional) The height of the pen.
 		 * @param align (optional) The align value of the pen.
		 */
		public override function draw( ...args:Array):void 
		{
			if ( args.length > 0 ) 
			{
				setPen.apply( this , args ) ;
			}
			super.draw() ;
		}
			
		/**
		 * This method contains the basic drawing shape algorithm.
		 */
		public override function drawShape():void
		{
			var $x:Number = x ;
			var $y:Number = y ;
			if( align == Align.BOTTOM ) 
			{
				$x -= width / 2 ;
				$y -= height ;
			}
			else if ( align == Align.BOTTOM_LEFT )
			{
				$y -= height ;
			}
			else if ( align == Align.BOTTOM_RIGHT )
			{
				$x -= width ;
				$y -= height ;
			}
			else if ( align == Align.CENTER )
			{
				$x -= width / 2 ;
				$y -= height / 2 ;
			}
			else if ( align == Align.LEFT )
			{
				$y -= height / 2 ;
			}
			else if ( align == Align.RIGHT )
			{
				$x -= width ;
				$y -= height / 2 ;
			}
			else if ( align == Align.TOP )
			{
				$x -= width / 2 ;
			}
			else if ( align == Align.TOP_RIGHT )
			{
				$x -= width ;
			}
			else // Align.TOP_LEFT
			{
				
			}
			graphics.drawRect( $x , $y , width , height ) ;
		}
	
		/**
		 * Sets the arc options to defined all values to draw the arc shape in the movieclip reference of this pen.
		 * @param x (optional) The x position of the pen.
		 * @param y (optional) The y position of the pen.
		 * @param width (optional) The width of the pen.
		 * @param height (optional) The height of the pen.
 		 * @param align (optional) The align value of the pen.
		 */
		public function setPen( ...args:Array  ):void 
		{
			if ( args[0] != null && args[0] is Number )
			{
				this.x = isNaN( args[0] ) ? 0 : args[0] ;
			}
			if ( args[1] != null && args[1] is Number )
			{
				this.y = isNaN( args[1] ) ? 0 : args[1] ;
			}
			if ( args[2] != null && args[2] is Number )
			{
				this.width = isNaN( args[2] ) ? 0 : args[2] ;
			}
			if ( args[3] != null && args[3] is Number )
			{
				this.height = isNaN( args[3] ) ? 0 : args[3] ;
			}
			if ( args[4] != null )
			{
				this.align = args[4] ;
			}
		}
		
	}
}
