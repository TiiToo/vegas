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
  Portions created by the Initial Developer are Copyright (C) 2004-2011
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
package lunas.components.labels 
{
    import lunas.CoreComponent;
    import lunas.Labelable;
    
    import flash.events.Event;
    
    /**
     * The Label component.
     */
    public class Label extends CoreComponent implements Labelable
    {
        /**
         * Creates a new Label instance.
         * @param w The prefered width of the button (default 175 pixels).
         * @param h The prefered height of the button (default 24 pixels).
         */
        public function Label( w:Number = 175 , h:Number = 24 )
        {
            super();
            setSize( w , h ) ;
        }
        
        /**
         * Indicates the label value of this display.
         */
        public function get label():String
        {
            return _label || ""  ;
        }
        
        /**
         * @private
         */
        public function set label( str:String ):void
        {
            _label = str || "" ;
            update() ;
        }
        
        /**
         * Returns the Builder constructor use to initialize this component.
         * @return the Builder constructor use to initialize this component.
         */
        public override function getBuilderRenderer():Class 
        {
            return LabelBuilder ;
        } 
        
        /**
         * Returns the Style constructor use to initialize this component.
         * @return the Style constructor use to initialize this component.
         */
        public override function getStyleRenderer():Class 
        {
            return LabelStyle ;
        }
           
        /**
         * Invoked when the enabled property of the component change.
         */
        public override function viewEnabled():void 
        {
            update() ;
        }
        
        /**
         * Invoked when the component Style changed.
         */
        public override function viewStyleChanged( e:Event=null ):void 
        {
            update() ;
        }
        
        /**
         * Invoked when the StyleSheet in the Style is changed.
         */
        public function viewStyleSheetChanged():void 
        {
            update() ;
        }
        
        /**
         * @private
         */
        private var _label:String ;
    }
}
