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
 * The IModel interface define all models in the application.
 * @author eKameleon
 */
if (andromeda.model.IModel == undefined) 
{

	/**
	 * Creates a new IModel instance.
	 * @param bGlobal the flag to use a global event flow or a local event flow.
	 * @param sChannel the name of the global event flow if the {@code bGlobal} argument is {@code true}.
	 */
	andromeda.model.IModel = function ( bGlobal /*Boolean*/ , sChannel /*String*/ ) 
	{ 
		vegas.events.AbstractCoreEventDispatcher.apply( this , Array.fromArguments( arguments ) ) ;
	}

	/**
	 * @extends vegas.events.AbstractCoreEventDispatcher
	 */
	andromeda.model.IModel.extend( vegas.events.AbstractCoreEventDispatcher ) ;
	
	/**
	 * Returns the id of this IModel .
	 * @return the id of this IModel .
	 */
	andromeda.model.IModel.prototype.getID = function() {} ;
	
	/**
	 * Sets the id of this IModel .
	 */
	andromeda.model.IModel.prototype.setID = function( id ) /*void*/ {}  ;
	
}