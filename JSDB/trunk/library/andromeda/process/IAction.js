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
 * This interface represents a process object.
 * @author eKameleon
 */
if ( andromeda.process.IAction == undefined ) 
{

	/**
	 * Creates a new IAction instance.
	 * @param bGlobal the flag to use a global event flow or a local event flow.
	 * @param sChannel the name of the global event flow if the {@code bGlobal} argument is {@code true}.
	 */
	andromeda.process.IAction = function( bGlobal /*Boolean*/ , sChannel /*String*/  ) 
	{ 
		vegas.events.AbstractCoreEventDispatcher.call(this, bGlobal, sChannel) ;
	}

	/**
	 * @extends vegas.events.AbstractCoreEventDispatcher
	 */
	proto = andromeda.process.IAction.extend( vegas.events.AbstractCoreEventDispatcher ) ;

	/**
	 * Notify an ActionEvent when the process is finished.
	 */
	proto.notifyFinished = function () /*Void*/ 
	{
		//
	}

	/**
	 * Notify an ActionEvent when the process is started.
	 */
	proto.notifyStarted = function () /*Void*/ 
	{
		//
	}

	/**
	 * Run the process.
	 */
	proto.run = function() /*void*/ 
	{
		// 
	}
	
	delete proto ;
	
}