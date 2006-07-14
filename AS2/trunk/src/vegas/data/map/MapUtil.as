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

/** MapUtil

	AUTHOR
	
		Name : MapUtil
		Package : vegas.data.map
		Version : 1.0.0.0
		Date :  2005-11-08
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	METHOD SUMMARY
	
		- static getNumber(map:Map, key):Number
		
	TODO : EN CONSTRUCTION !!

*/

import vegas.data.Map;

class vegas.data.map.MapUtil {

	// ----o Constructor
	
	private function MapUtil() {
		//
	}

	// ----o Public Methods
    
	static public function getNumber(map:Map, key):Number
	{
        if (map != null) 
        {
            var answer = map.get(key) ;
            if (answer != null) 
            {
                if (answer instanceof Number) 
                {
                    return Number(answer) ;
                }
                else if (answer instanceof String) 
                {
                    var r:Number = parseInt(answer) ;
					return (r == isNaN) ? null : Number(r) ;
                }
            }
        }
        return null ;
    }


}