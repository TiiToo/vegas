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

package andromeda.ioc.core 
{
    /**
     * Enumeration of all "orders" can be use in the object definitions.
     */
    public class ObjectOrder 
    {
        /**
         * The "after" order value.
         */
        public static var AFTER:String = "after" ;
        
        /**
         * The "before" order value.
         */
        public static var BEFORE:String = "before" ;
        
        /**
         * The "none" order value.
         */
        public static var NONE:String = "none" ;
        
        /**
         * The "now" order value.
         */
        public static var NOW:String = "now" ;
    }
}