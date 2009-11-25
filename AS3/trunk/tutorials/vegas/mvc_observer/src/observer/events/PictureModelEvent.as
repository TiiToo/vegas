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

package observer.events
{
    import flash.events.Event;
    
    /**
     * The PictureModelEvent used in the observer pattern with the PictureModel.
     */
    public class PictureModelEvent extends Event
    {
        /**
         * Creates a PictureModelEvent instance.
         * @param type The type of the event.
         * @param url The url of the picture to load.
         * @param visible The state of the visibility of the picture.
         */
        public function PictureModelEvent( type:String , url:String = null , visible:Boolean = false )
        {
            super( type ) ;
            this.url = url ;
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
         * Indicates the url string representation of the picture.
         */
        public var url:String ;
        
        /**
         * Indicates if the picture is visible.
         */
        public var visible:Boolean ;
        
        /**
         * Returns a shallow copy of the object.
         * @return a shallow copy of the object.
         */
        public override function clone():Event
        {
            return new PictureModelEvent( type, url, visible ) ;
        }
    }
}