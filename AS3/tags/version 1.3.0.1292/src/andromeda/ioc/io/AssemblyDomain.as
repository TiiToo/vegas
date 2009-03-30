﻿/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is AndromedAS Framework based on VEGAS.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2009
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package andromeda.ioc.io 
{

    /**
     * The static enumeration list of all ApplicationDomain modes in an AssemblyResource.
     */
    public class AssemblyDomain 
    {
        
        /**
         * Defines the "current" assembly ApplicationDomain mode.
         */
        public static const CURRENT:String = "current" ;  

        /**
         * Defines the "none" assembly ApplicationDomain mode.
         */
        public static const NONE:String = "none" ;  
        
        /**
         * Indicates if the specified value is a valid AssemblyDomain value.
         */
        public static function isValid( value:String ):Boolean
        {
        	return ([CURRENT, NONE]).indexOf( value ) > -1 ;
        }
               
    }
    
}