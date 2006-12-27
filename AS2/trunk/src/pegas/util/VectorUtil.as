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
	 * Computes the norm of the {@code Vector}.
	 * @param v a Vector reference.
	 * @return the norm of the specified {@code Vector}.
	 */
	static public function getNorm( v:Vector ):Number
	{
		return Math.sqrt( (v.x * v.x) + (v.y * v.y) + (v.z * v.z) );
	}

	/**
	 * Computes the oposite Vector of the {@code Vector}.
	 * @param {@code v} the Vector reference to negate.
	 * @return a new negate {@code Vector} reference.
	 */
	public static function negate( v:Vector ): Vector
	{
		return new Vector( - v.x, - v.y, - v.z );
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
	 * Computes the power of the specified Vector.
	 * @param v the Vector reference.
	 * @param valut the value of the pow..
	 * @return A new Vector powered by the method.
	 */
	static public function pow( v:Vector, value:Number ):Vector
	{
		return new Vector( Math.pow( v.x, value ) , Math.pow( v.x, value ) ,  Math.pow( v.x, value ) ) ;
	}

	/**
	 * Scales the specified Vector with the input value.
	 * @param vector the Vector reference to transform.
	 * @param value a real number to scale the current Vector.
	 */
	static public function scale( vector:Vector, value:Number ):Void
	{
		vector.x *= value ;
		vector.y *= value ;
		vector.z *= value ;
	}

}