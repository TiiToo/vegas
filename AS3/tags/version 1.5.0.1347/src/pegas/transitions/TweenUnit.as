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
    import pegas.transitions.Motion;
    import pegas.transitions.easings.Easing;
    
    /**
     * The TweenUnit class interpolate in time a value between 0 and 1.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * package examples 
     * {
     *     import pegas.transitions.TweenUnit;
     *     import pegas.transitions.easing.Bounce;
     *     
     *     import system.events.ActionEvent;
     *     
     *     import flash.display.Sprite;
     *     
     *     public class ExampleTweenUnit extends Sprite
     *     {
     *         public function ExampleTweenUnit()
     *         {
     *             tween = new TweenUnit ( Bounce.easeOut, 24, false, true ) ;
     *             tween.addEventListener( ActionEvent.CHANGE , change ) ;
     *             tween.run() ;
     *         }
     *         
     *         public var tween:TweenUnit ;
     *         
     *         public function change( e:ActionEvent ):void
     *         {
     *             trace( tween.position ) ;
     *         }
     *     }
     * }
     * </pre>
     */
    public class TweenUnit extends Motion
    {
        /**
         * Creates a new TweenUnit instance.
         * @param easing The easing equation reference.
         * @param duration A number indicating the length of time or number of frames for the tween motion.
         * @param useSeconds Indicates if the duration is in seconds.
         * @param auto Run the tween automatically.
         */
        public function TweenUnit( easing:* = null , duration:Number = 0 , useSeconds:Boolean = false , auto:Boolean = false )
        {
            this.duration   = duration   ;
            this.easing     = easing     ;
            this.useSeconds = useSeconds ;
            if ( auto ) 
            {
                run() ;
            }
        }
        
        /**
         * Defines the easing method reference of this entry.
         */
        public function get easing():*
        {
            return _easing as Object ;
        }
        
        /**
         * @private
         */
        public function set easing( f:* ):void 
        {
            if ( f is Easing )
            {
                _easing = f.ease ;
            }
            else if ( f is Function )
            {
                _easing = f ;
            }
            else
            {
                _easing = noEasing ;
            }
        }
        
        /**
         * The current position of this tween.
         */
        public var position:Number ;
        
        /**
         * Returns a shallow copy of this Tween object.
         * @return a shallow copy of this Tween object.
         */
        public override function clone():* 
        {
            return new TweenUnit(easing, duration, useSeconds) ;
        }
        
        /**
         * Set the TweenUnit properties.
         * @param easing the easing function of the tween entry.
         * @param duration A number indicating the length of time or number of frames for the tween motion.
         * @param useSeconds Indicates if the duration is in seconds.
         */
        public function set( easing:* , duration:Number = 0 , useSeconds:Boolean = false ):void
        {
            this.duration   = duration   ;
            this.useSeconds = useSeconds ;
            this.easing     = easing     ;
        }
        
        /**
         * Update the current Tween in the time.
         */
        public override function update():void 
        {
            position = _easing( _time, 0, _change , _duration ) ;
            notifyChanged() ;
        }
        
        /**
         * @private
         */
        protected var _change:Number = 1 ; // max - min
        
        /**
         * @private
         */
        protected var _easing:Function ;
        
        /**
         * @private
         */
        private function noEasing(t:Number, b:Number, c:Number, d:Number):Number 
        {
            return c * t / d + b ;
        }
    }
}

