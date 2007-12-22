/*
  
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is eden: ECMAScript data exchange notation AS2. 
  
  The Initial Developer of the Original Code is
  Zwetan Kjukov <zwetan@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2006
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):
  
  	- Alcaraz Marc (aka eKameleon) <vegas@ekameleon.net> (2007-2008)
	  Use this version only with Vegas AS3 Framework Please.

*/
package system
{

	/**
	 * This static enumeration class defines all host identifier.
	 */
	public class HostID extends Enum
    {
     
     	/**
     	 * Creates a new HostID instance.
     	 */   
        public function HostID( value:int, name:String )
        {
            super( value, name );
        }
        
        /**
         * The 'Unknow' host id constant.
         */
        public static const Unknown:HostID = new HostID( 0, "Unknown" );

        /**
         * The 'Flash' host id constant.
         */
        public static const Flash:HostID = new HostID( 1, "Flash" );

        /**
         * The 'Flex' host id constant.
         */
        public static const Apollo:HostID = new HostID( 2, "Apollo" );

        /**
         * The 'Air' host id constant.
         */
        public static const Air:HostID = new HostID( 3, "Air" );
        

    }
    
}

