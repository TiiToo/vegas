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

/** InvalidFilterError

	AUTHOR

		Name : InvalidFilterError
		Package : vegas.logging.errors
		Version : 1.0.0.0
		Date : 2006-08-31
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
	
	PROPERTY SUMMARY
		
		- message:String
		
		- name:String [Read Only]
	
	METHOD SUMMARY
	
		- getCategory():String
		
			get internal logger's category.
		
		- getLogger():ILogger 
		
			get internal Logger.
		
		- toString():String

	INHERIT
	
		Object → Error → AbstractError → InvalidFilterError
	
	IMPLEMENT
	
		IFormattable, IHashable

**/

package vegas.logging.errors
{
    
    import vegas.errors.FatalError;

    public class InvalidFilterError extends FatalError
    {
        
        // ----o Constructor
        
        public function InvalidFilterError(message:String="", id:int=0)
        {
            super(message, id);
        }
        
    }
}