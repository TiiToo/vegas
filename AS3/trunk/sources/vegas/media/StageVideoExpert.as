/*

  Version: MPL 1.1/GPL 2.0/LGPL 2.1
 
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is VEGAS Framework.
  
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

package vegas.media
{
    import core.maths.clamp;

    import graphics.Direction;

    import system.process.Lockable;
    import system.signals.Signal;
    import system.signals.Signaler;

    import flash.display.Stage;
    import flash.events.Event;
    import flash.events.StageVideoEvent;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    import flash.media.StageVideo;
    import flash.net.NetStream;
    
    // TODO use keepAspectRatio boolean
    
    /**
     * This expert control a StageVideo instance.
     */
    public class StageVideoExpert implements Lockable
    {
        /**
         * Creates a new StageVideoExpert instance.
         * @param stage The stage reference.
         * @param The index of the StageVideo in the stage.stageVideos Vectors to find the good StageVideo reference (default 0).
         */
        public function StageVideoExpert( stage:Stage , x:Number = 0 , h:Number = 0 , width:Number = 0 , height:Number = 0 , index:uint = 0 )
        {
            _stage    = stage ;
            _index    = index ;
            _viewPort = new Rectangle( 0 , 0 , width , height ) ;
            if ( _stage )
            {
                setUp() ;
            }
        }
        
        /**
         * Indicates if the StageVideo object is resizing when the stage resize event is invoked.
         */
        public function get autoSize():Boolean
        {
            return _autoSize ;
        }
        
        /**
         * @private
         */
        public function set autoSize( b:Boolean ):void
        {
            if( _autoSize == b )
            {
                return ;
            }
            _autoSize = b ;
            if ( _stage )
            {
                if ( _autoSize )
                {
                    _stage.addEventListener( Event.RESIZE , update ) ;
                    update() ;
                } 
                else
                {
                    _stage.removeEventListener( Event.RESIZE , update ) ;
                }
            }
        }
        
        /**
         * If the stageVideo reference is not null, indicates the names of available color spaces for this video surface. 
         * Usually this list includes "BT.601" and "BT.709". 
         * On some configurations, only "BT.601" is supported which means a video is possibly not rendered in the correct color space.
         * <p><b>Note:</b> On AIR for TV devices, a value of "BT.601" indicates software playback, and a value of "BT.709" indicates hardware playback.</p>
         */
        public function get colorSpaces():Vector.<String>
        {
            return _stageVideo ? _stageVideo.colorSpaces : null ; 
        }
        
        /**
         * The depth level of a StageVideo object relative to other StageVideo objects.
         * StageVideo objects always display behind other objects on the stage. 
         * If a platform supports more than one StageVideo object, the depth property indicates a StageVideo object's depth level. 
         * The bottom StageVideo object's depth property has the smallest value. 
         * If multiple StageVideo objects have the same depth setting, the order they appear in the stage,stageVideos Vector determines their relative depth.
         */
        public function get depth():int
        {
            return _depth ;
        }
        
        /**
         * @private
         */
        public function set depth( value:int ):void
        {
            _depth = value ;
            if( _stageVideo )
            {
                _stageVideo.depth = _depth ;
            }
        }
        
        /**
         * Indicates the direction value of the background when the display is in this "full" mode (default value is null).
         * @see graphics.Direction
         */
        public function get direction():String
        {
            return _direction ;
        }
        
        /**
         * @private
         */
        public function set direction( value:String ):void
        {
            _direction = (value == Direction.VERTICAL || value == Direction.HORIZONTAL ) ? value : null ;
            update() ;
        }
        
        /**
         * Determinates the virtual height value of this component.
         */
        public function get h():Number 
        {
            var n:Number = ( _isFull && (_stage != null) && (_direction != Direction.HORIZONTAL) ) ? _stage.stageHeight : _viewPort.height ;
            return clamp( n , _minHeight, _maxHeight) ;
        }
        
        /**
         * @private
         */
        public function set h( n:Number ):void 
        {
            _viewPort.height = clamp( n , _minHeight, _maxHeight ) ;
            update() ;
        }
        
        /**
         * The index of the expert to choose the good StageVideo reference in the stage.stageVideos collection.
         */
        public function get index():uint
        {
            return _index ;
        }
        
        /**
         * @private
         */
        public function set index( value:uint ):void
        {
            if( value == _index )
            {
                return ;
            }
            tearDown() ;
            _index = value ;
            setUp();
        }
        
        /**
         * Indicates if the background use full size (use Stage.stageWidth and Stage.stageHeight to update the background).
         */
        public function get isFull():Boolean
        {
            return _isFull ;
        }
        
        /**
         * @private
         */
        public function set isFull( b:Boolean ):void
        {
            _isFull = b ;
            update() ;
        }
        
        /**
         * This property defined the maximum height of this display.
         */
        public function get maxHeight():Number
        {
            return _maxHeight ;
        }
        
        /**
         * @private
         */
        public function set maxHeight( n:Number ):void
        {
            _maxHeight = n ;
            if ( _maxHeight < _minHeight )
            {
                _maxHeight = _minHeight ;
            }
            update() ;
        }
        
        /**
         * Defines the maximum width of this display.
         */
        public function get maxWidth():Number
        {
            return _maxWidth ;
        }
        
        /**
         * This property defined the mimimun height of this display (This value is >= 0).
         */
        public function get minHeight():Number
        {
            return _minHeight ;
        }
        
        /**
         * @private
         */
        public function set minHeight( n:Number ):void
        {
            _minHeight = n > 0 ? n : 0 ;
            if ( _minHeight > _maxHeight )
            {
                _minHeight = _maxHeight ;
            }
            update() ;
        }
        
        /**
         * This property defined the mimimun width of this display (This value is >= 0).
         */
        public function get minWidth():Number
        {
            return _minWidth ;
        }
        
        /**
         * @private
         */
        public function set minWidth( n:Number ):void
        {
            _minWidth = n > 0 ? n : 0 ;
            if ( _minWidth > _maxWidth )
            {
                _minWidth = _maxWidth ;
            }
            update() ;
        }
        
        /**
         * @private
         */
        public function set maxWidth( n:Number ):void
        {
            _maxWidth = n ;
            if ( _maxWidth < _minWidth )
            {
                _maxWidth = _minWidth ;
            }
            update() ;
        }
        
        /**
         * The index of the expert to choose the good StageVideo reference in the stage.stageVideos collection.
         */
        public function get pan():Point
        {
            return _pan ;
        }
        
        /**
         * @private
         */
        public function set pan( value:Point ):void
        {
            _pan = value || new Point() ;
            if( _stageVideo )
            {
                _stageVideo.pan = _pan ;
            }
        }
        
        
        /**
         * This signal emit when the StageVideo object render state of the StageVideo object changes.
         */
        public function get renderState():Signaler
        {
            return _sRenderState ;
        }
        
        /**
         * @private
         */
        public function set renderState( signal:Signaler ):void
        {
            _sRenderState = signal || new Signal() ;
        }
        
        /**
         * The stage reference of this expert.
         */
        public function get stage():Stage
        {
            return _stage ;
        }
        
        /**
         * The StageVideo reference of the expert.
         */
        public function get stageVideo():StageVideo
        {
            return _stageVideo ;
        }
        
        /**
         * If the stageVideo reference is not null, an integer specifying the height of the video stream, in pixels.
         */
        public function get videoHeight():Number
        {
            return _stageVideo ? _stageVideo.videoHeight : NaN ; 
        }
        
        /**
         * If the stageVideo reference is not null, an integer specifying the width of the video stream, in pixels.
         */
        public function get videoWidth():Number
        {
            return _stageVideo ? _stageVideo.videoWidth : NaN ; 
        }
        
        /**
         * The absolute position and size of the video surface in pixels.
         * The position of the video is relative to the upper left corner of the stage.
         * The valid range of the x and y properties of the viewPort Rectangle object are -8192 to 8191. Therefore, you can position the video completely or partially off the stage. You can also make the video larger than the stage if you make the width and height properties of the viewPort property larger than the stage.
         */
        public function get viewPort():Rectangle
        {
            return _viewPort ;
        }
        
        /**
         * @private
         */
        public function set viewPort( value:Rectangle ):void
        {
            _viewPort = value || new Rectangle() ;
            update() ;
        }
        
        /**
         * Determinates the virtual height value of this component.
         */
        public function get w():Number 
        {
            var value:Number = ( _isFull && (_stage != null) && (_direction != Direction.VERTICAL) ) ? _stage.stageWidth : _viewPort.width ;
            return clamp( value , _minWidth, _maxWidth ) ;
        }
        
        /**
         * @private
         */
        public function set w( value:Number ):void 
        {
            _viewPort.width = clamp( value , _minWidth, _maxWidth ) ;
            update() ;
        }
        
        /**
         * Determinates the x coordinate of the video in the stage. If the expert use the isFull mode the x returns always 0 but keep in memory the real value.
         */
        public function get x():Number 
        {
            return _isFull ? 0 : _viewPort.x ;
        }
        
        /**
         * @private
         */
        public function set x( value:Number ):void 
        {
            _viewPort.x = value ;
            update() ;
        }
        
        /**
         * Determinates the y coordinate of the video in the stage. If the expert use the isFull mode the y returns always 0 but keep in memory the real value.
         */
        public function get y():Number 
        {
            return _isFull ? 0 : _viewPort.y ;
        }
        
        /**
         * @private
         */
        public function set y( value:Number ):void 
        {
            _viewPort.y = value ;
            update() ;
        }
        
        /**
         * The zoom setting of the video, specified as a Point object.
         * The zoom point is a scale factor. By default, the value of zoom is (1.0, 1.0). This default value displays the entire video in the StageVideo.viewPort rectangle.
         * The valid values of the zoom property range from (1.0, 1.0) to (16.0, 16.0). The x property of the zoom Point object specifies the zoom value for the horizontal pixels, and the y property specifies the zoom value for the vertical pixels.
         */
        public function get zoom():Point
        {
            return _pan ;
        }
        
        /**
         * @private
         */
        public function set zoom( value:Point ):void
        {
            _zoom = value || new Point(1,1) ;
            if( _stageVideo )
            {
                _stageVideo.zoom = _zoom ;
            }
        }
        
        /**
         * Specifies a video stream to be displayed within the boundaries of the StageVideo object in the application. 
         * The video stream is either a video file played with NetStream.play(), or null. 
         * A video file can be stored on the local file system or on Flash Media Server. 
         * If the value of the netStream argument is null, the video is no longer played in the StageVideo object. 
         * Before calling attachNetStream() a second time, call the currently attached NetStream object's close() method. 
         * Calling close() releases all the resources, including hardware decoders, involved with playing the video. 
         * Then you can call attachNetStream() with either another NetStream object or null.
         */
        public function attachNetStream( netStream:NetStream ):void
        {
            if( _stageVideo )
            {
                _stageVideo.attachNetStream( netStream ) ;
            }
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if the object is locked.
         * @return <code class="prettyprint">true</code> if the object is locked.
         */
        public function isLocked():Boolean 
        {
            return ___isLock___ > 0 ;
        }
        
        /**
         * Locks the object.
         */
        public function lock():void 
        {
            ___isLock___ ++ ;
        }
        
        /**
         * Reset the lock security of the display.
         */
        public function resetLock():void 
        {
            ___isLock___ = 0 ;
        }
        
        /**
         * Sets the virtual width (w) and height (h) values of the component.
         */
        public function setSize( width:Number, height:Number ):void
        {
            _viewPort.width  = isNaN(width)  ? 0 : clamp( width  , _minWidth  , _maxWidth  ) ; 
            _viewPort.height = isNaN(height) ? 0 : clamp( height , _minHeight , _maxHeight ) ; 
            update() ;
        }
        
        /**
         * Unlocks the display.
         */
        public function unlock():void 
        {
            ___isLock___ = Math.max( ___isLock___ - 1  , 0 ) ;
        }
        
        /**
         * @private
         */
        protected var _autoSize:Boolean ;
        
        /**
         * @private
         */
        protected var _direction:String ;
         
        /**
         * @private
         */
        protected var _isFull:Boolean ;
        
        /**
         * @private
         */
        protected var _maxHeight:Number ;
        
        /**
         * @private
         */
        protected var _maxWidth:Number ;
        
        /**
         * @private
         */
        protected var _minHeight:Number = 0 ;
        
        /**
         * @private
         */
        protected var _minWidth:Number = 0 ;
        
        /**
         * Set up the StageVideo reference.
         */
        protected function setUp():void
        {
            if ( _stage && !_stageVideo )
            {
                var videos:Vector.<StageVideo> = _stage.stageVideos ;
                if( videos && videos.length > 0 )
                {
                    _stageVideo = videos[_index] as StageVideo ;
                    if ( _stageVideo )
                    {
                        _stageVideo.pan   = _pan ;
                        _stageVideo.depth = _depth ;
                        _stageVideo.zoom  = _zoom ;
                        _stageVideo.addEventListener( StageVideoEvent.RENDER_STATE, _renderState , false , 0 , true );
                    }
                    update() ;
                }
            }
        }
        
        /**
         * Tear down the StageVideo reference.
         */
        protected function tearDown():void
        {
            if ( _stageVideo )
            {
                _stageVideo.attachNetStream( null ) ;
                _stageVideo.removeEventListener( StageVideoEvent.RENDER_STATE, _renderState );
                _stageVideo = null ;
            }
        }
        
        /**
         * Update the stageVideo object.
         */
        protected function update( e:Event = null ):void
        {
            if ( isLocked() )
            {
                return ;
            }
            if( _stageVideo )
            {
                _realPort.x          = _isFull ? 0 : _viewPort.x ;
                _realPort.y          = _isFull ? 0 : _viewPort.y ;
                _realPort.width      = w ;
                _realPort.height     = h ;
                _stageVideo.viewPort = _realPort ;
            }
        }
        
        /**
         * @private
         */
        private var _depth:uint ;
        
        /**
         * @private
         */
        private var _index:uint ;
        
        /**
         * @private
         */ 
        private var ___isLock___:uint ;
        
        /**
         * @private
         */
        private var _pan:Point = new Point() ;
        
        /**
         * @private
         */
        private var _realPort:Rectangle = new Rectangle() ;
        
        /**
         * @private
         */
        private var _sRenderState:Signaler = new Signal() ;
        
        /**
         * @private
         */
        private var _stage:Stage ;
        
        /**
         * @private
         */
        private var _stageVideo:StageVideo ;
        
        /**
         * @private
         */
        private var _viewPort:Rectangle ;
        
        /**
         * @private
         */
        private var _zoom:Point = new Point(1,1) ;
        
        /**
         * @private
         */
        private function _renderState( e:StageVideoEvent ):void
        {
            _sRenderState.emit( e.status , e.colorSpace , this ) ;
        }
    }
}
