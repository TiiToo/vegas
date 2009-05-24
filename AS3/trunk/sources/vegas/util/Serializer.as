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
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2009
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package vegas.util
{
    import system.Reflection;
    import system.eden;    
    
    /**
     * Allows an object to control its own serialization with the eden representation.
     * @deprecated
     */
    public class Serializer
    {
        
        /**
         * Returns the string source representation of the specified object and serialize the array of arguments to pass in the constructor of the class.
         * @return the string source representation of the specified object and serialize the array of arguments to pass in the constructor of the class.
         */
        public static function getSourceOf(o:*=null, params:Array=null):String 
        {
            if ( o == null )
            {
                return "null" ;
            }
            var path:String   = Reflection.getClassPath(o) ;
            var source:String = "new " + path + "(" ;
            if ( params != null )
            {
                var l:uint = params.length ;
                if (l > 0) 
                {
                    var i:uint = 0 ;
                    while (i < l) 
                    {
                        source += Serializer.toSource( params[i] ) ;
                        i++ ;
                        if (i<l) 
                        {
                            source += "," ;
                        }
                    }
                }
            }
            source += ")" ;
            return source ;
        }
        
        /**
         * Returns the eden string representation of the specified object.
         * @return the eden string representation of the specified object.
         */
        public static function toSource( ...arguments ):String 
        {
            return eden.serialize(arguments[0]);
        }
    }
}
