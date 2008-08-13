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

import vegas.core.CoreObject;
import vegas.core.ICloneable;
import vegas.util.ConstructorUtil;
import vegas.util.serialize.Serializer;

/**
 * Determinates the corner parameters in a CornerRectanglePen (Bevel, Rounded...)
 * @author eKameleon
 */
class pegas.draw.Corner extends CoreObject implements ICloneable 
{
	
	/**
	 * Creates a new Corner instance.
	 */
	public function Corner(tl:Boolean , tr:Boolean, br:Boolean, bl:Boolean) 
	{
		super() ;
		if (tl != null) 
		{
			this.tl = tl ;
		}
		if (br!= null) 
		{
			this.br = br ;
		}
		if (tr!= null) 
		{
			this.tr = tr ;
		}
		if (bl!= null) 
		{
			this.bl = bl ;
		}
	}
	
	/**
	 * The bottom left flag value.
	 */
	public var bl:Boolean = true ; 

	/**
	 * The bottom right flag value.
	 */
	public var br:Boolean = true ; 

	/**
	 * The top left flag value.
	 */
	public var tl:Boolean = true ; 

	/**
	 * The top right flag value.
	 */
	public var tr:Boolean = true ; 
	
	/**
	 * Returns a shallow copy of the object.
	 * @return a shallow copy of the object.
	 */
	public function clone() 
	{
		return new Corner(tl , tr, br, bl) ;	
	}

	/**
	 * Returns a Eden reprensation of the object.
	 * @return a string representing the source code of the object.
	 */
	public function toSource():String 
	{
		return Serializer.getSourceOf(this, [tl, tr, br, bl] )  ;
	}
	
	/**
	 * Returns the string representation of this object.
	 * @return the string representation of this object.
	 */
	public function toString():String 
	{
		return "[" + ConstructorUtil.getName(this) + " tl:" + tl + ", br:" + br + ", tr:" + tr + ", bl:" + bl + "]" ;
	}
	
}