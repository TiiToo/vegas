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
    import graphics.LineStyle;
    import graphics.geom.EdgeMetrics;
    import graphics.transitions.TweenLite;
    import graphics.transitions.easings.Back;
    import graphics.transitions.easings.Elastic;
    
    import lunas.CoreStyle;
    
    /**
     * This style of the BackgroundButton component.
     */
    public class BackgroundButtonStyle extends CoreStyle 
    {
        /**
         * Creates a new BackgroundButtonStyle instance.
         * @param init An object that contains properties with which to populate the newly Style object. If init is not an object, it is ignored.
         * @param id The id of the object.
         */
        public function BackgroundButtonStyle( init:* = null , id:* = null )
        {
            super( init , id );
        }
        
        /**
         * The alignement of the background.
         * @see pegas.draw.Align
         */
        public var align:uint = 10 ;
        
        /**
         * The radius of the bottom-left corner, in pixels.
         */
        public var bottomLeftRadius:Number = 0 ;
        
        /**
         * The radius of the bottom-left corner, in pixels.
         */
        public var bottomRightRadius:Number = 0 ;
        
        /**
         * The margin values of the component.
         */
        public var margin:EdgeMetrics ;
        
        /**
         * The theme style when the component is up.
         */
        public var theme:FillStyle ;
        
        /**
         * The border style when the component is up.
         */
        public var themeBorder:LineStyle ;
        
        /**
         * The border style when the component is disabled.
         */
        public var themeBorderDisabled:LineStyle ;
        
        /**
         * The border style when the component is over.
         */
        public var themeBorderRollOver:LineStyle ;
        
        /**
         * The border style when the component is selected.
         */
        public var themeBorderSelected:LineStyle ;
        
        /**
         * The theme style when the component is disabled.
         */
        public var themeDisabled:FillStyle ;
        
        /**
         * The collection of all filters of the theme.
         */
        public var themeFilters:Array ;
        
        /**
         * The theme style when the component is over.
         */
        public var themeRollOver:FillStyle ;
        
        /**
         * The theme style when the component is selected.
         */
        public var themeSelected:FillStyle ;
        
        /**
         * The radius of the upper-left corner, in pixels.
         */
        public var topLeftRadius:Number = 0 ;
        
        /**
         * The radius of the upper-right corner, in pixels. 
         */
        public var topRightRadius:Number = 0 ;
        
        /**
         * The tween invoked when the button is over.
         */
        public var tweenOver:TweenLite ;
        
        /**
         * The tween invoked when the button is selected.
         */
        public var tweenSelected:TweenLite ;
        
        /**
         * Initialize the Style object.
         */
        public override function initialize():void 
        {
            margin              = new EdgeMetrics( 2, 2, 2, 2 ) ;
            theme               = new FillStyle( 0x338599 , 1 ) ;
            themeBorder         = new LineStyle( 2, 0xFFFFFF , 1 ) ;
            themeDisabled       = new FillStyle( 0xD2EBF0 , 1 ) ;
            themeRollOver       = new FillStyle( 0x286979 , 1 ) ;
            themeSelected       = new FillStyle( 0xDBD2F0 , 1 ) ;
            themeBorderDisabled = new LineStyle( 2, 0xFFFFFF , 1 ) ;
            themeBorderRollOver = new LineStyle( 2, 0xFFFFFF , 1 ) ;
            themeBorderSelected = new LineStyle( 2, 0xFFFFFF , 1 ) ;
            tweenOver           = new TweenLite( null , "brightness" , Back.easeOut    , 125 , 0 , 1   , true  ) ;
            tweenSelected       = new TweenLite( null , "brightness" , Elastic.easeOut , 100 , 0 , 0.5 , true  ) ;
        }
    }
}
