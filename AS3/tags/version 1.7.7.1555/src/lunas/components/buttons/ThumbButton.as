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
    import flash.filters.DropShadowFilter;
    import flash.net.URLRequest;

    /**
     * This ThumbButton class.
     */
    public class ThumbButton extends LightButton 
    {
        /**
         * Creates a new ThumbButton instance.
         * @param target The light target display reference of this component.
         * @param id Indicates the id of the object.
         * @param isFull Indicates if the display is full size or not.
         * @param name Indicates the instance name of the object.
         */
        public function ThumbButton( target:DisplayObject = null , id:* = null, isFull:Boolean=false, name:String = null )
        {
            super( target, id , isFull, name ) ;
            filters = [new DropShadowFilter(2,80,0,0.7,6,6,1,3)] ;
        }
        
        /**
         * Indicates the external picture or view request of the thumb.
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
            (builder as ThumbButtonBuilder).loader.unload() ;
            _request = request ;
            if ( _request != null )
            {
                (builder as ThumbButtonBuilder).loader.load( _request ) ;
            }
        }
        
        /**
         * Returns the constructor function of the <code class="prettyprint">IBuilder</code> of this instance.
         * @return the constructor function of the <code class="prettyprint">IBuilder</code> of this instance.
         */
        public override function getBuilderRenderer():Class
        {
            return ThumbButtonBuilder ;
        }
        
        /**
         * Returns the IStyle Class of this instance.
         * @return the IStyle Class of this instance.
          */
        public override function getStyleRenderer():Class 
        {
            return ThumbButtonStyle ;
        }
        
        /**
         * @private
         */
        private var _request:URLRequest ;
    }
}
