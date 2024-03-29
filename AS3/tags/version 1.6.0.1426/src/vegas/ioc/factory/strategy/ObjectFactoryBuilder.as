﻿/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is Vegas Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2009
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package vegas.ioc.factory.strategy 
{
    import vegas.ioc.ObjectAttribute;
    
    /**
     * This tool class is a helper to create an IObjectFactoryStrategy object with a generic object in the IoC context.
     */
    public class ObjectFactoryBuilder 
    {
    	
        /**
         * Creates the IObjectFactoryStrategy object with the specified generic object.
         * @param o The object definition to create an IObjectFactoryStrategy instance.
         */
        public static function create( o:* ):IObjectFactoryStrategy
        {
            switch( true )
            {
                case ObjectAttribute.OBJECT_FACTORY_METHOD in o :
                {
                    return ObjectFactoryMethod.build( o[ ObjectAttribute.OBJECT_FACTORY_METHOD ] ) ;
                }
                case ObjectAttribute.OBJECT_FACTORY_PROPERTY in o :
                {
                    return ObjectFactoryProperty.build( o[ ObjectAttribute.OBJECT_FACTORY_PROPERTY ] ) ;
                }
                case ObjectAttribute.OBJECT_STATIC_FACTORY_METHOD in o :
                {
                    return ObjectStaticFactoryMethod.build( o[ ObjectAttribute.OBJECT_STATIC_FACTORY_METHOD ] ) ;
                }
                case ObjectAttribute.OBJECT_STATIC_FACTORY_PROPERTY in o :
                {
                    return ObjectStaticFactoryProperty.build( o[ ObjectAttribute.OBJECT_STATIC_FACTORY_PROPERTY ] ) ;
                }
                case ObjectAttribute.OBJECT_FACTORY_VALUE in o :
                {
                    return ObjectFactoryValue.build( o[ ObjectAttribute.OBJECT_FACTORY_VALUE ] ) ;
                }
                case ObjectAttribute.OBJECT_FACTORY_REFERENCE in o :
                {
                    return ObjectFactoryReference.build( o[ ObjectAttribute.OBJECT_FACTORY_REFERENCE ] ) ;
                }
                default :
                {
                    return null ;
                }
            }
        } 
    }
}
