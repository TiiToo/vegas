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
    import graphics.transitions.Tween;
    import graphics.transitions.TweenEntry;
    import graphics.transitions.easings.Back;
    
    import lunas.events.ComponentEvent;
    
    import system.events.ActionEvent;
    import system.numeric.Mathematics;
    
    import flash.display.DisplayObject;
    import flash.events.Event;
    
    /**
     * This container is a list and can be scrolled.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * package examples 
     * {
     *     import graphics.Direction;
     *     
     *     import lunas.containers.ScrollContainer;
     *     
     *     import vegas.colors.Color;
     *     
     *     import flash.display.Sprite;
     *     import flash.display.StageScaleMode;
     *     import flash.events.KeyboardEvent;
     *     import flash.ui.Keyboard;
     *     
     *     public dynamic class ScrollContainerExample extends Sprite 
     *     {
     *         public function ScrollContainerExample()
     *         {
     *             container       = new ScrollContainer() ;
     *             container.x     = 25 ;
     *             container.y     = 25 ;
     *             container.space = 10 ;
     *             
     *             container.spaceH = 50 ;
     *             container.spaceV = 20 ;
     *             
     *             container.childCount = 5 ;
     *             //container.useScrollRect = true ;
     *             
     *             container.direction = Direction.HORIZONTAL ;
     *             
     *             addChild( container ) ;
     *             
     *             for (var i:uint = 0 ; i<10 ; i++ ) 
     *             {
     *                 var s:*     = new Square() ; // MovieClip loaded from the library.
     *                 var c:Color = new Color(s) ;
     *                 c.rgb       = Math.random() * 0xFFFFFF ;
     *                 container.addChild( s ) ;
     *             }
     *             
     *             stage.scaleMode = StageScaleMode.NO_SCALE ;
     *             stage.addEventListener( KeyboardEvent.KEY_DOWN , keyDown ) ;
     *         }
     *         
     *         public var container:ScrollContainer ;
     *         
     *         public function keyDown( e:KeyboardEvent ):void
     *         {
     *             var code:uint = e.keyCode ;
     *             switch( code )
     *             {
     *                 case Keyboard.LEFT :
     *                 {
     *                     container.scroll -- ;
     *                     break ;
     *                 }
     *                 case Keyboard.RIGHT :
     *                 {
     *                     container.scroll ++ ;
     *                     break ;
     *                 }
     *                 case Keyboard.SPACE :
     *                 {
     *                     container.direction = container.direction == Direction.HORIZONTAL ? Direction.VERTICAL : Direction.HORIZONTAL ;
     *                     break ;
     *                 }
     *                 case Keyboard.UP :
     *                 {
     *                     container.fixScroll = !container.fixScroll ;
     *                     break ;
     *                 }
     *                 case Keyboard.DOWN :
     *                 {
     *                     container.noScrollEasing = !container.noScrollEasing ;
     *                     break ;
     *                 }
     *             }
     *         }
     *     }
     * }
     * </pre>
     */
    public class ScrollContainer extends ListContainer 
    {
        /**
         * Creates a new ScrollContainer instance.
         * @param direction The direction value of the bar ("vertical" or "horizontal", see <code class="prettyprint">graphics.Direction</code>).
         * @param id Indicates the id of the object.
         * @param isFull Indicates if the display is full size or not.
         * @param name Indicates the instance name of the object.
         */
        public function ScrollContainer( direction:String = "vertical", id:* = null, isFull:Boolean=false, name:String = null )
        {
            _tw = new Tween() ;
            _tw.addEventListener( ActionEvent.CHANGE , _refreshChilds ) ;
            _tw.addEventListener( ActionEvent.FINISH , _finish  ) ;
            
            _entry = new TweenEntry() ;
            
            super( direction , id, isFull, name );
            
            _tw.target = _container ;
        }
        
        /**
         * Determinates the bottom scroll value.
         */
        public function get bottomScroll():Number 
        {
            return ( maxscroll > 1) ? (scroll + ( childCount - 1 ) ) : childCount ;
        }
        
        /**
         * @private
         */
        public override function set direction(value:String):void
        {
            _container.x = _container.y = 0 ;
            super.direction = value ;
            speedScroll( (fixScroll == true) ? 1 : scroll ) ;
        }
        
        /**
         * Indicates if the scroll is fixed.
         */
        public var fixScroll:Boolean ;
        
        /**
          * Returns the maxscroll value.
         * @return the maxscroll value.
         */
        public function get maxscroll():Number 
        {
            var m:int = (numChildren - childCount) ;
            if (isNaN(m)) 
            {
                m = 1 ;
            }
            return ( m >= 1 ) ? m+1 : 1 ;
        }
        
        /**
         * Indicates if the scroll use an easing effect.
         */
        public var noScrollEasing:Boolean ;
        
        /**
         * Returns the scroll value of this container.
         * @return the scroll value of this container.
         */
        public function get scroll():Number 
        {
            return Mathematics.clamp( _scroll , 1 , maxscroll ) ;
        }
        
        /**
         * Sets the scroll value of this container.
         */
        public function set scroll(n:Number):void 
        {
            setScroll( n ) ;
        }
        
        /**
         * Indicates the scroll easing method.
         */
        public var scrollEasing:Function ;
        
        /**
         * Indicates the scroll duration.
         */
        public var scrollDuration:Number = 12  ;
        
        /**
         * Indicates if the container use cacheAsBitmap flag when the scroll is in progress.
         */
        public var useCacheAsBitmap:Boolean ;
        
        /**
         * Adds a child DisplayObject instance to this DisplayObjectContainer instance. 
         * The child is added to the front (top) of all other children in this DisplayObjectContainer instance. 
         * (To add a child to a specific index position, use the addChildAt() method.)
         * If you add a child object that already has a different display object container as a parent, 
         * the object is removed from the child list of the other display object container.
         * @param child The DisplayObject instance to add as a child of this DisplayObjectContainer instance.
         * @throws ArgumentError Throws if the child is the same as the parent. Also throws if the caller is a child (or grandchild etc.) of the child being added.
         * @return The DisplayObject instance that you pass in the child parameter.  
         */
        public override function addChild( child:DisplayObject ):DisplayObject
        {
            _container.x = _container.y = 0 ;
            var d:DisplayObject = super.addChild(child) ;
            speedScroll( (fixScroll == true) ? 1 : scroll ) ;
            return d ;
        }
        
        /**
         * Adds a child DisplayObject instance to this DisplayObjectContainer instance. The child is added at the index position specified. 
         * An index of 0 represents the back (bottom) of the display list for this DisplayObjectContainer object. 
         * @param child The DisplayObject instance to add as a child of this DisplayObjectContainer instance. 
         * @param index The index position to which the child is added. If you specify a currently occupied index position, the child object that exists at that position and all higher positions are moved up one position in the child list. 
         * @throws RangeError Throws if the index position does not exist in the child list.
         * @throws ArgumentError Throws if the child is the same as the parent. Also throws if the caller is a child (or grandchild etc.) of the child being added.
         * @return The DisplayObject instance that you pass in the child parameter. 
         */
        public override function addChildAt( child:DisplayObject , index:int ):DisplayObject
        {
            _container.x = _container.y = 0 ;
            var d:DisplayObject = super.addChildAt(child, index) ;
            speedScroll( (fixScroll == true) ? 1 : scroll ) ;
            return d ;
        }
        
        /**
         * Draws the view of the component.
         */
        public override function draw( ...arguments:Array ):void 
        {
            super.draw() ;
            _clearTween() ;
            if (fixScroll) 
            {
                speedScroll(1) ;
            }
        }
        
        /**
         * Returns the current container position.
         * @return the current container position.
         */
        public function getContainerPos():Number 
        {
            var index:Number = scroll - 1 ;
            var prop:String = getCoordinateProperty() ;
            return index > 0 ? -1 * getChildAt(index)[prop] : 0 ;
        }
        
        /**
         * Invoked when the scroll is finished.
         */
        public function notifyFinish():void 
        {
            dispatchEvent( new ActionEvent( ActionEvent.FINISH , this ) ) ;
        }
        
        /**
         * Notify a scroll ComponentEvent.
         */
        public function notifyScroll():void 
        {
            fireComponentEvent( ComponentEvent.SCROLL ) ;
        }
        
        /**
         * Invoked when the scroll is started.
         */
        public function notifyStart():void 
        {
            dispatchEvent( new ActionEvent( ActionEvent.START , this ) ) ;
        }
        
        /**
         * Removes the specified child DisplayObject instance from the child list of the DisplayObjectContainer instance. 
         * The parent property of the removed child is set to null , and the object is garbage collected if no other references to the child exist. 
         * The index positions of any display objects above the child in the DisplayObjectContainer are decreased by 1.
         * @param child The DisplayObject instance to remove.
         * @throws ArgumentError Throws if the child parameter is not a child of this object.
         * @return The DisplayObject instance that you pass in the child parameter.
         */
        public override function removeChild( child:DisplayObject ):DisplayObject
        {
            _container.x = _container.y = 0 ;
            var d:DisplayObject = super.removeChild(child) ;
            speedScroll( (fixScroll == true) ? 1 : scroll ) ;
            return d ;
        }
        
        /**
         * Removes a child DisplayObject from the specified index position in the child list of the DisplayObjectContainer. 
         * The parent property of the removed child is set to null, and the object is garbage collected if no other references to the child exist. 
         * The index positions of any display objects above the child in the DisplayObjectContainer are decreased by 1.
         * @param index The child index of the DisplayObject to remove.
         * @throws RangeError Throws if the index does not exist in the child list.
         * @throws SecurityError This child display object belongs to a sandbox to which the calling object does not have access. 
         * You can avoid this situation by having the child movie call the Security.allowDomain() method.          
         * @return The DisplayObject instance that was removed.
         */
        public override function removeChildAt( index:int ):DisplayObject
        {
            _container.x = _container.y = 0 ;
            var d:DisplayObject = super.removeChildAt(index) ;
            speedScroll( (fixScroll == true) ? 1 : scroll ) ;
            return d ;
        }
        
        /**
         * Removes all childs in the model defined for the first item by the specified index value, 
         * this method remove the first and the <code class="prettyprint">size - 1</code> items.
         * @throws RangeError if the index value is out of the bounds of the container elements.
         */
        public override function removeChildsAt( index:int, size:Number ):Array 
        {
            _container.x = _container.y = 0 ;
            var removes:Array = super.removeChildsAt( index , size ) ;
            speedScroll( fixScroll ? 1 : scroll ) ;
            return removes ;
        }
        
        /**
         * Removes a range of childs in the container.
         * @return the array representation of all removed items.
         * @throws RangeError if the index value is out of the bounds of the container elements.
         */
        public override function removeRange( from:int , to:int ):Array 
        {
            _container.x = _container.y = 0 ;   
            var removes:Array = super.removeChildsAt( from , to ) ;
            speedScroll( (fixScroll == true) ? 1 : scroll ) ;
            return removes ;
        }
        
        /**
         * Sets the scroll value of the container.
         * @param n the scroll value.
         * @param noEvent This optional flag disabled the scroll event notify in this method if it's <code class="prettyprint">true</code>.
         */
        public function setScroll( value:Number, noEvent:Boolean=false ):void  
        {
            if ( value == _scroll ) 
            {
                return ;
            }
            if ( maxscroll > 0 ) 
            {
                _scroll = value ;
                _changeScroll() ;
                if ( noEvent == false ) 
                {
                    notifyScroll() ;
                }
            }
            else 
            {
                _scroll = 1 ;
            }
        }
        
        /**
         * Scroll the container without scroll and without notify an event.
         */
        public function speedScroll( n:Number ):void 
        {
            _clearTween() ;
            var pro:String = getCoordinateProperty() ;
            var inv:String = (pro == propY) ? propX : propY ;
            _scroll = ( maxscroll > 0) ? n : 1 ;
            _container[ pro ] = getContainerPos() ;
            _container[ inv ] = 0 ;
        }
        
        /**
         * Invoked to refreshChilds during the scroll of this container.
         */
        protected function _refreshChilds( ...arguments:Array ):void 
        {
            // overrides this method.
        }
        
        /**
         * @private
         */
        private var _entry:TweenEntry ;
        
        /**
         * @private
         */
        private var _scroll:Number = 0 ;
        
        /**
         * @private
         */
        private var _tw:Tween ;
        
        /**
         * @private
         */
        private function _changeScroll():void 
        {
            if ( _tw != null )
            {
                if ( _tw.running ) 
                {
                    _tw.stop() ;
                }
            }
            var prop:String = getCoordinateProperty() ;
            var pos:Number  = getContainerPos () ;
            
            var inv:String = (prop == propY) ? propX : propY ;
            
            _container[inv] = 0 ;
            
            notifyStart() ;
            
            if ( noScrollEasing ) 
            {
                _container[prop] = pos ;
                _refreshChilds() ;
                notifyFinish() ;
            } 
            else 
            {
                _tw.clear() ;
                
                _entry.prop   = prop ;
                _entry.easing = scrollEasing || Back.easeOut ;
                _entry.begin  = _container[prop] ;
                _entry.finish = pos ;
                
                cacheAsBitmap = useCacheAsBitmap ;
                
                _tw.add( _entry ) ;
                _tw.duration = isNaN( scrollDuration ) ? 24 : scrollDuration ;
                _tw.run() ;
            }
        }
        
        /**
         * @private
         */
        private function _clearTween():void 
        {
            if ( _tw != null )
            {
                if ( _tw.running )
                {
                    _tw.stop() ;
                }
            } 
        }
        
        /**
         * @private
         */
        private function _finish( e:Event ):void
        {
            cacheAsBitmap = false ;
            notifyFinish() ;
        }
    }
}
