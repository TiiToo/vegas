﻿/*
  Version: MPL 1.1/GPL 2.0/LGPL 2.1
 
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at
  http://www.mozilla.org/MPL/
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the
  License.
  
  The Original Code is [maashaack framework].
  
  The Initial Developers of the Original Code are
  Zwetan Kjukov <zwetan@gmail.com> and Marc Alcaraz <ekameleon@gmail.com>.
  Portions created by the Initial Developers are Copyright (C) 2006-2010
  the Initial Developers. All Rights Reserved.
  
  Contributor(s):
  
  Alternatively, the contents of this file may be used under the terms of
  either the GNU General Public License Version 2 or later (the "GPL"), or
  the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
  in which case the provisions of the GPL or the LGPL are applicable instead
  of those above. If you wish to allow use of your version of this file only
  under the terms of either the GPL or the LGPL, and not to allow others to
  use your version of this file under the terms of the MPL, indicate your
  decision by deleting the provisions above and replace them with the notice
  and other provisions required by the LGPL or the GPL. If you do not delete
  the provisions above, a recipient may use your version of this file under
  the terms of any one of the MPL, the GPL or the LGPL.
*/

package system.ioc.strategies 
{
    import system.ioc.IObjectFactoryStrategy;
    import system.ioc.ObjectAttribute;
    import system.ioc.ObjectMethod;
    import system.ioc.builders.createArguments;
    
    /**
     * This object create a delegate factory configured in the IObjectDefinition and replace the natural factory of the ObjectFactory.
     */
    public class ObjectFactoryMethod extends ObjectMethod implements IObjectFactoryStrategy
    {
        /**
         * Creates a new ObjectFactoryMethod instance.
         * @param factory The string name of the reference in the factory used to create the object.
         * @param name The name of the method to invoke to create the object.
         * @param arguments The array of the arguments to passed-in the factory method.
         */
        public function ObjectFactoryMethod( factory:String , name:String , arguments:Array =null )
        {
            super( name , arguments );
            this.factory = factory ;
        }
        
        /**
         * The factory string representation of the reference of this factory method object.
         */
        public var factory:String ;
        
        /**
         * Returns the ObjectFactoryMethod representation of the specified generic object or null.
         * @return the ObjectFactoryMethod representation of the specified generic object or null.
         */
        public static function build( o:Object=null ):ObjectFactoryMethod
        {
            if ( o == null ) 
            {
                return null ;
            }
            if ( ObjectAttribute.FACTORY in o && ObjectAttribute.NAME in o )
            {
                return new ObjectFactoryMethod
                ( 
                    o[ ObjectAttribute.FACTORY   ] as String , 
                    o[ ObjectAttribute.NAME      ] as String , 
                    createArguments( o[ ObjectAttribute.ARGUMENTS ] as Array ) 
                ) ;
            }
            else
            {
                return null ;
            }
        }
    }
}
