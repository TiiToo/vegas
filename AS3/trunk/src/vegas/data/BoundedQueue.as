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

/* BoundedQueue [Interface]

	AUTHOR
	
		Name : BoundedQueue
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

		- isFull():Boolean
		
		- iterator():Iterator

		- maxSize():uint
		
		- peek():*
		
		- poll():* 

        - size():uint

        - toSource(...arguments:Array):String
        
        - toString():String

    INHERIT
    
        Boundable, ICloneable, ICopyable, IFormattable, IHashable, Iterable, ISerializable, Queue

**/

package vegas.data
{
    public interface BoundedQueue extends Boundable, Queue
    {
        
    }
}