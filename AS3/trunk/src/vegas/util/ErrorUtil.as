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

/** ErrorUtil

	AUTHOR
	
		Name : ErrorUtil
		Package : vegas.util
		Version : 1.0.0.0
		Date :  2006-07-07
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	DESCRIPTION
	
		EDEN Compatibility to serialize ECMAScript data.

	METHOD SUMMARY
	
		- static toSource(e:Error):String
	
**/


package vegas.util
{
    public class ErrorUtil
    {
        
	    static public function toSource( e:Error ):String {
		    return 'new Error(\"' + e.message + '")' ;
        }
        
    }
}