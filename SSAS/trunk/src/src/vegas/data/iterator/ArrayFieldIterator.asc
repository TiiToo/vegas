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
 * Converts an array to an iterator but this iterator return the value of a specific field if the array is an array of objects.
 * <p><b>Example :</b></p>
 * {@code
 * import vegas.data.iterator.ArrayFieldIterator ;
 * 
 * var ar:Array = [
 *     { label : "item1", date : new Date(2005, 10, 12) } ,
 *     { label : "item2", date : new Date(2004, 2, 22) } ,
 *     { label : "item3", date : new Date(2005, 4, 3) }
 * ] ;
 * 
 * trace (" --- browse 'label' field") ;
 * 
 * var it:ArrayFieldIterator = new ArrayFieldIterator(ar, "label") ;
 * while (it.hasNext()) 
 * {
 *     trace (it.next() + " : " + it.key()) ;
 * }
 * 
 * trace(" --- browse 'date' field") ;
 * 
 * var it:ArrayFieldIterator = new ArrayFieldIterator(ar, "date") ;
 * while (it.hasNext())
 * {
 *     trace (it.next() + " : " + it.key()) ;
 * }
 * }
 * @author eKameleon
 */
if (vegas.data.iterator.ArrayFieldIterator == undefined) 
{
	
	/**
	 * @requires vegas.data.iterator.ArrayIterator
	 */
	require("vegas.data.iterator.ArrayIterator") ;

	/**
	 * Creates a new ArrayFieldIterator instance.
	 * @param ar the Array to enurate.
	 * @param fieldName the name of the field to enumerate in all objects in the Array.
	 */
	vegas.data.iterator.ArrayFieldIterator = function ( ar /*Array*/ , fieldName /*String*/ ) 
	{ 
		this.constructor.apply(this, [ar]) ; // super
		this.fieldName = (fieldName || null) ;
	}

	/**
	 * @extends vegas.data.iterator.ArrayIterator
	 */
	vegas.data.iterator.ArrayFieldIterator.extend(vegas.data.iterator.ArrayIterator) ;

	/**
	 * Returns the next field element in the iteration.
	 * @return the next field element in the iteration.
	 */
	vegas.data.iterator.ArrayFieldIterator.prototype.next = function () 
	{
		var o = this._a[++this._k] ;
		return (this.fieldName != null) ? o[this.fieldName] : o ;
	}
	
}