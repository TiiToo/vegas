/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is LunAS Library.
  
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
package lunas.components.buttons
{
    import flash.display.DisplayObject;
    import flash.display.Loader;
    import flash.net.URLRequest;

    /**
     * This button load an external bitmap or swf to create this view.
     */
    public class PictureButton extends BackgroundButton 
    {
        /**
         * Creates a new PictureButton instance.
         * @param w The prefered width of the button (default 74 pixels).
         * @param h The prefered height of the button (default 74 pixels).
         * @param id Indicates the id of the object.
         * @param isFull Indicates if the display is full size or not.
         * @param name Indicates the instance name of the object.
         */
        public function PictureButton( w:Number = 74 , h:Number = 74 , id:* = null, isFull:Boolean=false, name:String = null )
        {
            super( w, h, id, isFull, name ) ;
        }
        
        /**
         * Indicates a DisplayObject to mask the loading content of the button.
         */
        public var cover:DisplayObject ;
        
        /**
         * Returns the content reference of the button.
         */
        public function get content():DisplayObject
        {
            try
            {
                return (builder as PictureButtonBuilder).picture.content ;
            }
            catch( e:Error )
            {
                
            }
            return null ; 
        }
        
        /**
         * Returns the loader reference of the button.
         */
        public function get loader():Loader
        {
            try
            {
                return (builder as PictureButtonBuilder).picture ;
            }
            catch( e:Error )
            {
                
            }
            return null ; 
        }
        
        /**
         * Returns the URLRequest of the picture of the component.
         * @return the URLRequest of the picture of the component.
         */
        public function get request():URLRequest
        {
            return _request ;
        }
        
        /**
         * @private
         */
        public function set request( request:URLRequest ):void
        {
            _request = request ;
            ( builder as PictureButtonBuilder ).load( _request ) ;
        }
        
        /**
         * Returns the Builder constructor use to initialize this component.
         * @return the Builder constructor use to initialize this component.
         */
        public override function getBuilderRenderer():Class 
        {
            return PictureButtonBuilder ;
        }
        
        /**
         * Returns the Style constructor use to initialize this component.
         * @return the Style constructor use to initialize this component.
         */
        public override function getStyleRenderer():Class 
        {
            return PictureButtonStyle ;
        }
        
        /**
         * @private
         */
        private var _request:URLRequest ;
    }
}
