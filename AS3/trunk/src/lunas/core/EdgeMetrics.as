﻿/*

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
package lunas.core 
{
	import pegas.geom.IGeometry;
	
	import vegas.core.CoreObject;	

	/**
	 * The EdgeMetrics class specifies the thickness, in pixels, of the four edge regions around a visual component.
	 * @author eKameleon
	 */
	public class EdgeMetrics extends CoreObject implements IGeometry
	{
		
		/**
		 * Creates a new EdgeMetrics instance.
		 * @param left The width, in pixels, of the left edge region.
		 * @param top The height, in pixels, of the top edge region.
		 * @param right The width, in pixels, of the right edge region.
		 * @param bottom The height, in pixels, of the bottom edge region.
		 */
		public function EdgeMetrics( left:Number = 0, top:Number = 0, right:Number = 0, bottom:Number = 0 )
		{
			super();
			this.bottom = bottom ;
			this.left   = left ;
			this.right  = right ;
			this.top    = top ;
		}

		/**
		 *  An EdgeMetrics object with a value of zero for its
		 *  <code>left</code>, <code>top</code>, <code>right</code>,
		 *  and <code>bottom</code> properties.
		 */
		public static const EMPTY:EdgeMetrics = new EdgeMetrics(0, 0, 0, 0) ;

		/**
		 *  The height, in pixels, of the bottom edge region.
		 */
		public var bottom:Number ;
		
		/**
		 *  The width, in pixels, of the left edge region.
		 */
		public var left:Number ;
		
		/**
		 *  The width, in pixels, of the right edge region.
		 */
		public var right:Number ;
		
		/**
		 *  The height, in pixels, of the top edge region.
		 */
		public var top:Number ;

		/**
		 * Returns a shallow copy of this instance.
		 * @return a shallow copy of this instance.
		 */
		public function clone():*
		{
			return new EdgeMetrics(left, top, right, bottom);
		}

		/**
		 * Returns a deep copy of this instance.
		 * @return a deep copy of this instance.
		 */
		public function copy():*
		{
			return new EdgeMetrics(left, top, right, bottom);
		}

		/**
		 * Compares the specified object with this object for equality.
		 * @return {@code true} if the the specified object is equal with this object.
		 */
		public function equals( o:* ):Boolean
		{
			if ( o is EdgeMetrics )
			{
				return o.top == top && o.left = left && o.right == right && o.bottom == bottom ;
			}
			else 
			{
				return false ;
			}
		}
		
		/**
		 * Returns the Object representation of this object.
		 * @return the Object representation of this object.
		 */
		public function toObject():Object 
		{
			return { bottom:bottom , left:left , right:right , top:top } ;
		}
		
	}
}
