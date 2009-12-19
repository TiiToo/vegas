/*
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is VEGAS Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2010
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package examples.core
{
    import vegas.ioc.IObjectFactory;
    import vegas.ioc.factory.ObjectFactory;

    /**
     * This class is a helper to test the #this notation if the ref attributes in the IoC object definitions.
     */
    public class FactoryReference
    {
        /**
         * Creates a new FactoryReference instance.
         */
        public function FactoryReference( factory:ObjectFactory = null )
        {
            this.factory = factory ;
        }
        
        /**
         * The factory reference of this object.
         */
        public var factory:IObjectFactory ;
        
        /**
         * The root reference of the application.
         */
        public var root:* ;
    }
}