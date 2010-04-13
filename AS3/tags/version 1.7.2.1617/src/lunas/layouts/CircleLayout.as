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
package lunas.layouts 
{
    import graphics.Align;
    import graphics.numeric.Degrees;
    import graphics.numeric.Trigo;
    
    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    
    /**
     * This layout display all the childs elements in a specific DisplayObjectContainer with a circle trigonometric algorithm.
     */
    public class CircleLayout extends CoreLayout 
    {
        /**
         * Creates a new CircleLayout instance.
         * @param container The container to layout.
         */
        public function CircleLayout( container:DisplayObjectContainer = null )
        {
            super( container );
        }
        
        /**
         * Indicates the angle value in degrees of the childs in the container.
         */
        public function get childAngle():Number 
        {
            return _childAngle ; 
        }
        
        /**
         * @private
         */
        public function set childAngle( value:Number ):void 
        {
            _childAngle = isNaN(value) ? 0 : value ;
            run() ;
        }
        
        /**
         * Indicates the number of childs visible in this container (minimal value is 1).
         */
        public function get childCount():Number 
        {
            return _childCount ; 
        }
        
        /**
         * @private
         */
        public function set childCount(n:Number):void 
        {
            _childCount = n > 1 ? n : 1 ;
            run() ;
        }
        
        /**
         * Indicates if the childs of the container use a perpendicular tangente direction.
         * Use the childAngle value to change the angle of the perpendicular childs.
         */
        public function get childOrientation():Boolean 
        {
            return _childOrientation ; 
        }
        
        /**
         * @private
         */
        public function set childOrientation( b:Boolean ):void 
        {
            _childOrientation = b ;
            run() ;
        }
        
        /**
         * Indicates the radius of the circle container.
         */
        public function get radius():Number 
        {
            return _radius ;
        }
        
        /**
         * @private
         */
        public function set radius( n:Number ):void 
        {
            _radius = isNaN(n) ? 0 : n ;
            run() ;
        }
        
        /**
         * Indicates the value of the start angle to display all childs in the container (in degrees).
         */
        public function get startAngle():Number 
        {
            return Trigo.radiansToDegrees(_startAngle) ;
        }
        
        /**
         * @private
         */
        public function set startAngle(n:Number):void 
        {
            _startAngle = Trigo.degreesToRadians( isNaN(n) ? 0 : n%360 ) ;
            run() ;
        }
        
        /**
         * Render the layout, refresh and change the position of all childs in a specific container.
         */
        public override function render():void
        {
            if ( _container && _container.numChildren > 0 )
            {
                var child:DisplayObject ;
                var l:Number = _container.numChildren ;
                for ( var i:int ; i<l ; i++ ) 
                {
                    child    = _container.getChildAt(i) ;
                    child.x  = _radius * Math.cos( _startAngle - _pi1 + i * _pi2 / _childCount  )  ;
                    child.y  = _radius * Math.sin( _startAngle - _pi1 + i * _pi2 / _childCount  )  ;
                    if ( _childOrientation )
                    {
                        child.rotation = Degrees.atan2D( child.y , child.x ) + _childAngle ;
                    }
                }
            }
            _renderer.emit( this ) ;
        }
        
        /**
         * Receives a message when the layout emit when is updated.
         */
        public override function update():void
        {
            if ( _container )
            {
                _container.x = 0 ;
                _container.y = 0 ;
                if ( _container.numChildren > 0 ) 
                {
                    if (_align == Align.CENTER) 
                    {
                        // default
                    }
                    else if (_align == Align.BOTTOM) 
                    {
                        _container.y -= _container.height / 2 ;
                    }
                    else if (_align == Align.BOTTOM_LEFT) 
                    {
                        _container.x += _container.width / 2 ;
                        _container.y -= _container.height / 2 ;
                    }
                    else if (_align == Align.BOTTOM_RIGHT) 
                    {
                        _container.x -= _container.width / 2 ;
                        _container.y -= _container.height / 2 ;
                    }
                    else if (_align == Align.LEFT) 
                    {
                        _container.x += _container.width / 2 ;
                    }
                    else if (_align ==  Align.RIGHT) 
                    {
                        _container.x -= _container.width / 2 ;
                    }
                    else if (_align == Align.TOP) 
                    {
                        _container.y += _container.height / 2 ;
                    }
                    else if (_align == Align.TOP_RIGHT) 
                    {
                        _container.x -= _container.width / 2 ;
                        _container.y += _container.height / 2 ;
                    }
                    else // TOP_LEFT
                    {
                        _container.x += _container.width / 2 ;
                        _container.y += _container.height / 2 ;
                    }
                }
            }
        }
        
        /**
         * @private
         */
        protected var _childAngle:Number = 0 ;
        
        /**
         * @private
         */
        protected var _childCount:Number = 10 ;
        
        /**
         * @private
         */
        protected var _childOrientation:Boolean ;
        
        /**
         * @private
         */
        protected var _radius:Number = 100 ;
        
        /**
         * @private
         */
        protected var _startAngle:Number = 0 ;
         
        /**
         * @private
         */
        private const _pi1:Number =  Math.PI / 2 ;
        
        /**
         * @private
         */
        private const _pi2:Number = 2 * Math.PI ;
    }
}
