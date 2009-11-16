﻿/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is PEGAS Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2009
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
 
package pegas.transitions 
{
    /**
     * The TweenArray class interpolate a collection of numeric values defines in two Arrays (begin and finish).
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * package examples 
     * {
     *     import pegas.draw.Align;
     *     import pegas.draw.FillStyle;
     *     import pegas.draw.LineStyle;
     *     import pegas.draw.Pen;
     *     import pegas.draw.RectanglePen;
     *     import pegas.transitions.TweenTo;
     *     import pegas.transitions.easing.Bounce;
     *     
     *     import flash.display.Shape;
     *     import flash.display.Sprite;
     *     import flash.display.StageScaleMode;
     *     import flash.events.KeyboardEvent;
     *     import flash.ui.Keyboard;
     *     
     *     public class ExampleTweenTo extends Sprite
     *     {
     *         public function ExampleTweenTo()
     *         {
     *             /// stage
     *             
     *             stage.scaleMode = StageScaleMode.NO_SCALE ;
     *             
     *             stage.addEventListener( KeyboardEvent.KEY_DOWN , keyDown ) ;
     *             
     *             /// build and draw the shape
     *             
     *             var shape:Shape = new Shape() ;
     *             var pen:Pen     = new RectanglePen( shape ) ;
     *             
     *             pen.fill = new FillStyle(0xFFFFFF) ;
     *             pen.line = new LineStyle(1,0x999999) ;
     *             pen.draw(0,0,32,32,Align.CENTER) ;
     *             
     *             shape.x = 50 ;
     *             shape.y = 50 ;
     *             
     *             addChild( shape ) ;
     *             
     *             // initialize and run the tween
     *             
     *             var to:Object =
     *             {
     *                 x        : 700 ,
     *                 y        : 250 ,
     *                 rotation : 180
     *             };
     *             
     *             tween = new TweenTo( shape, to, Bounce.easeOut, 1.5, true , true ) ; // auto run
     *         }
     *         
     *         public var tween:TweenTo ;
     *         
     *         protected function keyDown( e:KeyboardEvent ):void
     *         {
     *             var code:uint = e.keyCode ;
     *             switch( code )
     *             {
     *                 case Keyboard.UP :
     *                 {
     *                     tween.duration = 1 ;
     *                     tween.run( { x : 50 , y : 50 , rotation : 0 } ) ;
     *                     break ;
     *                 }
     *                 default :
     *                 {
     *                     tween.duration = 1.5 ;
     *                     tween.to = { x : 700 , y : 250 , rotation : 180 } ;
     *                     tween.run() ;
     *                     break ;
     *                 }
     *             }
     *         }
     *     }
     * }
     * </pre>
     */
    public class TweenTo extends TweenUnit
    {
        /**
         * Creates a new TweenTo instance.
         * @param obj The target object of this tween.
         * @param to A generic object to defines the value of all properties to change over the specified object during the tween process.
         * @param easing The easing equation reference.
         * @param duration A number indicating the length of time or number of frames for the tween motion.
         * @param useSeconds Indicates if the duration is in seconds.
         * @param auto Run the tween automatically.
         */
        public function TweenTo( obj:* = null , to:Object = null , easing:* = null , duration:Number = 0 , useSeconds:Boolean = false , auto:Boolean = false )
        {
            super( easing , duration, useSeconds, false ) ;
            this.target = obj ;
            this.to     = to  ;
            if ( auto ) 
            {
                run() ;
            }
        }
        
        /**
         * @private
         */
        public override function set target( obj:* ):void
        {
            _target  = obj ;
            _changed = true ;
        }
        
        /**
         * Determinates the generic object with all properties to change inside.
         */
        public function get to():Object
        {
            return _to ;
        }
        
        /**
         * @private
         */
        public function set to( obj:* ):void
        {
            _to = obj ;
            _changed = true ;
        }
        
        /**
         * Returns a shallow copy of this Tween object.
         * @return a shallow copy of this Tween object.
         */
        public override function clone():* 
        {
            return new TweenTo( _target , _to , easing, duration, useSeconds) ;
        }
        
        /**
         * Runs the process.
         */
        public override function run( ...arguments:Array ):void 
        {
            if ( arguments.length > 0 && arguments[0] != null )
            {
                to = arguments[0] as Object ;
            }
            super.run() ;
        }
        
        /**
         * Update the current Tween in the time.
         */
        public override function update():void 
        {
            if ( _changed )
            {
                _changed = false ;
                if ( _target == null)
                {
                    throw new Error( this + " update failed, the 'target' property not must be null.") ;
                }
                if ( _to == null)
                {
                    throw new Error( this + " update failed, the 'to' property not must be null.") ;
                }
                _from = {} ;
                for ( _prop in _to )
                {
                    _from[_prop] = _target[_prop] ;
                }
                
            }
            for ( _prop in _to )
            {
                _target[_prop] = _easing( _time, _from[_prop] , _to[_prop] - _from[_prop] , _duration ) ;
            }
            notifyChanged() ;
        }
        
        /**
         * @private
         */
        protected var _changed:Boolean ;
        
        /**
         * @private
         */
        protected var _from:Object ;
        
        /**
         * @private
         */
        protected var _prop:String ;
        
        /**
         * @private
         */
        protected var _to:Object ;
    }
}
