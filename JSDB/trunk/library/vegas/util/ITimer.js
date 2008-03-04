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

/**
 * This interface is implemented by Timer class.
 * @author eKameleon
 */
if (vegas.util.ITimer == undefined) 
{

	/**
	 * @requires vegas.events.EventTarget
	 */
	require("vegas.events.EventTarget") ;

	/**
	 * Creates a new ITimer instance.
	 */	
	vegas.util.ITimer = function () 
	{ 
		//
	}

	/**
	 * @extends vegas.events.EventTarget
	 */
	proto = vegas.util.ITimer.extend(vegas.events.EventTarget) ;

	/**
	 * Clear the timer interval.
	 */
	proto.clear = function () /*void*/ 
	{
		//
	}

	/**
	 * Returns the delay of the interval.
	 * @return the delay of the interval.
	 */
	proto.getDelay = function () /*Number*/ 
	{
		//
	}

	/**
	 * Returns the max number of intervals of time.
	 * @return the max number of intervals of time.
	 */
	proto.getRepeatCount = function ()/*Number*/ 
	{
		//
	}
	
	/**
	 * Restarts the timer. The timer is stopped, and then started.
	 */
	proto.restart = function (noEvent /*Boolean*/) /*void*/ 
	{
		//
	}

	/**
	 * Run the command.
	 * @see IRunnable
	 */
	proto.run = function () /*void*/ 
	{
		//
	}

	/**
	 * Starts the timer if it is not already running.
	 */
	proto.start = function () /*void*/ 
	{
		//
	}

	/**
	 * Sets the delay of the interval.
	 */
	proto.setDelay = function ( n /*Number*/ ) /*void*/ 
	{
		//
	}
	
	/**
	 * Sets the max number of intervals of time.
	 */
	proto.setRepeatCount = function ( n /*Number*/ )/*void*/ 
	{
		//
	}
	
	/**
	 * Stop the timer.
	 */
	proto.stop = function ()/*void*/ 
	{
		//
	}	

	delete proto ;
	
}