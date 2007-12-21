﻿/*

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

package vegas.data
{
	import system.ISerializable;
	
	import vegas.core.ICloneable;
	import vegas.core.ICopyable;
	import vegas.core.IFormattable;
	import vegas.data.iterator.Iterable;	

	/**
	 * A collection designed for holding elements prior to processing. 
	 * <p>Stacks typically, but do not necessarily, order elements in a LIFO (last-in-first-out) manner.</p>
	 * @author eKameleon
	 */
    public interface Stack extends ICloneable, ICopyable, Iterable, IFormattable, ISerializable
    {

		/**
		 * Removes all of the elements from this stack (optional operation).
		 */
		function clear():void ;
	
		/**
		 * Returns {@code true} if this stack contains no elements.
		 * @return {@code true} if this stack is empty else {@code false}.
		 */
		function isEmpty():Boolean ;

		/**
		 * Returns the lastly pushed value without removing it.
		 * @throws the lastly pushed value.
		 */
		function peek():* ;
		
		/**
		 * Removes and returns the lastly pushed value.
		 * @return the lastly pushed value
		 */
		function pop():* ;

		/**
		 * Pushes the passed-in value to this stack.
		 */
		function push(o:*):void ;

		/**
		 * Search a value in the stack.
		 * @return the index position of a value in the stack.
		 */
		function search(o:*):uint ;

		/**
		 * Returns the number of pushed values.
		 * @return the number of pushed values.
		 */
		function size():uint ;

		/**
		 * Returns the array representation of this stack.
		 * @return the array representation of this stack
		 */
		function toArray():Array ;
	
    }
}