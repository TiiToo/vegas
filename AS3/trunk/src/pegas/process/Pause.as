/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is Vegas Framework.
  
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
    
    /**
     * This {@code IAction} object create a pause in the process.
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
		public function Pause( duration:Number=0 , seconds:Boolean=false, bGlobal:Boolean = false , sChannel:String = null )
		{
			
			super(bGlobal, sChannel) ;
			
			_timer = new Timer( 1000 , 1 ) ;
		    _timer.addEventListener( TimerEvent.TIMER_COMPLETE , _onFinished ) ;
		    _timer.addEventListener( TimerEvent.TIMER , _onTimer ) ;	
			
			this.duration = duration ;
		    this.useSeconds = seconds ;
		    
		}

    	/**
    	 * (read-write) Returns the duration of the process.
    	 * @return the duration of the process.
    	 */
    	public function get duration():Number
    	{
		    return ( isNaN(_duration) && !isFinite(_duration) ) ? 1 : _duration ;
	    }
	
	    /**
    	 * (read-write) Sets the duration of the process.
	     */
	    public function set duration( n:Number ):void 
	    {
    		_duration = (isNaN(duration) && duration < 0) ? 0 : duration ;	
    	}
	
    	/**
	     * Indicates if the process use seconds or not.
	     */
	    public var useSeconds:Boolean ;	
	
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
		    _timer.delay = useSeconds ? ( Math.round( duration * 1000 ) ) : duration ; 
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

	    private var _duration:Number ;
	    
	    private var _timer:Timer ;

        private function _onFinished(e:TimerEvent):void
        {
            trace(e) ;
            notifyFinished() ;
        }

        private function _onTimer(e:TimerEvent):void
        {
            trace(e) ;
        }


	}

}