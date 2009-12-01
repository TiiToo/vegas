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

package examples.core
{
    /**
     * The User class to test the LightContainer.
     */
    public class User
    {
        /**
         * Creates a new User instance.
         */
        public function User( pseudo:String = null, name:String =null , address:Address = null )
        {
            this.pseudo  = pseudo ;
            this.name    = name ;
            this.address = address ;
        }
        
        /**
         * The Address reference of this object.
         */
        public var address:Address ;
        
        /**
         * The age of the user.
         */
        public var age:Number ;
        
        /**
         * The fistname of the user.
         */
        public var firstName:String ;
        
        /**
         * The job of this User.
         */
        public var job:Job ;
        
        /**
         * The mail of the user.
         */
        public var mail:String ;
        
        /**
         * The name of the User.
         */
        public var name:String ;
        
        /**
         * The pseudo of the user.
         */
        public var pseudo:String ;
        
        /**
         * The url of the User.
         */
        public var url:String ;
        
        /**
         * Destroy the user.
         */
        public function destroy():void
        {
            trace( this + " destroy.") ;
        }
        
        /**
         * Initialize the User.
         */
        public function initialize():void
        {
            trace( this + " initialize.") ;
        }
        
        /**
         * Sets the mail value of this user.
         */
        public function setMail( sMail:String ):void
        {
            mail = sMail ;
        }
        
        /**
         * Returns the string representation of the object.
         * @return the string representation of the object.
         */
        public function toString():String
        {
            return "[User " + ( pseudo != null ? " " + pseudo : "" ) + "]" ;    
        }
    }
}