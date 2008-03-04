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
 * The ActionEvent is notify by all the objects who implements the IAction interface.
 * @author eKameleon
 */
if (andromeda.events.ActionEvent == undefined) 
{
	
	/**
	 * @requires vegas.events.DynamicEvent
	 */
	require("vegas.events.DynamicEvent") ;
	
	/**
	 * Creates a new ActionEvent instance.
	 */
	andromeda.events.ActionEvent = function( type/*String*/ , target/*Object*/ , oInfo /*Object*/, context ) 
	{
		vegas.events.DynamicEvent.call(this, type, target, context) ;
		this._oInfo = oInfo ;
	}
	
	/**
	 * @extends vegas.events.DynamicEvent
	 */
	andromeda.events.ActionEvent.extend( vegas.events.DynamicEvent ) ;
 
	andromeda.events.ActionEvent.CHANGE   = "onChanged"  ;
	
	andromeda.events.ActionEvent.CLEAR    = "onCleared"  ;
	
	andromeda.events.ActionEvent.FINISH   = "onFinished" ;
	
	andromeda.events.ActionEvent.INFO     = "onInfo"     ;
	
	andromeda.events.ActionEvent.LOOP     = "onLooped"   ;
	
	andromeda.events.ActionEvent.PROGRESS = "onProgress" ;
	
	andromeda.events.ActionEvent.RESUME   = "onResumed"  ;
	
	andromeda.events.ActionEvent.START    = "onStarted"  ;
	
	andromeda.events.ActionEvent.STOP     = "onStopped"  ;
	
	andromeda.events.ActionEvent.TIMEOUT  = "onTimeout"  ;
	
	/**
	 * Returns the shallow copy of this object.
	 * @return the shallow copy of this object.
	 */
	andromeda.events.ActionEvent.prototype.clone = function () 
	{
		return new andromeda.events.ActionEvent( this.getType() , this.getInfo(), this.getTarget(), this.getContext() ) ;
	}
	
	/**
	 * Returns the info object of this event.
	 * @return the info object of this event.
	 */
	andromeda.events.ActionEvent.prototype.getInfo = function () /*Object*/ 
	{
		return this._oInfo ;
	}

	/**
	 * Sets the info object of this event.
	 */
	andromeda.events.ActionEvent.prototype.setInfo = function ( oInfo /*Object*/ ) /*Void*/ 
	{
		this._oInfo = oInfo ;
	}

	/**
	 * The r/w info property of this event.
	 */
	vegas.util.factory.PropertyFactory.create(andromeda.events.ActionEvent.prototype, "info") ;

	/**
	 * The internal info object.
	 * @private
	 */ 
	andromeda.events.ActionEvent.prototype._oInfo /*Object*/ = null ; 

}
