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

/**	Entry [Interface]

	AUTHOR
		
		Name : Entry
		Package : vegas.data
		Version : 1.0.0.0
		Date :  20056-07-08
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	METHOD SUMMARY
	
		- getKey():*
		 
		    Returns the key corresponding to this entry.
		
		- getValue():*
		
		    Returns the value corresponding to this entry.
		
		- setKey(key:*):void
		
		    Set the key of this entry.
		
		- setValue(value:*):void
		
		    Replaces the value corresponding to this entry with the specified value (optional operation).
	
**/

package vegas.data
{
    public interface Entry
    {
	    function getKey():* ;
	
    	function getValue():* ; 
	
	    function setKey(key:*):void ;
	
    	function setValue(value:*):void ;
    }
}