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
  Portions created by the Initial Developer are Copyright (C) 2004-2005
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

/* Queue [Interface]

	AUTHOR
	
		Name : Queue
		Package : vegas.data
		Version : 1.0.0.0
		Date :  2006-07-08
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	DESCRIPTION

		File d'attente, on ajoute en queue de la liste et on enlève en tête.

	METHOD SUMMARY
	
	    - clear():void
	
	    - clone():*
	    
	    - copy():*
	
		- dequeue():Boolean
		
		- element():*
		
		- enqueue(o):Boolean
		
		- hashCode():uint
		
		- iterator():Iterator
		
		- peek():*
		
		- poll():* 

        - size():uint

        - toSource(...arguments:Array):String
        
        - toString():String

    INHERIT
    
        ICloneable, ICopyable, IFormattable, IHashable, Iterable, ISerializable

**/

package vegas.data
{
    
    import vegas.core.ICloneable;
    import vegas.core.ICopyable;
    import vegas.core.IFormattable;
    import vegas.core.IHashable;
    import vegas.core.ISerializable;

    import vegas.data.iterator.Iterable;

    public interface Queue extends ICloneable, ICopyable, IFormattable, IHashable, Iterable, ISerializable
    {
    	
    	/**
    	 * Clear the queue object.
    	 */
    	function clear():void ;
	
		/**
		 * Return true if the queue contains value.
		 */
    	function contains(o:*):Boolean ;
    	
        /**
         * Retrieves and removes the head of this queue.
         */
    	function dequeue():Boolean ;

	    /**
	     * Retrieves, but does not remove, the head of this queue.
	     */
    	function element():* ;
    	
	    /**
	     * Inserts the specified element into this queue, if possible.
	     */
    	function enqueue(o:*):Boolean ;

        /**
         * Returns trus if the queue is empty.
         */
    	function isEmpty():Boolean ;

        /**
         * Retrieves, but does not remove, the head of this queue, returning null if this queue is empty.
         */
    	function peek():* ;
	
	    /**
	     * Retrieves and removes the head of this queue.
	     */
    	function poll():* ;
	
	    /**
	     * Retrieves the size of the queue.
	     */
    	function size():uint ;
	
	    /**
	     * Retrieves an Array representation of the queue.
	     */
    	function toArray():Array ;
	
    }
}