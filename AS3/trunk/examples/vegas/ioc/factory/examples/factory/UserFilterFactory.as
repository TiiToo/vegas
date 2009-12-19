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

package examples.factory 
{
    import examples.core.User;

    /**
     * This factory creates User instances but use a filter with a black list array.
     */
    public class UserFilterFactory 
    {
        /**
         * Creates a new UserFilterFactory instance.
         * @param blackList The optional array of string pseudo to banish in this factory.
         */
        public function UserFilterFactory ( blackList:Array=null )
        {
            this.blackList = blackList || [] ;
        }
        
        /**
         * The blackList of this factory.
         */
        public var blackList:Array ;
        
        /**
         * Creates a new User instance with the specified pseudo.
         * @param pseudo The pseudo String representation of the new User.
         */
        public function build( pseudo:String ):User
        {
            if ( blackList.indexOf( pseudo ) > -1 )
            {
                throw new ArgumentError(this + " create failed, the user with the pseudo '" + pseudo + "' is in the black list of this factory") ;
            }
            return new User( pseudo ) ;
        }
    }
}
