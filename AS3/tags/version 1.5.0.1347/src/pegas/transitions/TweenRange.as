/*

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
    import system.numeric.Range;
    
    /**
     * The TweenRange class interpolate in time a value between a minimum and maximum
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * package examples 
     * {
     *     import pegas.transitions.TweenRange;
     *     import pegas.transitions.easing.Bounce;
     *     
     *     import system.events.ActionEvent;
     *     import system.numeric.Range;
     *     
     *     import flash.display.Sprite;
     *     
     *     public class ExampleTweenRange extends Sprite
     *     {
     *         public function ExampleTweenRange()
     *         {
     *             range = new Range( 100 , 200 ) ;
     *             
     *             tween = new TweenRange ( range , Bounce.easeOut, 24, false ) ;
     *             
     *             tween.addEventListener( ActionEvent.CHANGE , change ) ;
     *             
     *             tween.run() ;
     *         }
     *         
     *         public var range:Range ;
     *         
     *         public var tween:TweenRange ;
     *         
     *         public function change( e:ActionEvent ):void
     *         {
     *             trace( tween.position ) ;
     *         }
     *     }
     * }
     * </pre>
     */
    public class TweenRange extends TweenUnit
    {
        /**
         * Creates a new TweenRange instance.
         * @param range The range used to interpolate (by default a unity range is used between 0 and 1).
         * @param easing The easing equation reference.
         * @param duration A number indicating the length of time or number of frames for the tween motion.
         * @param useSeconds Indicates if the duration is in seconds.
         * @param auto Run the tween automatically.
         */
        public function TweenRange( range:Range = null , easing:* = null , duration:Number = 0 , useSeconds:Boolean = false , auto:Boolean = false )
        {
            this.range      = range      ;
            super( easing , duration, useSeconds, auto ) ;
        }
        
        /**
         * Determinates the maximum value of the range.
         */
        public function get max():Number
        {
            return _range.max ;
        }
        
        /**
         * @private
         */
        public function set max( value:Number ):void
        {
            _range.max = value ;
        }
        
        /**
         * Determinates the minimum value of the range.
         */
        public function get min():Number
        {
            return _range.min ;
        }
        
        /**
         * @private
         */
        public function set min( value:Number ):void
        {
            _range.min = value ;
        }
        
        /**
         * The range used to interpolate the position property. 
         * This property can't be null, by default a unity range is defined (new Range(0,1)).
         */
        public function get range():Range
        {
            return _range ;
        }
        
        /**
         * @private
         */
        public function set range( r:Range ):void
        {
            _range  = r || Range.UNITY.clone() ;
        }
        
        /**
         * Returns a shallow copy of this Tween object.
         * @return a shallow copy of this Tween object.
         */
        public override function clone():* 
        {
            return new TweenRange( _range , easing, duration, useSeconds) ;
        }
        
        /**
         * Update the current Tween in the time.
         */
        public override function update():void 
        {
            position = _easing( _time, _range.min, _range.max - _range.min , _duration ) ;
            notifyChanged() ;
        }
        
        /**
         * @private
         */
        private var _range:Range ;
    }
}
