/*

  Version: MPL 1.1/GPL 2.0/LGPL 2.1
 
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
package observer.models
{
    /**
     * The message emited from the picture model.
     */
    public class PictureMessage
    {
        /**
         * Creates a PictureMessage instance.
         * @param type The type of the message.
         * @param url The url of the picture to load.
         * @param visible The state of the visibility of the picture.
         */
        public function PictureMessage( type:String = null , url:String = null , visible:Boolean = false )
        {
            this.type    = type ;
            this.url     = url ;
            this.visible = visible ;
        }
        
        /**
         * The name of the event type when a new picture is added in the model.
         */
        public static const ADD:String = "add" ;
        
        /**
         * The name of the event type when the picture model is clear.
         */
        public static const CLEAR:String = "clear" ;
        
        /**
         * The name of the event type when the picture model load a new picture.
         */
        public static const LOAD:String = "load" ;
        
        /**
         * The name of the event type when the picture visibility is changed.
         */
        public static const VISIBLE:String = "visible" ;
        
        /**
         * Indicates the type of the message.
         */
        public var type:String ;
        
        /**
         * Indicates the url string representation of the picture.
         */
        public var url:String ;
        
        /**
         * Indicates if the picture is visible.
         */
        public var visible:Boolean ;
    }
}