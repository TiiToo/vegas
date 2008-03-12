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

package pegas.geom 
{
	import pegas.geom.Vector2;
	
	import system.Reflection;
	
	import vegas.util.Serializer;	

	/**
	 * Represents a vector in a 3D world with the coordinates x, y and z.
	 * @author eKameleon
	 */
	public class Vector3 extends Vector2 
	{
	
		/**
		 * Creates a new <code class="prettyprint">Vector3</code> instance.
		 * @param x the x coordinate.
		 * @param y the y coordinate.
		 * @param z the z coordinate.
		 */ 
		public function Vector3( x:Number = 0, y:Number = 0 ,  z:Number = 0 )
		{
			super( x , y ) ;
			this.z = isNaN( z ) ? 0 : z ;
		}
		
		/**
		 * Defines the Vector3 object with the x, y and z properties set to zero.
		 */
		public static var ZERO:Vector3 = new Vector3(0,0,0) ;
		
		/**
		 * Defined the z coordinate.
		 */
		public var z:Number;
		
		/**
		 * Returns a shallow copy of this instance.
		 * @return a shallow copy of this instance.
		 */
		public override function clone():*
		{
			return new Vector3(x, y, z) ;	
		}
	
		/**
	 	 * Returns a deep copy of this instance.
	 	 * @return a deep copy of this instance.
	 	 */
		public override function copy():*
		{
			return new Vector3( x, y, z ) ;	
		}
		
		/**
	 	 * Compares the specified object with this object for equality.
	 	 * @return <code class="prettyprint">true</code> if the the specified object is equal with this object.
	 	 */
		public override function equals( o:* ):Boolean 
		{
			if ( o is Vector3)
			{
				return (o.x == x) && (o.y == y) && (o.z == z) ;
			}
			return false ;
		}

		/**
		 * Returns the Object representation of this object.
		 * @return the Object representation of this object.
		 */
		public override function toObject() : Object 
		{
			return { x:x , y:y , z:z } ;
		}
		
		/**
		 * Returns a Eden reprensation of the object.
		 * @return a string representing the source code of the object.
		 */
		public override function toSource( indent:int = 0 ):String 
		{
			return Serializer.getSourceOf(this, [x, y, z]) ;
		}
	
		/**
	  	 * Returns the string representation of the object.
	 	 * @return the string representation of the object.
	 	 */ 	
		public override function toString():String
		{
			return "[" + Reflection.getClassName(this) + " {" + x + "," + y + "," + z + "}]" ;
		}
		
	}
}


