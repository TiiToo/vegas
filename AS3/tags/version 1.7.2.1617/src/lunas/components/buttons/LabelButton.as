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

    /**
     * This button contains a basic label field to display.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import lunas.components.buttons.LabelButton ;
     * 
     * var bt:LabelButton = new LabelButton() ;
     * 
     * bt.x               = 25 ;
     * bt.y               = 50 ;
     * bt.toggle          = true ;
     * 
     * bt.label           = "hello world" ;
     * 
     * addChild(bt) ;
     * </pre>
     */
    public class LabelButton extends BackgroundButton 
    {
        /**
         * Creates a new LabelButton instance.
         * @param w The prefered width of the button (default 120 pixels).
         * @param h The prefered height of the button (default 20 pixels).
         * @param id Indicates the id of the object.
         * @param isFull Indicates if the display is full size or not.
         * @param name Indicates the instance name of the object.
         */
        public function LabelButton( w:Number = 120 , h:Number = 20 , id:* = null, isFull:Boolean=false, name:String = null )
        {
            super( w , h , id, isFull , name ) ;
        }
        
        /**
         * Returns the <code class="prettyprint">IBuilder</code> constructor use to initialize this component.
         * @return the <code class="prettyprint">IBuilder</code> constructor use to initialize this component.
         */
        public override function getBuilderRenderer():Class 
        {
            return LabelButtonBuilder ;
        }
        
        /**
         * Returns the <code class="prettyprint">Style</code> constructor use to initialize this component.
         * @return the <code class="prettyprint">Style</code> constructor use to initialize this component.
         */
        public override function getStyleRenderer():Class 
        {
            return LabelButtonStyle ;
        }
        
        /**
         * Invoked when the label property of the component change.
         */
        public override function viewLabelChanged():void 
        {
            update() ;
        }
    }
}
