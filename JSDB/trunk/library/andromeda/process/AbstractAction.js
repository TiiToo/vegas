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
 * This class provides a skeletal implementation of the {@code IAction} interface, to minimize the effort required to implement this interface.
 * @author eKameleon
 */
if (andromeda.process.AbstractAction == undefined) 
{

	/**
	 * @requires andromeda.events.ActionEvent
	 */
	require("andromeda.events.ActionEvent") ;

	/**
	 * @requires andromeda.process.SimpleAction
	 */
	require("andromeda.process.SimpleAction") ;

	/**
	 * Creates a new AbstractAction instance.
	 * @param bGlobal the flag to use a global event flow or a local event flow.
	 * @param sChannel the name of the global event flow if the {@code bGlobal} argument is {@code true}.
	 */
	andromeda.process.AbstractAction = function( bGlobal /*Boolean*/ , sChannel /*String*/ ) 
	{ 
		
		andromeda.process.SimpleAction.call(this,  bGlobal, sChannel ) ;
		
		var ActionEvent = andromeda.events.ActionEvent ;
		
		this._eChange    = new ActionEvent( ActionEvent.CHANGE   , this ) ;
		this._eClear     = new ActionEvent( ActionEvent.CLEAR    , this ) ;
		this._eInfo      = new ActionEvent( ActionEvent.INFO     , this ) ;
		this._eLoop      = new ActionEvent( ActionEvent.LOOP     , this ) ;
		this._eProgress  = new ActionEvent( ActionEvent.PROGRESS , this ) ;
		this._eResume    = new ActionEvent( ActionEvent.RESUME   , this ) ;
		this._eStop      = new ActionEvent( ActionEvent.STOP     , this ) ;
		this._eTimeout   = new ActionEvent( ActionEvent.TIMEOUT  , this ) ;
	}

	/**
	 * @extends andromeda.process.SimpleAction
	 */
	proto = andromeda.process.AbstractAction.extend( andromeda.process.SimpleAction ) ;

	/**
	 * The flag to determinate if the Action object is looped.
	 */
	proto.looping /*Boolean*/ = false ;

	/**
	 * Returns a shallow copy of this object.
	 * @return a shallow copy of this object.
	 */
	proto.clone = function () /*AbstractAction*/ 
	{
		return new andromeda.process.AbstractAction() ;
	}

	/**
	 * Notify an ActionEvent when the process is changed.
	 */
	proto.notifyChanged = function () /*Void*/ 
	{
		this.dispatchEvent( this._eChange ) ;
	}

	/**
	 * Notify an ActionEvent when the process is cleared.
	 */
	proto.notifyCleared = function () /*Void*/ 
	{
		this.dispatchEvent( this._eClear ) ;
	}

	/**
	 * Notify an ActionEvent when an info is dispatched.
	 */
	proto.notifyInfo = function ( oInfo /*Object*/ ) /*Void*/ 
	{
		this._eInfo.setInfo( oInfo ) ;
		this.dispatchEvent( this._eInfo ) ;
	}

	/**
	 * Notify an ActionEvent when the process is looped.
	 */
	proto.notifyLooped = function () /*Void*/ 
	{
		this.dispatchEvent( this._eLoop ) ;
	}

	/**
	 * Notify an ActionEvent when the process is in progress.
	 */
	proto.notifyProgress = function () /*Void*/ 
	{
		this.dispatchEvent( this._eProgress ) ;
	}

	/**
	 * Notify an ActionEvent when the process is resumed.
	 */	
	proto.notifyResumed = function () /*Void*/ 
	{
		this.dispatchEvent( this._eResume ) ;
	}

	/**
	 * Notify an ActionEvent when the process is stopped.
	 */
	proto.notifyStopped = function () /*Void*/ 
	{
		this.dispatchEvent( this._eStop ) ;
	}

	/**
	 * Notify an ActionEvent when the process is out of time.
	 */
	proto.notifyTimeout = function () /*Void*/ 
	{
		this.dispatchEvent( this._eTimeout ) ;
	}
	
	/**
	 * @private
	 */
	proto._eChange    /*ActionEvent*/ = null ;

	/**
	 * @private
	 */
	proto._eClear     /*ActionEvent*/ = null ;
	
	/**
	 * @private
	 */
	proto._eInfo      /*ActionEvent*/ = null ;
	
	/**
	 * @private
	 */
	proto._eLoop      /*ActionEvent*/ = null ;
	
	/**
	 * @private
	 */
	proto._eProgress  /*ActionEvent*/ = null ;
	
	/**
	 * @private
	 */
	proto._eResume    /*ActionEvent*/ = null ;
	
	/**
	 * @private
	 */
	proto._eStop      /*ActionEvent*/ = null ;

	/**
	 * @private
	 */
	proto._eTimeout   /*ActionEvent*/ = null ;
	
	delete proto ;
	
}