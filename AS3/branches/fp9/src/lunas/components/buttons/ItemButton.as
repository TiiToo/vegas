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
package lunas.components.buttons 
{
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.DisplayObject;
    
    /**
     * The ItemButton component.
     */
    public class ItemButton extends IconButton 
    {
        /**
         * Creates a new ItemButton instance.
         * @param w The prefered width of the button (default 120 pixels).
         * @param h The prefered height of the button (default 20 pixels).
         */
        public function ItemButton( w:Number = 120 , h:Number = 20 )
        {
            super( w , h ) ;
        }
        
        /**
         * The delete name event.
         */
        public static const DELETE:String = "delete" ;
        
        /**
         * The option name event.
         */
        public static const OPTION:String = "option" ;
        
        /**
         * Defines the delete button view reference.
         */     
        public function get deleteIcon():*
        {
            return _deleteIcon ;
        }
        
        /**
         * @private
         */
        public function set deleteIcon( value:* ):void
        {
            _deleteIcon = null ;
            if ( value != null )
            {
                if ( value is BitmapData )
                {
                    value = new Bitmap(value as BitmapData) ;
                }
                if ( value is DisplayObject )
                {
                    _deleteIcon = value as DisplayObject ;
                     (builder as ItemButtonBuilder).attachDeleteButton(_deleteIcon as DisplayObject) ;
                } 
            }
        }
        
        /**
         * Defines the option button view reference.
         */ 
        public function get optionIcon():*
        {
            return _optionIcon ;
        }
        
        /**
         * @private
         */
        public function set optionIcon( value:* ):void
        {
            _optionIcon = null ;
            if ( value != null )
            {
                if ( value is BitmapData )
                {
                    value = new Bitmap(value as BitmapData) ;
                }
                if ( value is DisplayObject )
                {
                    _optionIcon = value as DisplayObject ;
                    (builder as ItemButtonBuilder).attachOptionButton(_optionIcon as DisplayObject) ;
                } 
            }
        }
        
        /**
         * Returns the Builder constructor use to initialize this component.
         * @return the Builder constructor use to initialize this component.
         */
        public override function getBuilderRenderer():Class 
        {
            return ItemButtonBuilder ;
        }
        
        /**
         * Returns the Style constructor use to initialize this component.
         * @return the Style constructor use to initialize this component.
         */
        public override function getStyleRenderer():Class 
        {
            return ItemButtonStyle ;
        }
        
        /**
         * @private
         */
        private var _optionIcon:* ;
        
        /**
         * @private
         */
        private var _deleteIcon:* ;
    }
}
