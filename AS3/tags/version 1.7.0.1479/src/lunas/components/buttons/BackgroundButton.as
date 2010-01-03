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
    import flash.events.Event;
    
    /**
     * The basic BackgroundButton component.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * package examples 
     * {
     *     import lunas.display.button.BackgroundButton;
     *     import lunas.display.button.BackgroundButtonStyle;
     *     
     *     import flash.display.Sprite;
     *     import flash.display.StageScaleMode;
     *     import flash.events.MouseEvent;
     *     import flash.filters.DropShadowFilter;
     *     
     *     public class ExampleBackgroundButton extends Sprite 
     *     {
     *         public function ExampleBackgroundButton()
     *         {
     *             //////////
     *             
     *             stage.scaleMode = StageScaleMode.NO_SCALE ;
     *             
     *             //////////
     *             
     *             var groupName:String = "background_button_group" ;
     *             
     *             bt1           = new BackgroundButton() ;
     *             bt1.x         = 25 ;
     *             bt1.y         = 50 ;
     *             bt1.groupName = groupName ;
     *             bt1.toggle    = true ;
     *             
     *             addChild(bt1) ;
     *             
     *             //////////
     *             
     *             bt2           = new BackgroundButton() ;
     *             bt2.x         = 25 ;
     *             bt2.y         = 80 ;
     *             bt2.groupName = groupName ;
     *             bt2.toggle    = true ;
     *             
     *             addChild(bt2) ;
     *             
     *             //////////
     *             
     *             var init:Object = 
     *             { 
     *                 themeFilters : [ new DropShadowFilter(4,45,0,0.7) ] 
     *             } ;
     *             
     *             bt3           = new BackgroundButton() ;
     *             bt3.x         =  25 ;
     *             bt3.y         = 110 ;
     *             bt3.groupName = groupName ;
     *             bt3.toggle    = true ;
     *             bt3.style     = new BackgroundButtonStyle( init ) ;
     *             
     *             addChild(bt3) ;
     *             
     *             //////////
     *             
     *             bt1.addEventListener( MouseEvent.CLICK , click ) ;
     *             bt2.addEventListener( MouseEvent.CLICK , click ) ;
     *             bt3.addEventListener( MouseEvent.CLICK , click ) ;
     *             
     *             ////////// Test singleton style by default
     *             
     *             bt1.setStyle( "topLeftRadius" , 4 ) ; 
     *             bt2.setStyle( "bottomLeftRadius" , 4 ) ;
     *             
     *             // Note: the style is a singleton by default in all default components
     *         }
     *         
     *         public var bt1:BackgroundButton ;
     *         public var bt2:BackgroundButton ;
     *         public var bt3:BackgroundButton ;
     *         
     *         public function click( e:MouseEvent ):void
     *         {
     *             trace( e ) ;
     *         }
     *     }
     * }
     * </pre>
     */
    public class BackgroundButton extends CoreButton 
    {
        /**
         * Creates a new BackgroundButton instance.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import lunas.components.buttons.BackgroundButton ;
         * 
         * var bt:LabelButton = new BackgroundButton() ;
         * bt.x               = 25 ;
         * bt.y               = 50 ;
         * bt.toggle          = true ;
         * 
         * addChild(bt) ;
         * </pre>
         * @param w The prefered width of the button (default 120 pixels).
         * @param h The prefered height of the button (default 20 pixels).
         * @param id Indicates the id of the object.
         * @param isFull Indicates if the display is full size or not.
         * @param name Indicates the instance name of the object.
         */
        public function BackgroundButton( w:Number = 120 , h:Number = 20 , id:* = null, isFull:Boolean=false, name:String = null )
        {
            super( id, isFull , name ) ;
            setSize( w , h ) ;
        }
        
        /**
         * Returns the <code class="prettyprint">Builder</code> constructor use to initialize this component.
         * @return the <code class="prettyprint">Builder</code> constructor use to initialize this component.
         */
        public override function getBuilderRenderer():Class 
        {
            return BackgroundButtonBuilder ;
        } 
        
        /**
         * Returns the <code class="prettyprint">Style</code> constructor use to initialize this component.
         * @return the <code class="prettyprint">Style</code> constructor use to initialize this component.
         */
        public override function getStyleRenderer():Class 
        {
            return BackgroundButtonStyle ;
        }
        
        /**
         * Invoked when the component Style changed.
         */
        public override function viewStyleChanged( e:Event = null ):void 
        {
            update() ;
        }
    }
}
