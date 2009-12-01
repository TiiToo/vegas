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
  Portions created by the Initial Developer are Copyright (C) 2004-2009
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package lunas.display.button 
{
    import graphics.FillStyle;
    import graphics.LineStyle;
    import graphics.geom.EdgeMetrics;
    
    /**
     * The IStyle class of the IconButton component.
     */
    public class IconButtonStyle extends LabelButtonStyle 
    {
        /**
         * Creates a new IconButtonStyle instance.
         * @param init An object that contains properties with which to populate the newly IStyle object. If initObject is not an object, it is ignored.
         * @param id The id of the object.
         */
        public function IconButtonStyle( init:* = null , id:* = null )
        {
            super( init , id ) ;
        }
        
        /**
         * Indicates the height value of the label field of the component.
         */
        public var height:Number ;
        
        /**
         * The collection of all filters over the icon of the button.
         */
        public var iconFilters:Array ;
        
        /**
         * Indicates the width value of the label field of the component.
         */
        public var width:Number ;
        
        /**
         * Initialize the IStyle object.
          */
        public override function initialize():void 
        {
            super.initialize() ;
            margin      = new EdgeMetrics( 6, 0, 4, 0 ) ;
            padding     = new EdgeMetrics( 6, 2, 2, 2 ) ;
            theme       = new FillStyle( 0xA2A2A2 , 0.5 ) ;
            themeBorder = new LineStyle( 2 , 0xFFFFFF , 0.5 ) ;
        }
    }
}
