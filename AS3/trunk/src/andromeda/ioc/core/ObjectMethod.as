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
package andromeda.ioc.core 
{

    /**
     * This object defines a method definition and this arguments.
     * @author eKameleon
     */
    public class ObjectMethod
    {
        
        /**
         * Creates a new ObjectMethod instance.
         * @param name The name of the method to invoke.
         * @param arguments The array of the arguments to passed-in the method.
         */
        public function ObjectMethod( name:String , arguments:Array =null )
        {
            this.name      = name    ;
            this.arguments = arguments ;
        }
        
        /**
         * The array of the arguments to passed-in the factory method.
         */
        public var arguments:Array ;

        /**
         * The name of the method to invoke to create the object.
         */
        public var name:String ;
        
        /**
         * Creates the Array definition of all arguments defines in the passed-in array.
         * @return the Array definition of all arguments defines in the passed-in array.
         */
        public static function create( a:Array = null ):Array
        {
            if ( a == null || a.length == 0 )
            {
                return null ;
            }
            else
            {
                var methods:Array  = [] ;
                var o:Object ;
                var i:uint ;
                var name:String  ;                
                var l:uint = a.length ;
                for ( i=0 ; i<l ; i++ )
                {
                    o = a[i] ;
                    if ( o != null && ( ObjectAttribute.NAME in o ) )
                    {
                        name = o[ ObjectAttribute.NAME ] as String ;                    	
                        if ( name == null || name.length == 0 )
                        {
                            continue ;
                        }
                        methods.push( new ObjectMethod( name, ObjectArgument.create( o[ ObjectAttribute.ARGUMENTS ] as Array ) ) ) ;
                    }
                }
                return methods.length > 0 ? methods : null ;
            }
        }          
        
    }
}
