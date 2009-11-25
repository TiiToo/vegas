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

package examples.vo 
{
    import vegas.vo.SimpleValueObject;

    import flash.net.registerClassAlias;

    /**
     * The user value object.
     */
    public class UserVO extends SimpleValueObject 
    {
        /**
         * Creates a new UserVO instance.
         * @param init A generic object containing properties with which to populate the newly instance. If this argument is null, it is ignored.
         */
        public function UserVO( init:Object = null  )
        {
            super(init) ;
        }
         
        /**
         * The age value of the user.
         */
        public var age:Number ;
        
        /**
         * The name value of the user.
         */
        public var name:String ;
        
        /**
         * The url value of the user.
         */
        public var url:String ;
        
        /**
         * Preserves the class (type) of an object when the object is encoded in Action Message Format (AMF). 
         */
        public static function register():void
        {
             registerClassAlias("UserVO" , UserVO) ;
        }
         
        /**
         * Returns the String representation of the object.
         * @return the String representation of the object.
         */
        public override function toString():String
        {
            return "[UserVO:" + name + ", age:" + this.age + ", url:" + this.url + "]"  ; 
        }
    }
}
