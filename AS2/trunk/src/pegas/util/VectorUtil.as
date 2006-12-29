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
  Portions created by the Initial Developer are Copyright (C) 2004-2007
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

import pegas.geom.Vector;

/**
 * Static tool class to manipulate and transform {@code Vector} references.
 * @author eKameleon
 */
class pegas.util.VectorUtil 
{

	/**
	 * Computes the addition of two Vectors.
	 * @param v1 a Vector to concat.
	 * @param v2 a Vector to concat.
	 * @return the addition result of two Vectors.
	 */
	static public function getAddition( v1:Vector, v2:Vector ):Vector
	{
		return new Vector( (v1.x + v2.x) , (v1.y + v2.y) , (v1.z + v2.z) ) ;	
	}

	/**
	* Returns the angle in radian between the two 3D vectors. The formula used here is very simple.
	* It comes from the definition of the dot product between two vectors.
	* @param v1	Vector The first Vector.
	* @param v2	Vector The second Vector.
	* @return the angle in radian between the two vectors.
	*/
	static public function getAngle ( v1:Vector, v2:Vector ):Number
	{
		var ncos:Number = (VectorUtil.getDot( v1, v2 )) / ( getNorm(v1) * getNorm(v2) );
		var sin2:Number = 1 - (ncos * ncos) ;
		if (sin2<0)
		{
			trace(" wrong "+ ncos ) ;
			sin2 = 0 ;
		}
		// I took long time to find this bug. Who can guess that (1-cos*cos) is negative ? !
		// sqrt returns a NaN for a negative value !
		return  Math.atan2( Math.sqrt(sin2), ncos );
	}

	/**
	 * Computes the cross product of the two Vectors.
	 * @param v1 a {@code Vector}.
	 * @param v2 a {@code Vector}.
	 * @return the {@code Vector} resulting of the cross product.
	 */
	static public function getCross( v1:Vector, v2:Vector ):Vector
	{
		return new Vector
		( 	
			(v2.y * v1.z) - (v2.z * v1.y) ,
			(v2.z * v1.x) - (v2.x * v1.z) ,
			(v2.x * v1.y) - (v2.y * v1.x)
		);
	}
	
	/**
	 * Computes the dot product of the two Vectors.
	 * @param v1 a {@code Vector}.
	 * @param v2 a {@code Vector}.
	 * @return the dot product of the 2 Vectors.
	 */
	static public function getDot( v1:Vector, v2:Vector ):Number
	{
		return (v1.x * v2.x) + (v1.y * v2.y) + (v1.z * v2.z) ;	
	}

	/**
	 * Computes the oposite Vector of the {@code Vector}.
	 * @param {@code v} the Vector reference to negate.
	 * @return a new negate {@code Vector} reference.
	 */
	public static function getNegate( v:Vector ):Vector
	{
		return new Vector( - v.x, - v.y, - v.z );
	}	

	/**
	 * Computes the norm of the {@code Vector}.
	 * @param v a Vector reference.
	 * @return the norm of the specified {@code Vector}.
	 */
	static public function getNorm( v:Vector ):Number
	{
		return Math.sqrt( (v.x * v.x) + (v.y * v.y) + (v.z * v.z) );
	}

	/**
	 * Computes the power of the specified Vector.
	 * @param v the Vector reference.
	 * @param valut the value of the pow..
	 * @return A new Vector powered by the method.
	 */
	static public function getPow( v:Vector, value:Number ):Vector
	{
		return new Vector( Math.pow( v.x, value ) , Math.pow( v.x, value ) ,  Math.pow( v.x, value ) ) ;
	}

	/**
	 * Scales the specified Vector with the input value.
	 * @param vector the Vector reference to transform.
	 * @param value a real number to scale the current Vector.
	 * @return A new Vector scaled by the value passed in second argument in this method.
	 */
	static public function getScale( v:Vector, value:Number ):Vector
	{
		return new Vector ( v.x * value , v.y * value , v.z * value ) ;
	}

	/**
	 * Computes the substraction of two Vectors.
	 * @param v1 a Vector to concat.
	 * @param v2 a Vector to concat.
	 * @return the substraction result of two Vectors.
	 */
	static public function getSubstraction( v1:Vector , v2:Vector ):Vector
	{
		return new Vector( (v1.x - v2.x) , (v1.y - v2.y) , (v1.z - v2.z) ) ;
	}

	/**
	 * Normalize the specified {@code Vector} in parameter.
	 * @param v a Vector reference.
	 * @return {@code true} of the normalize method is success else false for mistake.
	 */	
	static public function normalize( v:Vector ):Boolean
	{
		var norm:Number = getNorm( v );
		if( norm == 0 || norm == 1) 
		{
			return false ;
		}
		v.x /= norm ;
		v.y /= norm ;
		v.z /= norm ;
		return true ;
	}

	/**
	 * Scales the specified Vector with the input value.
	 * @param vector the Vector reference to transform.
	 * @param value a real number to scale the current Vector.
	 */
	static public function scale( v:Vector, value:Number ):Void
	{
		v.x *= value ;
		v.y *= value ;
		v.z *= value ;
	}

}