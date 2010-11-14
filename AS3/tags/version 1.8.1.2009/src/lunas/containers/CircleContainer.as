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
package lunas.containers 
{
    import graphics.layouts.CircleLayout;
    import graphics.layouts.Layout;
    
    import system.hack;
    
    import flash.display.Sprite;
    
    /**
     * This container display all this child elements with a circle trigonometric algorithm.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import flash.display.StageScaleMode ;
     * import flash.events.KeyboardEvent ;
     * import flash.ui.Keyboard ;
     * 
     * import graphics.Align;
     * 
     * import lunas.containers.CircleContainer ;
     * 
     * import vegas.colors.Color ;
     * 
     * var container:CircleContainer = new CircleContainer() ;
     * 
     * container.align      = Align.CENTER ;
     * container.childCount = 10  ;
     * container.radius     = 35  ;
     * container.x          = 360 ;
     * container.y          = 230 ;
     * 
     * container.childAngle       = 90  ;
     * container.childOrientation = true ;
     * 
     * var middle:Middle = new Middle() ; // inside the library
     * 
     * addChild( container ) ;
     * addChild( middle ) ;
     * 
     * var colors:Array =
     * [
     *     0x7A1D05 , 0xFF0000 , 0xF5532C , 0xECC671 , 0xF3E469 ,
     *     0xCFE478 , 0x72871B , 0x287968 , 0x1E5184 , 0x0E273F
     * ] ;
     * 
     * var n:int = colors.length ;
     * 
     * for (var i:int = 0 ; i<n ; i++ )
     * {
     *     var sprite:Sprite = new Particle() ;
     *     var co:Color = new Color( sprite ) ;
     *     co.setRGB( colors[i] ) ;
     *     container.addChild( sprite ) ;
     * }
     * 
     * var keyDown:Function = function( e:KeyboardEvent):void
     * {
     *     var code:Number = e.keyCode ;
     *     switch( code )
     *     {
     *         case Keyboard.UP :
     *         {
     *             container.childCount ++ ;
     *             container.radius += 10 ;
     *             break ;
     *         }
     *         case Keyboard.DOWN :
     *         {
     *             container.childCount -- ;
     *             container.radius -= 10 ;
     *             break ;
     *         }
     *         case Keyboard.SPACE :
     *         {
     *             var mc:Sprite = container.addChild( new Particle() ) ;
     *             var co:Color  = new Color( mc ) ;
     *             co.setRGB( Math.random() * 0xFFFFFF ) ;
     *             break ;
     *         }
     *         case Keyboard.LEFT:
     *         {
     *             container.startAngle -= 10 ;
     *             // container.align = Align.LEFT ;
     *             break ;
     *         }
     *         case Keyboard.RIGHT :
     *         {
     *             container.startAngle += 10 ;
     *             // container.align = Align.RIGHT ;
     *             break ;
     *         }
     *     }
     * }
     * 
     * stage.addEventListener( KeyboardEvent.KEY_DOWN , keyDown ) ;
     * stage.scaleMode = StageScaleMode.NO_SCALE ;
     * </pre>
     */
    public class CircleContainer extends Container 
    {
        use namespace hack ;
        
        /**
         * Creates a new CircleContainer instance.
         * @param id Indicates the id of the object.
         * @param isFull Indicates if the display is full size or not.
         * @param name Indicates the instance name of the object.
         */
        public function CircleContainer( id:* = null, isFull:Boolean=false, name:String = null )
        {
            super( id, isFull, name );
            
            _container = new Sprite();
            
            lock() ;
            addChild( _container ) ;
            unlock() ;
            
            registerView( _container ) ;
            
            layout = new CircleLayout() ;
            
            update() ;
        }
        
        /**
         * Indicates the angle value in degrees of the childs in the container.
         */
        public function get childAngle():Number 
        {
            return (_layout as CircleLayout).childAngle ; 
        }
        
        /**
         * @private
         */
        public function set childAngle( value:Number ):void 
        {
            (_layout as CircleLayout).childAngle = value ;
            update() ;
        }
        
        /**
         * Indicates the number of childs visible in this container (minimal value is 1).
         */
        public function get childCount():Number 
        {
            return (_layout as CircleLayout).childCount ; 
        }
        
        /**
         * @private
         */
        public function set childCount( n:Number ):void 
        {
            (_layout as CircleLayout).childCount = n ;
            update() ;
        }
        
        /**
         * Indicates if the childs of the container use a perpendicular tangente direction.
         * Use the childAngle value to change the angle of the perpendicular childs.
         */
        public function get childOrientation():Boolean 
        {
            return (_layout as CircleLayout).childOrientation ; 
        }
        
        /**
         * @private
         */
        public function set childOrientation( b:Boolean ):void 
        {
            (_layout as CircleLayout).childOrientation = b ;
            update() ;
        }
        
        /**
         * @private
         */
        public override function set layout( layout:Layout ):void
        {
            super.layout = ( layout as CircleLayout ) || new CircleLayout() ;
        }
        
        /**
         * Indicates the radius of the circle container.
         */
        public function get radius():Number 
        {
            return (_layout as CircleLayout).radius ;
        }
        
        /**
         * @private
         */
        public function set radius( n:Number ):void 
        {
            (_layout as CircleLayout).radius = n ;
            update() ;
        }
        
        /**
         * Indicates the value of the start angle to display all childs in the container (in degrees).
         */
        public function get startAngle():Number 
        {
            return (_layout as CircleLayout).startAngle ;
        }
        
        /**
         * @private
         */
        public function set startAngle(n:Number):void 
        {
           (_layout as CircleLayout).startAngle = n ;
           update() ;
        }
        
        /**
         * This Sprite reference defines a container display.
         */
        protected var _container:Sprite ;
    }
}
