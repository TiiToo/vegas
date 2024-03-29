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
    import graphics.LineStyle;
    import graphics.geom.EdgeMetrics;
    
    import flash.text.StyleSheet;
    
    /**
     * This style of the LabelButton component.
     */
    public class LabelButtonStyle extends BackgroundButtonStyle 
    {
        /**
         * Creates a new LabelButtonStyle instance.
         * @param init An object that contains properties with which to populate the newly Style object. If init is not an object, it is ignored.
         * @param id The id of the object.
         */
        public function LabelButtonStyle( init:* = null , id:* = null )
        {
            super( init , id ) ;
        }
        
        /**
         * The anti alias type of the fields in the component.
         */
        public var antiAliasType:String ;
        
        /**
         * Indicates if the button is autoSize.
         */
         public var autoSize:Boolean ;
        
        /**
         * Indicates if the border of the field is visible.
         */
        public var border:Boolean ;
        
        /**
         * The color of the field border.
         */
        public var borderColor:Number ;
        
        /**
         * The default color of the field of the component.
         */
        public var color:Number = 0xFFFFFF ;
            
        /**
         * Indicates if the fields embed fonts.
         */
        public var embedFonts:Boolean ;
        
        /**
         * Indicates the type of the gridfit of the fields.
         */
        public var gridFitType:String ;
            
        /**
         * Indicates if the button use a html text or not.
         */
        public var html:Boolean = true ;
        
        /**
         * The collection of all filters over the label of the button.
         */
        public var labelFilters:Array ;
        
        /**
         * The style name of the field of the component.
         */
        public var labelStyleName:String = "label_button_label" ;
        
        /**
         * Indicates if the text in the button is multiline.
         */
        public var multiline:Boolean ;
        
        /**
         * The padding value used in the component.
         */
        public var padding:EdgeMetrics ;
        
        /**
         * Indicates if the field is selectable in the component.
         */
        public var selectable:Boolean ;
        
        /**
         * The color of the text when is disabled.
         */
        public var textDisabledColor:Number = 0xCCCCCC ;
        
        /**
         * The color of the text when is over.
         */
        public var textRollOverColor:Number = 0xFEFE45 ;
        
        /**
         * The color of the text when is selected.
         */
        public var textSelectedColor:Number = 0xD1BE72 ;
        
        /**
         * Indicates if the component use the style text colors.
         */
        public var useTextColor:Boolean = true ;
        
        /**
         * The wordwrap value of the fields.
         */
        public var wordWrap:Boolean ;
        
        /**
         * Initialize the Style object.
         */
        public override function initialize():void 
        {
            super.initialize() ;
            
            autoSize            = false ;
            border              = false ;
            
            margin              = new EdgeMetrics( 1, 1, 2, 1 ) ;
            padding             = new EdgeMetrics( 1, 1, 2, 1 ) ;
            
            theme               = new FillStyle( 0 , 0 ) ;
            themeBorder         = new LineStyle( 0, 0 , 0 ) ;
            
            themeDisabled       = new FillStyle( 0 , 0 ) ;
            themeRollOver       = new FillStyle( 0 , 0 ) ;
            themeSelected       = new FillStyle( 0 , 0 ) ;
            
            themeBorderDisabled = new LineStyle( 0, 0 , 0 ) ;
            themeBorderRollOver = new LineStyle( 0, 0 , 0 ) ;
            themeBorderSelected = new LineStyle( 0, 0 , 0 ) ;
            
            styleSheet          = new StyleSheet() ;
            styleSheet.setStyle("." + labelStyleName, { color:"#FFFFFF", fontFamily:"Arial", fontSize:"12px", fontWeight:"bold" } ) ;
        }
    }
}
