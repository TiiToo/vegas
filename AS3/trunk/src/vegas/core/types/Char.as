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

/** Char

	AUTHOR
	
		Name : Char
		Package : vegas.core.types
		Version : 1.0.0.0
		Date :  2007-07-07
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
	
	METHOD SUMMARY
	
		- getCode():Number
		
		- hashCode():Number
		
		- toSource():String
		
		- toString():String
		
		- valueOf()
	
	INHERIT
	
		CoreObject → Char  

	IMPLEMENTS
	
		IFormattable, IHashable, ISerializable

**/


package vegas.core.types
{
    import vegas.core.CoreObject;
    import vegas.core.HashCode ;
    
    public class Char extends CoreObject
    {
        
        // ----o Constructor
        
        public function Char( value:String="" )
        {
            _ch = value.substring(0, 1) ; ;
        }

        // ----o Public Methods
        
    	public function getCode():Number {
	    	return _ch.charCodeAt(0) ;
    	}
        
        override public function toSource(...arguments):String 
        {
            return 'new vegas.core.types.Char("' + _ch + '")' ;    
        }

        override public function toString():String
        {
            return _ch ;
        }  

        
        public function valueOf():Object
        {
            return _ch ;
        }
        
        // ----o Private Properties
        
        private var _ch:String ;
        
    }
}