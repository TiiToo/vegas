/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is Andromeda Framework based on VEGAS.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package andromeda.ioc.io 
{
    import andromeda.ioc.core.ObjectAttribute;                    

    /**
     * This tool class is a helper to create an ObjectAttribute object with a generic object in the IoC context.
     */
    public class ObjectResourceBuilder 
    {
    	
        /**
         * Creates the ObjectAttribute object with the specified generic object.
         * @param o The object definition to create an ObjectAttribute instance.
         */
        public static function create( o:Object ):ObjectResource
        {
            if ( ObjectAttribute.RESOURCE in o )
            {
                var type:String = o[ ObjectAttribute.TYPE ] as String ;
                switch( type )
                {
                    case ObjectResourceType.ASSEMBLY :
                    {
                        break ;
                    }
                    case ObjectResourceType.CONFIG :
                    {
                        return new ConfigResource( o ) ;
                        break ;
                    }
                    case ObjectResourceType.I18N :
                    {
                        return new LocaleResource( o ) ;                         
                        break ;
                    }
                    case null :
                    {
                        return new ContextResource( o ) ;
                        break ;
                    }
                    default :
                    {
                        return null ;
                        break ;
                    }                        
                }   
            }
            return null ;	
        }    	
    	
    }
}
