﻿/*

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
package lunas.components.buttons 
{
    /**
     * The dashboard button component.
     */
    public class DashboardButton extends PictureButton 
    {
        /**
         * Creates a new DashboardButton instance.
         * @param w The prefered width of the button (default 74 pixels).
         * @param h The prefered height of the button (default 74 pixels).
         */ 
        public function DashboardButton( w:Number = 74 , h:Number = 74 )
        {
            super( w , h) ;
        }
        
        /**
         * Indicates the text label for a button instance when is selected.
         */
        public function get selectLabel():String
        {
            return _selectLabel || null ; 
        }
        
        /**
         * @private
         */
        public function set selectLabel(str:String):void 
        {
            _selectLabel = str ; 
            update() ;
        }
        
        /**
         * Returns the builder class use to initialize this component.
         * @return the builder class use to initialize this component.
         */
        public override function getBuilderRenderer():Class 
        {
            return DashboardButtonBuilder ;
        }
        
        /**
         * Returns the style class use to initialize this component.
         * @return the style class use to initialize this component.
         */
        public override function getStyleRenderer():Class 
        {
            return DashboardButtonStyle ;
        }
        
        /**
         * Invoked when the label property of the component change.
         */
        public override function viewLabelChanged():void 
        {
            update() ;
        }
        
        /**
         * @private
         */
        private var _selectLabel:String ;
    }
}
