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
 * A simple representation of the {@code Action} interface.
 * @author eKameleon
 */
if (andromeda.process.SimpleAction == undefined) 
{

	/**
	 * @requires andromeda.events.ActionEvent
	 */
	require("andromeda.events.ActionEvent") ;

	/**
	 * @requires andromeda.process.IAction
	 */
	require("andromeda.process.IAction") ;

	/**
	 * Creates a new SimpleAction instance.
	 * @param bGlobal the flag to use a global event flow or a local event flow.
	 * @param sChannel the name of the global event flow if the {@code bGlobal} argument is {@code true}.
	 */
	andromeda.process.SimpleAction = function( bGlobal /*Boolean*/ , sChannel /*String*/ ) 
	{ 
		andromeda.process.IAction.call(this,  bGlobal, sChannel ) ;
		this._eFinish = new andromeda.events.ActionEvent(andromeda.events.ActionEvent.FINISH , this ) ;
		this._eStart  = new andromeda.events.ActionEvent(andromeda.events.ActionEvent.START  , this ) ;
	}

	/**
	 * @extends vegas.process.IAction
	 */
	proto = andromeda.process.SimpleAction.extend( andromeda.process.IAction ) ;

	/**
	 * Returns a shallow copy of this object.
	 * @return a shallow copy of this object.
	 */
	proto.clone = function () /*SimpleAction*/ 
	{
		return new andromeda.process.SimpleAction() ;
	}

	/**
	 * Returns {@code true} if the process is in progress.
	 * @return {@code true} if the process is in progress.
	 */
	proto.getRunning = function () /*Boolean*/ 
	{
		return this._isRunning ;
	}

	/**
	 * Notify an ActionEvent when the process is finished.
	 */			
	proto.notifyFinished = function () /*void*/ 
	{
		this.dispatchEvent( this._eFinish ) ;
	}

	/**
	 * Notify an ActionEvent when the process is started.
	 */
	proto.notifyStarted = function () /*void*/ 
	{
		this.dispatchEvent( this._eStart ) ;
	}

	/**
	 * Run the process.
	 */
	proto.run = function () /*void*/ 
	{
		//
	}
	
	/**
	 * Sets the boolean value of the _isRunning property.
	 * @private
	 */
	/*protected*/ proto.setRunning = function (b /*Boolean*/) /*void*/
	{
		this._isRunning = b ;	
	}
	
	/**
	 * (read-write) Returns 'true' if the process is in progress. 
	 */
	vegas.util.factory.PropertyFactory.create(proto, "running") ;
	
	/**
	 * The internal finish event.
	 * @private
	 */
	proto._eFinish /*ActionEvent*/ = null ;

	/**
	 * The internal start event.
	 * @private
	 */
	proto._eStart /*ActionEvent*/ = null ;
	
	/**
	 * The internal running boolean value.
	 * @private
	 */
	proto._isRunning /*Boolean*/ = false ;
	
	delete proto ;
	
}