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
    import flash.events.Event;
    import flash.events.TimerEvent;
    import flash.utils.getTimer;

    /**
     * Constructs a <code class="prettyprint">new FrameTimer</code> object with the specified delay and repeat state. 
     * This timer use the frames by second of the animation. 
     * The timer does not start automatically, you much call the <code class="prettyprint">start()</code> method to start it.
     */
    public class FrameTimer extends FrameEngine implements ITimer 
    {

        /**
         * Creates a new FrameTimer instance.
         * The timer does not start automatically; you must call the start() method to start it.
         * @param delay The delay between timer events, in milliseconds.
         * @param repeatCount Specifies the number of repetitions. If zero, the timer repeats infinitely. If nonzero, the timer runs the specified number of times and then stops. 
         * @param global the flag to use a global event flow or a local event flow.
         * @param channel the name of the global event flow if the <code class="prettyprint">bGlobal</code> argument is <code class="prettyprint">true</code>.
         */
        public function FrameTimer(delay:Number = 0, repeatCount:int = 0, global:Boolean = false, channel:String = null)
        {
            super( global , channel ) ;
            this.delay       = delay ;
            this.repeatCount = repeatCount ;
        }
        
        /**
         * Invoked when the frame engine is in progress.
         */        
        public override function enterFrame( e:Event = null ):void
        {
            _next     += getTimer() - _lastTime ;
            _lastTime  = getTimer() ;
            if ( _next >= _delay ) 
            {
                _count ++ ;
                dispatchEvent( new TimerEvent( TimerEvent.TIMER ) ) ;
                _next = 0 ;
            }
            if ( _repeatCount != 0 && _count >= _repeatCount ) 
            {
                dispatchEvent( new TimerEvent( TimerEvent.TIMER_COMPLETE ) ) ;
                this.reset() ;
            }
        }
        
        /**
         * The total number of times the timer has fired since it started at zero.
         */
        public function get currentCount():int 
        {
            return _count ;    
        }
        
        /**
         * The delay, in milliseconds, between timer events.
         * @throws Error Throws an exception if the delay specified is negative or not a finite number. 
         */
        public function get delay():Number 
        {
            return _delay ;
        }
        
        /**
         * @private
         */
        public function set delay( time:Number ):void 
        {
            if ( time < 0 || !isFinite(time) )
            {
                throw new Error( this + " the delay specified is negative or not a finite number." ) ;
            } ;
            _delay = (time > 0) ? time : 0 ;
        }
        
        /**
         * The total number of times the timer is set to run. 
         * If the repeat count is set to 0, the timer continues forever or until the stop() method is invoked or the program stops. 
         */
        public function get repeatCount():int
        {
            return _repeatCount ;
        }        

        /**
         * @private
         */
        public function set repeatCount( count:int ):void
        {
            _repeatCount = count ;
        }
        
        /**
         * Stops the timer, if it is running, and sets the currentCount property back to 0, like the reset button of a stopwatch.
         */
        public function reset():void
        {
            if ( running )
            {
                this.stop() ;
            }
            _count = 0 ;
        }
        
        /**
         * The internal counter of the timer.
         */
        protected var _count:int ;
        
        /**
         * The internal delay of the timer.
         */
        protected var _delay:Number ;
        
        /**
         * The internal 
         */
        protected var _lastTime:uint ;

        /**
         * The next value.
         */
        protected var _next:Number = 0 ;

        /**
         * The internal repeat counter of the timer.
         */
        protected var _repeatCount:int ;
        
    }
}
