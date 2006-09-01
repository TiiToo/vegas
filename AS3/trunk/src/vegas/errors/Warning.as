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

/** Warning

	AUTHOR

		Name : Warning
		Package : vegas.errors
		Version : 1.0.0.0
		Date : 2006-07-07
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
	
		Object → Error → AbstractError → Warning
	
	IMPLEMENT
	
		IFormattable, IHashable

**/

package vegas.errors
{
    public class Warning extends AbstractError
    {
        
        // ----o Constructor
        
        public function Warning(message:String="", id:int=0)
        {
            super(message, id);
        }
        
    	// ----o Public Methods
	
	    override public function toString():String {
    		var msg:String = "!! " + name + " : " + message + " !!" ;
    		getLogger().warn( msg ) ;
    		return msg ;
    	}
        
        
    }
}