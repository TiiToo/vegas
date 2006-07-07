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

/** DateUtil

	AUTHOR
	
		Name : DateUtil
		Package : vegas.util.type
		Version : 1.0.0.0
		Date :  2006-07-07
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	METHOD SUMMARY
	
		- static clone(d:Date):Date
		
		- static copy(d:Date):Date
		
		- static equals( d1:Date, d2:Date ):Boolean

        - static toSource(d:Date):String
**/

package vegas.util
{
    
    public class DateUtil
    {

        /**
         * Creates a shallow copy of the Date.
         */
        static public function clone(d:Date):Date 
        {
		    return d ;
    	}

        /**
         * Creates a deep copy of the Date.
         */
	    static public function copy(d:Date):Date 
	    {
    		return new Date(d.valueOf()) ;
    	}

        /**
         * compare if two Dates are equal by value.
         */
	    static public function equals( d1:Date, d2:Date ):Boolean 
	    {
		    if (!d2) return false ;
    		return d1.valueOf() == d2.valueOf() ;
        }
 
        /**
         * Returns a string representing the source code of the Date.
         */
        static public function toSource(date:Date):String 
            {
		    return "new Date(" + date.valueOf() + ")" ;
            }
        
    }
    
}