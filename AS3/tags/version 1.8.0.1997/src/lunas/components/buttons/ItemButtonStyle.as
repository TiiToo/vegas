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
    import graphics.FillStyle;
    import graphics.geom.EdgeMetrics;
    
    /**
     * This style of the ItemButton component.
     */
    public class ItemButtonStyle extends IconButtonStyle 
    {
        /**
         * Creates a new ItemButtonStyle instance.
         * @param id The id of the object.
         * @param init An object that contains properties with which to populate the newly Style object. If init is not an object, it is ignored. 
         */
        public function ItemButtonStyle( init:* = null , id:* = null )
        {
            super( id, init );
        }
        
        /**
         * Indicate the space value between the icons.
         */
        public var spacing:Number ;
        
        /**
         * Initialize the Style object.
         */
        public override function initialize():void 
        {
            super.initialize() ;
            
            labelStyleName      = "item_button_label" ;
            
            margin              = new EdgeMetrics( 6, 1, 6, 1 ) ;
            padding             = new EdgeMetrics( 2, 1, 6, 1 ) ;
            spacing             = 10 ;
            
            theme               = new FillStyle( 0xFFFFFF , 1 ) ;
            themeDisabled       = new FillStyle( 0x999999 , 1 ) ;
            themeRollOver       = new FillStyle( 0x999999 , 1 ) ;
            themeSelected       = new FillStyle( 0x666666 , 1 ) ;
            
            color             = 0x333333 ;
            textDisabledColor = 0xFFFFFF ;
            textRollOverColor = 0xFFFFFF ;
            textSelectedColor = 0xFFFFFF ;
            
            styleSheet.setStyle("." + labelStyleName, { fontFamily:"Arial", fontSize:"11px" , marginLeft:"6px"} ) ;
        }
    }
}