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
package pegas.util 
{
	import pegas.geom.Vector2;	
	
	/**
	 * Static tool class to manipulate and transform <code class="prettyprint">Vector2</code> references.
	 * @author eKameleon
	 */
	public class Vector2Util 
	{
		
		/**
		 * Computes the addition of two Vector2 and returns the first vector.
		 * @param v1 the first Vector2.
		 * @param v2 the second Vector2.
		 * @return the addition result of two Vector2.
		 */
		public static function addition( v1:Vector2, v2:Vector2 ):Vector2
		{
		 	v1.x += v2.x ;
		 	v1.y += v2.y ;
		 	return v1 ;	
		}
		
		/**
		 * Computes the addition of two Vector2.
		 * @param v1 a Vector2 to concat.
		 * @param v2 a Vector2 to concat.
		 * @return the addition result of two Vector2.
		 */
		public static function getAddition( v1:Vector2, v2:Vector2 ):Vector2
		{
		return new Vector2( (v1.x + v2.x) , (v1.y + v2.y) ) ;	
		}
	
		/**
	 	 * Returns the distance between the 2 vectors in argument.
		 * @param v1 the first vector.
		 * @param v2 the second vector.
		 * @return the distance between the 2 vectors in argument.
	 	 */
		public static function getDistance( v1:Vector2, v2:Vector2 ):Number
		{
			return Math.sqrt( Vector2Util.getSquaredDistance( v1, v2 ) ) ;
		}
		
		/**
		 * Returns the length of the vector.
		 * @param v the vector.
		 * @return the length of the vector.
		 */
		public static function getLength( v:Vector2 ):Number
		{
			return Math.sqrt( (v.x * v.x) + (v.y * v.y) ) ;
		}
		
		/**
	 	 * Returns the middle Vector2 between 2 Points.
		 * <p><b>Example :</b></p>
		 * <code class="prettyprint">
		 * var p1:Vector2 = new Vector2(10,10) ;
		 * var p2:Vector2 = new Vector2(20,20) ;
		 * var middle:Vector2 = Vector2Util.getMiddle(p1,p2) ;
		 * trace(middle) ;
		 * </code>
	 	 * @return the middle Point between 2 Points.
		 */
		public static function getMiddle(p1:Vector2, p2:Vector2):Vector2 
		{
			return new Vector2( (p1.x + p2.x) / 2 , (p1.y + p2.y) / 2) ;
		}
		
		/**
		 * Normalizes the Vector2 instance passed in argument..
		 * @param v the Vector2 to normalize.
		 * @return a normalized Vector2, with length 1.
		 */
		public static function getNormalize( v:Vector2 ):Vector2
		{
			var len:Number = 1 / Vector2Util.getLength(v) ;
			return Vector2Util.getScale( v , len ) ;
		}
		
		/**
		 * Computes the power of the specified Vector2.
		 * @param v the Vector2 reference.
		 * @param value the value of the pow..
		 * @return A new Vector2 powered by the method.
		 */
		public static function getPow( v:Vector2, value:Number ):Vector2
		{
			return new Vector2( Math.pow( v.x, value ) , Math.pow( v.y, value ) ) ;
		}
		
		/**
		 * Scales the specified Vector2 with the input value.
		 * @param vector the Vector2 reference to transform.
		 * @param value a real number to scale the current Vector2.
		 * @return A new Vector2 scaled by the value passed in second argument in this method.
		 */
		public static function getScale( v:Vector2, value:Number ):Vector2
		{
			return new Vector2 ( v.x * value , v.y * value ) ;
		}
		
		/**
		 * Returns the squared distance between 2 vectors.
		 * @param v1 the first vector.
		 * @param v2 the second vector.
		 * @return the squared distance between 2 vectors.
		 */
		public static function getSquaredDistance( v1:Vector2, v2:Vector2 ):Number
		{
			var dx:Number= v2.x - v1.x ;
			var dy:Number= v2.y - v1.y ; 
			return (dx * dx) + (dy * dy) ;
		}
			
		/**
		 * Returns the squared length of this vector.
	 	 * @param v the vector.
		 * @return the squared length of this vector.
		 */
		public static function getSquaredLength( v:Vector2 ):Number
		{
			return (v.x * v.x) + (v.y * v.y) ;
		}
		
		/**
		 * Computes the substraction of two Vector2.
		 * @param v1 a Vector2 to substract.
	 	 * @param v2 a Vector2 to substract.
		 * @return the substraction result of two Vector2.
		 */
		public static function getSubstraction( v1:Vector2 , v2:Vector2 ):Vector2
		{
			return new Vector2( (v1.x - v2.x) , (v1.y - v2.y) ) ;
		}
	
		/**
	 	 * Sets the specified <code class="prettyprint">Vector2</code> object with the second <code class="prettyprint">Vector2</code> object passed in argument.
		 * @param v1 the first <code class="prettyprint">Vector2</code>.
		 * @param v2 the second <code class="prettyprint">Vector2</code>.
		 * @return the first <code class="prettyprint">Vector2</code> transformed.
		 */
		public static function setByVector2( v1:Vector2, v2:Vector2):Vector2
		{
			v1.x = v2.x ;
			v1.y = v2.y ;
			return v1 ;
		}
				
		/**
		 * Computes the substraction of two Vector2.
		 * @param v1 the first Vector2.
	 	 * @param v2 the second Vector2.
	 	 * @return the substraction result of two Vector2.
		 */
		public static function substraction( v1:Vector2 , v2:Vector2 ):Vector2
		{
		 	v1.x -= v2.x ;
			v1.y -= v2.y ;
		 	return v1 ;	
		}
		
	}

}
