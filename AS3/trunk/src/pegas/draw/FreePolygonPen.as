﻿/*

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
	import flash.geom.Point;
	
	import pegas.draw.Pen;
	import pegas.geom.Vector2;
	
	import vegas.errors.UnsupportedOperation;		

	/**
	 * This pen is the tool to draw a free polygon vector shape. This class don't use the 'align' property.
	 * @author eKameleon
	 */
	dynamic public class FreePolygonPen extends Pen 
	{
		
		/**
		 * The Pen class use composition to control a Graphics reference and draw custom free polygon vector graphic shapes.
		 * @param graphic The Graphics reference to control with this helper.
		 * @param ...arguments An array of flash.geom.Point or pegas.geom.Vector2 objects or an argument serie of point objects. 
		 * @author eKameleon
		 */
		public function FreePolygonPen( graphic:Graphics , ...arguments:Array )
		{
			super( graphic ) ;
			if ( arguments.length == 1 && arguments[0] is Array ) 
			{
				this.points = arguments[0] ;
			}
			else if ( arguments.length > 0 )
			{
				this.points = arguments ;
			}
		}

		/**
	 	 * @private
	 	 */
		public override function set align( align:uint ):void 
		{
			throw new UnsupportedOperation( this + " align property can't be use to align this free shape.") ;
		}

		/**
		 * The list of all flash.geom.Point or pegas.geom.Vector2 objects to draw the specified polygon.
		 */
		public function get points():Array
		{
			return _points ;	
		}
		
		/**
		 * @private
		 */
		public function set points( ar:Array ):void
		{
			if ( ar == null || ar.length == 0 )
			{
				_points = null ;
			}
			else
			{
				_points = [] ;
				var len:uint = ar.length ;
				for(var i:uint = 0 ; i<len ; i++)
				{
					var p:* = ar[i] ;
					if ( p is Point || p is Vector2 )
					{
						_points.push( p ) ;						
					}
				}
			}
		}
		
		/**
		 * Draws the shape.
		 * @param ...arguments An array of flash.geom.Point or pegas.geom.Vector2 objects or an argument serie of point objects.
		 */
		public override function draw( ...arguments:Array ):void
		{
			if ( arguments.length == 1 && arguments[0] is Array ) 
			{
				points = arguments[0] ;
			}
			else if ( arguments.length > 0 )
			{
				points = arguments ;
			}
			super.draw() ;
		}

		/**
		 * This method contains the basic drawing shape algorithm.
		 */
		public override function drawShape():void
		{
			if ( _points == null )
			{
				return ;
			}
			var size:uint = _points.length ;
			if ( size > 1 ) 
			{
				graphics.moveTo( _points[0].x, _points[0].y );
            	for( var i:int = 1 ; i< size ; i++ )
                {
                	graphics.lineTo( _points[i].x, _points[i].y );
                }
            	graphics.lineTo( _points[0].x, _points[0].y );
			}
		}
		
		/**
		 * @private
		 */
		private var _points:Array = null ;
		
	}

	
}
