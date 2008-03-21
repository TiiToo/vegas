/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is Vegas Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

/**
 * Collected methods which allow easy implementation of {@code hashCode}.
 * @author eKameleon
 */
if (vegas.core.HashCode == undefined) 
{

	/**
	 * Creates the HashCode singleton.
	 */
	vegas.core.HashCode = {} ;

	/**
	 * Compare two IHashable objects.
	 * <p><b>Example :</b></p>
	 * {@code var isEquals:Boolean = HashCode.equals(o1, o2) ; }
	 * @param   o1 the first value to compare.
	 * @param   o2 the second value to compare.
	 * @return {@code true} of the two object are equals.  
	 */
	vegas.core.HashCode.equals = function ( o1, o2 ) /*Boolean*/ 
	{
		return o1.hashCode() == o2.hashCode() ;
	}

	/**
	 * Indenfity the hashcode value of an object.
	 */
	vegas.core.HashCode.identify = function ( o ) /*Number*/ 
	{
		return o.hashCode() ;
	}

	/**
	 * Returns the next hashcode value.
	 * @return the next hashcode value.
	 */
	vegas.core.HashCode.next = function () /*Number*/
	{
		return vegas.core.HashCode._nHash ++ ;
	}

	/**
	 * Returns the string representation of the next hashcode value.
	 * @return the string representation of the next hashcode value.
	 */
	vegas.core.HashCode.nextName = function () /*String*/ 
	{
		return String(vegas.core.HashCode._nHash + 1) ;
	}

	vegas.core.HashCode._nHash /*Number*/ = 1 ;
	
	
}