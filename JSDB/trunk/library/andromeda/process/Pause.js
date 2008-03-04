/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is AndromedA Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

/**
 * This IAction object create a pause in the process.
 * @author eKameleon
 */
if (andromeda.process.Pause == undefined) 
{

	/**
	 * @requires andromeda.process.AbstractAction
	 */
	require("andromeda.process.AbstractAction") ;

	/**
	 * Creates a new Pause instance.
	 * @param duration the duration of the process.
	 * @param useSeconds the flag to indicate if the duration is in seconds or milliseconds.
	 * @param bGlobal the flag to use a global event flow or a local event flow.
	 * @param sChannel the name of the global event flow if the {@code bGlobal} argument is {@code true}.
	 */
	andromeda.process.Pause = function( duration /*Number*/ , useSeconds /*Boolean*/ , bGlobal /*Boolean*/ , sChannel /*String*/  ) 
	{ 
		
		andromeda.process.AbstractAction.call(this,  bGlobal, sChannel ) ;
		
		this.setDuration(duration) ;
		this.useSeconds = useSeconds || false ;
		
		var finishListener /*EventListener*/ = new vegas.events.Delegate(this, this.notifyFinished) ;
		
		this._timer = new vegas.util.Timer() ;
		this._timer.setRepeatCount(1) ;
		this._timer.addEventListener( vegas.events.TimerEventType.TIMER, finishListener ) ;
		
	}

	/**
	 * @extends andromeda.process.AbstractAction
	 */
	proto = andromeda.process.Pause.extend( andromeda.process.AbstractAction ) ;

	/**
	 * Indicates if the process use seconds or not.
	 */
	proto.useSeconds /*Boolean*/ = false ;

	/**
	 * Returns a shallow copy of this object.
	 * @return a shallow copy of this object.
	 */
	proto.clone = function () /*Pause*/ 
	{
		return new andromeda.process.Pause( this.getDuration(), this.useSeconds ) ;
	}

	/**
	 * Returns the duration of the process.
	 * @return the duration of the process.
	 */
	proto.getDuration = function () /*Number*/ 
	{
		var d /*Number*/ = this._duration ;
		if ( this.useSeconds )
		{
			d = Math.round(d * 1000) ;
		}
		return d ;
	}

	/**
	 * Runs the process.
	 */
	proto.run = function () /*void*/ 
	{
		if (this._timer.running) 
		{
			return ;
		}
		
		this.notifyStarted() ;
		this.setRunning(true) ;
		this._timer.setDelay(this.getDuration()) ;
		this._timer.start() ;
		
	}

	/**
	 * Sets the duration of the process.
	 */
	proto.setDuration = function ( duration /*Number*/ ) /*void*/
	{
		this._duration = (duration > 0) ? duration : 0 ;
	}

	/**
	 * Start the pause process.
	 */
	proto.start = function () /*void*/
	{
		this.run() ;
	}

	/**
	 * Stop the pause process.
	 */
	proto.stop = function () /*void*/
	{
		if ( this._timer.running() ) 
		{
			this.setRunning(false) ;
			this._timer.stop() ;
			this.notifyStopped() ;	
			this.notifyFinished() ;	
		}	
	}

	/**
	 * Returns a Eden reprensation of the object.
	 * @return a string representing the source code of the object.
	 */
	proto.toSource = function () /*String*/
	{
		var useSeconds /*Boolean*/ = (this.useSeconds == true) ;
		return "new andromeda.process.Pause(" + this.getDuration().toSource() + "," + this.useSeconds.toSource() + ")" ;	
	}
	
	/**
	 * Returns the string representation of this instance.
	 * @return the string representation of this instance.
	 */
	proto.toString = function () /*String*/
	{
		return "[Pause:" + this.getDuration() + (this.useSeconds ? "s" : "ms") + "]" ;
	}

	/**
	 * (read-write) The duration value of the process.
	 */
	vegas.util.factory.PropertyFactory.create(proto, "duration") ;

	/**
	 * @private
	 */
	proto._duration /*Number*/ = null ;
	
	delete proto ;

}