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
package lunas.components.textinputs 
{
    import core.maths.replaceNaN;

    import graphics.IFillStyle;
    import graphics.ILineStyle;
    import graphics.drawing.IPen;

    import vegas.colors.LightColor;

    import flash.display.Sprite;
    import flash.events.Event;
    import flash.text.TextField;
    import flash.text.TextFormat;
    
    /**
     * The simple representation of the TextInput interface.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import lunas.components.textinputs.SimpleTextInput ;
     * import lunas.components.textinputs.SimpleTextInputStyle ;
     * 
     * var input:SimpleTextInput = new SimpleTextInput() ;
     *  
     * input.x = 50 ;
     * input.y = 50 ;
     * 
     * addChild( input ) ;
     * 
     * // tests
     * 
     * input.style = new SimpleTextInputStyle( null , { color:0xFF0000 } ) ;
     * 
     * // input.displayAsPassword = true ;
     * // input.htmlText = "&lt;p&gt;Hello &lt;b&gt;World&lt;/b&gt;&lt;/p&gt;" ;
     * // input.restrict = "a-z 1-9" ;
     * // input.editable = false ;
     * // input.enabled  = false ;
     * </pre>
     */
    public class SimpleTextInput extends CoreTextInput 
    {
        /**
         * Creates a new SimpleTextInput instance.
         */ 
        public function SimpleTextInput()
        {
            lock() ;
            super() ;
            background        = new Sprite() ;
            textField         = new TextField() ;
            defaultTextFormat = new TextFormat("Verdana", 11, null, null, null, null, null, null, null, 4, 4 ) ;
            unlock() ;
            setSize(150,20) ;
        }
        
        /**
         * The internal background of this TextInput.
         */
        public function get background():Sprite
        {
            return _background ;
        }
        
        /**
         * @private
         */
        public function set background( sprite:Sprite ):void
        {
            if ( _background != null )
            {
                _backgroundColor = null ;
                _backgroundPen    = null ;
                removeChild( _background ) ;
            }
            _background      = sprite || new Sprite() ;
            _backgroundColor = new LightColor(_background) ;
            _backgroundPen   = initBackgroundPen(_background) ;
            addChildAt(_background, 0) ;
            update() ;
        }
        
        /**
         * Determinates the background IFillStyle reference of this display.
         */
        public function get backgroundFill():IFillStyle
        {
            return (style as SimpleTextInputStyle).backgroundFill ;
        }
        
        /**
         * @private
         */
        public function set backgroundFill( style:IFillStyle ):void
        {
           (style as SimpleTextInputStyle).backgroundFill = style ;
            update() ;
        }
        
        /**
         * Determinates the background ILineStyle reference of this display.
         */
        public function get backgroundLine():ILineStyle
        {
            return (style as SimpleTextInputStyle).backgroundLine ;
        }
        
        /**
         * @private
         */
        public function set backgroundLine( style:ILineStyle ):void
        {
           (style as SimpleTextInputStyle).backgroundLine = style ;
            update() ;
        }
        
        /**
         * Draw the view of the component.
         */
        public override function draw( ...arguments:Array ):void
        {
            if ( textField != null && _backgroundPen != null )
            {
                var b:Number = replaceNaN( border.bottom ) ;
                var l:Number = replaceNaN( border.left   ) ;
                var r:Number = replaceNaN( border.right  ) ;
                var t:Number = replaceNaN( border.top    ) ;
                
                var $w:Number = isNaN(w) ? 0 : w ;
                var $h:Number = isNaN(h) ? 0 : h ;
                
                var s:SimpleTextInputStyle = style as SimpleTextInputStyle ;
                
                _backgroundPen.fill = s.backgroundFill ; 
                _backgroundPen.line = s.backgroundLine ;
                
                _backgroundPen.draw( 0, 0, $w, $h ) ;
                
                textField.textColor = enabled ? s.color : s.disabledColor ;
                
                textField.x      = l  ;
                textField.y      = t+1  ;
                textField.width  = $w - l - r ;
                textField.height = $h - t - b ;
            }
        }
        
        /**
         * Invoked when the style of the component is changed.
         */
        public override function getStyleRenderer():Class 
        {
            return SimpleTextInputStyle ;
        }
        
        /**
         * Invoked when the group property or the groupName property changed.
         */
        public override function groupPolicyChanged():void 
        {
            //
        }
        
        /**
         * Called when the view of the component is changed.
         */
        public override function viewChanged():void
        {
            
        }
        
        /**
         * Invoked when the enabled property of the component change.
         */
        public override function viewEnabled():void 
        {
            var s:SimpleTextInputStyle = style as SimpleTextInputStyle ;
            textField.textColor = enabled ? s.color : s.disabledColor ;
            viewEditableChanged() ;
        }
        
        /**
         * Invoked when the component IStyle changed.
         */
        public override function viewStyleChanged( e:Event=null ):void 
        {
            update() ;
        }
        
        /**
         * @private
         */
        private var _background:Sprite ;
        
        /**
         * @private
         */
        private var _backgroundColor:LightColor ;
        
        /**
         * @private
         */
        private var _backgroundPen:IPen ;
    }
}
