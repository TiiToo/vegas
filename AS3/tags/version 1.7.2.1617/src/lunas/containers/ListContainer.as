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
    import graphics.Direction;
    import graphics.FillStyle;
    import graphics.drawing.IPen;
    import graphics.drawing.RectanglePen;
    import graphics.geom.EdgeMetrics;
    
    import lunas.layouts.Layout;
    
    import system.hack;
    
    import flash.display.DisplayObject;
    import flash.display.Sprite;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    
    /**
     * The ListContainer class is a list container component.
     */
    public class ListContainer extends Container
    {
        use namespace hack ;
        
        /**
         * Creates a new ListContainer instance.
         * @param direction The direction value of the bar ("vertical" or "horizontal", see <code class="prettyprint">graphics.Direction</code>).
         * @param id Indicates the id of the object.
         * @param isFull Indicates if the display is full size or not.
         * @param name Indicates the instance name of the object.
         */
        public function ListContainer( direction:String = "vertical" , id:* = null, isFull:Boolean=false, name:String = null )
        {
            super( id, isFull, name );
            
            _background         = new Sprite() ;
            _container          = new Sprite() ;
            _mask               = new Sprite() ;
            _area               = new Sprite() ;
            
            _background.buttonMode   = false ;
            _background.mouseEnabled = false ;
            
            _container.buttonMode   = false ;
            _container.mouseEnabled = false ;
            
            _area.buttonMode   = false ; 
            _area.mouseEnabled = false ;
            
            _mask.buttonMode   = false ; 
            _mask.mouseEnabled = false ;
            
            _areaPen       = new RectanglePen( _area ) ;
            _backgroundPen = new RectanglePen( _background ) ;
            _maskPen       = new RectanglePen( _mask ) ;
            
            _areaPen.fill       = new FillStyle( 0 , 0 ) ;
            _backgroundPen.fill = new FillStyle( 0 , 0 ) ;
            _maskPen.fill       = new FillStyle( 0 , 0 ) ;
            // _maskPen.fill       = new FillStyle( 0xFF0000 , 0.2 ) ; // Test only
            
            _bound = new Rectangle() ;
            
            lock() ;
            
            this.direction = direction ;
            
            addChild( _background ) ;
            addChild( _container ) ;
            addChild( _mask ) ;
            addChild( _area ) ;
            
            unlock() ;
            
            registerView( _container ) ;
            
            update() ;
        }
        
        /**
         * Returns the area reference of this component.
         */
        public function get area():Sprite 
        {
            return _area ;
        }
        
        /**
         * Indicates the area Pen reference of this component.
         */
        public function get areaPen():IPen 
        {
            return _areaPen ;
        }
        
        /**
         * Indicates the background reference of this component.
         */
        public function get background():Sprite 
        {
            return _background ;
        }
        
        /**
         * Indicates the background Pen reference of this component.
         */
        public function get backgroundPen():IPen 
        {
            return _backgroundPen ;
        }
        
        /**
         * Determinates the number of childs in this container. If this value is -1 no mask effect is apply over the list container, all the childs are visible.
         */
        public function get childCount():int 
        {
            return (_childCount > numChildren) ? numChildren : _childCount ;
        }
        
        /**
         * Sets the number of childs visible in this container.
         */
        public function set childCount( value:int ):void 
        {
            _childCount   = ( value > -1 ) ? value : -1 ; // -1 no mask effect
            _maskIsActive = _childCount > 0 ;
            update() ;
        }
        
        /**
         * Indicates if the mask is active or not over this container.
         */
        public function get maskIsActive():Boolean 
        {    
            return _maskIsActive ;
        }
        
        /**
          * @private
          */
        public function set maskIsActive( b:Boolean ):void 
        {
            _maskIsActive = b ;
            update() ;
        }
        
        /**
         * Determinates the mask reference of this container.
         */
        public function get maskView():Sprite 
        {    
            return _mask ;
        }
        
        /**
         * The height property name use in the container to layout all items.
         */
        public var propHeight:String = "height" ;
        
        /**
         * The x property name use in the container to layout all items.
         */
        public var propX:String = "x" ;
        
        /**
         * The y property name use in the container to layout all items.
         */
        public var propY:String = "y" ;
        
        /**
         * The width property name use in the container to layout all items.
         */
        public var propWidth:String = "width" ;
        
        /**
         * Returns the internal Rectangle object of this display.
         * @return the internal Rectangle object of this display.
         */
        public function get rectangle():Rectangle 
        { 
            return _bound ;
        }
        
        /**
         * Indicates the space value (in pixel) between 2 childs in the list.
         */
        public function get space():Number
        {
            return _space ;
        }
        
        /**
         * @private
         */
        public function set space(n:Number):void 
        {
            _space = isNaN(n) ? 0 : n ; 
            if ( numChildren > 0 )
            {
                update() ;
            }
        }
        
        /**
         * Indicates the space value (in pixel) between 2 childs in the list when the direction is horizontal.
         */
        public function get spaceH():Number
        {
            return _spaceH ;
        }
        
        /**
         * @private
         */
        public function set spaceH(n:Number):void 
        {
            _spaceH = n ; 
            if ( numChildren > 0 )
            {
                update() ;
            }
        }
        
        /**
         * Indicates the space value (in pixel) between 2 childs in the list when the direction is vertical.
         */
        public function get spaceV():Number
        {
            return _spaceV ;
        }
        
        /**
         * @private
         */
        public function set spaceV(n:Number):void 
        {
            _spaceV = n ; 
            if ( numChildren > 0 )
            {
                update() ;
            }
        }
        
        /**
         * Indicates if this container use a scrollRect reference to mask the content.
         */
        public function get useScrollRect():Boolean
        {
            return _useScrollRect ;
        }
        
        /**
         * @private
         */
        public function set useScrollRect( b :Boolean ):void
        {
            _useScrollRect = b ;
            update() ;
        }
        
        /**
         * Refreshs and changes the child position of all childs in the container.
         */
        public function changeChildsPosition():void 
        {
            var l:Number = numChildren ;
            if ( l > 0 )
            {
                var child:DisplayObject ;
                var prev:DisplayObject ;
                var spa:Number ;
                var pro:String = getCoordinateProperty() ;
                var inv:String = (pro == propY) ? propX : propY ;
                if ( direction == Direction.HORIZONTAL && !isNaN(_spaceH))
                {
                    spa = _spaceH ; 
                }
                else if ( direction == Direction.VERTICAL && !isNaN(_spaceV))
                {
                    spa = _spaceV ; 
                }
                else
                {
                    spa = _space ;
                }
                var s:String = getSizeProperty() ;
                for ( var i:int ; i < l ; i++ ) 
                {
                    child      = getChildAt(i) ;
                    prev       = i > 0 ? getChildAt(i-1) : null ;
                    child[pro] = (i == 0) ? 0 : ( prev[pro] + prev[s] + spa ) ;
                    child[inv] = 0 ;
                }
            }
        }
        
        /**
         * Draws the view of the component.
         */
        public override function draw( ...arguments:Array ):void 
        {
            if ( numChildren > 0 ) 
            {
                changeChildsPosition() ;
            }
            updateLayout() ;
            refreshBackground() ;
            refreshMask() ;
        }
        
        /**
         * Returns the string representation of the coordinate attribute used in this display with the current direction value.
         * @return the string representation of the coordinate attribute used in this display with the current direction value.
         */
        public function getCoordinateProperty():String 
        {
            return (direction == Direction.VERTICAL) ? propY : propX ;
        }
        
        /**
         * Returns the child position with the specified index and the current direction of this display.
         * @return the child position with the specified index and the current direction of this display.
         */
        public function getChildPositionAt( n:Number ):Point 
        {
            var o:DisplayObject ;
            var pos:Point = new Point() ;
            try
            {
                o = getChildAt(n-1) ;
            }
            catch( e:Error )
            {
                return pos ;
            }
            var p:String = getCoordinateProperty() ;
            var s:String = getSizeProperty() ;
            if ( direction == Direction.VERTICAL )
            {
                pos.x = 0 ;
                pos.y = o[p] + o[s] + ( isNaN(_spaceV) ? _space : _spaceV ) ;
            }
            else
            {
                pos.x = o[p] + o[s] + ( isNaN(_spaceH) ? _space : _spaceH ) ;
                pos.y = 0 ;
            }
            return pos ;
        }
        
        /**
         * Returns the string representation of the size attribute with the current direction.
         * @return the string representation of the size attribute with the current direction.
         */
        public function getSizeProperty():String 
        {
            return (direction == Direction.VERTICAL) ? propHeight : propWidth ;
        }
        
        /**
         * Use the mask protection.
         */
        public function lockMask():void
        {
            _lockMask = true ;
        }
        
        /**
         * Refresh the mask view of the display.
         */
        protected function refreshBackground():void 
        {
            _background.x = _bound.x ;
            _background.y = _bound.y ;
            _backgroundPen.draw( 0, 0, _bound.width , _bound.height ) ;
            _area.x = _bound.x ;
            _area.y = _bound.y ;
            _areaPen.draw( 0 , 0 , _bound.width , _bound.height ) ;
        }
        
        /**
         * Refresh the mask view of the display.
          */
        protected function refreshMask():void 
        {
            scrollRect = null ;
            mask       = null ;
            _mask.graphics.clear() ;
            if ( maskIsActive && _lockMask == false ) 
            {
                _maskPen.draw( _bound.x , _bound.y, _bound.width , _bound.height ) ;
                mask = _mask ; // remove this line to test the mask only
                if ( useScrollRect )
                {
                    scrollRect = _bound ;
                }
            }
        }
        
        /**
         * Unlock the mask protect.
         */
        public function unlockMask():void
        {
            _lockMask = false;    
        }
        
        /**
         * Invoked when the container layout change.
         */
        protected override function updateLayout( layout:Layout = null):void 
        {
            if ( numChildren > 0 ) 
            {
                var i:int ;
                var n:int ;
                
                var isHorizontal:Boolean = direction == Direction.HORIZONTAL ;
                
                _bound.width  = 0 ;
                _bound.height = 0 ;
                
                var d:DisplayObject ;
                
                var offset:Point = new Point(0,0) ;
                
                var n1:Number  = 0 ;
                var n2:Number  = 0 ;
                var p:String   = isHorizontal ? propWidth  : propHeight ;
                var f:String   = isHorizontal ? propHeight : propWidth  ;
                
                var vertical:Number   = EdgeMetrics.filterNaNValue( border.vertical ) ;
                var horizontal:Number = EdgeMetrics.filterNaNValue( border.horizontal ) ;
                
                var spa:Number ;
                if ( direction == Direction.HORIZONTAL && !isNaN(_spaceH))
                {
                    spa = _spaceH ; 
                }
                else if ( direction == Direction.VERTICAL && !isNaN(_spaceV))
                {
                    spa = _spaceV ;
                }
                else
                {
                    spa = _space ;
                }
                n = (childCount > 0) ? childCount : numChildren ;
                for ( i = 0 ; i<n ; i++) 
                {
                    d = getChildAt(i) ;
                    if ( d ) 
                    {
                        offset.x = Math.min( offset.x , d.x ) ;
                        offset.y = Math.min( offset.y , d.y ) ;
                        n1 += spa + d[p] ;
                    }
                }
                n1 -= spa ;
                
                n = numChildren ;
                for ( i = 0  ; i<n ; i++) 
                {
                    d = getChildAt(i) ;
                    if ( d != _mask ) 
                    {
                        n2 = Math.max(d[f], n2) ;
                    }
                }
                n2 += isHorizontal ? vertical : horizontal ;
                
                _bound.x      = offset.x ;
                _bound.y      = offset.y ;
                _bound.width  = (isHorizontal ? n1 : n2) ; 
                _bound.height = (isHorizontal ? n2 : n1) ;
            }
            else if ( maskIsActive ) 
            {
                _bound.width  = w ;
                _bound.height = h ; 
            }
            else 
            {
                _bound.width  = width ;
                _bound.height = height ;
            }
            _w = _bound.width ; 
            _h = _bound.height ;
        }
        
        /**
         * This area sprite defines a hide background display back of the display.
         */
        protected var _area:Sprite ;
        
        /**
         * The pen of the area IPen object.
         */
        protected var _areaPen:RectanglePen ;
        
        /**
         * This Background reference defines a background display.
         */
        protected var _background:Sprite ;
        
        /**
         * The pen of the background Pen object.
         */
        protected var _backgroundPen:RectanglePen ;
        
        /**
         * The Rectangle internal bound object of the container.
         */
        protected var _bound:Rectangle ;
        
        /**
         * This CoreShape reference defines a mask display.
         */
        protected var _mask:Sprite ;
        
        /**
         * The pen of the mask IPen object.
         */
        protected var _maskPen:RectanglePen ;
        
        /**
         * @private
         */
        private var _childCount:int = -1 ;
        
        /**
         * This CoreSprite reference defines a container display.
         */
        protected var _container:Sprite ;
        
        /**
         * @private
         */
        private var _lockMask:Boolean ;
        
        /**
         * @private
         */
        private var _maskIsActive:Boolean ;
        
        /**
         * @private
         */
        private var _space:Number = 0 ;
        
        /**
         * @private
         */
        private var _spaceH:Number ; 
        
        /**
         * @private
         */
        private var _spaceV:Number ; 
        
        /**
         * @private
         */
        private var _useScrollRect:Boolean ;
    }
}

