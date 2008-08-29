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
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package vegas.data
{
	
	/**
	 * A map entry (key-value pair).
	 * @author eKameleon
	 */
    public interface Entry
    {
    	
	 	/**
		 * Returns the key corresponding to this entry.
		 * @return the key corresponding to this entry.
		 */
	    function getKey():* ;

		/**
		 * Returns the value corresponding to this entry.
		 * @return the value corresponding to this entry.
		 */
    	function getValue():* ; 
	
		/**
		 * Sets the key of this entry.
		 */
	    function setKey(key:*):void ;

		/**
		 * Replaces the value corresponding to this entry with the specified value (optional operation).
		 */
    	function setValue(value:*):void ;
    }
}