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
  Portions created by the Initial Developer are Copyright (C) 2004-2010
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package mvc.events
{
    /**
     * The global event type list of this application.
     */
    public class EventList
    {
        /**
         * The name of the event when a new PictureVO is inserted in the model.
         */
        public static const ADD_PICTURE:String = "addPicture" ;
        
        /**
         * The name of the event when the gallery model is changed.
         */
        public static const CHANGE_PICTURE:String = "changePicture" ;
        
        /**
         * The name of the event when the model is cleared
         */
        public static const CLEAR_PICTURE:String = "clearPicture" ;
        
        /**
         * The name of the event when a PictureVO is removed in the model.
         */
        public static const REMOVE_PICTURE:String = "removePicture" ;
    }
}