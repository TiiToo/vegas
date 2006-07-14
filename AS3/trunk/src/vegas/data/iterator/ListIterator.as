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

/* ListIterator [Interface]

	AUTHOR

		Name : ListIterator
		Package : vegas.data.iterator
		Version : 1.0.0.0
		Date :  2006-07-08
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
	
	METHOD SUMMARY
	
		- hasNext():Boolean

 		- hasPrevious():Boolean		
 
        - insert(o:*):void
 
		- key():*
		
		- next():*
		
		- nextIndex():uint
		
		- previous():*
		
		- previousIndex():int
		
		- remove():*
		
		- reset():void
		
		- seek(position:*):void
	
	    - set(o:*):void
	
	INHERIT
	
		Iterator → OrderedIterator → ListIterator
	
**/

package vegas.data.iterator
{
    public interface ListIterator extends OrderedIterator
    {
        
        	function insert(o:*):void ;

        	function nextIndex():uint ;	
	
        	function previousIndex():int ;
	
        	function set(o:*):void ;
        
    }
}