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
    import lunas.Iconifiable;

    import flash.display.DisplayObject;
    import flash.display.Loader;
    import flash.net.URLRequest;

    /**
     * The IconButton component with a label and a basic icon display representation.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import lunas.components.buttons.IconButton ;
     * 
     * import flash.display.StageScaleMode ;
     * import flash.net.URLRequest;  
     * import flash.events.KeyboardEent ;
     * 
     * stage.scaleMode = StageScaleMode.NO_SCALE ;
     * 
     * var bt:IconButton = new IconButton() ;
     * 
     * bt.x      = 25 ;
     * bt.y      = 25 ;
     * bt.icon   = new URLRequest("library/icons/none.png") ;
     * bt.label  = "Hello world" ;
     * bt.toggle = true ;
     * 
     * addChild( bt ) ;
     * 
     * var keyDown:Function = function( e:KeyboardEvent ):void
     * {
     *     var code:Number = e.keyCode ;
     *     switch(code)
     *     {
     *         case Keyboard.UP :
     *         {
     *             bt.icon = new URLRequest("library/icons/de.png") ;
     *             break ;
     *         }
     *         case Keyboard.DOWN :
     *         {
     *             bt.icon = new URLRequest("library/icons/none.png") ;
     *             break ;
     *         }
     *         case Keyboard.SPACE :
     *         {
     *            bt.icon = new Bitmap( new FR(16,11) ) ; // Bitmap icon in the library
     *            break ;
     *         }
     *     }
     * }
     * 
     * stage.addEventListener( KeyboardEvent.KEY_DOWN , keyDown ) ;
     * </pre>
     */
    public class IconButton extends LabelButton implements Iconifiable
    {
        /**
         * Creates a new IconButton instance.
         * @param w The prefered width of the button (default 120 pixels).
         * @param h The prefered height of the button (default 20 pixels).
         * @param id Indicates the id of the object.
         * @param isFull Indicates if the display is full size or not.
         * @param name Indicates the instance name of the object.
         */
        public function IconButton( w:Number = 120 , h:Number = 20 , id:* = null, isFull:Boolean=false, name:String = null )
        {
            super( w , h , id, isFull , name ) ;
        }
        
        /**
         * Indicates the icon value of this display (URLRequest or DisplayObject reference).
         * If the icon property is a URLRequest an external picture or swf is loading to populate the view of the icon;
         * If the icon property is a DisplayObject the component attach the visual reference to populate the view of the icon;
         */
        public function get icon():*
        {
            return _icon ;
        }
        
        /**
         * @private
         */
        public function set icon( value:* ):void
        {
            _icon = null ;
             if ( value != null )
             {
                 if ( value is DisplayObject )
                 {
                     _icon = value ;
                    (builder as IconButtonBuilder).attach( _icon as DisplayObject ) ;
                 }
                 else if ( value is URLRequest )
                 {
                     _icon = value ;
                    (builder as IconButtonBuilder).load( _icon as URLRequest ) ;
                 }
             }
        }
        
        /**
         * Indicates the icon content reference of the component.
         */
        public function get iconContent():*
        {
            var c:DisplayObject = (builder as IconButtonBuilder).container as DisplayObject ;
            if ( c == null )
            {
                return null ;
            }
            else
            {
                return  ( c is Loader ) ? ( c as Loader ).content : c ;
            }
        }
                
        /**
         * Returns the <code class="prettyprint">IBuilder</code> constructor use to initialize this component.
         * @return the <code class="prettyprint">IBuilder</code> constructor use to initialize this component.
         */
        public override function getBuilderRenderer():Class 
        {
            return IconButtonBuilder ;
        }
            
        /**
         * Returns the <code class="prettyprint">Style</code> constructor use to initialize this component.
         * @return the <code class="prettyprint">Style</code> constructor use to initialize this component.
         */
        public override function getStyleRenderer():Class 
        {
            return IconButtonStyle ;
        }
        
        /**
         * @private
         */
        private var _icon:* ;
    }
}
