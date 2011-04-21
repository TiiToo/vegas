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
  Portions created by the Initial Developer are Copyright (C) 2004-2011
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package examples.vo
{
    import vegas.CoreObject;

    /**
     * The User class to test the object container.
     */
    public class User extends CoreObject
    {
        /**
         * Creates a new User instance.
         */
        public function User( name:String = null )
        {
            this.name = name ;
        }
        
        /**
         * The name of the User.
         */
        public var name:String ;
        
        /**
         * Initialize the User.
         */
        public function initialize():void
        {
            trace( this + " initialize.") ;
        }
        
        /**
         * Returns the string representation of the object.
         * @return the string representation of the object.
         */
        public override function toString():String
        {
            return "[User " + ( name != null ? " " + name : "" ) + "]" ;
        }
    }
}