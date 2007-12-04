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
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package pegas.process
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import vegas.util.Serializer;	

	/**
     * This {@code IAction} object create a pause in the process.
     * <p><b>Example :</b></p>
     * {@code
     * var handleEvent:Function = function( ...args:Array ) :void
     * {
     *     trace( this + " " + args) ;
     * }
     * var p:Pause = new Pause(10, true) ;
     * p.duration = 2 ;
     * p.addEventListener( ActionEvent.START  , handleEvent ) ;
     * p.addEventListener( ActionEvent.FINISH , handleEvent ) ;
     * p.run() ;
	 * }
     * @author eKameleon
     */
	public class Pause extends Action
	{
		
    	/**
    	 * Creates a new Pause instance.
    	 * @param duration the duration of the pause.
    	 * @param seconds the flag to indicates if the duration is in second or not.
    	 * @param bGlobal the flag to use a global event flow or a local event flow.
    	 * @param sChannel the name of the global event flow if the {@code bGlobal} argument is {@code true}.
		 */
		public function Pause( duration:uint = 0 , seconds:Boolean = false , bGlobal:Boolean = false , sChannel:String = null )
		{
			super(bGlobal, sChannel) ;
			_setDuration( duration ) ;
			_setUseSeconds( seconds ) ;
			_timer = new Timer( delay , 1 ) ;
		    _timer.addEventListener( TimerEvent.TIMER_COMPLETE , _onFinished ) ;
		    _timer.addEventListener( TimerEvent.TIMER , _onTimer ) ;	
		}
		
		/**
		 * (read-only) Returns the delay of the pause in ms. This property use the duration and useSeconds properties to defined the delay.
		 * @return the delay of the pause in ms.
		 */
		public function get delay():Number
		{
		    return useSeconds ? ( Math.round( duration * 1000 ) ) : duration ; 
		}

    	/**
    	 * (read-write) Returns the duration of the process.
    	 * @return the duration of the process.
    	 */
    	public function get duration():uint
    	{
		    return ( isNaN(_duration) && !isFinite(_duration) ) ? 1 : _duration ;
	    }
	
	    /**
    	 * (read-write) Sets the duration of the process.
	     */
	    public function set duration( n:uint ):void 
	    {
    		_duration = (isNaN(n) && n < 0 && !isFinite(n) ) ? 0 : n ;
    		_timer.delay = delay ;	
    	}
	
    	/**
	     * (read-write) Indicates if the process use seconds or not.
	     */
	    public function get useSeconds():Boolean
	    {
	        return _useSeconds ;
	    }	
	    
    	/**
	     * (read-write) Indicates if the process use seconds or not.
	     */
	    public function set useSeconds( b:Boolean ):void
	    {
	        _useSeconds = b ;
	        _timer.delay = delay ;	
	    }	
	
    	/**
    	 * Returns a shallow copy of this object.
    	 * @return a shallow copy of this object.
    	 */
		public override function clone():*
		{
			return new Pause(duration, useSeconds) ;
		}
		
		/**
	     * Runs the process.
	     */
	    public override function run( ...arguments:Array ):void 
	    {
    		if ( running ) 
    		{
    		    return ;
    		}
		    notifyStarted() ;
		    setRunning( true ) ;
		    _timer.start() ;
	    }
        
    	/**
	    * Start the pause process.
	    */
	    public function start():void 
	    {
    		run() ;
	    }

	    /**
	     * Stop the pause process.
	     */
	    public function stop():void 
	    {
    		if (_timer.running) 
		    {
    			setRunning(false) ;
			    _timer.stop() ;
			    notifyStopped() ;	
			    notifyFinished() ;	
		    }
	    }
	    
		/**
		 * Returns a Eden representation of the object.
		 * @return a string representation the source code of the object.
		 */
		public override function toSource(...arguments:Array):String 
		{
			return Serializer.getSourceOf( this , [ delay , useSeconds ] ) ;
		}
	    
	   	/**
    	 * Returns the string representation of this instance.
    	 * @return the string representation of this instance.
    	 */
	    public override function toString():String 
	    {
    		return "[Pause duration:" + duration + (useSeconds ? "s" : "ms") + "]" ;
    	}

	    private var _duration:uint = 0;
	    
	    private var _timer:Timer ;

        private var _useSeconds:Boolean = false ;

        /**
         * Invoqued when the internal timer of this process is finished.
         */
        private function _onFinished(e:TimerEvent):void
        {
            setRunning( false ) ;
            notifyFinished() ;
        }
        
        /**
         * Invoqued when the timer of this process is in progress.
         */
        private function _onTimer(e:TimerEvent):void
        {
            notifyProgress() ;
        }

        /**
    	 * Sets the duration of the process and not refresh the Timer delay value.
	     */        
        private function _setDuration( n:Number ):void 
	    {
    		_duration = (isNaN(n) && n < 0 && !isFinite(n) ) ? 0 : n ;
    	}
    	
    	/**
    	 * Sets the useSeconds value of the process and not refresh the Timer delay value.
	     */        
        private function _setUseSeconds( b:Boolean ):void 
	    {
    		_useSeconds = b ;
    	}
	}
}
